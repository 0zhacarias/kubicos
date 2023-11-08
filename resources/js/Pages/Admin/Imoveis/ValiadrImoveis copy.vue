<template>
    <AdminLayout>
        <v-container>
            <v-col v-if="!loading" cols="12" style="margin-top: 150px">
                <div class="text-center">
                    <v-progress-circular
                        color="primary"
                        indeterminate
                        size="80"
                    />
                </div>
            </v-col>

            <section v-if="loading">
                <v-card>
                    <v-container>
                        <v-row>
                            <!-- <v-col cols="12" sm="2" md="4"> </v-col>
                            <v-col cols="12" sm="2" md="4"> </v-col> -->
                            <v-breadcrumbs
                                class="text-uppercase font-weight-bolder"
                                :items="items"
                            />
                            <v-spacer />
                            <div>
                                <!-- <v-btn class="mx-2" fab dark large color="purple">
                  <v-icon dark> mdi-plus </v-icon>
                </v-btn>
                <v-btn class="mx-2" fab dark large color="purple">
                  <v-icon dark> mdi-plus </v-icon>
                </v-btn>
                 -->
                            </div>
                            <!-- <v-divider class="mt-0" color="primary" /> -->
                        </v-row>
                    </v-container>
                </v-card>
                <v-divider></v-divider>
                <v-card>
                    <v-container>
                        <v-row>
                            <v-col cols="12" sm="2" md="12">
                                <p
                                    v-for="condominio in condominios"
                                    :key="condominio.id"
                                >
                                    {{ condominio.designacao }} |
                                    {{ condominio.localizacao }}
                                </p>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card>
                <div class="text-right mt-4">
                    <v-btn
                        class="mx-2"
                        fab
                        dark
                        large
                        bottom
                        color="#4649FF"
                        @click="showDialogAddCondominio()"
                        title="Reigstrar Novo Morador"
                    >
                        <v-icon dark> mdi-plus </v-icon>
                    </v-btn>
                </div>
                <!-- <v-btn
                    color="primary"
                    fab
                    large
                    dark
                    bottom
                    right
                    class="v-btn--example"
                >
                    <v-icon>mdi-plus</v-icon>
                </v-btn> -->
            </section>

            <v-dialog
                name="dialog-add-new-condominio"
                v-if="dialogAddCondominio"
                v-model="dialogAddCondominio"
                persistent
                max-width="900px"
            >
                <v-card>
                    <v-card-title class="text-h5 grey lighten-2">
                        <span class="text-h5"> {{ formTitle }}</span>
                        <v-spacer></v-spacer>
                        <v-toolbar-items>
                            <v-btn dark text class="text-h5" @click="close()">
                                <v-icon color="red">close</v-icon>
                            </v-btn>
                        </v-toolbar-items>
                    </v-card-title>
                    <v-card-text>
                        <v-container>
                            <v-stepper flat v-model="e1">
                                <v-stepper-header>
                                    <v-stepper-step
                                        class="text-uppercase"
                                        :complete="e1 > 1"
                                        step="1"
                                        >Dados Pessoais</v-stepper-step
                                    >

                                    <v-divider></v-divider>

                                    <v-stepper-step
                                        class="text-uppercase"
                                        step="2"
                                        >Localização</v-stepper-step
                                    >
                                </v-stepper-header>

                                <v-stepper-items flat>
                                    <v-stepper-content step="1">
                                        <v-card class="mb-12" flat>
                                            <v-form ref="form" lazy-validation>
                                                <v-container>
                                                    <v-row dense>
                                                        <v-col
                                                            cols="12"
                                                            md="12"
                                                        >
                                                            <v-text-field
                                                                label="Nome do Condominio*"
                                                                :rules="[
                                                                    rules.required,
                                                                ]"
                                                                v-model="
                                                                    condominio.designacao
                                                                "
                                                            ></v-text-field>
                                                        </v-col>
                                                    </v-row>
                                                </v-container>
                                            </v-form>
                                        </v-card>
                                        <v-card-actions>
                                            <v-spacer />
                                            <v-btn
                                                color="primary"
                                                @click="continuar(2, 'form')"
                                            >
                                                Continuar
                                            </v-btn>
                                        </v-card-actions>
                                    </v-stepper-content>

                                    <v-stepper-content step="2">
                                        <v-card flat>
                                            <v-form ref="form2" lazy-validation>
                                                <v-container>
                                                    <v-row dense>
                                                        <v-col
                                                            cols="12"
                                                            md="12"
                                                        >
                                                            <v-text-field
                                                                label="Localização do Condominio*"
                                                                :rules="[
                                                                    rules.required,
                                                                ]"
                                                                v-model="
                                                                    condominio.localizacao
                                                                "
                                                            ></v-text-field>
                                                        </v-col>
                                                    </v-row>
                                                    <v-col cols="12" md="12">
                                                        <v-text-field
                                                            label="Contactos do Condominio*"
                                                            :rules="[
                                                                rules.required,
                                                            ]"
                                                            v-model="
                                                                condominio.contactos
                                                            "
                                                        ></v-text-field>
                                                    </v-col>
                                                </v-container>
                                            </v-form>
                                        </v-card>

                                        <v-card-actions>
                                            <v-btn
                                                color="warning"
                                                @click="e1 = 1"
                                                >Voltar</v-btn
                                            >

                                            <v-spacer />
                                            <v-btn
                                                class="bg-primary darken-4 white--text"
                                                @click="setNovoCondominio()"
                                            >
                                                {{
                                                    editedIndex > -1
                                                        ? "Actualizar"
                                                        : "Guardar"
                                                }}
                                            </v-btn>
                                        </v-card-actions>
                                    </v-stepper-content>
                                </v-stepper-items>
                            </v-stepper>
                        </v-container>
                    </v-card-text>
                </v-card>
            </v-dialog>
        </v-container>
    </AdminLayout>
</template>

<script>
import AdminLayout from "../../../Templates/AdminLayout";
export default {
    props: ["condominios"],
    components: {
        AdminLayout,
    },
    data: () => ({
        loading: null,
        condominio: {},
        items: [
            {
                text: "Início",
                disabled: false,
                href: "/home",
            },
            {
                text: "Listar Condomínios",
                disabled: true,
                href: "/",
            },
        ],
        e1: 1,
        steps: 3,
        editedIndex: -1,
        dialogAddCondominio: false,
        morador: {},
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
