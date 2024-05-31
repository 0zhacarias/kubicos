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

        .main-content {
            padding: 0px 20px;
        }

        .invoice-container {
            max-width: 1020px;
            margin: auto;

        }
        .titulos {
            color: #0034bb;
            font-weight: 500;
        }

        .note {
            text-align: center;
            margin-top: 1rem;
            font-size: 12px;
            color: #858585;
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
            border-left: 1px solid #1b2c1c;
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
            border-bottom: 1px solid #070707;
            font-size: 15px;
        }
    </style>
    
</head>
{{-- <div id="logo">
    <img width="210" src="img/LogoM/mutue_helpdesk-h.png">
</div> --}}
<header class="clearfix main-content1">
    <div id="company">
        <h2 class="name">Kubicos </h2>
        <div>(+244)922 969 192</div>
        <div>nokubico.com</div>
    </div>
    </div>
</header>

<body>
    <div id="details" class="main-content">
        <div>
            <div id="invoice">
                <h5>Relatório de Utilizadores
                    <span class="spas">Total de
                        Registros: {{ count($relatorioPessoaFuncao) }}
                    </span>
                </h5>
            </div>
            <div >
                <table>
                    <thead>
                        <th>#</th>
                        <th>Nome Completo</th>
                        <th>Email</th>
                        <th>Contacto </th>
                        <th>Função</th>
                        <th>Data de abertura de conta</th>
                    </thead>
                    <tbody>
                   @if (count($relatorioPessoaFuncao))
                            @foreach ($relatorioPessoaFuncao as $pessoa)
                                <tr>
                                    <td>{{ $loop->iteration }}</td>
                                    <td>{{ $pessoa->name}}</td>
                                    <td>{{ $pessoa->email }}</td>
                                    <td>{{ $pessoa->telefone }}</td>
                                    <td>{{ $pessoa->tipo_user->designacao}}</td> 
                                    <td>{{ $pessoa->created_at }}</td>
                            </tr>
                        @endforeach
                    @endif 
                </tbody>
            </table>
        <div class="note">Data de Impressão: {{ $datatime }}</div>
    </div>
</div>

</body>

</html>
<style>
    table {
    border-collapse: collapse;
    width: 100%;
}

table, thead, td {
    border: .3px solid black;
    
}

table,tbody th, td {
    padding: 8px;
    border: 1px solid black;
    font-size: .8rem;
    text-align: center;
}

</style>
    