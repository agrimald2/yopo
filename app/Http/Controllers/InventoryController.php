<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Inventory;
use App\RawMaterial;
use App\Sale;
use DateTime;
use Illuminate\Support\Facades\Auth;

class InventoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $sd = (new DateTime($request->sd))->format('Y-m-d');
        $ed = (new DateTime($request->ed))->modify('+1 day')->format('Y-m-d');
        $sales = Sale::whereBetween('created_at', [$sd, $ed])->get();
        $salesId = $sales->map(function($item) {
            return $item->id;
        });
        $inventories = Inventory::with(['product' => function($query) {
                return $query->with('category', 'subCategory');
            }])
            ->with(['sale' => function($query) {
                return $query->with('customer', 'delivery');
            }])
            ->whereIn('sale_id', $salesId)
            ->get();
        return ['inventories' => $inventories];
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        foreach ($request->inventories as $item) {
            for ($i=0; $i < $item['quantity']; $i++) { 
                $inventory = new Inventory($item);
                if(!$inventory->office_id)
                {
                    $inventory->office_id = session('officeId');
                }
                $inventory->user_id = Auth::id();
                $inventory->codigo = Str::random(10);
                $inventory->save();

                if($inventory->raw_material_id)
                {
                    $rawMaterial = RawMaterial::find($inventory->raw_material_id );
                    $rawMaterial->weight_remaining -= $inventory->weight;
                    $rawMaterial->status = 1;
                    $rawMaterial->save();
                }
            }
        }

        return NULL;
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $inventory = Inventory::find($id);
        $inventory->fill($request->inventory);
        $inventory->save();
        return ['inventory' => $inventory];
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $inventory = Inventory::find($id);

        if($inventory->raw_material_id)
        {
            $rawMaterial = RawMaterial::find($inventory->raw_material_id);
            $rawMaterial->weight_remaining += $inventory->weight;
            $rawMaterial->save();
        }

        $inventory->delete();
    }
}