<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use DateTimeInterface;

class Condominio extends Model
{
    use HasFactory;
    use SoftDeletes;

    // protected $table="condominios";
    protected $guarded = ['id'];

    protected function serializeDate(DateTimeInterface $date){
        return $date->format('d M Y');
    }

}
