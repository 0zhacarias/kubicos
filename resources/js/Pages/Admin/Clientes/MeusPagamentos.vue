<template>
    <v-app>
        <v-container  class="w-90 justify-space-around">
        <v-subheader class="text-h4 text-bold ">Pagamentos</v-subheader>
        <v-row>
            <v-col cols="12" md="12" class="pa-0  mt-15 indigo">
                    <v-card-actions>
                        <span class=" white--text text-bold text-h5">
                            Pagamentos
                        </span>

                        <v-spacer></v-spacer>
                        <v-card-title>
                            <v-text-field v-model="search" append-icon="mdi-magnify" label="Pesquisar" outlined
                                dense dark single-line hide-details></v-text-field>
                        </v-card-title>
                        <!-- <v-text-field v-model="imobiliaria.pesquisar" outlined dense label="Contacto*" type="text">
                        </v-text-field> -->
                        <v-btn icon elevation="5" color="indigo" class="white" outlined rounded
                            title="Relatório" @click="carregarDialogimobiliaria(item)">
                            <v-icon>
                                mdi mdi-file-document-multiple
                            </v-icon>
                        </v-btn>
                        <!-- <v-btn icon color="indigo" outlined rounded class="white" title="Cadastrar Funcionario"
                                    @click="carregarDialogpessoa(item)">
                                    <v-icon>
                                        mdi mdi-plus
                                    </v-icon>
                                </v-btn> -->
                    </v-card-actions>
                </v-col>
            <v-col v-for="item in pagamentos" :key="item.id" cols="12" sm="6" md="4" :lg="pagamentos.length <= 4 ? 6 : 3">
                <v-hover v-slot="{ hover }">

                    <v-card :loading="!loading" class=" elevation-10 pa-2 ma-1 border" :elevation="hover ? 10 : 0">
                        <!-- <v-img height="150" src="/img/pexels-dids-2969915.jpg"></v-img> -->
                        <!-- <v-img height="200"  gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.2)" :src="item.src" ></v-img> -->
                        <v-row>
                            <v-col cols="4"><v-chip title="O processo esta no estado" >
                                andamento
                                </v-chip>
                                <v-rating :value="2.5" color="amber" dense half-increments readonly
                                            size="14"></v-rating></v-col>
                            <v-col><span>Pedido feito em: 22 jun, 2023<br/>
ID do processo: 81704</span></v-col>
                        </v-row>                        
                        <v-divider inset class="mx-1 my-0 pa-0"></v-divider>
                        <v-card-title> <v-icon icon x-large>mdi mdi-cash</v-icon>{{ item.title }}</v-card-title>
                        
                        <v-card-title v-text="item.subtitle"></v-card-title>

                        <v-card-text>
                            <v-chip-group v-model="selection" active-class="deep-purple accent-4 white--text" column>
                            </v-chip-group>
                        </v-card-text>

                        <v-card-actions class="justify-end">
                            <!-- <v-btn icon color="deep-purple lighten-2" outlined rounded  title="Gostei do Imóvel"> -->
                            <!-- </v-btn> -->
                            
                            <v-btn icon color="#885cda" class="mx-2" outlined rounded  title="Confirmar pagamento" @click="teminarNegociacaoPagamentos()" >
                                <v-icon>
                                    mdi mdi-handshake-outline
                                </v-icon>
                            </v-btn>
                            <v-btn icon color="red" class="mx-2" outlined rounded  title="Cancelar pagamento" @click="cancelarMeusPagamentos()" >
                                <v-icon>
                                    mdi mdi-hand-back-left-off-outline
                                </v-icon>
                            </v-btn>
                        </v-card-actions>
                    </v-card>
                </v-hover>
            </v-col>
        </v-row>
        </v-container>
    </v-app>
</template>

<script>
import AdminLayout from "../../../Templates/AdminLayout";
export default {

    props: ["condominios"],
    components: {
        AdminLayout
    },
    data: () => ({
        loading: null,
        condominio: {},
        pagamentos: [
            {
                id: 1,
                title: "Casa 1",
                subtitle: "Localização 1",
                cliente: "Mateus Paulo",
                src: "/img/pexels-dids-2969915.jpg",
            },
            {
                id: 2,
                title: "Residencial T4",
                cliente: "Mateus Paulo",
                subtitle: "Localização 2",
                src: "https://cdn.quasar.dev/img/parallax2.jpg",
            },
            {
                id: 3,
                title: "Imovel 0100",
                cliente: "Mateus Paulo",
                subtitle: "LOCALIZAÇÃO 3",
                src: "https://cdn.quasar.dev/img/parallax2.jpg",
            },
            {
                id: 4,
                title: "Imovel 0004",
                cliente: "Mateus Paulo",
                subtitle: "LOCALIZAÇÃO 3",
                // description:
                //     "Aliquam albucius mei ei, debitis torquatos et pro, eos natum scribentur no. Putant verear constituto te qui. Adolescens persequeris vim ei. Vel nullam reprimique te.",
                
            },
            {
                id: 4,
                title: "CLIENTE 3",
                cliente: "Mateus Paulo",
                subtitle: "LOCALIZAÇÃO 3",
                // description:
                //     "Aliquam albucius mei ei, debitis torquatos et pro, eos natum scribentur no. Putant verear constituto te qui. Adolescens persequeris vim ei. Vel nullam reprimique te.",
                
            },
            {
                id: 5,
                title: "CLIENTE 3",
                cliente: "Mateus Paulo",
                subtitle: "LOCALIZAÇÃO 3",
                // description:
                //     "Aliquam albucius mei ei, debitis torquatos et pro, eos natum scribentur no. Putant verear constituto te qui. Adolescens persequeris vim ei. Vel nullam reprimique te.",
                
            },
            {
                id: 6,
                title: "CLIENTE 3",
                cliente: "Mateus Paulo",
                subtitle: "LOCALIZAÇÃO 3",
                // description:
                //     "Aliquam albucius mei ei, debitis torquatos et pro, eos natum scribentur no. Putant verear constituto te qui. Adolescens persequeris vim ei. Vel nullam reprimique te.",
                
            },
        ],
    }),


    mounted() {
        this.loading = true;
        setTimeout(function () {
            this.loading = false;
        }, 2000);
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
        setTimeout(() => {
            this.overlay = false;
        }, 2000);
    },

    watch: {
        steps(val) {
            if (this.e1 > val) {
                this.e1 = val;
            }
        },
    },

    methods: {
        cancelarMeusPagamentos(){
            alert('cancelado com sucesso')
        },
        teminarNegociacaoPagamentos(){
            alert('Negociacao terminada')
        },
        setNovoCondominio() {
            // this.loading = true;

            this.$inertia.post("/condominios", this.condominio, {});

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
            setTimeout(() => {
                this.overlay = false;
            }, 2000);
        },
    },
};
</script>
<style>
@import "vuetify/dist/vuetify.min.css";
</style>