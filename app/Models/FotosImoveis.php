<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use DateTimeInterface;
class FotosImoveis extends Model
{

    use HasFactory,SoftDeletes;
    protected $table="fotos_imoveis";
    protected $guarded=['id'];
    protected function serializeDate(DateTimeInterface $date){
        return $date->format('d-M-Y H:i:s');
    }
    public function imoveis(){
        return $this->belongsTo(Imoveis::class);
    }
}
