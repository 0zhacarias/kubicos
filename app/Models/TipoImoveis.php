<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipoImoveis extends Model
{
    use HasFactory;
    protected $table="tipo_imoveis";
    protected $guarded=['id'];
}
