<?php

namespace App\Http\Controllers;

use App\Models\Imobiliaria;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ImobiliariaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $dados['imobiliarias']=Imobiliaria::all();
        // dd( $imobiliarias);
        return Inertia::render('Admin/Clientes/Imobiliaria',$dados);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // dd($request);
        // $data = $request->all();
        $imobiliaria=$request->all();
        Imobiliaria::create($imobiliaria);

        return redirect()->back()->with('success','Imóbiliaria cadastrado com sucesso');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Imobiliaria  $imobiliaria
     * @return \Illuminate\Http\Response
     */
    public function show(Imobiliaria $imobiliaria)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Imobiliaria  $imobiliaria
     * @return \Illuminate\Http\Response
     */
    public function edit(Imobiliaria $imobiliaria)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Imobiliaria  $imobiliaria
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $imobiliaria=Imobiliaria::find($id);
        $imobiliaria->update($request->all());
     
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Imobiliaria  $imobiliaria
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $imobiliaria=Imobiliaria::find($id);
        $imobiliaria->delete();
    }
}
