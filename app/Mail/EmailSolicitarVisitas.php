<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class EmailSolicitarVisitas extends Mailable
{
    use Queueable, SerializesModels;
    public $referenca;
    public $mensagem;
    public $nome_cliente;
    public $url;
    public $designacao_imovel;
   // public $localizacao;
    public $preco;
    public $condicao_imovel;
    //public $data_visita;
   // public $hora_visita;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct(
        string $referenca,
        string $mensagem,
        string $nome_cliente,
        string $url,
        string $designacao_imovel,
        string $preco,
        string $condicao_imovel
     //   string $data_visita,
       // string $hora_visita
    )
    {
        $this->referenca = $referenca;
        $this->mensagem = $mensagem;
        $this->$nome_cliente= $nome_cliente;
        $this->url = $url;
        $this->designacao_imovel = $designacao_imovel;
     //   $this->localizacao = $localizacao;
        $this->preco = $preco;
        $this->condicao_imovel = $condicao_imovel;
      //  $this->data_visita = $data_visita;
        //$this->hora_visita = $hora_visita;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->markdown('Email.ComunicadoCliente', [
            'url' => $this->url,
        ]);
    }
}
