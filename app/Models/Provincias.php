<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Provincias extends Model
{
    protected $table="provincias";
    protected $guarded=['id'];
    use HasFactory, SoftDeletes;
}
