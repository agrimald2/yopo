<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ShoppingOption extends Model
{
    protected $fillable = ['name', 'price'];

    public function shopping()
    {
        return $this->belongsTo(Shopping::class);
    }
}
