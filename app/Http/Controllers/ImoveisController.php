<?php

namespace App\Http\Controllers;

use App\Models\ActividadeImoveis;
use App\Models\CategoriasImoveis;
use App\Models\CondicaoImoveis;
use App\Models\Documentacoes;
use App\Models\EstadoImoveis;
use App\Models\FotosImoveis;
use App\Models\Imobiliaria;
use App\Models\Imoveis;
use App\Models\Municipios;
use App\Models\OperacaoImoveis;
use App\Models\Pessoa;
use App\Models\Provincias;
use App\Models\SolicitarImoveis;
use App\Models\TipoDeDocumento;
use App\Models\TipoDocumentacoes;
use App\Models\TipoImoveis;
use App\Models\Tipologia;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;

class ImoveisController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function portal_imovel()
    {
        //$userLog=auth()->user()->load('tipo_user');

       /// dd($userLog->tipo_user->id);
        $dados['provincias'] = Provincias::all();
        $dados['municipios'] = Municipios::all();
        $dados['tipologiaImoveis'] = Tipologia::all();
        $dados['tipoImoveis'] = TipoImoveis::all();
        // $dados['novos_imoveis']=Imoveis::with('fotosImoveis','condicaoImoveis','actividadeImoveis.operacaoImoveis','estadoImoveis')->orderBy('created_at','desc')->get();
        // $dados['mais_proximos']=Imoveis::with('fotosImoveis','condicaoImoveis','actividadeImoveis.operacaoImoveis','estadoImoveis')->get();

        return Inertia::render('Portal/PortalIndex', $dados);
        // return Inertia::render('Portal/Carousel');
        // return view();
    }
    public function municipios(Request $request)
    {
        //dd($request);

        $dados = Municipios::where('provincia_id', $request->id)->get();
        return response()->json($dados);
    }
    public function tipo_tipologia(Request $request)
    {
        // dd($request);
        $dados = Tipologia::where('tipo_imoveis_id', $request->id)->get();
        return response()->json($dados);
    }
    public function index()
    {

        $dados['provincias'] = Provincias::all();
        $dados['municipios'] = Municipios::all();
        $dados['tipologiaImoveis'] = Tipologia::all();
        $dados['tipoImoveis'] = TipoImoveis::all();

        return Inertia::render('Portal/ImoveisCriar',$dados);
        // return Inertia::render('Portal/Carousel');
        // return view();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        // return response()->json($request);

        // $data = $request->all();
        // Imoveis::created($data);
        if ($request->get('arrendamento_id')) {
            $operacao_imoveis_id = 2;
        } else if ($request->get('venda_id')) {
            $operacao_imoveis_id = 1;
        }
        $userLog = auth()->user()->load('tipo_user');
        // $proprietario_colaborador_corrector = $userLog->tipo_user->id;
        $imovel = Imoveis::create([
            'designacao' => $request->get('designacao'),
            'descricao' => $request->get('designacao'),
            // 'mobiliado' => $request->get('mobiliado'),
            'metros' => $request->get('metros'),
            'localizacao' => $request->get('localizacao_geografica'),
            // 'imposto_predial' => $request->get('imposto_predial'),
            'numero_banheiro' => $request->get('numero_banheiro'),
            'provincia_id' => $request->get('provincia_id'),
            'preco' => $request->get('preco'),
            'estado_imoveis_id' => 3,
            'numero_cozinha' => $request->get('numero_cozinha'),
            'tipologia_imoveis_id' => $request->get('tipologia_id'),
            'categoria_imoveis_id' => $request->get('categoria_imoveis_id'),
            // 'suite' => $request->get('numero_quartos'),
            'condicao_imoveis_id' => $request->get('condicao_imoveis_id'),
            'numero_sala_estar' => $request->get('numero_sala_estar'),
            'numero_quartos' => $request->get('numero_quartos'),
            'numero_andar' => $request->get('numero_andar'),
            //Vai deixar alguma coisa
            'mobiliado' => $request->get('mobiliado'),
            //Parte Interna
            'armario_embutido' => $request->get('armario_embutido'),
            'arcondicionados' => $request->get('ar_condicionados'),
            'mesa_cadeira' => $request->get('mesa_cadeira'),
            // 'maquina_lavar_roupa' => $request->get('maquina_lavar_roupa'),
            //Exterior
            'numero_garagem' => $request->get('numero_garagem'),
            'maquina_lavar_roupa' => $request->get('maquina_lavar_roupa'),
            'churrasqueira' => $request->get('churrasqueira'),
            'piscina' => $request->get('piscina'),
            'gerador' => $request->get('gerador'),
            'ginasio' => $request->get('ginasio'),
            'tanqueagua' => $request->get('tanqueagua'),
            'cadastrado_por' => auth()->user()->id,

        ]);
        if ($request->hasFile('foto_principal')) {
            $fileFoto = $request->foto_principal->store('Foto_principal');
            $imovel->update([
                'foto_principal' => $fileFoto,
            ]);
        }
        if ($request->hasFile('tituloPropriedade')) {
            $filepdf = $request->tituloPropriedade->store('Tipo_Propriedade');
            $fotos = Documentacoes::create([
                'foto' => $filepdf,
                'imoveis_id' => $imovel->id,
                'tipo_domumentacoes' => 1,
            ]);
        }

        if ($request->hasFile('croquis')) {
            $filepdf = $request->croquis->store('Croquis');
            $fotos = Documentacoes::create([
                'nome_arquivo' => $filepdf,
                'imoveis_id' => $imovel->id,
                'tipo_domumentacoes' => 2,
            ]);
        }
        if ($request->hasFile('tituloPropriedade')) {
            $filepdf = $request->tituloPropriedade->store('Tipo_Propriedade');
            $fotos = Documentacoes::create([
                'foto' => $filepdf,
                'imoveis_id' => $imovel->id,
                'tipo_domumentacoes' => 1,
            ]);
        }
        if ($request->hasFile('mutiplaImagem')) {
            foreach ($request->mutiplaImagem as $foto) {
                $fileFoto =  $foto->store('Foto_Multipla');
                $fotos = FotosImoveis::create([
                    'foto' => $fileFoto,
                    'imoveis_id' => $imovel->id,
                ]);
            };
        }
        // dd($proprietario_colaborador);

        $actividade = ActividadeImoveis::create([
            // 'proprietario_colaborador' => $proprietario_colaborador_corrector,
            'operacao_imoveis_id' => $operacao_imoveis_id,
            'imoveis_id' => $imovel->id,
            'tempo_arrendar' => $request->get('tempo_arrendar'),
            'quantidade_prestacoes' => $request->get('quantidade_prestacoes'),
            'cadastrado_por' => $userLog->id,
        ]);

        return redirect()->back()->with('success', 'successo');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Imoveis  $imoveis
     * @return \Illuminate\Http\Response
     */
    public function show(Imoveis $imoveis)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Imoveis  $imoveis
     * @return \Illuminate\Http\Response
     */
    public function edit(Imoveis $imoveis)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Imoveis  $imoveis
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        // $foto = [];
        // foreach ($request->fotos_imoveis as $fotos) {
        //     $foto = $fotos['imoveis_id'];
        // };
        // $imovelData = $request->input('imovel');

        // Decodifique a string JSON em um objeto PHP
        // $imovelDataArray = json_decode($imovelData, true);
        $imovel = Imoveis::find($request->id);

        // $proprietario_colaborador_corrector = $userLog->tipo_user->id;
        $userLog = auth()->user()->load('tipo_user');
        $imovel->update([
            'designacao' => $request->get('designacao'),
            'descricao' => $request->get('designacao'),
            'metros' => $request->get('metros'),
            'localizacao' => $request->get('localizacao_geografica'),
            'numero_banheiro' => $request->get('numero_banheiro'),
            'provincia_id' => $request->get('provincia_id'),
            'preco' => $request->get('preco'),
            // 'estado_imoveis_id' => 3,
            'numero_cozinha' => $request->get('numero_cozinha'),
            'tipologia_imoveis_id' => $request->get('tipologia_id'),
            'categoria_imoveis_id' => $request->get('categoria_imoveis_id'),
            'condicao_imoveis_id' => $request->get('condicao_imoveis_id'),
            'numero_sala_estar' => $request->get('numero_sala_estar'),
            'numero_quartos' => $request->get('numero_quartos'),
            'numero_andar' => $request->get('numero_andar'),
            //Vai deixar alguma coisa
            'mobiliado' => $request->get('mobiliado'),
            //Parte Interna
            'armario_embutido' => $request->get('armario_embutido'),
            'arcondicionados' => $request->get('ar_condicionados'),
            'mesa_cadeira' => $request->get('mesa_cadeira'),
            //Exterior
            'numero_garagem' => $request->get('numero_garagem'),
            'maquina_lavar_roupa' => $request->get('maquina_lavar_roupa'),
            'churrasqueira' => $request->get('churrasqueira'),
            'piscina' => $request->get('piscina'),
            'gerador' => $request->get('gerador'),
            'ginasio' => $request->get('ginasio'),
            'tanqueagua' => $request->get('tanqueagua'),
            // 'foto_principal' => $request->get('foto_principal'),
            'cadastrado_por' => auth()->user()->id,
        ]);

        if ($request->hasFile('foto_principal')) {

            $fileFoto = $request->foto_principal->store('Foto_principal');
            $imovel->update([
                'foto_principal' => $fileFoto,
            ]);
        }

        $documentos = Documentacoes::where('imoveis_id', $imovel->id)->first();
        if ($request->hasFile('tituloPropriedade')) {
            if ($documentos->tipo_domumentacoes) {
                Storage::delete('Tipo_Propriedade', $documentos->Tipo_Propriedade);
            }
            $filepdf = $request->tituloPropriedade->store('Tipo_Propriedade');
            $fotos = Documentacoes::create([
                'foto' => $filepdf,
                'imoveis_id' => $imovel->id,
                'tipo_domumentacoes' => 1,
            ]);
        }


        /*   Procurar a primeira palavra com um caracter especifico
     $string = "esta/é/uma/exemplo";
        $caractere = "/";

        // Use preg_match para encontrar a primeira palavra antes do caractere "/"
        if (preg_match('/([^\/]+)\/.*$/', $string, $matches)) {
            $primeiraPalavra = $matches[1];
        } else {
            echo "Nenhuma correspondência encontrada.";
        }*/
        $diretorioComFotos = 'Foto_Multipla';

        $fotosmultiplas = FotosImoveis::where('imoveis_id', $imovel->id)->get();

        // Recupere uma lista de todas as fotos no diretório
        $fotosNoDiretorio = Storage::files($diretorioComFotos);
        // Itere sobre as fotos e exclua cada uma
        foreach ($fotosmultiplas as $foto) {
            $fotoParaExcluir = $foto->foto;
            // $caminhoDaFoto = $fotoParaExcluir;

            // Storage::delete($foto);
            if (Storage::exists('Foto_Multipla')) {
                Storage::delete($fotoParaExcluir);
                // A foto foi removida com sucesso do armazenamento
            }
            $foto->delete();
        }

        if ($request->hasFile('mutiplaImagem')) {
            foreach ($request->mutiplaImagem as $foto) {
                dd($foto);
                $fileFoto =  $foto->store('Foto_Multipla');
                $fotos = FotosImoveis::create([
                    'foto' => $fileFoto,
                    'imoveis_id' => $imovel->id,
                ]);

                // $fileFoto =  $foto->store('Foto_Multipla');
                //  $foto->foto = $fileFoto;
                // $foto->save();
            };
        }

        $actividades = ActividadeImoveis::where('imoveis_id', $imovel->id)->first();

        if ($request->get('operacao_id') == 1 && $request->get('quantidade_prestacoes')) {
            $actividades->update([
                'operacao_imoveis_id' => $request->operacao_id,
                'imoveis_id' => $imovel->id,
                'quantidade_prestacoes' => $request->get('quantidade_prestacoes'),

            ]);
        } else if ($request->get('operacao_id') == 2 && $request->get('tempo_arrendar')) {
            $actividades->update([
                'operacao_imoveis_id' => $request->operacao_id,
                'imoveis_id' => $imovel->id,
                'tempo_arrendar' => $request->get('tempo_arrendar'),
            ]);
        }

        return redirect()->back()->with('success', 'Actualização feita com sucesso');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Imoveis  $imoveis
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $imovel = Imoveis::find($id);
        $imovel->delete();
        return redirect()->back()->with('success', 'Dados eliminado com sucesso');
    }
    public function lista_imoveis_comprar()
    {
        $dados['provincias'] = Provincias::orderBy('designacao', 'asc')->get();
        $dados['tipologiaImoveis'] = Tipologia::all();
        $dados['operacao_imoveis'] = 1;
        $dados['CondicoesImoveis'] = CondicaoImoveis::get();
        $dados['estadoImoveis'] = EstadoImoveis::whereIn('id', [1, 6, 7])->get();
        $dados['tipoImoveis'] = TipoImoveis::all();
        return Inertia::render('Portal/ListaImoveis', $dados);
    }
    public function lista_imoveis_arrendamento()
    {
        $dados['provincias'] = Provincias::orderBy('designacao', 'asc')->get();
        $dados['operacao_imoveis'] = 2;

        $dados['estadoImoveis'] = EstadoImoveis::whereIn('id', [1, 6, 7])->get();
        $dados['CondicoesImoveis'] = CondicaoImoveis::all();
        $dados['tipoImoveis'] = TipoImoveis::all();
        return Inertia::render('Portal/ListaImoveis', $dados);
        // dd();
    }
    public function imovel_selecionado($id)
    {
        $id = base64_decode(base64_decode(base64_decode($id)));

        $data['imoveis'] = Imoveis::with('solicitacaoImoveis', 'fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis')->find($id);;
        return Inertia::render('Portal/ImovelSelecionado', $data);
        // dd();
    }
    public function imoveis_provincia($id)
    {
        $dados['operacao_imoveis'] = 0;
        $dados['provincias'] = Provincias::all();
        $dados['provincia_selecionado'] = $id;
            // $dados['provincia'] = Imoveis::with('fotosImoveis','condicaoImoveis','actividadeImoveis.operacaoImoveis','estadoImoveis')->where('provincia_id',$id)->get();
            // dd($dados);
        ;
        return Inertia::render('Portal/ListaImoveis', $dados);
        // dd();
    }
    // Pode ser usado esse para as provas de caixa branca
    public function filtrar_imoveis_portal(Request $request)
    {
        $servico = $request->servico;
        $dados['operacao_imoveis'] = 0;
        $dados['provincias'] = Provincias::all();
        $dados['estadoImoveis'] = EstadoImoveis::whereIn('id',  [1, 6, 7])->get();
        $dados['CondicoesImoveis'] = CondicaoImoveis::all();
        $dados['tipoImoveis'] = TipoImoveis::all();
        $dados['meio_periodo'] = OperacaoImoveis::where('id', $servico);
        if ($servico == 0) {
            $servico = 3;
        } else if ($servico == 1) {
            $servico = 2;
        } else {
            $servico = 4;
        }
        if ($request->provincia_id) {

            $dados['provincia_selecionado'] = $request->provincia_id;
            $provincia_id[] = $request->provincia_id;
        } else {
            $dados['provincia_selecionado'] = 0;
            $provincias[] = Provincias::pluck('id');
            foreach ($provincias as $provincia) {
                $provincia_id = $provincia;
            }
        }
        if ($request->provincia_id) {
            $tipo_imovel[] = $request->tipo_imovel;
            $dados['tipo_imoveis_selecionado'] = $request->tipo_imovel;
        } else {
            $categorias[] = CategoriasImoveis::pluck('id');
            foreach ($categorias as $categoria) {
                $tipo_imovel = $categoria;
            }
            $dados['tipo_imoveis_selecionado'] = 0;
        }
        return Inertia::render('Portal/ListaImoveis', $dados);
    }

    public function filtrar_imoveis_paginate(Request $request)
    {
        //  dd($request);
        $meio_periodo_id = $request->get('meio_periodo_id');
        $provincia_id = $request->get('provincia_id');
        $tipo_imoveis = $request->get('tipo_imoveis_id');
        if ($tipo_imoveis) {
            if ($provincia_id) {
                $imoveis = Imoveis::with('solicitacaoImoveis', 'fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis')
                    ->where('provincia_id', $provincia_id)
                    ->where('condicao_imoveis_id', $tipo_imoveis)
                    ->whereIn('estado_imoveis_id', [1, 6, 7])
                    ->paginate(10);;
            } else {
                $actividadeImoveis = ActividadeImoveis::where('operacao_imoveis_id', $request->get('operacao_id'))->select('imoveis_id')->get();
                $imoveis = Imoveis::with('fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis')
                    ->whereIn('id', $actividadeImoveis)
                    ->whereIn('estado_imoveis_id', [1, 6, 7])
                    ->where('condicao_imoveis_id', $tipo_imoveis)
                    ->paginate(10);
            }
        } else {

            if ($provincia_id) {
                $imoveis = Imoveis::with('solicitacaoImoveis', 'fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis')
                    ->where('provincia_id', $provincia_id)
                    ->paginate(10);
            } else {
                $actividadeImoveis = ActividadeImoveis::where('operacao_imoveis_id', $request->get('operacao_id'))->select('imoveis_id')->get();
                if ($request->get('operacao_id') == 0) {
                    $imoveis = Imoveis::with('solicitacaoImoveis', 'fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis')
                    ->whereIn('estado_imoveis_id', [1, 6, 7])
                        ->where('deleted_at', null)
                        ->paginate(10);
                } else {


                    $imoveis = Imoveis::with('solicitacaoImoveis', 'fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis')
                        ->where('deleted_at', null)
                        ->whereIn('estado_imoveis_id', [1, 6, 7])
                        ->whereIn('id', $actividadeImoveis)
                        ->paginate(10);
                    // dd( $imoveis);
                }
            }
        }

        return response()->json($imoveis);
    }
    public function peesquisar_imoveis(Request $request)
    {

        if ($request->get('operacao_id') == 0) {
            $actividadeImoveis = ActividadeImoveis::pluck('imoveis_id');
        } else {
            $actividadeImoveis = ActividadeImoveis::where('operacao_imoveis_id', $request->get('operacao_id'))
                ->pluck('imoveis_id');
        }
        $estado_imoveis_id = $request->get('estado_imoveis_id');
        $condicoes_imoveis_id = $request->get('condicoes_imoveis_id');
        $provincia_id = $request->get('provincia_id');
        $preco_inicio = $request->get('preco_inicio');
        $preco_final = $request->get('preco_final');
        $tipo_imoveis_id = $request->get('id_tipo_imoveis');
        $designacao = $request->get('designacao');

        if ($provincia_id) {
            $id_provincia[] = $provincia_id;
        } else {
            $provincias[] = Provincias::pluck('id');
            foreach ($provincias as $provincia) {
                $id_provincia = $provincia;
            }
        }

        if ($condicoes_imoveis_id) {
            $condicoes_imovel[] = $provincia_id;
        } else {
            $condicoes_imoveis[] = CondicaoImoveis::pluck('id');
            foreach ($condicoes_imoveis as $condicao) {
                $condicoes_imovel = $condicao;
            }
        }
        if ($estado_imoveis_id) {
            $id_estadoimovel[] = $estado_imoveis_id;
        } else {
            $estadoimoveis[] = EstadoImoveis::pluck('id');
            foreach ($estadoimoveis as $estadoimovel) {
                $id_estadoimovel = $estadoimovel;
            }
        }
        if ($tipo_imoveis_id) {
            $id_tipo[] = $tipo_imoveis_id;
        } else {
            $tipo_imoveis[] = TipoImoveis::pluck('id');
            foreach ($tipo_imoveis as $tipo) {
                $id_tipo = $tipo;
            }
        }

        if ($preco_final) {

            $imoveis = Imoveis::with('solicitacaoImoveis', 'fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis')
                ->whereIn('id', $actividadeImoveis)
                ->whereIn('provincia_id', $id_provincia)
                ->whereIn('condicao_imoveis_id', $condicoes_imovel)
                ->whereIn('estado_imoveis_id', $id_estadoimovel)
                ->whereIn('categoria_imoveis_id', $id_tipo)
                ->where('preco', '>=', $preco_inicio)
                ->where('preco', '<=', $preco_final)
                ->orderBy('created_at', 'asc')->get();
        } else {
            $imoveis = Imoveis::with('solicitacaoImoveis', 'fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis')
                ->whereIn('id', $actividadeImoveis)
                ->whereIn('provincia_id', $id_provincia)
                ->whereIn('condicao_imoveis_id', $condicoes_imovel)
                ->whereIn('estado_imoveis_id', $id_estadoimovel)
                ->whereIn('categoria_imoveis_id', $id_tipo)
                ->orderBy('created_at', 'asc')
                ->get();

            // dd($imoveis,$id_tipo, $request);
        }

        // dd($imoveis,$id_provincia,$actividadeImoveis);
        return response()->json($imoveis);
    }
    public function imoveis_paginacao()
    {
        if (auth()->user()) {
            $userLogado = auth()->user()->id;
            $dados['novos_imoveis'] = Imoveis::with('solicitacaoImoveis', 'fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis')
                ->where('estado_imoveis_id', '!=', 2)
                ->where('estado_imoveis_id', '!=', 3)
                ->where('estado_imoveis_id', '!=', 8)
                ->orderBy('created_at', 'asc')->paginate(8);

            $dados['id_imoveis_solicitados'] = SolicitarImoveis::where('user_marca_visita', $userLogado)->get();
            $dados['solicitado_distinct'] = SolicitarImoveis::distinct()
                ->select('imoveis_id')->get();
           // dd($dados['id_imoveis_solicitados']);
        } else {
            $dados['novos_imoveis'] = Imoveis::with('solicitacaoImoveis', 'fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis')
                ->where('estado_imoveis_id', '!=', 2)
                ->where('estado_imoveis_id', '!=', 3)
                ->where('estado_imoveis_id', '!=', 8)
                ->orderBy('created_at', 'asc')->paginate(8);

            $dados['id_imoveis_solicitados'] = SolicitarImoveis::get();
            $dados['solicitado_distinct'] = SolicitarImoveis::distinct()
                ->select('imoveis_id')->get();
            //dd($dados['id_imoveis_solicitados']);
        }
        return response()->json($dados);
    }
    public function paginacao_imoveis_proximo(Request $request)
    {
        if (auth()->user()) {
            $userLogado = auth()->user()->id;
            // $localizacao=Pessoa::select('provincia_id')->find($userLogado);
            $dados['mais_proximos'] = Imoveis::with('solicitacaoImoveis', 'fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis')
                ->whereIn('provincia_id', [1, 13])
                ->where('estado_imoveis_id', '!=', 2)
                ->where('estado_imoveis_id', '!=', 3)
                ->where('estado_imoveis_id', '!=', 8)
                ->paginate(8);
            // dd($dados['mais_proximos']);
        } else {
            $dados['mais_proximos'] = Imoveis::with('solicitacaoImoveis', 'fotosImoveis', 'condicaoImoveis', 'actividadeImoveis.operacaoImoveis', 'estadoImoveis')
                ->where('estado_imoveis_id', '!=', 2)
                ->where('estado_imoveis_id', '!=', 3)
                ->where('estado_imoveis_id', '!=', 8)
                ->paginate(8);
        }
        $dados['tipo_imoveis'] = TipoImoveis::get();
        $dados['provincias'] = Provincias::orderBy('designacao', 'asc')->get();
        $dados['imobiliarias'] = Imobiliaria::orderBy('designacao', 'asc')->get();

        return response()->json($dados);
    }
}
