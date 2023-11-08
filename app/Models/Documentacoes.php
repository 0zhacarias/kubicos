<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Documentacoes extends Model
{
    use HasFactory;
    protected $table='documentacoes';
    protected $guarded=['id'];
}
