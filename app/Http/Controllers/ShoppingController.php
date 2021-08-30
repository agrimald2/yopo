<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Shopping;

class ShoppingController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $shoppings = Shopping::where('tmp_id', session('tmp_id'))->with('product')->get();
        return ['shoppings' => $shoppings];
    }

    public function removeAll()
    {
        $shoppings = Shopping::where('tmp_id', session('tmp_id'))->with('product')->get();
        foreach ($shoppings as $item) {
            $item->delete();
        }
        return NULL;
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $sessionId = session('tmp_id');

        if (!$sessionId) {
            $sessionId = Str::random(10);
            session(['tmp_id' => $sessionId]);
        }

        $product = $request->product;

        $counter = isset($product['counter']) ? $product['counter'] : 1;

        $shopping = Shopping::firstOrCreate([
            'product_id' => $product['id'],
            'tmp_id' => $sessionId,
            'options' => $product['options'],
        ], [
            'counter' => $counter,
        ]);

        $shopping->counter = $counter;

        $shopping->save();

        return ['shopping' => $shopping];
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
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $shopping = Shopping::where([
            'product_id' => $id,
            'tmp_id' => session('tmp_id'),
        ])->first();
        $shopping->delete();
        return NULL;
    }
}
