<?php

namespace App\Http\Controllers;

use App\Models\Morador;
use App\Models\Genero;
use App\Models\TipoDeDocumento;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use Illuminate\Support\Facades\Crypt;
use Hash;
use PDF;
use Inertia\Inertia;

class MoradorController extends Controller
{
    public function index()
    {
        $data['generos'] = Genero::get();
        $data['tipos_de_documentos'] = TipoDeDocumento::get();
        return Inertia::render('Admin/Moradores/MoradoresIndex', $data);
    }

    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Morador  $morador
     * @return \Illuminate\Http\Response
     */
    public function show(Morador $morador)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Morador  $morador
     * @return \Illuminate\Http\Response
     */
    public function edit(Morador $morador)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Morador  $morador
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Morador $morador)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Morador  $morador
     * @return \Illuminate\Http\Response
     */
    public function destroy(Morador $morador)
    {
        //
    }
}
