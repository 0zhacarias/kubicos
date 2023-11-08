<template>
    <Cliente>
        <v-container class="mt-15">
            <!-- <v-snackbar v-if="$page.props.flash.success" v-model="bar" top :timeout="7000" color="success">
                {{ $page.props.flash.success }}
            </v-snackbar> -->

            <template>
                <div class="text-center">
                    <v-snackbar v-if="$page.props.flash.success" v-model="bar" :multi-line="multiLine" :timeout="4000" outlined
                        color="deep-purple accent-4">
                        {{ $page.props.flash.success }}
                        <v-btn color="indigo" text @click="snackbar = false">
                            Close
                        </v-btn>
                    </v-snackbar>
                </div>
            </template>
            <section>
                <v-subheader class="text-h5 text-bold">  Sincronizar Permissões para cada Função</v-subheader>
              
                <v-card elevation="0" class="my-2">
                    <v-form @submit.prevent="sincronizarPermissoes" ref="form" lazy-validation>
                        <v-card-text>

                            <v-toolbar flat color="white">
                                <v-toolbar-title>Total({{
                                    permissions.length
                                }})</v-toolbar-title>
                            </v-toolbar>
                            <v-spacer></v-spacer>
                            <v-row>
                                <v-col cols="12" sm="6" md="4">
                                    <v-autocomplete v-model="role_id" append-icon="wc" name="role_id"
                                        :rules="[rules.required]" item-text="name" item-value="id" :items="roles"
                                        label="Função" single-line hide-details class="mx-6"
                                        @change="getRoles"></v-autocomplete>
                                </v-col>

                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field v-model="busca_permission" append-icon="mdi-magnify" label="Pesquisar"
                                        single-line hide-details class="mx-6"></v-text-field>
                                </v-col>

                                <v-col cols="12" md="4" class="">
                                    <v-btn color="#2C3A47" class="white--text" type="submit" @click="validate">
                                        <v-icon>sync</v-icon> Sincronizar
                                    </v-btn>
                                    <!-- <v-btn color="#2C3A47" dark>
                                        <inertia-link
                                            class="white--text"
                                            href="/users/user"
                                        >
                                            <v-icon
                                                >mdi-account-group-outline</v-icon
                                            >&nbsp;Utilizadores
                                        </inertia-link>
                                    </v-btn> -->
                                    <!-- <a
                                        @click="redirectPropostaPDF()"
                                        v-if="$vuetify.breakpoint.mdAndUp"
                                    >
                                        <v-btn
                                            color="red"
                                            large
                                            class="remover-link white--text font-weight-bold mx-2"
                                            title=" Exportar lista em Pdf"
                                        >
                                            <v-icon left
                                                >mdi mdi-file-pdf-box</v-icon
                                            >
                                            PDF
                                        </v-btn>
                                    </a> -->
                                </v-col>
                            </v-row>

                            <v-data-table :headers="headers" :items="filtrerPermissoes">
                                <template v-slot:item.actions="{ item }">
                                    <div class="d-flex">
                                        <v-checkbox color="#2C3A47" v-model="role_permissions"
                                            :value="item.name"></v-checkbox>
                                    </div>
                                </template>
                                <template v-slot:no-data>
                                    <v-btn color="#2C3A47" @click="initialize()">Reset</v-btn>
                                </template>
                            </v-data-table>
                        </v-card-text>
                    </v-form>
                </v-card>
            </section>

            <!-- <v-btn bottom color="#2C3A47" type="submit" dark fab fixed right @click="validate">
        <v-icon>add</v-icon>
      </v-btn> -->
        </v-container>
    </Cliente>
</template>

<script>
import Cliente from "../Clientes/Cliente";

const gradients = [
    ["#222"],
    ["#42b3f4"],
    ["red", "orange", "yellow"],
    ["purple", "violet"],
    ["#00c6ff", "#F0F", "#FF0"],
    ["#f72047", "#ffd200", "#1feaea"],
];
export default {
    props: ["users", "roles", "permissions"],
    components: {
        Cliente,
    },

    data: () => ({
        bar: true,
        editedIndex: -1,
        dialog: false,
        dialog2: false,
        dialog3: false,
        role: {},
        query: { palavra_chave: "" },
        role_id: "",

        role_permissions: [],
        busca_roles: "",
        busca_permission: null,

        search_roles: "",
        search_permissions: "",
        overlay: true,
        e1: 1,
        headers: [
            {
                text: "Nº",
                align: "start",
                sortable: false,
                value: "id",
            },
            { text: "Permissão", value: "name", sortable: true },
            { text: "Estado", value: "actions", sortable: false },
        ],

        rules: {
            required: (value) => !!value || "Obrigatória.",
        },

        singleSelect: false,
        headersRoles: [
            {
                text: "Função",
                align: "start",
                sortable: false,
                value: "name",
            },
            { text: "Data de Criação", value: "created_at" },
            { text: "Data de Modificação", value: "updated_at" },
        ],

        headersPermissions: [
            {
                text: "Permissão",
                align: "start",
                sortable: false,
                value: "name",
            },
            { text: "Data de Criação", value: "created_at" },
            { text: "Data de Modificação", value: "updated_at" },
        ],
    }),

    computed: {
        user() {
            return this.$page.props.auth.user;
        },
        filtrerPermissoes() {
            if (this.busca_permission) {
                let result = this.permissions.filter((item) => {
                    return (
                        item.name.toLowerCase().match(this.busca_permission) ||
                        item.created_at
                            .toLowerCase()
                            .match(this.busca_permission) ||
                        item.id == this.busca_permission
                    );
                });
                return result ? result : [];
            } else {
                return this.permissions;
            }
        },
    },

    created() {
        setTimeout(() => {
            this.overlay = false;
        }, 1000);
    },

    methods: {
        validate() {
            return this.$refs.form.validate();
        },

        reset() {
            this.$refs.form.reset();
        },

        resetValidation() {
            this.$refs.form.resetValidation();
        },

        initialize() { },

        close() {
            this.$nextTick(() => {
                this.dialog = false;
                this.editedIndex = -1;
            });
        },

        sincronizarPermissoes() {
            if (this.validate()) {
                this.overlay = true;
                this.$inertia.visit(
                    "/clientes/permissoes-funcao/" + this.role_id,
                    {
                        method: "put",
                        data: { role_permissions: this.role_permissions },
                        // onSuccess: () => {
                        //     setTimeout(() => {
                        //         this.overlay = false;
                        //         this.$inertia.reload(
                        //             "/clientes/permissoes-funcao/"
                        //         );
                        //     }, 10);
                        //     this.user_roles = [];
                        // },
                    }
                );
            }
        },

        getRoles() {
            this.overlay = false;
            axios
                .get("/clientes/buscar-roles", {
                    params: { role_id: this.role_id },
                })
                .then(
                    function (response) {
                        this.role = response.data;

                        this.role_permissions = [];

                        this.role.permissions.forEach((permission) => {
                            this.role_permissions.push(permission.name);
                            this.overlay = false;
                        });
                    }.bind(this)
                );
        },
        //fim funcoes

        getPermissions: function (page = 1) {
            this.overlay = true;
            axios
                .get("/permission/permissoes-usuarios?page=" + page, {
                    params: { palavra_chave: this.busca_permission },
                })
                .then(
                    function (response) {
                        this.permissions = response.data.permissions;
                        this.overlay = false;
                    }.bind(this)
                );
        },
        //fim Permissoes
    },
};
</script>

<style>
.corprincipal {
    background-color: #2c3a47 !important;
}
</style>
