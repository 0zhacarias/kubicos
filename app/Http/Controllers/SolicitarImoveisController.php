<?php

namespace App\Http\Controllers;

use App\Mail\EmailSolicitarVisitas;
use App\Models\Imoveis;
use App\Models\Pessoa;
use App\Models\SolicitarImoveis;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Inertia\Inertia;

class SolicitarImoveisController extends Controller
{
    protected $emailFuncionario;
   public function __construct()
   {

      //$this->emailFuncionario = new ActividadeImoveisController();
   }

    
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
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
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\SolicitarImoveis  $solicitarImoveis
     * @return \Illuminate\Http\Response
     */
    public function show(SolicitarImoveis $solicitarImoveis)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\SolicitarImoveis  $solicitarImoveis
     * @return \Illuminate\Http\Response
     */
    public function edit(SolicitarImoveis $solicitarImoveis)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\SolicitarImoveis  $solicitarImoveis
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, SolicitarImoveis $solicitarImoveis)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\SolicitarImoveis  $solicitarImoveis
     * @return \Illuminate\Http\Response
     */
    public function destroy(SolicitarImoveis $solicitarImoveis)
    {
        //
    }
    public function solicitar_visita_imovel(Request $request)
    {
        $funcionario=Pessoa::whereHas('usuario',function($query) {
                $query->where('tipo_user_id',1);
            })->get();
        $mensagem="O Imovel XXXXX foi solicitado uma visita pelo cliente XX";
        $solicitar_visita = SolicitarImoveis::create([
            'designacao' => $request->get('designacao'),
            'hora_visita' => $request->get('hora_visita'),
            'data_visita' => $request->get('data_visita'),
            'actividade_imoveis_id' => $request->get('actividade_imoveis_id'),
            'imoveis_id' => $request->get('imoveis_id'),
            'estado_imoveis_id' => 4,
            'user_marca_visita' => auth()->user()->id,

        ]);
      //  ->whereHas('empresas',function($query) use ($empresaLogado)
        // {
        //     $query->where('empresa_id',$empresaLogado->id);
        // })->get();

       //return $this->emailFuncionario->emailValidar($funcionario,$mensagem);
       // $this->emailValidar($solicitavisita, $mensagem);
       // Imoveis::find($request->get('imoveis_id'))->update([
       //     'estado_imoveis_id' => 4,
     //   ]);

       return redirect()->back()->with('success','sucesso');
        // return Inertia::render('Admin/Clientes/SolicitarVisista');
    }

    public function emailValidar($solicitavisita, $mensagem)
    {
        $emailfuncionarios=[];
        foreach($solicitavisita as $funcionario ){
            $emailfuncionarios=$funcionario->email;
        }
      //  dd($emailfuncionario,$mensagem);

        $email_marca_visita = $solicitavisita->usuario_marca_visita->email;
        $nome_marca_visita = $solicitavisita->usuario_marca_visita->name;
        // Imovel
        $designacao_imovel = $solicitavisita->imovel->designacao;
        $localizacao = $solicitavisita->imovel->localizacao;
        $preco = $solicitavisita->imovel->preco;
        $condicao_imovel = $solicitavisita->imovel->condicaoImoveis->designacao;
        //Informação da visita
        $data_visita = $solicitavisita->data_visita;
        $hora_visita = $solicitavisita->hora_visita;
        $url = action([ImoveisController::class, 'portal_imovel']);
        // dd($solicitavisita);
      
        foreach($emailfuncionarios as $emailfuncionario){
             Mail::to('zhacarias50@outlook.com')->send(new EmailSolicitarVisitas(
            $mensagem,
            $nome_marca_visita,
            $url,
            $designacao_imovel,
            $localizacao,
            $preco,
            $condicao_imovel,
            $data_visita,
            $hora_visita
        ));};
    }


}