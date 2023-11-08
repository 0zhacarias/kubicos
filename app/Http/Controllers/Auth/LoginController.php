<?php

namespace App\Http\Controllers\Auth;
use Laravel\Socialite\Facades\Socialite;
use App\Http\Controllers\Controller;
use App\Models\User;
use App\Providers\RouteServiceProvider;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = RouteServiceProvider::HOME;
    //REPLICANDO A FUNÇÃO REDIRECTTO E USANDO A VARIAVEL PERFIL PARA OMPREENDER O REDIRECIONAMENTO.
    // protected $redirectPe = RouteServiceProvider::PERFIL;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }
    //LOGIN COM O GOOGLE
    public function redirectToGoogle()
    {      
        return Socialite::driver('google')->redirect();
    }
    
    public function handleGoogleCallback()
    {

        $user = Socialite::driver('google')->user();
        
        $this->_registerOrLoginUser($user);
        // Faça o login do usuário ou registre-o conforme necessário
        // $user contém as informações do usuário retornado pelo Google
    
        return redirect('/home'); // Redirecionar após o login
    }
    
    protected function _registerOrLoginUser($data)
        {
            
            $user = User::where('email', '=', $data->email)->first();
            // dd( $user);
            if (!$user) {
                $user = new User();
                $user->name = $data->name;
                $user->email = $data->email;
                $user->provider_id = $data->id;
                $user->avatar = $data->avatar;
                $user->save();
            }
    
            Auth::login($user);
        }
}
