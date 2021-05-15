<?php

namespace App\Http\Controllers;

use App\Product;
use App\RawMaterial;
use App\RawProduct;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class RawMaterialController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $rawMaterial = RawMaterial::paginate(18);
        return [
            'rawMaterial' => $rawMaterial->items(),
            'count' => $rawMaterial->total(),
            'pages' => $rawMaterial->lastPage()
        ];
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $rawMaterial = new RawMaterial();
        $rawMaterial->fill($request->rawMaterial);
        $rawMaterial->user_id = Auth::id();
        $rawMaterial->save();
        return ['rawMaterial' => $rawMaterial];
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $rawMaterial = RawMaterial::find($id);

        return [
            'rawMaterial' => $rawMaterial
        ];
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
        $rawMaterial = RawMaterial::find($id);
        $rawMaterial->fill($request->rawMaterial);
        $rawMaterial->save();
        return ['rawMaterial' => $rawMaterial];
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $rawMaterial = RawMaterial::find($id);
        $rawMaterial->delete();
    }

    /**
     * Return Products from raw material.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function inventory($id)
    {
        $products = Product::with('category', 'subCategory')->paginate(18);
        return [
            'products' => $products->items(),
            'count' => $products->total(),
            'pages' => $products->lastPage(),
        ];
    }

    /**
     * Set Raw Material as finished.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function finish(Request $request)
    {
        $rawMaterial = RawMaterial::find($request->id);
        $rawMaterial->status = 2;
        $rawMaterial->save();
        return [
            'rawMaterial' => $rawMaterial
        ];
    }
}
