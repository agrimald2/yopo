<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class RawMaterial extends Model
{

    use SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'unit_code', 'weight', 'weight_remaining','status', 'weight_registered'
    ];

    public function inventory(){
        return $this->hasMany(Inventory::class);
    }
}
