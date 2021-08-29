<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductQuestion extends Model
{
    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    public function options()
    {
        return $this->hasMany(ProductOption::class);
    }
}
