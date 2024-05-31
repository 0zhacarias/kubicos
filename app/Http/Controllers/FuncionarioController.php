<?php

namespace App\Http\Controllers;

use App\Mail\EmailSenha;
use App\Models\Funcionario;
use App\Models\Pessoa;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Inertia\Inertia;

class FuncionarioController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $senha='KBC-'. User::count().date('m-d');
        // dd( $senha);
        $dados['pessoas'] = User::where('tipo_user_id', 1)->get();
        return Inertia::render('Admin/Clientes/Funcionario', $dados);
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
      

     //   DB::beginTransaction();
        try {
            
           
            $user = User::create(
                [
                    'name' => $request->get('name'),
                    'email' => $request->get('email'),
                    'telefone' => $request->get('telefone'),
                    'password' => Hash::make($request->get('telefone')),
                    //'password' => 'KBC-'. User::count().date('m-d'),
                    'tipo_user_id' => 1,
                ]
            );
            $senha=$request->get('telefone');
           // $senha='KBC-'. User::count().date('m-d');
           // $user->assignRole('Administrador');
           $user->assignRole('Funcionarios');
            $pessoas=Pessoa::create([
                'nome'=>$request->get('name'),
                'sobre_nome'=>$request->get('name'),
                'telefone'=>$request->get('telefone'),
                'email' => $request->get('email'),
                'user_id'=>$user->id,
            ]);
            $nome = $user->name;
        $email=$user->email;
            $url = action([ImoveisController::class, 'portal_imovel']);
        // dd($solicitavisita);
        //Mail::to('zhacarias50@outlook.com')
        Mail::to($email)
        ->send(new EmailSenha(
            $nome,
            $senha,
            $url,
        ));
            //return $this->emailSenha($user);
        //    DB::commit();
            return redirect()->back()->with('success','Funcionario cadastrado com sucesso');
        } catch (\Throwable $th) {
         //   DB::rollBack();
         
           return redirect()->back()->with('error','Não foi possivel cadastrar o funcionario');
        }

    }
    public function emailSenha($usuario)
    {
        $nome = $usuario->name;
        $senha = $usuario->password;
        $email=$usuario->email;
        dd($nome,$senha,$email);
        // Imovel
        //Informação da visita
        $url = action([ImoveisController::class, 'portal_imovel']);
        // dd($solicitavisita);
        //Mail::to('zhacarias50@outlook.com')
        Mail::to($email)
        ->send(new EmailSenha(
            $nome,
            $senha,
            $url,
        ));
        
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Funcionario  $funcionario
     * @return \Illuminate\Http\Response
     */
    public function show(Funcionario $funcionario)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Funcionario  $funcionario
     * @return \Illuminate\Http\Response
     */
    public function edit(Funcionario $funcionario)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Funcionario  $funcionario
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        
        $funcionario=User::find($id);
        $funcionario->update([
            'name'=>$request->get('name'),
            'telefone'=>$request->get('telefone'),
            'email' => $request->get('email'),
            'user_id'=>$funcionario->id,
        ]);
        // dd($funcionario);
        $pessoa=Pessoa::where('user_id',$funcionario->id)->first();
        $pessoa->update([
            'nome'=>$request->get('name'),
            'sobre_nome'=>$request->get('name'),
            'email' => $request->get('email'),
            'user_id'=>$funcionario->id,
            ]
        );
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Funcionario  $funcionario
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $funcionario=User::find($id);
        $pessoa=Pessoa::where('user_id',$funcionario->id)->first();
        $pessoa->delete();
        $funcionario->delete();

    }
}
