<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePessoasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pessoas', function (Blueprint $table) {
            $table->id();
            $table->string('nome_completo');

            $table->string('nome_pai');

            $table->string('nome_mae');

            $table->string('numero_identificacao');

            $table->date('data_emissao');

            $table->date('data_validade');

            $table->string('numero_telefone_1');

            $table->string('numero_telefone_2');

            $table->date('data_nascimento');

            $table->integer('morador_id')->unsigned();
            // $table->foreign('morador_id')->references('id')->on('moradores');

            $table->integer('genero_id')->unsigned();
            // $table->foreign('genero_id')->references('id')->on('generos');

            $table->integer('user_id')->unsigned();
            // $table->foreign('user_id')->references('id')->on('users');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('pessoas');
    }
}
