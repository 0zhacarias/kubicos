<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ActividadeImoveis extends Model
{
    protected $table='actividade_imoveis';
    protected $guarded=['id'];
    use HasFactory,SoftDeletes;
    public function operacaoImoveis(){
        return $this->belongsTo(OperacaoImoveis::class,'operacao_imoveis_id');
    }
}
