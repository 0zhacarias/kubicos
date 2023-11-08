<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDocumentosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('documentos', function (Blueprint $table) {
            $table->id();

            $table->string('nome_arquivo');

            $table->integer('pessoa_id')->unsigned();
            // $table->foreign('pessoa_id')->references('id')->on('pessoas');

            $table->integer('tipo_documento_id')->unsigned();
            // $table->foreign('tipo_documento_id')->references('id')->on('tipo_documentos');

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
        Schema::dropIfExists('documentos');
    }
}
