@component('mail::message')
    Cordiais saudações, senhor(a):{{ $nome }}, damos lhe as boas vindas a equipe senhor(a) 
    <>A sua senha é para o acesso ao siste é: {{ $senha }} </p>
    Clique no Botão a baixo para ser rediricionado ao site Kubicos:
    @component('mail::button', ['url' => $url])
        Autenticar-se
    @endcomponent
    Atenciosamente ,<br>
  NOKubicos({{ config('app.name') }})
@endcomponent