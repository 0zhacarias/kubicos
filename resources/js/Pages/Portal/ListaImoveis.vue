<template>
    <PortalLayout>


        <v-row>
            <v-col cols="4">
                <v-card class="my-4 py-4 grey lighten-4" elevation="0">
                    <v-row>
                        <v-col cols="4">

                        </v-col>
                        <v-col cols="8">

                            <v-row class="mx-0 mt-0">
                                <v-card elevation="0" class="mt-3 px-0 transparent" :style="'border-radius: 10px'">
                                    <v-card-title color="deep-purple--text">O que estás a procura</v-card-title>
                                    <v-card-text color="deep-purple accent-4">
                                        <v-row>
                                            <v-col cols="12" class="pt-6 mb-n8 ">
                                                <v-autocomplete prepend-icon="" :items="tipoImoveis" item-text="designacao"
                                                    item-value="id" label="Tipo de Imóvel" type="text" clearable outlined
                                                    v-model="query.id_tipo_imoveis" dense no-data-text="sem dados"
                                                    @change="FiltrarImoveis()">
                                                </v-autocomplete>
                                            </v-col>
                                            <v-col cols="6" class="opens-sans mb-n8">
                                                <v-autocomplete @change="FiltrarImoveis()" clearable
                                                    v-model="query.preco_inicio" :items="itervalo_precos"
                                                    item-text="designacao" item-value="id" prepend-icon="" 
                                                    label="Intervalo de preço" dense no-data-text="sem dados" outlined
                                                    type="number" >
                                                </v-autocomplete>
                                            </v-col>
                                            <v-col cols="6" class="opens-sans mb-n8">
                                                <v-autocomplete @change="FiltrarImoveis()" clearable
                                                    v-model="query.preco_final" :items="itervalo_precos"
                                                    item-text="designacao" item-value="id" prepend-icon=""
                                                    label="Intervalo de preço" dense no-data-text="sem dados" outlined
                                                    type="number">
                                                </v-autocomplete>
                                            </v-col>
                                        </v-row>
                                        <v-row>
                                            <v-col cols="12" class="pt-6 mb-n8 ">
                                                <v-autocomplete prepend-icon="" :items="provincias" item-text="designacao"
                                                    item-value="id" label="Provincia" type="text" clearable outlined
                                                    v-model="query.provincia_id" dense no-data-text="sem dados"
                                                    @change="FiltrarImoveis()">
                                                </v-autocomplete>
                                            </v-col>

<!--                                             <v-col cols="12" class="pt-6 mb-n8">
                                                <v-autocomplete @change="FiltrarImoveis()" clearable v-model="query.valor"
                                                    :items="funcionario_operadores" item-text="nome_funcionario"
                                                    item-value="id" prepend-icon="" label="Valores" outlined dense
                                                    no-data-text="sem dados">
                                                </v-autocomplete>
                                            </v-col> -->

                                            <v-col cols="12" class="pt-6 mb-n8">
                                                <v-autocomplete class="custom-autocomplete" @change="FiltrarImoveis()"
                                                    clearable v-model="query.condicoes_imoveis_id" :items="CondicoesImoveis"
                                                    item-text="designacao" item-value="id" prepend-icon=""
                                                    label="Condições do imóvel" outlined dense no-data-text="sem dados">
                                                    <!-- <template v-slot:item="data">
                                                {{ data.item.nome_funcionario }}
                                                {{ data.item.sobre_nome_funcionario }}
                                            </template> -->
                                                </v-autocomplete>
                                            </v-col>
                                            <v-col cols="12" class="pt-6 mb-n8">
                                                <v-autocomplete class="custom-autocomplete" @change="FiltrarImoveis()"
                                                    clearable v-model="query.estado_imoveis_id" :items="estadoImoveis"
                                                    item-text="designacao" item-value="id" prepend-icon=""
                                                    label="Estado do imóvel" outlined dense no-data-text="sem dados">
                                                    <!-- <template v-slot:item="data">
                                                {{ data.item.nome_funcionario }}
                                                {{ data.item.sobre_nome_funcionario }}
                                            </template> -->
                                                </v-autocomplete>
                                            </v-col>
                                        </v-row>
                                        <v-row>
                                            <v-col cols="6" class="pt-13">
                                                <v-text-field clearable label="Data inicial" class="my-n8 rounded"
                                                    v-model="query.data_inicial" type="date" :error-messages="erros.dat_inicio_real
                                                        " dense outlined>
                                                </v-text-field>
                                            </v-col>
                                            <v-col cols="6" class="pt-13">
                                                <v-text-field clearable label="Data termino" v-model="query.data_final"
                                                    class="my-n8 rounded" @input="FiltrarImoveis()" type="date"
                                                    :error-messages="erros.data_final" dense outlined>
                                                </v-text-field>
                                            </v-col>
                                        </v-row>
                                    </v-card-text>
                                </v-card>
                            </v-row>

                        </v-col>
                    </v-row>
                </v-card>
            </v-col>


            <v-col cols="7" sm="7" md="7">
                <template>
                    <v-card class="ma-4 pa-4  grey lighten-4 " elevation="0">
                        <v-card-title>
                            <span class="text-uppercase" style="font-size: 20px">
                                Total: {{ ImoveisComprar.length }}</span>
                        </v-card-title>
                    </v-card>

                    <v-dialog v-model="dialogN" max-width="400px">
                        <v-card class="" max-width="400">
                            <v-list>
                                <v-list-item>
                                    <v-list-item-avatar>
                                        <img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John">
                                    </v-list-item-avatar>

                                    <v-list-item-content>
                                        <v-list-item-title class="subtitle-1 text-h5">KUBICOS</v-list-item-title>
                                        <v-list-item-subtitle>Entre em contacto com um corretor</v-list-item-subtitle>
                                    </v-list-item-content>

                                    <v-list-item-action>
                                        <v-btn :class="fav ? 'red--text' : ''" icon @click="fav = !fav">
                                            <v-icon>mdi-heart</v-icon>
                                        </v-btn>
                                    </v-list-item-action>
                                </v-list-item>
                            </v-list>
                            <v-col cols="12">
                                <v-text-field v-model="email" outlined dense :error-messages="errors" label="E-mail"
                                    required></v-text-field>

                            </v-col>
                            <v-col cols="12">
                                <v-textarea v-model="phoneNumber" dense outlined :error-messages="errors"
                                    label="Informe o seu comentario aqui" required rows="3"></v-textarea>
                            </v-col>
                            <v-card-actions>
                                <v-spacer></v-spacer>

                                <v-btn color="red" text @click="dialogN = false">
                                    Cancel
                                </v-btn>
                                <v-btn color="primary" text @click="dialogN = false">
                                    Save
                                </v-btn>
                            </v-card-actions>
                        </v-card>
                        <!-- <v-card> -->
                        <!-- <v-card-text class="text-h6 py-2">
                        Não existe funcionario_tecnicos associado!
                    </v-card-text> -->
                        <!-- <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn
                            color="red"
                            dark
                            @click="dialogN = false"
                            >Fechar</v-btn
                        >

                        <v-spacer></v-spacer>
                    </v-card-actions> -->
                        <!-- </v-card> -->
                    </v-dialog>
                    <v-dialog v-model="dialogContacto" max-width="400px">
                        <v-card class="" max-width="400">
                            <v-list>
                                <v-list-item>
                                    <v-list-item-avatar>
                                        <img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John">
                                    </v-list-item-avatar>

                                    <v-list-item-content>
                                        <v-list-item-title class="subtitle-1 text-h5">KUBICOS</v-list-item-title>
                                        <v-list-item-subtitle>Entre em contacto com um corretor</v-list-item-subtitle>
                                    </v-list-item-content>

                                    <v-list-item-action>
                                        <v-btn :class="fav ? 'red--text' : ''" icon @click="fav = !fav">
                                            <v-icon>mdi-heart</v-icon>
                                        </v-btn>
                                    </v-list-item-action>
                                </v-list-item>
                            </v-list>
                            <v-col cols="12">
                                <v-card-actions>+244 (992-963-9856) /+244 (992-963-9856)</v-card-actions>
                                <v-card-actions>+244 (992-963-9856)</v-card-actions>

                                <v-spacer></v-spacer>
                                <v-btn color="primary" text @click="dialogContacto = false">
                                    Ok
                                </v-btn>
                            </v-col>
                            <v-card-actions>
                            </v-card-actions>
                        </v-card>
                        <!-- <v-card> -->
                        <!-- <v-card-text class="text-h6 py-2">
                        Não existe funcionario_tecnicos associado!
                    </v-card-text> -->
                        <!-- <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn
                            color="red"
                            dark
                            @click="dialogN = false"
                            >Fechar</v-btn
                        >

                        <v-spacer></v-spacer>
                    </v-card-actions> -->
                        <!-- </v-card> -->
                    </v-dialog>




                    <template v-for="item in ImoveisComprar">
                        <!-- <inertia-link
                                                                    :href="`/tickets/visualizar-resposta/${item.id}` "
                                                                > -->
                        <v-hover v-slot="{ hover }">
                            <v-card class="ma-5 pa-0" :elevation="hover ? 6 : 0" @click.stop="findimoveis(item.id)">
                                <template>
                                    <!--   <card> -->
                                    <v-list-item-content>
                                        <v-row>
                                            <v-col md="8" class="px-4" justify="center">
                                                <v-card-text>
                                                    <!-- <v-spacer></v-spacer> -->

                                                    <v-list-item-title class="font-weight-bold  text-subtitle-1">
                                                        <span class="deep-purple--text">{{
                                                            item.designacao

                                                        }}</span>
                                                    </v-list-item-title>
                                                    <v-list-item-title class="text-subtitle-2">
                                                        <p class="lighten-1--text"
                                                            v-html="quebraDeLinhaItem(item.descricao)"></p>
                                                    </v-list-item-title>

                                                    <v-list-item-title class="font-weight-bold text-h6">
                                                        <span class="">Total KZ: {{
                                                            item.preco

                                                        }}</span>
                                                    </v-list-item-title>

                                                    <v-chip-group v-model="selection"
                                                        active-class="deep-purple accent-4 white--text" column>
                                                        <v-chip><span class="mdi mdi-seat-individual-suite"
                                                                title="Dormitório">{{ item.suite }}</span></v-chip>
                                                        <v-chip><span class="mdi mdi-car" title="Garagem">{{
                                                            item.numero_garagem }}</span></v-chip>
                                                        <v-chip><span class="mdi mdi-chart-areaspline-variant"
                                                                title="Superficie ">{{ item.metros
                                                                }}<sup>2</sup></span></v-chip>

                                                        <v-chip title="Cozinha"><span class="mdi mdi-countertop"></span>{{
                                                            item.cozinha }}</v-chip>
                                                        <v-chip title="Quarto de Banho">
                                                            <span class="mdi mdi-shower-head"></span>{{
                                                                item.numero_banheiro }}</v-chip>
                                                        <v-chip v-for="(actidade) in item.actividade_imoveis"
                                                            :key="actidade.id" v-if="actidade.tempo_arrendar > 0">

                                                            <span class="mdi mdi-timer-lock-outline"
                                                                title="Arrendamento"></span>{{
                                                                    actidade.tempo_arrendar }} </v-chip>
                                                        <v-chip :color="getcor(item.estado_imoveis_id)"
                                                            title="estado do imovel" class="white--text">
                                                            <span v-if="item.estado_imoveis_id == 1"
                                                                class="mdi mdi-archive-lock-open "></span>
                                                            <span v-if="item.estado_imoveis_id == 2"
                                                                class="mdi mdi-archive-remove"></span>
                                                            <span v-if="item.estado_imoveis_id == 3"
                                                                class="mdi mdi-archive-cog "></span>
                                                            <span v-if="item.estado_imoveis_id == 4"
                                                                class="mdi mdi-archive-eye"></span>
                                                            <span v-if="item.estado_imoveis_id == 5"
                                                                class="mdi mdi-archive-refresh"></span>

                                                            {{ item.estado_imoveis.designacao }} </v-chip>
                                                    </v-chip-group>
                                                    <v-btn v-on:click.stop="contacto()" depressed class="mr-10">
                                                        Telefone
                                                    </v-btn>
                                                    <v-btn v-on:click.stop="say()" outlined depressed color="deep-purple">
                                                        Mensagem
                                                    </v-btn>

                                                    <!-- <v-btn v-on:click.stop="say()">Diga tchau</v-btn> -->




                                                </v-card-text>
                                            </v-col>
                                            <v-col md="4" class="ma-0 pa-0 imagensFocos " :class="{ 'on-hover': hover }">
                                                <!-- <v-img
                                                            max-height="300"
                                                            max-width="300"
                                                            @click="
                                                                verFoto(item)
                                                            "
                                                            :src="
                                                                '/storage/' +
                                                                item.ficheiro_resposta
                                                            "
                                                        ></v-img> -->
                                                <!-- <v-img height="250"
                                                            src="/img/Aaa.png"></v-img>:class="{ 'on-hover': hover }" -->
                                                <!-- <v-img max-height="255" max-width="490" :src="'/storage/' +
                                                    item.foto_principal
                                                    " alt="Avatar"></v-img> -->
                                                <template>
                                                    <v-carousel hide-delimiters :style="'height: 255px;'">
                                                        <v-carousel-item max-height="255" max-width="490"
                                                            v-for="(imagem, i) in item.fotos_imoveis" :key="i"
                                                            :src="'/storage/' + imagem.foto"></v-carousel-item>
                                                    </v-carousel>
                                                </template>
                                            </v-col>

                                        </v-row>
                                    </v-list-item-content>

                                    <!--  </card> -->
                                </template>

                            </v-card>
                        </v-hover>
                        <!-- </inertia-link> -->
                    </template>
                </template>




                <!-- <v-row class="fill-height" align-content="center" justify="center" >
                            <v-col class="text-subtitle-1 text-center" cols="12">
                                Carregando os seus dados
                            </v-col>
                            <v-col cols="6">
                                <v-progress-linear color="#002e5b" indeterminate rounded height="6"></v-progress-linear>
                            </v-col>
                        </v-row> -->

                <v-row class="mb-10" justify="end">
                    <v-col cols="7">

                    </v-col>
                    <v-spacer />
                    <v-col cols="5">
                        <v-pagination @input="paginacao(dados.page)" v-model="dados.page" :length="last_page"
                            circle></v-pagination>
                    </v-col>
                </v-row>
            </v-col>

            <v-col cols="1" sm="1" md="1"></v-col>
        </v-row>



    </PortalLayout>
</template>
<script>
import PortalLayout from "../../Templates/PortalLayout";
export default {
    props: ['operacao_imoveis', 'provincia_selecionado', 'provincias', 'estadoImoveis', 'CondicoesImoveis','tipoImoveis', 'tipo_imoveis_selecionado', 'meio_periodo'],
    components: {
        PortalLayout,
    },
    data: () => ({
        images: null,
        dialogN: false,
        totalImoveis: 0,
        dialogContacto: false,
        dados: {
            page: 1,
        },

        last_page: 1,
        estadoTickets: [],
        ticketpaginas: [],
        ImoveisComprar: [],
        dataFinalFiltrolRules: [],
        showSecondAutocompleteModulo: [],
        funcionario_operadores: [],
        funcionario_tecnicos: [],
        showSecondAutocompleteProjecto: [],
        projectos: [],
        query: {
            estado_imoveis_id: null,
            condicoes_imoveis_id: null,
            provincia_id: null,
            preco_inicio: null,
            preco_final: null,
            tipologia: null,
            id_tipo_imoveis:null
        },
        itervalopreco: {


        },
        itervalo_precos: [
            { id: 10000, designacao: '10.000' },
            { id: 20000, designacao: '20.000' },
            { id: 50000, designacao: '50.000' },
            { id: 100000, designacao: '100.000' },
            { id: 500000, designacao: '500.000' },
            { id: 1000000, designacao: '1.000.000' },
            { id: 150000, designacao: '1.500.0000' },
            { id: 5000000, designacao: '5.000.000' },
        ],
        tipo_clientes: [
            { id: 1, designacao: "SINGULAR" },
            { id: 2, designacao: "EMPRESA" },
        ],
        // loading: null,
        imoveis: {},
        erros: [],
        transparent: 'rgba(255, 255, 255, 0)',
    }),

    mounted() {
        this.loading = true;
        setTimeout(function () {
            this.loading = false;
        }, 4000);
        // alert(this.condominios);
    },
    computed: {
        user() {
            return this.$page.props.auth.user;
        },
    },

    created() {
        this.paginacao()
        this.getcor(estado_imoveis_id)

    },

    watch: {
        steps(val) {
            if (this.e1 > val) {
                this.e1 = val;
            }
        },
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
        say() {
            this.dialogN = true
        },
        contacto() {
            this.dialogContacto = true
        },
        quebraDeLinhaItem(texto) {
            const tamanhoMaximo = 50;
            let novoTexto = '';

            for (let i = 0; i < texto.length; i += tamanhoMaximo) {
                novoTexto += texto.slice(i, i + tamanhoMaximo) + '<br>';
            }
            return novoTexto;
        },
        findimoveis(id) {
            window.location.href = "/portal/imovel-selecionado/" + btoa(btoa(btoa(id)));
            // alert(id);
        },
        setNovoCondominio() {
            // this.loading = true;

            alert(JSON.stringify(this.condominio)); // this.$inertia.post("/condominios", this.condominio, {});

            // axios
            //     .post(this.base_url + "/condominios", this.condominio)
            //     .then((response) => {
            //         this.loading = false;
            //         alert(JSON.stringify(response.data));
            //         //   this.resposta = response.data
            //     })
            //     .catch(() => {
            //         alert(JSON.stringify(response.data));

            //         //   console.log('Falha ao registar os dados na base de dados!...')
            //     });
        },
        validate() {
            this.$refs.form.validate();
            this.$refs.form2.validate();
        },

        close() {
            this.morador = {};
            this.dialogAddCondominio = false;
            this.$nextTick(() => {
                this.morador = Object.assign({}, this.defaultItem);
                this.editedIndex = -1;
            });
            // setTimeout(() => {
            //     this.overlay = false;
            // }, 2000);
        },
        paginacao(page = 1) {
            this.dados.operacao_id = this.operacao_imoveis
            this.dados.provincia_id = this.provincia_selecionado
            this.dados.tipo_imoveis_id = this.tipo_imoveis_selecionado
            this.dados.meio_periodo_id = this.meio_periodo
            axios
                .post("/portal/filtrarImoveisPaginate", this.dados, {
                })
                .then((response) => {
                    // alert(JSON.stringify(response.data.data))
                    this.ImoveisComprar = response.data.data;
                    this.last_page = response.data.last_page;
                    this.totalImoveis = response.data.total;
                    this.images = response.data.data;

                })
                .catch((error) => {
                    console.log(error);
                });

        },
        FiltrarImoveis() {
            // alert(JSON.stringify(this.query));
            // alert(itervalo_precos)
            this.query.operacao_id = this.operacao_imoveis
            this.query.tipo_imoveis_id = this.tipo_imoveis
            axios
                .get("/portal/pesquisarImovel", {
                    params: this.query,
                })
                .then((response) => {
                    this.ImoveisComprar = response.data;

                })
                .catch((error) => {
                    //toastr.warning('Houve uma falha ao carregar os dados!...');
                });
        },
    },
};
</script>
<style scoped>
.custom-autocomplete .v-input__control {
    background-color: #ff0000;
    /* Substitua pelo código de cor desejado */
    color: #ffffff;
    /* Substitua pelo código de cor desejado */
}

.imagensFocos {
    transition: opacity .4s ease-in-out;
}

.imagensFocos:not(.on-hover) {
    opacity: 0.6;
}

.show-btns {
    color: rgba(255, 255, 255, 1) !important;
}</style>