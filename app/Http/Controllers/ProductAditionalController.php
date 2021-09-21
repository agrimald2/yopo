<?php

namespace App\Http\Controllers;

use App\Product;
use Illuminate\Http\Request;

class ProductAditionalController extends Controller
{

    public function index(Product $product)
    {
        return $product->aditionals;
    }


    public function attach(Product $product, Request $request)
    {
        $request->validate([
            'id' => 'required|integer',
        ]);

        $product->aditionals()->syncWithoutDetaching([$request->id]);

        return $product->aditionals;
    }

    public function detach(Product $product, Request $request)
    {
        $request->validate([
            'id' => 'required|integer',
        ]);

        $product->aditionals()->detach([$request->id]);

        return $product->aditionals;
    }
}
