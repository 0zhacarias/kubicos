<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class OperacaoImoveis extends Model
{
    use HasFactory,SoftDeletes;
    protected $table="operacao_imoveis";
    protected $guarded=['id'];
    public function actividadeImoveis(){
        return $this->hasMany(ActividadeImoveis::class);
    }
}
