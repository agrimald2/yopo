<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Credential extends Model
{
    protected $fillable = [
        'user_id',
        'dashboard',
        'pos',
        'posAdmin',
        'rawMaterial',
        'products',
        'categories',
        'subCategories',
        'stock',
        'inventories',
        'inventoriesAdmin',
        'customers',
        'sales',
        'salesAdmin',
        'users',
        'dispatchedsSale',
        'deliveriesSale',
        'deliveries',
        'paymentMethods',
        'deletedReasons',
        'offices',
    ];

    protected $casts = [
        'user_id' => 'integer',
        'dashboard' => 'integer',
        'pos' => 'integer',
        'posAdmin' => 'integer',
        'rawMaterial' => 'integer',
        'products' => 'integer',
        'categories' => 'integer',
        'subCategories' => 'integer',
        'stock' => 'integer',
        'inventories' => 'integer',
        'inventoriesAdmin' => 'integer',
        'customers' => 'integer',
        'sales' => 'integer',
        'salesAdmin' => 'integer',
        'users' => 'integer',
        'dispatchedsSale' => 'integer',
        'deliveriesSale' => 'integer',
        'deliveries' => 'integer',
        'paymentMethods' => 'integer',
        'deletedReasons' => 'integer',
        'offices' => 'integer',
    ];
}
