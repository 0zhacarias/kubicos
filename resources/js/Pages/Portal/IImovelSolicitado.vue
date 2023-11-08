<template>
    <PortalLayout>
        <v-card>
            <v-card-title class="text-h5 primary lighten-2 white--text">
                <span class="text-uppercase" style="font-size: 20px">
                    {{ formTitle }}</span
                >
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

                            <v-stepper-step class="text-uppercase" step="2"
                                >Localização</v-stepper-step
                            >
                        </v-stepper-header>

                        <v-stepper-items flat>
                            <v-stepper-content step="1">
                                <v-card class="mb-12" flat>
                                    <v-form ref="form" lazy-validation>
                                        <v-container>
                                            <v-row dense>
                                                <v-col cols="12" md="6">
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

                                                <v-col cols="12" md="6">
                                                    <v-text-field
                                                        label="NIF do Condominio*"
                                                        :rules="[
                                                            rules.required,
                                                        ]"
                                                        v-model="condominio.nif"
                                                    ></v-text-field>
                                                </v-col>

                                                <v-col cols="12" md="6">
                                                    <v-text-field
                                                        label="Telefone 1*"
                                                        :rules="[
                                                            rules.required,
                                                        ]"
                                                        v-model="
                                                            condominio.telefone1
                                                        "
                                                    ></v-text-field>
                                                </v-col>

                                                <v-col cols="12" md="6">
                                                    <v-text-field
                                                        label="Telefone 2*"
                                                        :rules="[
                                                            rules.required,
                                                        ]"
                                                        v-model="
                                                            condominio.telefone2
                                                        "
                                                    />
                                                </v-col>

                                                <v-col cols="12" md="6">
                                                    <v-text-field
                                                        label="Email*"
                                                        :rules="[
                                                            rules.required,
                                                        ]"
                                                        v-model="
                                                            condominio.email
                                                        "
                                                    />
                                                </v-col>

                                                <v-col cols="12" md="6">
                                                    <v-text-field
                                                        label="Site*"
                                                        :rules="[
                                                            rules.required,
                                                        ]"
                                                        v-model="
                                                            condominio.website
                                                        "
                                                    />
                                                </v-col>

                                                <v-col cols="12" md="6">
                                                    <v-autocomplete
                                                        outlined
                                                        label="Tipo de Cliente"
                                                        dense
                                                        :items="tipo_clientes"
                                                        item-value="id"
                                                        item-text="designacao"
                                                        v-model="
                                                            condominio.tipo_cliente_id
                                                        "
                                                        required
                                                    />
                                                </v-col>
                                                <v-col cols="12" md="6">
                                                    <v-autocomplete
                                                        outlined
                                                        label="Tipo de Regime"
                                                        dense
                                                        :items="tipo_regimes"
                                                        item-value="id"
                                                        item-text="designacao"
                                                        v-model="
                                                            condominio.tipo_regime_id
                                                        "
                                                        required
                                                    />
                                                </v-col>

                                                <v-col cols="12" md="6">
                                                    <v-file-input
                                                        dense
                                                        show-size
                                                        counter
                                                        label="Logotipo"
                                                        v-model="
                                                            condominio.logotipo
                                                        "
                                                    />
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
                                                <v-col cols="12" md="6">
                                                    <v-autocomplete
                                                        outlined
                                                        label="Pais"
                                                        dense
                                                        :items="paises"
                                                        item-value="id"
                                                        item-text="designacao"
                                                        v-model="
                                                            condominio.pais_id
                                                        "
                                                        required
                                                    />
                                                </v-col>

                                                <v-col cols="12" md="6">
                                                    <v-autocomplete
                                                        outlined
                                                        label="Cidade"
                                                        dense
                                                        :items="cidades"
                                                        item-value="id"
                                                        item-text="designacao"
                                                        v-model="
                                                            condominio.cidade_id
                                                        "
                                                        required
                                                    />
                                                </v-col>
                                                <v-col cols="12" md="12">
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
                                        </v-container>
                                    </v-form>
                                </v-card>

                                <v-card-actions>
                                    <v-btn color="warning" @click="e1 = 1"
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
    </PortalLayout>
</template>
<script>
import PortalLayout from "../../Templates/PortalLayout.vue";
export default {
    components: {
        PortalLayout,
    },
    data: () => ({
        tipo_regimes: [
            { id: 1, designacao: "GERAL" },
            { id: 2, designacao: "ESPECÍFICO" },
        ],
        tipo_clientes: [
            { id: 1, designacao: "SINGULAR" },
            { id: 2, designacao: "EMPRESA" },
        ],
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
            setTimeout(() => {
                this.overlay = false;
            }, 2000);
        },
    },
};
</script>
