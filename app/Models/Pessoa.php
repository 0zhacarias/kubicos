<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Pessoa extends Model
{
    use HasFactory,SoftDeletes;
    protected $table='pessoas';
    protected $guarded=['id'];
    public function usuario(){
        return $this->belongsTo(User::class,'user_id');
    }
    public function provincias(){
        return $this->belongsTo(Provincias::class,'provincia_id');
    }
}
