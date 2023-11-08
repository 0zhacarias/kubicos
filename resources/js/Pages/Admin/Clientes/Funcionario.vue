<template>
    <Cliente>
        <!-- <v-subheader>Meus Anúcios</v-subheader> -->
        <v-container class="w-90 justify-space-around">
            <v-row>
                <v-col cols="12" md="12" class="pa-0  mt-15 indigo">
                    <v-card-actions>
                        <span class=" white--text text-bold text-h5">
                            Funcionarios ({{ pessoas.length }})
                        </span>

                        <v-spacer></v-spacer>
                        <v-card-title>
                            <v-text-field v-model="search" append-icon="mdi-magnify" label="Pesquisar" outlined
                                dense dark single-line hide-details></v-text-field>
                        </v-card-title>
                        <!-- <v-text-field v-model="imobiliaria.pesquisar" outlined dense label="Contacto*" type="text">
                        </v-text-field> -->
                        <v-btn icon elevation="5" color="indigo" class="white" outlined rounded
                            title="Pesquisar" @click="carregarDialogimobiliaria(item)">
                            <v-icon>
                                mdi-magnify
                            </v-icon>
                        </v-btn>
                        <v-btn icon color="indigo" outlined rounded class="white" title="Cadastrar Funcionario"
                                    @click="carregarDialogpessoa(item)">
                                    <v-icon>
                                        mdi mdi-plus
                                    </v-icon>
                                </v-btn>
                    </v-card-actions>
                </v-col>
                <!-- :lg="pessoas.length > 3 ? 3 : 4" -->
                <v-col v-for="item in pessoas" :key="item.id" cols="12" sm="6" md="2" lg="4">
                    <v-hover v-slot="{ hover }">

                        <v-card class=" elevation-10 pa-2 ma-3 border" :elevation="hover ? 10 : 0"  
                        :style="'white-space:nowrap; padding:0;max-width: 100%; position:relative;top:10px; ; border-radius: 10px 80px 10px 60px;'">
                            <!-- <v-img height="150" src="/img/pexels-dids-2969915.jpg"></v-img> -->
                            <!-- <v-img height="100" gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.2)" :src="'/storage/' +
                                item.foto_principal"></v-img> -->
                            <v-card-text>

                                <div> <span class="font-weight-bold">Nome:</span> {{ item.name }}
                                </div>
                                <div > <span class="font-weight-bold">E-mail:</span> {{ item.email }}
                                </div>
                                <div > <span class="font-weight-bold">Contacto:</span> {{ item.telefone }}
                                </div>
                            </v-card-text>
                            <!-- <v-card-title v-text="item.designacao"></v-card-title> -->
<v-divider class="ma-0 pa-0"></v-divider>
                            <v-card-actions class="justify-end">
                                <v-btn icon color="deep-purple lighten-2" outlined rounded title="Editar Imóvel"
                                    @click="carregarDialogEditarpessoa(item)">
                                    <v-icon>
                                        mdi mdi-pencil-outline
                                    </v-icon>
                                </v-btn>
                                <v-btn icon color="red" outlined rounded title="Remover o Imóvel"
                                    @click="deletepessoa(item)">
                                    <v-icon>
                                        mdi mdi-delete-outline
                                    </v-icon>
                                </v-btn>
                            </v-card-actions>
                        </v-card>
                    </v-hover>
                </v-col>
            </v-row>
            <template>
                <v-row justify="center">
                    <v-dialog v-model="dialogEditar" persistent max-width="700px">
                        <v-card>
                            <v-card-title>
                                <span class="text-h5">{{ editedIndex < 0 ? 'Cadastrar ' : 'Editar ' }} Funcionario</span>
                            </v-card-title>
                            <template>
                                <v-card>
                                    <v-container>

                                        <v-form ref="form" lazy-validation>
                                            <v-row dense>
                                                <v-col cols="12" sm="12" md="12">
                                                    <v-text-field v-model="pessoa.name" outlined dense
                                                        label="Nome Completo do pessoa" type="text">
                                                    </v-text-field>
                                                </v-col>
                                                <v-col cols="12" sm="6" md="6">
                                                    <v-text-field v-model="pessoa.email" outlined dense label="E-mail"
                                                        type="email">
                                                    </v-text-field>
                                                </v-col>
                                                <v-col cols="12" sm="6" md="6">
                                                    <v-text-field v-model="pessoa.telefone" outlined dense
                                                        label="Contacto*" type="number" min="0" max="9">

                                                    </v-text-field>
                                                </v-col>
                                            </v-row>
                                        </v-form>
                                    </v-container>
                                </v-card>
                            </template>
                            <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn color="red darken-1" text @click="fecharDialog()">
                                    fechar
                                </v-btn>
                                <v-btn color="blue darken-1" text @click="editarpessoa()">
                                 {{ editedIndex > -1 ? 'Editar  ' : 'Cadastrar' }} funcionario
                                </v-btn>
                            </v-card-actions>
                        </v-card>
                    </v-dialog>
                    <v-dialog v-if="dialogDelete" v-model="dialogDelete" max-width="500px">
                        <v-card>
                            <v-card-title class="text-h6">Tens a certeza de que desejas
                                eliminar?</v-card-title>
                            <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn rounded outlined color="indigo" @click="dialogDelete = false">Não</v-btn>
                                <v-btn rounded outlined color="red" @click="deleteItemConfirm()">Sim</v-btn>
                                <v-spacer></v-spacer>
                            </v-card-actions>
                        </v-card>
                    </v-dialog>
                </v-row>
                <v-snackbar v-model="snackbar"  :multi-line="multiLine" :timeout="8000" outlined
                    color="deep-purple accent-4">
                    {{ textvalidado }}
                    <v-btn color="indigo" text @click="snackbar = false">
                        Close
                    </v-btn>
                </v-snackbar>
            </template>
        </v-container>
    </Cliente>
</template>

<script>
import Cliente from "../Clientes/Cliente";
export default {

    props: ["pessoas",],
    components: {
        Cliente
    },
    data: () => ({
        dialogEditar: false,
        dialogDelete: false,
        editedIndex: -1,
        search:'',
        pessoa: {
        },
        defautpessoa: {
        },
        snackbar: false,
        textvalidado: `Operação feita com sucesso`,
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

    },

    created() {
        setTimeout(() => {
            this.overlay = false;
        }, 2000);
    },

    watch: {

    },

    methods: {


        validate() {
            this.$refs.form.validate();
        },

        carregarDialogpessoa() {
            // item.actividade_imoveis.forEach(actividade => {
            //     this.operacao_id = actividade.operacao_imoveis_id
            // });
            // alert(JSON.stringify(this.operacao_id));
            this.dialogEditar = true;

        },
        carregarDialogEditarpessoa(item) {
            this.editedIndex = this.pessoas.indexOf(item);
            this.pessoa = Object.assign({}, item);
            this.dialogEditar = true;
        },
        deletepessoa(item) {
            this.editedIndex = this.pessoas.indexOf(item);
            this.pessoa = Object.assign({}, item);
            this.dialogDelete = true;
        },
        deleteItemConfirm() {
            this.$inertia.delete(
                "/pessoa/" + this.pessoa.id,
                {
                    onFinish: () => {
                        if (this.$page.props.flash.success != null) {
                            Vue.toasted.global.defaultSuccess({
                                msg: "" + this.$page.props.flash.success,
                            });
                        }
                        if (this.$page.props.flash.error != null) {
                            Vue.toasted.global.defaultError({
                                msg: "" + this.$page.props.flash.error,
                            });
                        }

                    },
                }
            );
            this.dialogDelete = false;
            this.pessoa = Object.assign({}, this.defautpessoa);
        },
        fecharDialog() {
            this.dialogEditar = false;
            this.editedIndex=-1;
            this.pessoa = Object.assign({}, this.defautpessoa);
        },
        editarpessoa() {
            if (this.editedIndex > -1) {
                axios
                
                    .put(`/pessoa/${this.pessoa.id}`, this.pessoa )
                    .then((response) => {
                        //   this.resposta = response.data
                    })
                    .catch(() => {
                        alert(JSON.stringify(response.data));

                        //   console.log('Falha ao registar os dados na base de dados!...')
                    });
                this.fecharDialog();
                location.reload();
            } else {
                this.$inertia.post(
                    "/pessoa",
                    this.pessoa,
                    {

                        onFinish: () => {
                           
                            // this.pessoa = Object.assign({}, this.defautpessoa);
                            if (this.$page.props.flash.success != null) {
                                Vue.toasted.global.defaultSuccess({
                                    msg:
                                        "" + this.$page.props.flash.success,
                                });
                                this.snackbar = true

                            }
                            if (this.$page.props.flash.error != null) {
                                Vue.toasted.global.defaultError({
                                    msg: "" + this.$page.props.flash.error,
                                });
                            }
                            this.fecharDialog();
                        },

                    }
                    
                );
            };

        },
    },
};
</script>
<style></style>