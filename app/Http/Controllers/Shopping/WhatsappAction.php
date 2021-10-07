<?php

namespace App\Http\Controllers\Shopping;

use App\Http\Controllers\Controller;
use App\Sale;
use Illuminate\Http\Request;

class WhatsappAction extends Controller
{
    function __invoke(Sale $sale)
    {
        $sale->load('customer', 'items.shoppingOptions', 'items.product', 'delivery');

        $customer = $sale->customer->name;

        $m = "Hola {$customer}!\n";
        $m .= "Muchas gracias por dejar tu pedido 🐤❤️\n";
        $m .= "Tu pedido es el siguiente:\n";

        $total = 0;

        foreach ($sale->items as $item) {
            $total += $item->sale_price;

            $options = "";
            foreach ($item->shoppingOptions as $option) {
                $total += $option->price;

                if ($options) {
                    $options .= ", ";
                }
                $options .= $option->name . " +S/" . $option->price;
            }

            $product = $item->product->name;
            $price = $item->product->sale_price;
            $m .= "- {$product} S/{$price} ({$options})\n";
        }

        $delivery = $sale->delivery->price;
        $totalWithDelivery = number_format($total + $delivery, 2);

        $direction = $sale->customer->address;

        $m .= "\n";
        $m .= "Total: S/ " . number_format($total, 2) . "\n";
        $m .= "Total con delivery: S/ {$totalWithDelivery}\n";
        $m .= "\n";
        $m .= "Tu dirección es:\n";
        $m .= "{$direction}\n";
        $m .= "\n";
        $m .= "Sería genial si nos puedes decir tu medio de pago:\n";
        $m .= "\n";
        $m .= "1. Yape\n";
        $m .= "2. Bcp Cuenta\n";
        $m .= "3. Link de pago Visa o Mastercard\n";


        $text = urlencode($m);
        $url = "https://api.whatsapp.com/send?phone=51924649794&text={$text}";
        return redirect()->away($url);
    }
}
