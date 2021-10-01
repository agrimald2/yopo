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

    public function product()
    {
        return $this->belongsTo('App\Product');
    }

    public function options()
    {
        return $this->hasMany(ShoppingOption::class);
    }
}
