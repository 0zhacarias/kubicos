<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CondicaoImoveis extends Model
{
    use HasFactory,SoftDeletes;
    protected $table="condicao_imoveis";
    protected $guarded=['id'];
    public function imoveis(){
        return $this->hasMany(Imoveis::class);
    }
}
