<?php

namespace App\Http\Controllers;

use App\Inventory;
use App\Custormer;
use App\Sale;
use Carbon\Carbon;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        $start_date = Carbon::parse($request->sd)->startOfMonth();
        $end_date = Carbon::parse($request->ed);

        $sales = [];
        $revenue = [];

        $date = $start_date->copy();

        while($date->lessThanOrEqualTo($end_date)) {
            $date_format = $date->format('MY');

            if($date_format=="Mar2020" or $date_format=="May2020" or $date_format=="Jul2020" or $date_format=="Aug2020" or $date_format=="Oct2020" or $date_format=="Dec2020" or $date_format=="Jan2021" or $date_format=="Mar2021" or $date_format=="May2021" or $date_format=="Jul2021" or $date_format=="Aug2021" or $date_format=="Oct2021" or $date_format=="Dec2021"){
                $date_end = $date->copy()->addDays(31);
            }elseif($date_format=="Apr2020" or $date_format=="Jun2020" or $date_format=="Sep2020" or $date_format=="Nov2020" or $date_format=="Jun2021" or $date_format=="Sep2021" or $date_format=="Nov2021"){
                $date_end = $date->copy()->addDays(30);
            }elseif($date_format=="Feb2021"){
                $date_end = $date->copy()->addDays(28);
            }elseif($date_format=="Feb2020"){
                $date_end = $date->copy()->addDays(28);
            }else{
                $date_end = $date->copy()->addMonths(1);
            }

            $sales_by_month = Sale::where('created_at', '>=', $date)
                        ->where('created_at', '<=', $date_end)->count();
                    
            $payed_by_month = Sale::where('created_at', '>=', $date)
                        ->whereNotNull('payment_id')
                        ->where('created_at', '<=', $date_end)->count();
        
            $sales[$date_end->format('d-M-Y')] = $sales_by_month;
            
            $revenue_by_month = Inventory::join('sales', 'sales.id', '=', 'inventories.sale_id')
                            ->selectRaw('SUM(sale_price + sales.delivery_price) as total')
                            ->selectRaw('SUM(sales.delivery_price) as delivery')
                            ->where('sales.created_at', '>=', $date)
                            ->where('sales.created_at', '<=', $date_end)->first();
                
            $deliveryprice_by_month = Sale::where('created_at', '>=', $date)
            ->selectRaw('SUM(delivery_price) as total')
            ->where('created_at', '<=', $date_end)->first();

            $general_revenue_by_month = Inventory::join('sales', 'sales.id', '=', 'inventories.sale_id')
                            ->selectRaw('SUM(sale_price + sales.delivery_price) as total')
                            ->selectRaw('SUM(sales.delivery_price) as delivery')
                            ->whereNotNull('sales.payment_date')
                            ->where('sales.created_at', '>=', $date)
                            ->where('sales.created_at', '<=', $date_end)->first();
        
            $revenue[$date_end->format('d-M-Y')] = $revenue_by_month->total ? $revenue_by_month->total : 0;
            
            if($date_format=="Mar2020" or $date_format=="May2020" or $date_format=="Jul2020" or $date_format=="Aug2020" or $date_format=="Oct2020" or $date_format=="Dec2020" or $date_format=="Jan2021" or $date_format=="Mar2021" or $date_format=="May2021" or $date_format=="Jul2021" or $date_format=="Aug2021" or $date_format=="Oct2021" or $date_format=="Dec2021"){
                $date->addDays(31);
            }elseif($date_format=="Apr2020" or $date_format=="Jun2020" or $date_format=="Sep2020" or $date_format=="Nov2020" or $date_format=="Jun2021" or $date_format=="Sep2021" or $date_format=="Nov2021"){
                $date->addDays(30);
            }elseif($date_format=="Feb2021"){
                $date->addDays(28);
            }elseif($date_format=="Feb2020"){
                $date->addDays(28);
            }else{
                $date->addMonths(1);
            }


        }

        $week_sales = [];
        $start_of_week = Carbon::now()->startOfWeek();
        for ($day = 0; $day <= 7; $day++) {
            
            $date = $start_of_week->copy()->addDays($day);
            $sales_by_day = Sale::whereDate('created_at', $date)->count();
        
            $week_sales[$date->format('d-m')] = $sales_by_day;
        }

        $deliveries = [];
        $last_30_days = Carbon::now()->subMonths(1);
        
        $sales_by_delivery = Sale::selectRaw('delivery_id, COUNT(id) as total')
                                ->where('delivery_id','>',0)->where('created_at','>',$last_30_days)
                                ->orderBy('total','desc')->groupBy('delivery_id')->limit(5)->get();

        foreach($sales_by_delivery as $delivery){
            if($delivery->delivery){
                $deliveries[$delivery->delivery->name] = $delivery->total;
            }
        }                   

        $best_sellers = [];
        $inventories = Inventory::join('products', 'products.id', '=', 'inventories.product_id')
                            ->join('sales', 'sales.id', '=', 'inventories.sale_id')
                            ->selectRaw('products.name, SUM(weight) as quantity')
                            ->where('sale_id','<>',null)->where('sales.created_at','>',$last_30_days)->orderBy('quantity','desc')
                            ->groupBy('product_id')->limit(5)->get();

        
        foreach($inventories as $inventory){
            $best_sellers[$inventory->name] = $inventory->quantity;
        }

        $pending_deliveries = Sale::whereNotNull('deliver_date')->whereNull('delivered_date')->where('created_at','>',$last_30_days)->count();
        $dispathced_deliveries = Sale::whereNotNull('delivered_date')->whereNull('deliver_date')->where('created_at','>',$last_30_days)->count();

        $stock = Inventory::join('products', 'products.id', '=', 'inventories.product_id')
                            ->selectRaw('products.id, products.name, SUM(weight) as quantity, products.unit_code')
                            ->where('sale_id',null)->having('quantity','<',10)->orderBy('quantity')
                            ->groupBy('product_id')->get();

        $customers = Sale::join('customers', 'customers.id', '=', 'sales.customer_id')
        ->selectRaw('customers.id, customers.name, COUNT(customer_id) as quantity, customers.mobile')
        ->where('sales.created_at','>',$last_30_days)
        ->having('quantity','>',7)
        ->orderBy('quantity','desc')
        ->groupBy('customer_id')->get();

        $sellers = Sale::join('users', 'users.id', '=', 'sales.user_id')
        ->selectRaw('users.id, users.name, COUNT(user_id) as quantity')
        ->where('sales.created_at','>',$last_30_days)
        ->having('quantity','>',7)
        ->orderBy('quantity','desc')
        ->groupBy('user_id')->get();
        
        $start_date2 = Carbon::parse($request->ed)->endOfday()->addMonth()->format('MY');

        return [
            'sellers' => $sellers,
            'customers' => $customers,
            'sd_p' => $start_date2,
            'ed_p' => $end_date,
            'delivery_price' => $deliveryprice_by_month,
            'payed' => $payed_by_month,
            'general_revenue' => $general_revenue_by_month,
            'sales' => $sales,
            'revenue' => $revenue,
            'week_sales' => $week_sales,
            'deliveries' => $deliveries,
            'inventory' => $best_sellers,
            'stock' => $stock,
            'pending_deliveries' => [$dispathced_deliveries,$pending_deliveries]
        ];
    }
}
