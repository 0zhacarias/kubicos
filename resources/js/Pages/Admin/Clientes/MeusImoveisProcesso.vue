<template>
    <Cliente>
        <v-container class="w-90 justify-space-around">
            <!-- <v-subheader class="text-h5 text-bold mt-10 ">Minhas solicitações: {{ imoveis_processos.length }}</v-subheader>  -->

            <v-row>
                <v-col cols="12" md="12" class="pa-0  mt-15 indigo">
                    <v-card-actions>
                        <span class=" white--text text-bold text-h5">
                            Minhas solicitações: {{ imoveis_processos.length }}
                        </span>

                        <v-spacer></v-spacer>
                        <v-card-title>
                            <v-text-field v-model="search" append-icon="mdi-magnify" label="Pesquisar" outlined dense dark
                                single-line hide-details></v-text-field>
                        </v-card-title>
                        <!-- <v-text-field v-model="imobiliaria.pesquisar" outlined dense label="Contacto*" type="text">
                        </v-text-field> -->
                        <v-btn icon elevation="5" color="indigo" class="white" outlined rounded title="Pesquisar"
                            @click="carregarDialogimobiliaria(item)">
                            <v-icon>
                                mdi-magnify
                            </v-icon>

                        </v-btn>
                        <v-btn icon color="indigo" outlined rounded class="white" title="Emitir Relatório do processo"
                            @click="emitirRelatoriosProcesso(item)">
                            <v-icon>
                                mdi mdi-file-document-multiple
                            </v-icon>
                        </v-btn>
                    </v-card-actions>
                </v-col>
                <v-col v-for="item in imoveis_processos" :key="item.id" cols="12" sm="6" md="4"
                    :lg="imoveis_processos.length <= 2 ? 6 : 4">
                    <v-hover v-slot="{ hover }">

                        <v-card :loading="!loading" class=" elevation-10 pa-2 ma-3 border" :elevation="hover ? 10 : 0">
                            <!-- <v-img height="150" src="/img/pexels-dids-2969915.jpg"></v-img> -->
                            <v-img height="180" gradient="to bottom, rgba(0,0,0,.4), rgba(0,0,0,.2)" :src="'/storage/' +
                                item.foto_principal"></v-img>
                            <v-card-text class="mb-0 pb-0 indigo--text"> Código: {{ item.codigo_imovel }}</v-card-text>
                            <v-card-text class="my-0 py-0 "> Valor a pagar:
                                <v-card-title class="mt-0 py-0 indigo--text">
                                    {{ formatValor(item.preco) }} KZ
                                </v-card-title>
                            </v-card-text>
                            <v-card-text class="my-0 py-0"> Designação:
                                <v-card-text class="my-0 py-0 indigo--text text-h6" v-text="item.designacao"></v-card-text>
                            </v-card-text>
                            <v-card-text>
                                <!-- <v-row align="center" class="mx-0">
                                        <v-rating :value="4.5" color="amber" dense half-increments readonly
                                            size="14"></v-rating>
                                    </v-row> -->

                                <div>{{ item.descricao }}
                                </div>
                            </v-card-text>

                            <v-divider class="mx-1 my-0 py-0"></v-divider>

                            <!-- <v-scard-title v-text="item.descricao"></v-scard-title> -->

                            <v-card-actions class="pa-0 ma-0">
                                <v-chip-group v-model="selection" active-class="deep-purple accent-4 white--text" column>
                                    <v-chip><span class="mdi mdi-seat-individual-suite" title="Dormitório">{{ item.suite
                                    }}</span></v-chip>
                                    <v-chip><span class="mdi mdi-car" title="Garagem">{{ item.numero_garagem
                                    }}</span></v-chip>
                                    <v-chip><span class="mdi mdi-chart-areaspline-variant" title="Superficie ">{{
                                        item.metros
                                    }}<sup>2</sup></span></v-chip>

                                    <v-chip title="Cozinha"><span class="mdi mdi-countertop"></span>{{ item.cozinha
                                    }}</v-chip>
                                    <v-chip title="Quarto de Banho">
                                        <span class="mdi mdi-shower-head"></span>{{
                                            item.numero_banheiro }}</v-chip>
                                    <v-chip v-for="(actidade) in item.actividade_imoveis" :key="actidade.id"
                                        v-if="actidade.tempo_arrendar > 0">

                                        <span class="mdi mdi-timer-lock-outline" title="Arrendamento"></span>{{
                                            actidade.tempo_arrendar }} </v-chip>
                                    <!--    <v-chip title="estado do imóvel" :color="getcor(item.estado_imoveis_id)"
                                        class="white--text text-bold">
                                        <span v-if="item.estado_imoveis_id == 1" class="mdi mdi-archive-lock-open "></span>
                                        <span v-if="item.estado_imoveis_id == 2" class="mdi mdi-archive-remove"></span>
                                        <span v-if="item.estado_imoveis_id == 3" class="mdi mdi-archive-cog "></span>
                                        <span v-if="item.estado_imoveis_id == 4" class="mdi mdi-archive-eye"></span>
                                        <span v-if="item.estado_imoveis_id == 5" class="mdi mdi-archive-refresh"></span>

                                        {{ item.estado_imoveis.designacao }}</v-chip> -->

                                    <span v-if="item.solicitacao_imoveis.length > 0">
                                        <span v-for="(solicitacao) in item.solicitacao_imoveis" :key="solicitacao.id">

                                            <span
                                                v-if="solicitacao.user_marca_visita == user.id && solicitacao.imoveis_id == item.id">
                                                <v-chip outlined title="estado do imóvel" class="white--text"
                                                    :color="getcor(solicitacao.estado_imoveis_id)"
                                                   >
                                                    <span v-if="solicitacao.estado_imoveis_id == 8"
                                                        class="mdi mdi-archive-remove">Em negociacao</span>
                                                    <!-- <span v-if="solicitacao.estado_imoveis_id == 3" class="mdi mdi-archive-cog "></span> -->
                                                    <span v-if="solicitacao.estado_imoveis_id == 4"
                                                        class="mdi mdi-archive-eye">Visita pendentes</span>
                                                    <span v-if="solicitacao.estado_imoveis_id == 5"
                                                        class="mdi mdi-archive-refresh">{{ 'Visita confirmada' }}</span>

                                                </v-chip>
                                            </span>
                                            <span v-else>
                                                <v-chip outlined title="estado do imóvel" class="white--text"
                                                    :color="getcor(solicitacao.estado_imoveis_id)">
                                                    <span v-if="solicitacao.estado_imoveis_id == 8"
                                                        class="mdi mdi-archive-remove">Em negociacao</span>
                                                    <!-- <span v-if="solicitacao.estado_imoveis_id == 3" class="mdi mdi-archive-cog "></span> -->
                                                    <span v-if="solicitacao.estado_imoveis_id == 4"
                                                        class="mdi mdi-archive-eye">Visita pendentes</span>
                                                    <span v-if="solicitacao.estado_imoveis_id == 5"
                                                        class="mdi mdi-archive-refresh">{{ 'Visita confirmada' }}</span>

                                                </v-chip>
                                            </span>
                                        </span>

                                    </span>
                                    <v-chip v-else outlined title="estado do imóvel" class="white--text"
                                        :color="getcor(item.estado_imoveis_id)">

                                        <span v-if="item.estado_imoveis_id == 1" class="mdi mdi-archive-lock-open "></span>
                                        <span v-if="item.estado_imoveis_id == 2" class="mdi mdi-archive-remove"></span>
                                        <span v-if="item.estado_imoveis_id == 5" class="mdi mdi-archive-refresh"></span>

                                        {{ item.estado_imoveis.designacao }}
                                    </v-chip>

                                </v-chip-group>
                            </v-card-actions>
                            <v-card-actions class="justify-end m-0 p-0">

                                 <span v-for="(solicitacao) in item.solicitacao_imoveis" :key="solicitacao.id" 
                                            >
                                    <v-btn icons
                                        :disabled="solicitacao.estado_imoveis_id !== 5 || user.tipo_user.id === 1"
                                        color="green" outlined rounded title="Gostei do Imóvel"
                                        v-model="validar_gostar.valiado"  @click="gostarImovel(item.id)"
                                     >
                                        <v-icon>
                                            mdi mdi-thumb-up
                                        </v-icon>
                                    </v-btn>
                            

                                <v-btn icon :disabled="solicitacao.estado_imoveis_id !== 5 || user.tipo_user.id == 1" color="red"
                                    outlined rounded title="Não gostei do Imóvel" @click="naogostarImovel(item.id)"
                                    v-model="validar_gostar.naoValiado">
                                    <v-icon>
                                        mdi mdi-thumb-down
                                    </v-icon>
                                </v-btn>
                                <v-btn icon
                                    v-if="user.tipo_user.id == 1 && solicitacao.estado_imoveis_id == 4 && solicitacao.estado_imoveis_id != 1"
                                    color="orange" outlined rounded title="Nao Aprovar a visita do imóvel"
                                    @click="naoValidarVisita(item.id)" v-model="validar_processo.aprovaVisita">
                                    <v-icon>
                                        mdi mdi-handshake

                                    </v-icon>
                                </v-btn>
                                <v-btn icon
                                    v-if="user.tipo_user.id == 1 && solicitacao.estado_imoveis_id == 4 && solicitacao.estado_imoveis_id != 1"
                                    color="indigo" outlined rounded title="Aprovar a visita do imóvel"
                                    @click="validaVisita(item.id)" v-model="validar_processo.naoAprovarVisita">
                                    <v-icon>
                                        mdi mdi-handshake
                                    </v-icon>
                                </v-btn>
                            </span>
                                <v-btn icon v-if="user.tipo_user.id == 1 && item.estado_imoveis_id == 8" color="red"
                                    outlined rounded title="Para com a negociação"
                                    @click="cancelarProcessoNegociacao(item.id)"
                                    v-model="validar_processo.naoAprovarVisita">
                                    <v-icon>
                                        mdi mdi-hand-back-left-off-outline

                                    </v-icon>
                                </v-btn>
                                <v-btn icon
                                    v-if="user.tipo_user.id == 1 && item.estado_imoveis_id == 3 && item.estado_imoveis_id != 1"
                                    color="red" outlined rounded title="Nao Aprovar o imóvel"
                                    @click="naoAprovarImovel(item.id)" v-model="validar_processo.aprovaVisita">
                                    <v-icon>
                                        mdi mdi-handshake

                                    </v-icon>
                                </v-btn>
                           
                                <v-btn icon
                                    v-if="user.tipo_user.id == 1 && item.estado_imoveis_id == 3 && item.estado_imoveis_id != 1"
                                    color="indigo" outlined rounded title="Validar veracidade do imóvel"
                                    @click="aprovarImovel(item.id)" v-model="validar_processo.naoAprovarVisita">
                                    <v-icon>
                                        mdi mdi-handshake
                                    </v-icon>
                                </v-btn>
                                <v-btn icon v-if="item.estado_imoveis_id == 6 || item.estado_imoveis_id == 7" color="indigo"
                                    outlined rounded title="Emitir declaração do Imóvel" @click="imprirDadosImovel(item.id)"
                                    v-model="validar_gostar.valiado">
                                    <v-icon>
                                        mdi mdi-file-document-multiple
                                    </v-icon>
                                </v-btn>
                           
                            </v-card-actions>
                        </v-card>
                    </v-hover>
                </v-col>
            </v-row>
            <div class="text-center">
                <v-snackbar v-model="snackbar" :multi-line="multiLine" :timeout="8000" outlined
                    color="deep-purple accent-4">
                    {{ textvalidado }}
                    <v-btn color="indigo" text @click="snackbar = false">
                        Close
                    </v-btn>
                </v-snackbar>
            </div>
            <!-- :multi-line="multiLine" -->
            <div class="text-center">
                <v-snackbar v-model="snackbarNaovalidado" :multi-line="multiLine" :timeout="8000" outlined
                    color="deep-purple accent-4">
                    {{ textnaovalidado }}
                    <v-btn color="indigo" text @click="snackbarNaovalidado = false">
                        Close
                    </v-btn>
                </v-snackbar>
            </div>
        </v-container>
    </Cliente>
</template>

<script>
import Cliente from "../Clientes/Cliente";
export default {

    props: ["imoveis_processos"],
    components: {
        Cliente
    },
    data: () => ({
        found: false,
        loading: null,
        snackbar: false,
        textnaovalidado: `Descontinuidade do processo da negociação do Imóvel`,
        textvalidado: `Confirmaste a continuação da negociação do Imóvel Confirmaste a continuação da negociação do Imóvel`,
        snackbarNaovalidado: false,
        validar_processo: {},
        validar_gostar: {},
        dadoscarregado: [],
        processedSolicitacoes: [],
    }),


    mounted() {
        this.isUniqueSolicitacao()
        this.loading = true;
        setTimeout(function () {
            this.loading = false;
        }, 2000);

        for (let i = 0; i < this.item.solicitacao_imoveis.length; i++) {
            const item = this.items[i];
            if (!this.found) {
                if (this.solicitacao.user_marca_visita !== this.user.id && this.solicitacao.imoveis_id == item.id) {
                    this.found = true; // Define a variável de controle para true e quebra o loop
                }
            }
        }
        // alert(this.condominios);
    },
    computed: {
        user() {
            return this.$page.props.auth.user;
        },

    },

    created() {
        this.getcor(estado_imoveis_id);
        // this.getImoveisprocesso()
        setTimeout(() => {
            this.overlay = false;
        }, 2000);
    },

    watch: {

    },

    methods: {
        getcor(estado_imoveis_id) {
            if (estado_imoveis_id == 1) {
                return 'green'
            } else if (estado_imoveis_id == 2) {
                return 'deep-orange darken-4'
            } else if (estado_imoveis_id == 3) {
                return 'blue-grey darken-4'
            } else if (estado_imoveis_id == 4) {
                return 'yellow darken-3'
            } else if (estado_imoveis_id == 5) {
                return 'deep-purple darken-2'
            } else if (estado_imoveis_id == 6) {
                return 'red darken-4'
            } else if (estado_imoveis_id == 7) {
                return 'red darken-4'
            } else if (estado_imoveis_id == 8) {
                return 'amber accent-4'
            }
        },
        formatValor: function (atual) {
            const valorFormatado = Intl.NumberFormat("pt-br", {
                style: "currency",
                currency: "AOA",
            }).format(atual);
            const valorNumerico = valorFormatado.replace(/AOA/g, '').trim();
            return valorNumerico;
        },
        getImoveisprocesso() {
            this.loading = true;
            this.validar_processo.imovel_id = item
            axios
                .get("/carregar-imoveis-processo")
                .then((response) => {
                    this.dadoscarregado = response.data;
                    this.snackbar = true;
                    alert(JSON.stringify(response.data));
                })
                .catch(() => {
                    alert(JSON.stringify(response.data));
                });
        },
        gostarImovel(item) {
            this.loading = true;
            this.validar_gostar.imovel_id = item
            // alert(JSON.stringify( this.validar_processo));
            axios
                .post("/gostar-imovel", this.validar_gostar)
                .then((response) => {
                    this.loading = true;
                    this.snackbar = true;
                    alert(JSON.stringify(response.data));
                })
                .catch(() => {
                    alert(JSON.stringify(response.data));
                    //   console.log('Falha ao registar os dados na base de dados!...')
                });
             //   location.reload();
        },
        naogostarImovel(item) {
            this.loading = true;
            this.validar_gostar.imovel_id = item
            axios
                .post("/nao-gostar-imovel", this.validar_gostar)
                .then((response) => {
                    this.loading = true;
                    this.snackbarNaovalidado = true;
                })
                .catch(() => {
                    // alert(JSON.stringify(response.data));
                    //   console.log('Falha ao registar os dados na base de dados!...')
                });
           // location.reload();
        },
        validaVisita(item) {

            this.loading = true;
            this.validar_processo.imovel_id = item
            // alert(JSON.stringify( this.validar_processo));
            axios
                .post("/validar-processo", this.validar_processo)
                .then((response) => {
                    this.loading = true;
                    this.snackbar = true;
                    alert(JSON.stringify(response.data));
                })
                .catch(() => {
                    alert(JSON.stringify(response.data));
                    //   console.log('Falha ao registar os dados na base de dados!...')
                });
        },
        naoValidarVisita(item) {

            this.loading = true;
            this.validar_processo.imovel_id = item
            axios
                .post("/nao-validar-processo", this.validar_processo)
                .then((response) => {
                    this.loading = true;
                    this.snackbarNaovalidado = true;
                })
                .catch(() => {
                    // alert(JSON.stringify(response.data));
                    //   console.log('Falha ao registar os dados na base de dados!...')
                });
            //location.reload();
        },
        naoAprovarImovel(item) {
            this.loading = true;
            this.validar_processo.imovel_id = item
            axios
                .post("/nao-validar-imovel", this.validar_processo)
                .then((response) => {
                    this.loading = true;
                    this.snackbarNaovalidado = true;
                })
                .catch(() => {
                    // alert(JSON.stringify(response.data));
                    //   console.log('Falha ao registar os dados na base de dados!...')
                });
            location.reload();
        },
        aprovarImovel(item) {
            this.loading = true;
            this.validar_processo.imovel_id = item
            // alert(JSON.stringify( this.validar_processo));
            axios
                .post("/validar-imovel", this.validar_processo)
                .then((response) => {
                    this.loading = true;
                    this.snackbar = true;

                })
                .catch(() => {
                    alert(JSON.stringify(response.data));
                    //   console.log('Falha ao registar os dados na base de dados!...')
                });
            // location.reload();
        },

        cancelarProcessoNegociacao(item) {
            this.loading = true;
            this.validar_processo.imovel_id = item
            axios
                .post("/cancelar-processo", this.validar_processo)
                .then((response) => {
                    this.loading = true;
                    this.snackbarNaovalidado = true;
                })
                .catch(() => {
                    // alert(JSON.stringify(response.data));
                    //   console.log('Falha ao registar os dados na base de dados!...')
                });
            // location.reload();
        },
        imprirDadosImovel: function () {
            window.open(
                // alert(JSON.stringify(this.query)),
                "/pdfs/listar-pdf-funcionarios/"
            );
        },
        imprirDadosImovel(item) {
            window.open(
                "/imprimir-documentacao/" + item
            )
            // this.loading = true;
            // this.validar_processo.imovel_id = item
            // axios
            //     .post("/imprimir-documentacao", this.validar_processo)
            //     .then((response) => {
            //         this.loading = true;
            //         this.snackbarNaovalidado = true;
            //     })
            //     .catch(() => {
            //         // alert(JSON.stringify(response.data));
            //         //   console.log('Falha ao registar os dados na base de dados!...')
            //     });
            // // location.reload();
        },
        emitirRelatoriosProcesso() {
            window.open(
                "/emitir-relatorios-processo"
            )
        }

    },
};
</script>
<style></style>