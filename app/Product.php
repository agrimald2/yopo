<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Product extends Model
{
    use SoftDeletes;

    protected $with = ['inventoryShop'];

    protected $fillable = [
        'name',
        'description',
        'sale_price',
        'sub_category_id',
        'category_id',
        'image_url',
        'unit_code',
        'is_hidden',
    ];

    protected $casts = [
        'sale_price' => 'double',
        'is_hidden' => 'boolean'
    ];

    protected $appends = [
        'weights',
        'packages',
        'picked',
        'unit',
        'short_unit'
    ];

    public function getPickedAttribute()
    {
        return [];
    }

    public function getUnitAttribute()
    {
        switch ($this->unit_code) {
            case 'KGM':
                return 'Kilogramos';
            case 'BO':
                return 'Botellas';
            case 'BG':
                return 'Bolsas';
            case 'BX':
                return 'Cajas';
            default:
                return 'Unidades';
        }
    }

    public function getShortUnitAttribute()
    {
        switch ($this->unit_code) {
            case 'KGM':
                return 'Kg';
            case 'BG':
                return 'Bol';
            case 'BO':
                return 'Bot';
            case 'BX':
                return 'Caj';
            default:
                return 'Ud';
        }
    }

    public function getWeightsAttribute()
    {
        return $this->inventory->sum('weight');
    }

    public function getPackagesAttribute()
    {
        return $this->inventory->count();
    }

    public function category()
    {
        return $this->belongsTo('App\Category');
    }

    public function subCategory()
    {
        return $this->belongsTo('App\SubCategory');
    }

    public function inventoryShop()
    {
        return $this->hasMany('App\Inventory')->where([
            'sale_id' => NULL,
            'office_id' => 1,
        ])->orderBy('weight', 'desc');
    }

    public function inventory()
    {
        return $this->hasMany('App\Inventory')->where([
            'sale_id' => NULL,
            'office_id' => session('officeId'),
        ])->orderBy('weight', 'desc');
    }

    public function inventoryAll()
    {
        return $this->hasMany('App\Inventory')->where([
            'office_id' => session('officeId'),
        ])->orderBy('weight', 'desc');
    }

    public function inventory_rm()
    {
        return $this->hasMany('App\Inventory')->where('raw_material_id', request('rm'))->orderBy('weight', 'desc');
    }

    /**
     * Questions
     */

    public function questions()
    {
        return $this->hasMany(ProductQuestion::class);
    }

    public function getHasQuestionsAttribute()
    {
        return $this->questions()->count();
    }

    /**
     * Aditionals
     */
    public function aditionals()
    {
        return $this->belongsToMany(Product::class, 'aditional_products', 'owner_product_id', 'child_product_id');
    }


    public function aditional_for()
    {
        return $this->belongsToMany(Product::class, 'aditional_products', 'child_product_id', 'owner_product_id');
    }
}
