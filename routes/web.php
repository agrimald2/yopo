<?php

use App\Http\Controllers\Shopping\WhatsappAction;
use Illuminate\Support\Facades\Route;
// use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


// Auth::routes(['register' => false]);
Auth::routes();


Route::get('/api/{officeId}/setOffice', function ($officeId) {
    session(['officeId' => $officeId]);
    return ['ok' => true];
});

Route::get('/api/dashboard', 'DashboardController@index');
Route::get('/api/products/withInventory', 'ProductController@withInventory');
Route::post('/api/products/image', 'ProductController@storeImage');
Route::get('/api/products/images/{id}', 'ProductController@getImage');
Route::get('/api/customers/byDni', 'CustomerController@byDni');
Route::get('/api/shoppings/removeAll', 'ShoppingController@removeAll');
Route::get('/api/products/{id}/inventoryAll', 'ProductController@inventoryAll');

/**
 * Product questions
 */
Route::post('/api/products/questions/add', 'ProductQuestionController@addQuestion');
Route::post('/api/products/questions/remove', 'ProductQuestionController@removeQuestion');
Route::post('/api/products/questions/options/add', 'ProductQuestionController@addOption');
Route::post('/api/products/questions/options/remove', 'ProductQuestionController@removeOption');

Route::post('/api/products/autocomplete', 'ProductController@autocomplete');
Route::get('/api/products/aditionals/{product}', 'ProductAditionalController@index');
Route::post('/api/products/aditionals/{product}/attach', 'ProductAditionalController@attach');
Route::post('/api/products/aditionals/{product}/detach', 'ProductAditionalController@detach');


Route::get('/api/products/{key}/search', 'ProductController@search');
Route::get('/api/customers/{key}/search', 'CustomerController@search');

Route::get('/api/sales/{id}/delivery', 'SaleController@delivery');
Route::get('/api/sales/all', 'SaleController@all');
Route::get('/api/sales/{id}/dispatched', 'SaleController@dispatched');
Route::post('/api/sales/deleteSale', 'SaleController@deleteSale');
Route::post('/api/sales/shop', 'SaleController@shop');
Route::post('/api/sales/shopPayment', 'SaleController@shopPayment');
Route::get('/api/sales/find', 'SaleController@find');
Route::put('/api/sales/{id}/withInventory', 'SaleController@updateWithInventory');
Route::put('/api/sales/pay', 'SaleController@pay');
Route::get('/api/sales/dispatchedSales', 'SaleController@dispatchedSales');
Route::get('/api/sales/deliverySales', 'SaleController@deliverySales');

Route::get('/api/products/all', 'ProductController@all');
Route::get('/api/deletedReasons/all', 'DeletedReasonController@all');
Route::get('/api/users/session', 'UserController@session');
Route::get('/api/customers/{dni}/dni', 'CustomerController@getDni');
Route::get('/api/users/dealers', 'UserController@dealers');

Route::get('/api/deliveries/all', 'DeliveryController@all');
Route::get('/api/disableds/shop', 'DisabledController@shop');

Route::get('/api/rawMaterial/{id}/inventory', 'RawMaterialController@inventory');
Route::post('/api/rawMaterial/terminar', 'RawMaterialController@finish');

Route::apiResources([
    'api/disableds' => 'DisabledController',
    'api/offices' => 'OfficeController',
    'api/deliveryman' => 'DeliverymanController',
    'api/credentials' => 'CredentialController',
    'api/users' => 'UserController',
    'api/paymentMethods' => 'PaymentMethodController',
    'api/emails' => 'EmailController',
    'api/rawMaterial' => 'RawMaterialController',
    'api/products' => 'ProductController',
    'api/categories' => 'CategoryController',
    'api/subCategories' => 'SubCategoryController',
    'api/shoppings' => 'ShoppingController',
    'api/inventories' => 'InventoryController',
    'api/customers' => 'CustomerController',
    'api/sales' => 'SaleController',
    'api/checkout' => 'CheckoutController',
    'api/deliveries' => 'DeliveryController',
    'api/deletedReasons' => 'DeletedReasonController',
]);
Route::post('/api/categories/image', 'CategoryController@storeImage');
Route::get('/api/categories/images/{id}', 'CategoryController@getImage');

Route::post('/api/logout', 'Auth\LoginController@logout');

Route::get('/', 'OfficeController@landing');




Route::get('/store/{id}', function () {
    return view('store');
});

Route::get('/storeProductAdd/{id}/{qty}', function () {
    return view('store');
});

Route::get('/store', function () {
    return view('store');
});

Route::get('/payment', function () {
    return view('store');
});

Route::get('/{saleId}/checkoutDetails', function () {
    return view('store');
});

Route::get('/{saleId}/checkout', function () {
    return view('store');
});

Route::get('/checkout', function () {
    return view('store');
});

Route::get('/shopping', function () {
    return view('store');
});

Route::get('/shopping/{sale}/whatsapp', 'Shopping\WhatsappAction');

Route::get('{any}', function () {
    return view('app');
})->where('any', '.*');
