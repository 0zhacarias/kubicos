@component('mail::message')
    Cordiais saudações senhor :{{ $nome }}
    <p>A sua senha é </p>
    <p>{{ $senha }} </p>
    Clique no Botão a baixo para ser rediricionado ao site Kubicos:
    @component('mail::button', ['url' => $url])
        Verificar
    @endcomponent
    Atenciosamente ,<br>
  NOKubicos({{ config('app.name') }})
@endcomponent