@component('mail::message')
    Cordiais saudações senhor :{{ $nome_marca_visita }}
    <p>{{ $mensagem }} </p>
    <p>Detalhes do seu Imovel</p>
   <p> Designação do imovel : {{ $designacao_imovel }}
    Localização do imovel : {{ $localizacao }} " "
    Condição do imovel : {{ $condicao_imovel }}</p>
    Valor do imovel : {{ $preco }}
    Data e hora MArcada : {{ $data_visita }} - {{ $hora_visita }}
    <p>Por favor confirme a nesse mesmo E-mail </p>

    Clique no Botão a baixo para ser rediricionado ao site Kubicos:
    @component('mail::button', ['url' => $url])
        Verificar
    @endcomponent
    Atenciosamente ,<br>
   Kubicos({{ config('app.name') }})
@endcomponent