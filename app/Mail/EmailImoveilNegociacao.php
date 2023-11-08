<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class EmailImoveilNegociacao extends Mailable
{
    use Queueable, SerializesModels;
    public $mensagem;
    public $nome_marca_visita;
    public $url;
    public $designacao_imovel;
    public $localizacao;
    public $preco;
    public $condicao_imovel;
    public $data_visita;
    public $hora_visita;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct(
        string $mensagem,
        string $nome_marca_visita,
        string $url,
        string $designacao_imovel,
        string  $localizacao,
        string $preco,
        string $condicao_imovel,
        string $data_visita,
        string $hora_visita
    ) {
        $this->mensagem = $mensagem;
        $this->nome_marca_visita = $nome_marca_visita;
        $this->url = $url;
        $this->designacao_imovel = $designacao_imovel;
        $this->localizacao = $localizacao;
        $this->preco = $preco;
        $this->condicao_imovel = $condicao_imovel;
        $this->data_visita = $data_visita;
        $this->hora_visita = $hora_visita;
        // dd($designacao_imovel);
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->markdown('Email.name', [
            'url' => $this->url,
        ]);
    }
}
