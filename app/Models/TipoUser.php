<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipoUser extends Model
{
    protected $table='tipo_users';
    protected $guarded=['id'];
    use HasFactory;
}
