<?php

namespace App\Http\Controllers;

use App\Mail\EmailImoveilNegociacao;
use App\Mail\EmailSolicitarVisitas;
use App\Models\ActividadeImoveis;
use App\Models\Imoveis;
use App\Models\Pessoa;
use App\Models\SolicitarImoveis;
use App\Models\User;
use PDF;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Twilio\Rest\Client;

class ActividadeImoveisController extends Controller
{
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
     * @param  \App\Models\ActividadeImoveis  $actividadeImoveis
     * @return \Illuminate\Http\Response
     */
    public function show(ActividadeImoveis $actividadeImoveis)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\ActividadeImoveis  $actividadeImoveis
     * @return \Illuminate\Http\Response
     */
    public function edit(ActividadeImoveis $actividadeImoveis)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\ActividadeImoveis  $actividadeImoveis
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, ActividadeImoveis $actividadeImoveis)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\ActividadeImoveis  $actividadeImoveis
     * @return \Illuminate\Http\Response
     */
    public function destroy(ActividadeImoveis $actividadeImoveis)
    {
        //
    }
    public function emailValidar($solicitavisita, $mensagem)
    {
        $email_marca_visita = $solicitavisita->usuario_marca_visita->email;
        $nome_marca_visita = $solicitavisita->usuario_marca_visita->name;
        // Imovel
        $designacao_imovel = $solicitavisita->imovel->designacao;

        $localizacao =  $solicitavisita->imovel->localizacao!=null ? $solicitavisita->imovel->localizacao:"Desconhecido ";
        $preco = $solicitavisita->imovel->preco;
        $condicao_imovel = $solicitavisita->imovel->condicaoImoveis->designacao;
        //Informação da visita
        $data_visita = $solicitavisita->data_visita;
        $hora_visita = $solicitavisita->hora_visita;
        $url = action([ImoveisController::class, 'portal_imovel']);
         //dd( $mensagem,);
        Mail::to('zhacarias50@outlook.com')->send(new EmailImoveilNegociacao(
            $mensagem,
            $nome_marca_visita,
            $url,
            $designacao_imovel,
            $localizacao,
            $preco,
            $condicao_imovel,
            $data_visita,
            $hora_visita
        ));
    }
    public function emailValidarFuncionario($cliente, $mensagem, $imovel)
    {
             $email_marca_visita = $cliente->email;
             $nome_cliente=$cliente->nome;
             $mensagem=$mensagem;
        // Imovel
        $referenca = $imovel->codigo_imovel;
        $designacao_imovel = $imovel->designacao;
        $localizacao = $imovel->localizacao;
        $preco = $imovel->preco;
        $condicao_imovel = $imovel->condicaoImoveis->designacao;
        //Informação da visita
       // dd($cliente,$preco,$condicao_imovel);  
        $url = action([ImoveisController::class, 'portal_imovel']);
      

       // Mail::to('zhacarias50@outlook.com')
        Mail::to($email_marca_visita)->send(new EmailSolicitarVisitas(
            $referenca,
            $mensagem,
            $nome_cliente,
            $url,
            $designacao_imovel,
            $preco,
            $condicao_imovel,
        ));
    }
    public function emailSolicitarImovel($solicitavisita, $mensagem)
    {
        $email_marca_visita = $solicitavisita->confirmar_marcacao_visita->email;
        $nome_marca_visita = $solicitavisita->confirmar_marcacao_visita->name;
        // Imovel
        $designacao_imovel = $solicitavisita->imovel->designacao;
        $localizacao =  $solicitavisita->imovel->localizacao!=null ? $solicitavisita->imovel->localizacao:"Desconhecido ";
        $preco = $solicitavisita->imovel->preco;
        $condicao_imovel = $solicitavisita->imovel->condicaoImoveis->designacao;
        //Informação da visita
        $data_visita = $solicitavisita->data_visita;
        $hora_visita = $solicitavisita->hora_visita;
        $url = action([ImoveisController::class, 'portal_imovel']);
        Mail::to('zhacarias50@outlook.com')->send(new EmailImoveilNegociacao(
            $mensagem,
            $nome_marca_visita,
            $url,
            $designacao_imovel,
            $localizacao,
            $preco,
            $condicao_imovel,
            $data_visita,
            $hora_visita
        ));
    }
    public function solicitar_visita_imovel(Request $request)
    {
        // Pode ser usado esse para as provas de caixa branca
        $imovel = Imoveis::find($request->imovel_id);
        $solicitavisita = SolicitarImoveis::with('usuario_marca_visita','imovel.condicaoImoveis','confirmar_marcacao_visita')
            ->where('imoveis_id', $request->imovel_id)->where('funcionario_id', null)->first();
        $mensagem = 'Nada Marcado.';
        if ($imovel->estado_imoveis_id == 1) {
            $mensagem = 'A sua marcação foi aceite no horário desejado.';
            $solicitavisita->update(['funcionario_id' => auth()->user()->id,]);
        } else if ($imovel->estado_imoveis_id == 4) {
            $imovel->update(['estado_imoveis_id' => 1,]);
            $mensagem = 'A sua marcação foi aceite no horário desejado.';
        } else {
            $this->emailValidar($solicitavisita, $mensagem);
         //   $this->enviarSms($request->imovel_id, $mensagem);
            $solicitavisita->update(['funcionario_id' => auth()->user()->id,]);
        }
    }
    public function validar_processo(Request $request)
    {

        $userLog = auth()->user()->load('tipo_user');
        $imovel = Imoveis::find($request->imovel_id);
      $solicitavisita = SolicitarImoveis::with('usuario_marca_visita','imovel.condicaoImoveis','confirmar_marcacao_visita')->where('imoveis_id', $request->imovel_id)->where('funcionario_id', null)->first();
       $mensagem = 'A sua marcação foi aceite no horário desejado.';
       $updateSolicitavisita = SolicitarImoveis::where('user_marca_visita',$solicitavisita->user_marca_visita)->where('imoveis_id', $request->imovel_id)->first();

       $this->emailValidar($solicitavisita, $mensagem,);
       //$this->enviarSms($request->imovel_id, $mensagem);
       $updateSolicitavisita->update([

           'estado_imoveis_id' => 5,
           'funcionario_id' => auth()->user()->id,
       ]);

        // dd($imovel, $solicitavisita->usuario_marca_visita->email);

    }
    public function nao_validar_processo(Request $request)
    {
        
        $solicitavisita = SolicitarImoveis::with('usuario_marca_visita','imovel.condicaoImoveis','confirmar_marcacao_visita')->where('imoveis_id', $request->imovel_id)->where('funcionario_id', null)->first();
        $mensagem = 'A sua marcação não foi aceite no horário desejado, por favor volte a reagendar o mesmo.';
     
        //$this->enviarSms($request->imovel_id, $mensagem);

        $cliente_id=$solicitavisita->user_marca_visita;
        $imovel = Imoveis::find($request->imovel_id);
        
        $updateSolicitavisita = SolicitarImoveis::where('user_marca_visita',$solicitavisita->user_marca_visita)->where('imoveis_id', $request->imovel_id)->first();
      //  dd($updateSolicitavisita);
   //     if ($imovel->estado_imoveis_id == 1) {
            $updateSolicitavisita->delete();
     /*   } else if ($imovel->estado_imoveis_id == 4) {
            $imovel->update(
                [
                    'estado_imoveis_id' => 5,
                ]

            );
        }*/
        $this->emailValidar($solicitavisita, $mensagem);
    }
    public function cancelar_processo(Request $request)
    {
        $solicitavisita = SolicitarImoveis::with('usuario_marca_visita','imovel.condicaoImoveis','confirmar_marcacao_visita')->where('imoveis_id', $request->imovel_id)->where('funcionario_id', null)->first();
        
        $mensagem = 'Devido algumas inregularidade no processo de negociação , foi cancelado o imóvel processo, e estará disponivel para outros interessado ...';

        $this->emailValidar($solicitavisita, $mensagem);
        //$this->enviarSms($request->imovel_id, $mensagem);
        $imovel = Imoveis::find($request->imovel_id);
        $actividade = ActividadeImoveis::where('imoveis_id', $request->imovel_id)->select('cadastrado_por')->first();
        $pessoa_id = Pessoa::where('user_id', $actividade->cadastrado_por)->first();
        $numerofone = "+244" . $pessoa_id->numero_telefone;
        $imovel->update(
            ['estado_imoveis_id' => 1,]
        );
    }

    public function enviarSms($imovel_id, $mensagem)
    {
        $sid = getenv("TWILIO_SID");
        $token = getenv("TWILIO_TOKEN");
        $number = getenv("TWILIO_PHONE");
        $twilio = new Client($sid, $token);

        $actividade = ActividadeImoveis::where('imoveis_id', $imovel_id)->select('cadastrado_por')->first();
        $pessoa_id = Pessoa::where('user_id', $actividade->cadastrado_por)->first();
        $numerofone = "+244" . $pessoa_id->numero_telefone;
        $message = $twilio->messages
            ->create(
                $numerofone, // to
                [
                    "body" => $mensagem,
                    "from" => $number
                ]
            );
    }

    public function imprimir_documentacao($id)
    {

        $declaracoes = Imoveis::with('fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis', 'categoria', 'usuario.pessoa', 'condicaoImoveis')
            ->find($id);
        $userLog = auth()->user()->load('tipo_user');
        $user = User::where('id', $userLog->id)->get();

        $pdf = PDF::loadView('declaracaoPDF', [
            'declaracaoPDF' => $declaracoes,
            'datatime' => date("Y-m-d"),
            'operacao_imovel' => $declaracoes->actividadeImoveis[0]->operacaoImoveis->designacao,
        ]);
        return $pdf->stream('Listas tipo de problemas projecto.pdf');
    }
    public function emitir_anuncio($id)
    {
        $emissaoarquivo = Imoveis::with('fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis', 'categoria', 'usuario.pessoa', 'condicaoImoveis')
            ->where('id',$id)->get();
        $userLog = auth()->user()->load('tipo_user');
        $user = User::where('id', $userLog->id)->get();

        $pdf = PDF::loadView('eminitirAnuncioPDF', [
            'eminitirAnuncioPDF' => $emissaoarquivo,
            'datatime' => date("Y-m-d"),
            'user' => $user,
        ]);
        // dd($pdf );
        return $pdf->stream('Listas tipo de problemas projecto.pdf');
    }
    public function emitir_relatorios_processo()
    {
        $userLog = auth()->user()->load('tipo_user');
        if($userLog->tipo_user_id==1){
            $emissaoarquivo = Imoveis::with('fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis', 'categoria', 'usuario.pessoa', 'condicaoImoveis')
            ->get();
        }else if($userLog->tipo_user_id==2){
            $updateSolicitavisita = SolicitarImoveis::where('user_marca_visita',$userLog->id)
            ->select('imoveis_id')->get();
            $emissaoarquivo = Imoveis::with('fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis', 'categoria', 'usuario.pessoa', 'condicaoImoveis')
                ->where('id',$updateSolicitavisita->imoveis_id)->get();
        }else{
            $emissaoarquivo = Imoveis::with('fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis', 'categoria', 'usuario.pessoa', 'condicaoImoveis')
                ->where('cadastrado_por',$userLog->id)->get();
        }
        // $user = User::where('id', $userLog->id)->get();

        $pdf = PDF::loadView('emitirRelatorioProcesso', [
            'emitirRelatorioProcesso' => $emissaoarquivo,
            'datatime' => date("Y-m-d"),
            // 'user'=>$user,
        ]);
        // dd($pdf );
        return $pdf->stream('Listas tipo de problemas projecto.pdf');
    }
    public function gostar_imovel(Request $request)
    {
        $imovel = Imoveis::find($request->imovel_id);
      
        $imovel = Imoveis::find($request->imovel_id);
        $solicitavisita = SolicitarImoveis::with('usuario_marca_visita','imovel.condicaoImoveis','confirmar_marcacao_visita')->where('imoveis_id', $request->imovel_id)->first();
        $mensagem = 'Gostaste do Imóvel.';
        $imovel->update(
            [
                'estado_imoveis_id' => 8,
            ]

        );
        $updateSolicitavisita = SolicitarImoveis::where('user_marca_visita',$solicitavisita->user_marca_visita)->where('imoveis_id', $request->imovel_id)->first();
        $updateSolicitavisita->update([

'estado_imoveis_id' => 8,
]);
     //   $url = action([ImoveisController::class, 'portal_imovel']);
        // Mail::to('zhacarias50@outlook.com')->send(new EmailImoveilNegociacao($mensagem, $nome_confirma_visita, $url));
        $this->emailSolicitarImovel($solicitavisita, $mensagem);
        $this->enviarSms($request->imovel_id, $mensagem);
    }
    public function nao_gostar_imovel(Request $request)
    {

        $imovel = Imoveis::find($request->imovel_id);
        // dd($imovel);
        $imovel->update(
            [
                'estado_imoveis_id' => 1,
            ]

        );
        $imovel = Imoveis::find($request->imovel_id);
        $solicitavisita = SolicitarImoveis::with('usuario_marca_visita','imovel.condicaoImoveis','confirmar_marcacao_visita')->where('imoveis_id', $request->imovel_id)->where('user_marca_visita',auth()->user()->id)->first();
        $mensagem = 'Não gostou do Imóvel.';
       
        $updateSolicitavisita = SolicitarImoveis::where('user_marca_visita',$solicitavisita->user_marca_visita)->where('imoveis_id', $request->imovel_id)->first();
        $updateSolicitavisita->delete();
        
        $this->emailSolicitarImovel($solicitavisita, $mensagem);
        //$this->enviarSms($request->imovel_id, $mensagem);
    }

    public function validar_imovel(Request $request)
    {
      $imovel = Imoveis::find($request->imovel_id);
    $actividade=ActividadeImoveis::where('imoveis_id',$request->imovel_id)->select('cadastrado_por')->first();
    $cliente=Pessoa::where('user_id',$actividade->cadastrado_por)->first();
   
     $mensagem = "sua marcação foi aceite no horário desejado.";
     $this->emailValidarFuncionario($cliente, $mensagem, $imovel);
       //$this->enviarSms($request->imovel_id, $mensagem);
       $imovel->update(
               [
                  'estado_imoveis_id' => 1,
              ]

           );
    }
    public function nao_validar_imovel(Request $request)
    {
        $imovel = Imoveis::find($request->imovel_id);
    $actividade=ActividadeImoveis::where('imoveis_id',$request->imovel_id)->select('cadastrado_por')->first();
   $cliente=Pessoa::where('user_id',$actividade->cadastrado_por)->first();
     $mensagem = 'Depois de ser analizado o seu Imóvel constatamos que as informações não são as mesma que a casa verdadeira, por tanto descontinuaremos o processo!.';
       $this->emailValidarFuncionario($cliente, $mensagem, $imovel);
       //$this->enviarSms($request->imovel_id, $mensagem);
       $imovel->update(
               [
                  'estado_imoveis_id' => 2,
              ]

           );
    }


    
    public function carregar_imoveis_processo()
    {
        return response()->json(2);
    }
    public function sms_twilio()
    {
        $sid = getenv("TWILIO_SID");
        $token = getenv("TWILIO_TOKEN");
        $number = getenv("TWILIO_PHONE");
        $twilio = new Client($sid, $token);

        $message = $twilio->messages
            ->create(
                "+244926315250", // to
                [
                    "body" => "Testando a API",
                    "from" => $number
                ]
            );
        dd("Teste feito");
        return response()->json(2);
    }
}
