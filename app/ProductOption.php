<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductOption extends Model
{
    public function question()
    {
        return $this->belongsTo(ProductQuestion::class);
    }
}
