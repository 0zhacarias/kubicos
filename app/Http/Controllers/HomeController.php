<?php

namespace App\Http\Controllers;

use App\Models\Imoveis;
use App\Models\Municipios;
use App\Models\Provincias;
use App\Models\TipoImoveis;
use App\Models\Tipologia;
use Illuminate\Http\Request;

use Inertia\Inertia;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    protected $userLogado;

    public function __construct()
    {
        
        $this->middleware('auth');
      
    }
    public function index()
    {
        // session(['previous_url' => url()->current()]);
        // $previousUrl2 = session('previous_url');
        session(['previous_url' => url()->previous()]);
        $previousUrl = session('previous_url', '/perfil');
        $urlLogin =  env('LOCAL_URL') . '/logar';
        // dd($previousUrl);
        // dd($previousUrl);
        $urlListarArrendado =  env('LOCAL_URL') . '/portal/listaImoveisArrendamentos';
        $urlListarComprar =  env('LOCAL_URL') . '/portal/listaImoveisCompras';
        $urlAnunciar =  env('LOCAL_URL') . '/portal/imoveis';
        $urlPerfil =  env('LOCAL_URL').'/perfil';
        $urlHome = env('LOCAL_URL') . '/home';
        $urlGoogle = env('LOCAL_URL');
        $urlRegistrar = env('LOCAL_URL') . '/RegistrarConta';
        $dados['provincias']=Provincias::all();
        $dados['municipios']=Municipios::all();
        $dados['tipologiaImoveis']=Tipologia::all();
        $dados['tipoImoveis']=TipoImoveis::all();
        // $dados['novos_imoveis']=Imoveis::with('fotosImoveis','condicaoImoveis','actividadeImoveis.operacaoImoveis','estadoImoveis')->orderBy('created_at','desc')->get();
        // $dados['mais_proximos']=Imoveis::with('fotosImoveis','condicaoImoveis','actividadeImoveis.operacaoImoveis','estadoImoveis')->get();
      
       // dd($previousUrl);
        if($previousUrl== $urlPerfil ||$previousUrl== $urlLogin ||$previousUrl== $urlHome || $previousUrl){
            // dd($previousUrl);
            return Inertia::render('Portal/PortalIndex');  
            // }else if($previousUrl== $urlLogin){
            //     return Inertia::render('Portal/PortalIndex');  
            }else if($previousUrl== $urlListarArrendado){
                return Inertia::render('Portal/ListaImoveis',$dados);  
            }else if($previousUrl== $urlListarComprar){
                // session()->flush();
                return Inertia::render('Portal/ListaImoveis',$dados);  
            }else if($previousUrl==$urlAnunciar){

                return Inertia::render('Portal/ImoveisCriar',$dados);  
            
            }else if($previousUrl==$urlRegistrar){

                return Inertia::render('Admin/Clientes/Cliente',$dados);  
            }
     // dd($dados);
        // $this->redirecionarUsuario();
        
        // return Inertia::render('Portal/PortalIndex', $dados);
        // return Inertia::render('Admin/Home');
    }

    protected function redirecionarUsuario()
    {
         // Recupere a URL anterior da sessão ou redirecione para uma rota padrão se não houver uma URL anterior.
         $previousUrl = session('previous_url', '/home');
        $url = $previousUrl;
$baseUrl = "http://127.0.0.1:8000";

// Remove a parte do prefixo da URL
$route = str_replace($baseUrl, '', $url);
       
if($previousUrl=="http://127.0.0.1:8000/logar"){
    // dd($previousUrl,$route);
    return Inertia::render('Portal/PortalIndex');  
    }
        // return redirect($previousUrl);
    }
    public function portal_auth()
    {
        return Inertia::render('Admin/Portal');
    }

}
