<template>
    <PortalLayout>


        <v-row>
            <v-col cols="4">
                <v-card class="my-4 py-4 grey lighten-4" elevation="0">
                    <v-row>
                        <v-col cols="2">

                        </v-col>
                        <v-col cols="10">

                            <v-row class="mx-0 mt-0">
                                <v-card elevation="0" class="mt-3 px-0 transparent" :style="'border-radius: 10px'">
                                    <v-card-title color="deep-purple--text">O que estás a procura</v-card-title>
                                    <v-card-text color="deep-purple accent-4">
                                        <v-col cols="12" class="opens-sans mb-n8">
                                            <v-autocomplete @change="filtrarTicket()" clearable v-model="query.operacao_id"
                                                :items="estadoTickets" item-text="designacao" item-value="id"
                                                prepend-icon="" label="Serviços" dense no-data-text="sem dados" outlined>
                                            </v-autocomplete>
                                        </v-col>
                                        <v-col cols="12" class="pt-6 mb-n8 " v-if="showSecondAutocompleteModulo">
                                            <v-autocomplete prepend-icon="" label="Provincia" type="text" clearable outlined
                                                dense no-data-text="sem dados">
                                            </v-autocomplete>
                                        </v-col>

                                        <v-col cols="12" class="pt-6 mb-n8">
                                            <v-autocomplete @change="filtrarTicket()" clearable v-model="query.operador_id"
                                                :items="funcionario_operadores" item-text="nome_funcionario" item-value="id"
                                                prepend-icon="" label="Valores" outlined dense no-data-text="sem dados">
                                            </v-autocomplete>
                                        </v-col>

                                        <v-col cols="12" class="pt-6 mb-n8">
                                            <v-autocomplete class="custom-autocomplete" @change="filtrarTicket()" clearable
                                                v-model="query.tecnico_id" :items="funcionario_tecnicos"
                                                item-text="nome_funcionario" item-value="id" prepend-icon=""
                                                label="Técnicos" outlined dense no-data-text="sem dados">
                                                <!-- <template v-slot:item="data">
                                                {{ data.item.nome_funcionario }}
                                                {{ data.item.sobre_nome_funcionario }}
                                            </template> -->
                                            </v-autocomplete>
                                        </v-col>
                                        <v-col cols="12" class="pt-13 mb-n8">
                                            <v-text-field clearable label="Data inicial" class="my-n8 rounded"
                                                v-model="query.data_inicial" type="date" :error-messages="erros.dat_inicio_real
                                                    " dense outlined>
                                            </v-text-field>
                                        </v-col>
                                        <v-col cols="12" class="pt-13 mb-n8">
                                            <v-text-field clearable label="Data termino" v-model="query.data_final"
                                                @input="filtrarTicket()" type="date" :error-messages="erros.data_final"
                                                dense outlined>
                                            </v-text-field>
                                        </v-col>

                                        <v-col cols="12" class="pt-13 mb-n8">
                                            <v-text-field clearable label="Data termino" v-model="query.data_final"
                                                @input="filtrarTicket()" type="date" :error-messages="erros.data_final"
                                                dense outlined>
                                            </v-text-field>
                                        </v-col>
                                        <v-col cols="12" class="pt-13 mb-n8">
                                            <v-text-field clearable label="Data termino" v-model="query.data_final"
                                                @input="filtrarTicket()" type="date" :error-messages="erros.data_final"
                                                dense outlined>
                                            </v-text-field>
                                        </v-col>

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
                                Total: {{ totalImoveis }}</span>
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
                                                                title="Arrendamento"  ></span >{{
                                                                    actidade.tempo_arrendar }} </v-chip>
                                                        <v-chip color="deep-purple" title="estado do imovel" class="white--text">
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
                                                    <template >
                <v-carousel hide-delimiters :style="'height: 255px;'">
                    <v-carousel-item  max-height="255" max-width="490" v-for="(imagem, i) in item.fotos_imoveis" :key="i" :src="'/storage/' + imagem.foto" 
                     ></v-carousel-item>
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
                        <v-pagination @input="paginacao(dados.page)" v-model="dados.page" :length="last_page" circle></v-pagination>
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
props:['operacao_imoveis'],
    components: {
        PortalLayout,
    },
    data: () => ({
        images: null,
        dialogN: false,
        totalImoveis: 0,
        dialogContacto: false,
        dados:{
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
        query: {},
        tipo_regimes: [
            { id: 1, designacao: "GERAL" },
            { id: 2, designacao: "ESPECÍFICO" },
        ],
        tipo_clientes: [
            { id: 1, designacao: "SINGULAR" },
            { id: 2, designacao: "EMPRESA" },
        ],
        // loading: null,
        imoveis: {},
        // items: [
        //     {
        //         text: "Início",
        //         disabled: false,
        //         href: "/home",
        //     },
        //     {
        //         text: "Listar Condomínios",
        //         disabled: true,
        //         href: "/",
        //     },
        // ],
        erros: [],
        rules: {
            required: (value) => !!value || "Campos obrigatório.",
            max: (v) => v.length == 9 || "Tem que ter 9 caracteres",
            emailMatch: () => `The email and password you entered don't match`,
        },
        emailRules: [(v) => /.+@.+\..+/.test(v) || "E-mail deve ser válido"],
        telefoneRules: [
            (v) => !!v || "Campo telefone obrigatório.",
            (v) => (v && v.length == 9) || "Tem que ter 9 caracteres",
        ],
        documentoRules: [(v) => !!v || "Campo telefone obrigatório."],
        dateNascRules: [
            (v) => !!v || "Data é Obrigatório",
            (v) =>
                v < new Date().toISOString().substr(0, 10) ||
                "Data de Nascimento deve ser Menor que a Data Actual!",
            (v) =>
                new Date().getFullYear() - new Date(v).getFullYear() >= 18 ||
                "Idade informada é Inferior a 18",
        ],
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
        formTitle() {
            return this.editedIndex === -1 ? "Novo Condomínio" : "Editar ";
        },


    },

    created() {
        this.paginacao()

    },

    watch: {
        steps(val) {
            if (this.e1 > val) {
                this.e1 = val;
            }
        },
    },

    methods: {
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
        showDialogAddCondominio() {
            this.dialogAddCondominio = true;
        },
        continuar(stepe, form) {
            if (this.$refs[form].validate()) {
                this.e1 = stepe;
            }
        },
        continuar2(stepe, form) {
            if (this.$refs[form].validate()) {
                this.e1 = stepe;
            }
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
            this.dados.operacao_id=this.operacao_imoveis
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
        filtrarTicket() {
            axios
                .get("/tickets/filtrar-ticket", {
                    params: this.query,
                })
                .then((response) => {
                    this.dadostickets = response.data.ticket.data;
                    this.mensagem_lida = response.data.ticket.resposta_count;
                    this.empresas = response.data.empresas;
                    // this.resposta_nao = response.data.resposta_nao;
                    this.funcionario_tecnicos =
                        response.data.tecnicos_projectos;
                    this.modulos_projectos = response.data.modulos_projectos;
                    this.last_page = response.data.ticket.last_page;
                    this.totalTicket = response.data.ticket.total;
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
}
</style>