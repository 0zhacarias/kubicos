<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Imobiliaria extends Model
{
    protected $table='imobiliaria';
    protected $guarded=['id'];
    use HasFactory, SoftDeletes;
}
