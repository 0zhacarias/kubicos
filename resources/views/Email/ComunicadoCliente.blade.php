@component('mail::message')
    Cordiais saudações senhor :{{ $nome_cliente }}
    <p>{{ $mensagem }} </p>
    <p>Detalhes do seu Imovel</p>
   <p> Designação do imovel : {{ $designacao_imovel }}
  {{-- Localização do imovel : {{ $localizacao }} " " --}}
    Condição do imovel : {{ $condicao_imovel }}</p>
    Valor do imovel : {{ $preco }}
   <p>Por favor verifica o estado do seu Imóvel com a referernça:{{ $referenca }} </p>

    Clique no Botão a baixo para ser rediricionado ao site Kubicos:
    @component('mail::button', ['url' => $url])
        Verificar
    @endcomponent
    Atenciosamente ,<br>
   Kubicos({{ config('app.name') }})
@endcomponent