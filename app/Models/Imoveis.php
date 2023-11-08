<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Imoveis extends Model
{
    use HasFactory,SoftDeletes;
    protected $table="imoveis";
    protected $guarded=['id'];
    
public function categoria() {
    return $this->belongsTo(CategoriasImoveis::class,'condicao_imoveis_id');
}
public function tipologiaImoveis() {
    return $this->belongsTo(Tipologia::class);
}
public function usuario(){
    return $this->belongsTo(User::class,'cadastrado_por');
}
public function condicaoImoveis(){
    return $this->belongsTo(CondicaoImoveis::class,);
}
public function fotosimoveis(){
    return $this->hasMany(FotosImoveis::class,'imoveis_id');
}
public function actividadeImoveis(){
    return $this->hasMany(ActividadeImoveis::class,'imoveis_id');
}
public function solicitacaoImoveis(){
    return $this->hasMany(SolicitarImoveis::class,'imoveis_id');
}
public function estadoImoveis(){
    return $this->belongsTo(EstadoImoveis::class,);
}
protected static function boot(){
    parent::boot();

    static::created(function ($imovel) {
        $imovel->codigo_imovel = 'KBC-'. $imovel->id;
        $imovel->save();
    });

    // $relacoes = ['tickets', 'projectos', 'controlEmpresa', 'funcionario'];

    // foreach ($relacoes as $relacao) {
    // static::deleting(function ($empresa) use ($relacao) {
    //     $empresa->{$relacao}()->delete();
    // });
    // }
}
}
