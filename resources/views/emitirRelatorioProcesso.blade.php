<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Declaração do imóvel</title>

    <style>
        * {
            box-sizing: border-box;
            background: #fff;
            padding: 0px;
            margin: 0px;
        }


        body,
        html {
            font-family: "Roboto", serif;
            font-size: 16px;
            line-height: 1.5;
        }

        .header {
            display: flex;
            background: #fff;
            padding: 15px 20px;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 2rem;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.05);
        }

        .header {
            font-size: 32px;
            font-weight: bold;
            color: #0034bb;
        }

        .header .search {
            position: relative;
        }

        .header .search .icon {
            position: absolute;
            top: 5px;
            left: 5px;
        }

        .header .search .icon img {
            width: 24px;
            height: 24px;
            object-fit: cover;
        }

        .header .search .form-control {
            padding: 8px 10px;
            border-radius: 8px;
            font-size: 1rem;
            width: 100%;
            background: rgba(0, 52, 187, 0.06);
            border: 1px solid transparent;
            color: #2b2b2b;
            padding-left: 40px;
            outline: 0px;
        }

        .header .search .form-control:focus {
            background: #fff;
            border-color: #0034bb;
        }

        .header .search .form-control::placeholder {
            color: rgba(0, 52, 187, 0.5);
        }

        .main-content {
            padding: 0px 20px;
        }

        .invoice-container {
            max-width: 1020px;
            margin: auto;

        }

        .invoice-container .top {
            margin-bottom: 4rem;
            display: flex;
            justify-content: space-between;
        }

        .invoice-container .top .top-left {
            color: #0034bb;
        }

        .invoice-container .top .main {
            font-size: 40px;
            text-transform: uppercase;
            font-weight: 500;
            display: block;
            margin-bottom: 0.5rem;
        }

        .invoice-container .top .code {
            font-size: 24px;
        }

        .invoice-container .top .date {
            font-size: 18px;
            color: #adadad;
            margin-bottom: 10px;
        }

        .bill-box {
            display: flex;
            justify-content: space-between;
            margin-bottom: 4rem;
            color: #adadad;
        }

        .bill-box .left,
        .bill-box .right {
            max-width: 240px;
        }

        .bill-box .text-m {
            font-size: 18px;
            margin-bottom: 1rem;
            text-transform: uppercase;
        }

        .bill-box .title {
            font-size: 2rem;
            margin-bottom: 1rem;
            font-weight: 500;
            color: #2b2b2b;
        }

        .table-bill table {
            width: 100%;
            border-collapse: 0px;
            border-spacing: 0px;
            font-size: 1rem;
        }

        .table-bill th,
        .table-bill td {
            text-align: left;
            padding: 10px 10px;
        }

        .table-bill td {
            padding: 15px 10px;
        }

        .table-bill th {
            color: #0034bb;
            font-weight: 500;
        }

        .titulos {
            color: #0034bb;
            font-weight: 500;
        }

        .table-bill .quantity {
            width: 100px;
        }

        .table-bill .cost {
            text-align: right;
            white-space: nowrap;
        }

        .table-bill .total {
            font-size: 24px;
            color: #0034bb;
        }

        .table-bill .total td {
            font-weight: normal;
            border-top: 1px solid #ececec;
        }

        .table-bill .total .number {
            text-align: right;
            font-weight: 600;
        }

        .actions {
            text-align: center;
            margin-top: 4rem;
        }

        .actions .btn {
            margin: 3px;
            padding: 8px 10px;
            font-size: 1rem;
            text-transform: uppercase;
            font-weight: bold;
            border: 0px;
            min-width: 130px;
            color: #0034bb;
            border-radius: 8px;
            background: rgba(0, 52, 187, 0.06);
            cursor: pointer;
        }

        .actions .btn:hover {
            background: rgba(0, 52, 187, 0.1);
        }

        .note {
            text-align: center;
            margin-top: 1rem;
            font-size: 12px;
            color: #858585;
        }

        @media (max-width: 1320px) {

            body,
            html {
                font-size: 14px;
            }

            .invoice-container .top .date {
                font-size: 14px;
            }

            .invoice-container .top .main {
                font-size: 32px;
            }

            .invoice-container .top .code {
                font-size: 18px;
            }

            .bill-box .text-m {
                font-size: 14px;
            }

            .bill-box .title {
                font-size: 1.5rem;
            }

            .table-bill .total {
                font-size: 16px;
            }
        }

        @media (max-width: 768px) {
            .invoice-container .top {
                display: block;
            }

            .invoice-container .top .top-left {
                margin-bottom: 1rem;
            }

            .bill-box {
                display: block;
            }

            .bill-box .left,
            .bill-box .right {
                max-width: 100%;
            }

            .table-bill table,
            .table-bill tbody,
            .table-bill tfoot,
            .table-bill td,
            .table-bill th,
            .table-bill tr {
                display: block;
            }

            .table-bill th {
                display: none;
            }

            .table-bill tbody tr {
                padding: 10px 0px;
                border-bottom: 1px solid #070707;
            }

            .table-bill tbody tr td:first-child {
                display: none;
            }

            .table-bill td {
                padding: 5px 0px;
            }

            .table-bill .cost {
                text-align: left;
            }

            .table-bill .total {
                margin-top: 20px;
            }

            .table-bill .total td {
                border-top: 0px;
            }

            .table-bill .total .number {
                text-align: left;
            }
        }

        @media (max-width: 420px) {
            .actions .btn {
                width: 100%;
                margin: 5px 0px;
            }

            .header {
                display: block;
            }
        }

        .clearfix:after {
            content: "";
            display: table;
            clear: both;
            margin-bottom: 2px;
        }

        #company {
            float: right;
            text-align: right;
            font-family: Impact, Haettenschweiler, 'Arial Narrow Bold', sans-serif
        }

        #invoice {
            font-family: Impact, Haettenschweiler, 'Arial Narrow Bold', sans-serif
        }

        #invoice h5 {
            border-bottom: 2px solid #1b2c1c;
            font-size: 1.5em;
            line-height: 1em;
            font-weight: bold;
            margin: 0 0 20px 0;
            /* text-align: center; */
            {{--  font-family: Impact, Haettenschweiler, 'Arial Narrow Bold', sans-serif  --}}
        }

        #logo {
            float: left;
            margin: 25px;
        }

        .main-content1 {
            max-width: 1030px;
            margin: auto;
            /*    margin: 10px; */
            padding: 20px;
        }

        .line {
            border: 1px solid #070707;
        }

        .spas {
            float: right;
            font-weight: normal;
            font-size: 15px;
        }
    </style>
    
</head>
{{-- <div id="logo">
    <img width="210" src="img/LogoM/mutue_helpdesk-h.png">
</div> --}}
<header class="clearfix main-content1">
    <div id="company">
        <h2 class="name">Sistema de gestão de venda e arrendamento de imóveis</h2>
        {{-- <div>Rua Nossa Senhora da Muxima, Kinaxixi</div> --}}
        <div>Luanda-Angola</div>
        <div>(+244)922 969 192</div>
        <div>(+244)922 969 192</div>
        <div>nokubico.com</div>
    </div>
    </div>
</header>

<body>
    <div id="details" class="main-content">
        <div class="invoice-container">
            <div id="invoice">
                <h5>Declaração do processo do imóvel
                    <span class="spas">Total de
                        Registros:{{ count($emitirRelatorioProcesso) }}
                    </span>
                </h5>
            </div>
            <div class="table-bill">
                <table>
                    <thead>
                        <th>#</th>
                        <th>Nome do Imóvel</th>
                        <th>Localização publicado</th>
                        <th>Condição </th>
                        <th>Nome do Projecto</th>
                        {{-- <th>Tipo de operação</th> --}}
                        <th>Publicado por</th>
                        <th>Data e Hora de abertura</th>
                    </thead>
                    <tbody>
                        {{-- <table>
                            <tr>
                                <td>linha 1, coluna 1</td>
                                <td>linha 1, coluna 2</td>
                            </tr>
                            <tr>
                                <td>linha 2, coluna 1</td>
                                <td>linha 2, coluna 2</td>
                            </tr>
                            <tr>
                                <td>linha 3, coluna 1</td>
                                <td>linha 3, coluna 2</td>
                                <td>linha 3, coluna 3</td>
                                <td>linha 3, coluna 4</td>
                                <td>linha 3, coluna 5</td>
                            </tr>
                            <tr>
                                <td>linha 4, coluna 1</td>
                                <td>linha 4, coluna 2</td>
                                <td>linha 4, coluna 3</td>
                                <td>linha 4, coluna 4</td>
                                <td>linha 4, coluna 5</td>
                            </tr>

                        </table> --}}
                   @if (count($emitirRelatorioProcesso))
                            @foreach ($emitirRelatorioProcesso as $imovel)
                                <tr>
                                    <td><span class="subtitulos">{{ $loop->iteration }}</span></td>
                                    <td><span class="subtitulos">{!! $imovel->designacao !!}</span></td>
                                    <td><span class="subtitulos">{{ $imovel->localizacao }}</span></td>
                                    <td><span class="subtitulos">{{ $imovel->condicaoImoveis->designacao }}</span></td>
                                    {{-- <td><span class="subtitulos">{{ $imovel->actividadeImoveis[0]->operacaoImoveis->designacao }}</span></td> --}}
                                    <td><span class="subtitulos">{{ $imovel->usuario->pessoa->nome }}</span></td>
                                    <td><span class="subtitulos">
                                            {{-- @if ($imovel->resposta)
                                                @foreach ($imovel->resposta as $resposta)
                                                    @if ($resposta->user && $resposta->user->funcionario && $resposta->user->funcionario->funcao_id == 3)
                                                        {{ $resposta->user->funcionario->nome_funcionario }}
                                                    @break
                                                @endif
                                            @endforeach
                                        @endif --}}
                                    </span></td>
                                <td><span class="subtitulos">{{ $imovel->created_at }}</span></td>
                            </tr>
                            <tr>
                                <td><span class="titulos">Descrição</span></td>
                                <td colspan="7" class="line"><span
                                        class="subtitulos">{!! $imovel->descricao !!}</span></td>
                            </tr>
                        @endforeach
                    @endif 
                </tbody>
            </table>

            <div class="note">Nós confirmamos que esta declaração foi gerada pelo nosso sistema.</div>
        <div class="note">Data de Impressão: {{ $datatime }}</div>
    </div>
</div>

</body>

</html>
{{-- <style>
    table {
    border-collapse: collapse;
    width: 100%;
}

table, th, td {
    border: 1px solid black;
}

th, td {
    padding: 8px;
    text-align: center;
}

/* Estilizando as duas primeiras linhas */
table tr:nth-child(1),
table tr:nth-child(2) {
    background-color: #ccc; /* Cor de fundo das duas primeiras linhas */
}

/* Estilizando as outras linhas */
table tr:not(:first-child):not(:nth-child(2)) {
    background-color: #f2f2f2; /* Cor de fundo das outras linhas */
}
</style> --}}
    