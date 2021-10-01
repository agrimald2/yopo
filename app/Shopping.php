<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Shopping extends Model
{
    protected $fillable = [
        'tmp_id',
        'product_id',
        'counter',
        'options',
    ];

    protected $casts = [
        'counter' => 'double',
    ];

    /**
     * Relationships
     */
    public function product()
    {
        return $this->belongsTo('App\Product');
    }

    public function options()
    {
        return $this->hasMany(ShoppingOption::class);
    }

    /**
     * Attributes
     */
    public function getPriceAttribute()
    {
        $optionsTotal = $this->options
            ->reduce(function ($carry, $option) {
                return $carry + $option->price;
            }, 0);

        return $this->product->sale_price + $optionsTotal;
    }
}
