<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CategoriasImoveis extends Model
{
    protected $table="categoria_imoveis";
    protected $guarded=['id'];
    use HasFactory;
}
