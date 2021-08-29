<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductOption extends Model
{
    protected $fillable = ['question_id', 'option'];

    public function question()
    {
        return $this->belongsTo(ProductQuestion::class);
    }
}
