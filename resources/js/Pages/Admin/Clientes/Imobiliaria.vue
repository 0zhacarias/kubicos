<template>
    <Cliente>
        <!-- <v-subheader>Meus Anúcios</v-subheader> -->
        <v-container class="w-90 justify-space-around">
            <v-row>


                <v-col cols="12" md="12" class="pa-0  mt-15 indigo">
                    <v-card-actions>
                        <span class=" white--text text-bold text-h5">
                            Imóbiliarias ({{ imobiliarias.length
                            }})
                        </span>

                        <v-spacer></v-spacer>
                        <v-card-title>
                            <v-text-field v-model="imobiliaria.search" append-icon="mdi-magnify" label="Pesquisar" outlined
                                dense dark single-line hide-details></v-text-field>
                        </v-card-title>
                        <!-- <v-text-field v-model="imobiliaria.pesquisar" outlined dense label="Contacto*" type="text">
                        </v-text-field> -->
                        <v-btn icon elevation="5" color="deep-purple lighten-2" class="white" outlined rounded
                            title="Pesquisar" @click="carregarDialogimobiliaria(item)">
                            <v-icon>
                                mdi-magnify
                            </v-icon>
                        </v-btn>
                        <v-btn icon elevation="5" color="deep-purple lighten-2" class="white" outlined rounded
                            title="Cadastrar Imobiliaria" @click="carregarDialogimobiliaria(item)">
                            <v-icon>
                                mdi mdi-plus
                            </v-icon>
                        </v-btn>
                    </v-card-actions>
                </v-col>

                <!-- :lg="imobiliarias.length > 3 ? 3 : 4" -->
                <v-col v-for="item in imobiliarias" :key="item.id" :search="search" cols="12" sm="6" md="2" lg="3">
                    <v-hover v-slot="{ hover }">

                        <v-card class=" elevation-10 pa-2 ma-3 border" :elevation="hover ? 10 : 2">
                            <!-- <v-img height="150" src="/img/pexels-dids-2969915.jpg"></v-img> -->
                            <!-- <v-img height="100" gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.2)" :src="'/storage/' +
                                item.foto_principal"></v-img> -->
                            <v-card-text>

                                <div>{{ item.designacao }}
                                </div>
                            </v-card-text>

                            <v-divider class="mx-1"></v-divider>

                            <!-- <v-card-title v-text="item.designacao"></v-card-title> -->

                            <v-card-actions class="justify-end">
                                <v-btn icon color="deep-purple lighten-2" outlined rounded title="Editar Imóvel"
                                    @click="carregarDialogEditarimobiliaria(item)">
                                    <v-icon>
                                        mdi mdi-pencil-outline
                                    </v-icon>
                                </v-btn>
                                <v-btn icon color="red" outlined rounded title="Remover o Imóvel"
                                    @click="deleteimobiliaria(item)">
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
                                <span class="text-h5">{{ editedIndex < 0 ? 'Cadastrar ' : 'Editar ' }} Imóbiliatia</span>
                            </v-card-title>
                            <template>
                                <v-card>
                                    <v-container>

                                        <v-form ref="form" lazy-validation>
                                            <v-row dense>
                                                <v-col cols="12" sm="12" md="6">
                                                    <v-text-field v-model="imobiliaria.designacao" outlined dense
                                                        label="Nome Completo do imobiliaria" type="text">
                                                    </v-text-field>
                                                </v-col>
                                                <v-col cols="12" sm="12" md="6">
                                                    <v-text-field v-model="imobiliaria.nif" outlined dense
                                                        label="NIF" type="number">
                                                    </v-text-field>
                                                </v-col>
                                                <v-col cols="12" sm="6" md="6">
                                                    <v-text-field v-model="imobiliaria.email" outlined dense label="E-mail"
                                                        type="email">
                                                    </v-text-field>
                                                </v-col>
                                                <v-col cols="12" sm="6" md="6">
                                                    <v-text-field v-model="imobiliaria.telefone" outlined dense
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
                                <v-btn color="blue darken-1" text @click="editarimobiliaria()">
                                    {{ editedIndex > -1 ? 'Editar ' : 'Cadastrar' }} Imobiliaria
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
                <v-snackbar v-model="snackbar" :multi-line="multiLine" :timeout="8000" outlined
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

    props: ["imobiliarias"],
    components: {
        Cliente
    },
    data: () => ({
        dialogEditar: false,
        dialogDelete: false,
        editedIndex: -1,
        search: '',
        imobiliaria: {
        },
        defautimobiliaria: {
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

        carregarDialogimobiliaria() {
            this.dialogEditar = true;

        },
        carregarDialogEditarimobiliaria(item) {
            this.editedIndex = this.imobiliarias.indexOf(item);
            this.imobiliaria = Object.assign({}, item);
            this.dialogEditar = true;
        },
        deleteimobiliaria(item) {
            this.editedIndex = this.imobiliarias.indexOf(item);
            this.imobiliaria = Object.assign({}, item);
            this.dialogDelete = true;
        },
        deleteItemConfirm() {
            this.$inertia.delete(
                "/imobiliaria/" + this.imobiliaria.id,
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
            this.imobiliaria = Object.assign({}, this.defautimobiliaria);
        },
        fecharDialog() {
            this.dialogEditar = false;
            this.editedIndex = -1;
            this.imobiliaria = Object.assign({}, this.defautimobiliaria);
        },
        editarimobiliaria() {
            if (this.editedIndex > -1) {
                axios

                    .put(`/imobiliaria/${this.imobiliaria.id}`, this.imobiliaria)
                    .then((response) => {
                        //   this.resposta = response.data
                    })
                    .catch(() => {
                        alert(JSON.stringify(response.data));

                        //   console.log('Falha ao registar os dados na base de dados!...')
                    });
                this.fecharDialog();
                // location.reload();
            } else {
                this.$inertia.post(
                    "/imobiliaria",
                    this.imobiliaria,
                    {

                        onFinish: () => {

                            // this.imobiliaria = Object.assign({}, this.defautimobiliaria);
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

                        },

                    }

                );
                this.fecharDialog();
            };

        },
    },
};
</script>
<style></style>