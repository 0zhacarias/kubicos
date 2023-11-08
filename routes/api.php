<?php

use App\Http\Controllers\RegistrarController;
use App\Models\Registrar;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::post('/registrar',[App\Http\Controllers\RegistrarController::class,'registrar_usuario']);

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
