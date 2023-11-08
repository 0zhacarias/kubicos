<template>
    <Cliente class="font-montserrat">
        <v-container>
            <v-row>
                <v-col cols-12 sm="6" md="6">
                    <v-card elevation="0" class="transparent">
                        <h3
                            class="corTitle text-left font-weight-bold pa-2 text-uppercase"
                        >
                            Lista de Permissões & Funções
                        </h3>
                    </v-card>
                </v-col>
            </v-row>

            <!-- <v-alert v-if="$page.props.flash.success" text type="success">{{
        $page.props.flash.success
      }}</v-alert>
      <v-alert v-if="$page.props.flash.error" text type="error">{{
        $page.props.flash.error
      }}</v-alert> -->

            <v-row class="my-2">
                <!--v-col cols="12" sm="12">
          <div v-if="loading" class="text-center">
            <v-progress-circular indeterminate color="primary"></v-progress-circular>
          </div>
          <v-alert dense text v-if="alert.type == 'success'" type="success">{{ alert.text }}</v-alert>
          <v-alert dense outlined v-if="alert.type == 'error'" type="error">
            <v-list-item v-for="texto in alert.text" :key="texto">
              <v-list-item-title v-for="msg in texto" :key="msg">{{ msg }}</v-list-item-title>
            </v-list-item>
          </v-alert>
        </|v-col-->

                <!-- <v-snackbar
          v-if="$page.props.flash.success"
          v-model="bar"
          top
          :timeout="4000"
          color="success"
        >
          {{ $page.props.flash.success }}
        </v-snackbar> -->

                <v-col cols="12" sm="12">
                    <v-card>
                        <v-toolbar
                            class="text-uppercase font-weight-bold"
                            elevation="1"
                        >
                            <v-tabs v-model="tab" flat dark color="#2C3A47">
                                <v-tab class="black--text">
                                    <v-icon left color="#2C3A47">group</v-icon
                                    >Funções
                                </v-tab>
                                <v-tab class="black--text">
                                    <v-icon left color="#2C3A47">edit</v-icon
                                    >Permissões
                                </v-tab>
                            </v-tabs>
                        </v-toolbar>

                        <v-tabs-items v-model="tab">
                            <v-tab-item>
                                <v-card flat>
                                    <v-card-text>
                                        <v-row>
                                            <v-col cols="12" md="2">
                                                <v-toolbar-title
                                                    >Total({{
                                                        roles.length
                                                    }})</v-toolbar-title
                                                >
                                            </v-col>
                                            <v-col cols="12" md="3">
                                                <v-text-field
                                                    v-model="busca_roles"
                                                    v-slot:append
                                                    label="Procurar"
                                                    single-line
                                                    hide-details
                                                >
                                                    <v-icon color="#002e5b"
                                                        >mdi-magnify</v-icon
                                                    ></v-text-field
                                                >
                                            </v-col>
                                            <v-col cols="12" md="4">
                                                <v-btn
                                                    bottom
                                                    color="#002e5b"
                                                    class="rounded font-montserrat mb-2 mx-4"
                                                >
                                                    <inertia-link
                                                        class="white--text"
                                                        href="/permission/associar-funcoes-permissoes"
                                                    >
                                                        <v-icon>sync</v-icon
                                                        >&nbsp;Sincronizar
                                                        Permissões
                                                    </inertia-link>
                                                </v-btn>
                                            </v-col>

                                            <a
                                                @click="
                                                    redirectPropostaPDF_funcoes()
                                                "
                                                v-if="
                                                    $vuetify.breakpoint.mdAndUp
                                                "
                                            >
                                                <v-btn
                                                    color="red"
                                                    large
                                                    class="remover-link white--text font-weight-bold mx-2"
                                                    title=" Exportar lista em Pdf"
                                                >
                                                    <v-icon left
                                                        >mdi
                                                        mdi-file-pdf-box</v-icon
                                                    >
                                                    PDF
                                                </v-btn>
                                            </a>

                                            <!-- Para mais tarde, quando for preciso -->
                                            <!--  <v-col cols="12" md="3">
                                                <v-btn
                                                    color="#002e5b  "
                                                    class="mb-2 white--text"
                                                    @click="
                                                        dialog_add_role = true
                                                    "
                                                >
                                                    <v-icon>add</v-icon>
                                                    Nova Função
                                                </v-btn>
                                            </v-col> -->
                                        </v-row>
                                        <v-data-table
                                            :headers="headersRoles"
                                            :items="filtrerFuncoes"
                                            sort-by="name"
                                            elevation="0"
                                            class="opens-sans"
                                            :search="search"
                                        >
                                            <!--  <template v-slot:item.created_at="{ item }">
                                                <span>{{ item.created_at | formatDateTime }}</span>
                                            </template>
                                            <template v-slot:item.updated_at="{ item }">
                                                <span>{{ item.updated_at | formatDateTime }}</span>
                                            </template> -->

                                            <template
                                                v-slot:item.actions="{ item }"
                                            >
                                                <v-icon
                                                    small
                                                    @class="mr - 2"
                                                    @click="editItemRole(item)"
                                                    color="blue"
                                                    >mdi-pencil</v-icon
                                                >
                                                <v-icon
                                                    small
                                                    @click="
                                                        deleteItemRole(item)
                                                    "
                                                    color="red"
                                                    >mdi-delete</v-icon
                                                >
                                            </template>
                                        </v-data-table>
                                        <v-btn
                                            bottom
                                            class="white--text"
                                            color="#002e5b"
                                            fab
                                            fixed
                                            right
                                            @click="dialog_add_role = true"
                                        >
                                            <v-icon>add</v-icon>
                                        </v-btn>
                                    </v-card-text>
                                    <!-- MODAL ADICIONAR FUNÇÃO-->
                                    <v-dialog
                                        v-model="dialog_add_role"
                                        max-width="500px"
                                    >
                                        <template v-slot:activator="{ on }">
                                        </template>
                                        <v-form ref="form" lazy-validation>
                                            <v-card>
                                                <v-card-title
                                                    class="text-uppercase font-weight-bold"
                                                    elevation="2"
                                                >
                                                    <span class="headline">{{
                                                        formTitleRole
                                                    }}</span>
                                                </v-card-title>

                                                <v-card-text>
                                                    <v-container>
                                                        <v-row class="mx-2">
                                                            <v-col
                                                                class="align-center justify-space-between"
                                                                cols="12"
                                                                md="12"
                                                            >
                                                                <v-text-field
                                                                    v-model="
                                                                        role.name
                                                                    "
                                                                    :rules="
                                                                        rulesname
                                                                    "
                                                                    prepend-icon="perm_identity"
                                                                    placeholder="Função"
                                                                />
                                                            </v-col>
                                                        </v-row>
                                                    </v-container>
                                                </v-card-text>

                                                <v-card-actions>
                                                    <v-spacer></v-spacer>
                                                    <v-btn
                                                        color="red darken-1"
                                                        text
                                                        @click="close()"
                                                        >Cancelar</v-btn
                                                    >
                                                    <v-btn
                                                        color="#2C3A47"
                                                        text
                                                        @click="save()"
                                                        >Guardar</v-btn
                                                    >
                                                </v-card-actions>
                                            </v-card>
                                        </v-form>
                                    </v-dialog>
                                    <!-- MODAL ELIMINAR -->
                                    <v-dialog
                                        v-model="dialog_eliminar_role"
                                        max-width="400"
                                    >
                                        <v-card>
                                            <v-card-title
                                                class="text-uppercase font-weight-bold"
                                                elevation="2"
                                            >
                                                <span class="headline"
                                                    >Eliminar Registo</span
                                                >
                                            </v-card-title>

                                            <v-card-text>
                                                <br />
                                                <h5 class="text-danger">
                                                    Deseja eliminar este
                                                    registo?
                                                </h5>
                                            </v-card-text>

                                            <v-card-actions>
                                                <v-spacer></v-spacer>
                                                <v-btn
                                                    color="red darken-1"
                                                    dark
                                                    @click="
                                                        dialog_eliminar_role = false
                                                    "
                                                    >Não</v-btn
                                                >
                                                <v-btn
                                                    color="blue darken-1"
                                                    dark
                                                    @click="
                                                        confirmDeleteItemRole
                                                    "
                                                    >Sim</v-btn
                                                >
                                            </v-card-actions>
                                        </v-card>
                                    </v-dialog>
                                </v-card>
                            </v-tab-item>

                            <v-tab-item>
                                <v-card flat>
                                    <v-card-text>
                                        <v-row>
                                            <v-col cols="12" md="3">
                                                <v-toolbar-title
                                                    >Total Permission({{
                                                        permissions.length
                                                    }})</v-toolbar-title
                                                >
                                            </v-col>
                                            <!-- <v-divider class="mx-4" inset vertical></v-divider> -->
                                            <v-col cols="12" md="2">
                                                <v-text-field
                                                    v-model="busca_permission"
                                                    v-slot:append
                                                    label="Procurar"
                                                    single-line
                                                    hide-details
                                                >
                                                    <v-icon color="#002e5b"
                                                        >mdi-magnify</v-icon
                                                    ></v-text-field
                                                >
                                            </v-col>

                                            <v-col cols="12" md="4">
                                                <v-btn
                                                    bottom
                                                    class="rounded font-montserrat"
                                                    large
                                                    color="#002e5b"
                                                >
                                                    <inertia-link
                                                        class="white--text"
                                                        href="/permission/associar-funcoes-permissoes"
                                                    >
                                                        <v-icon>sync</v-icon
                                                        >&nbsp;Sincronizar
                                                        Permissões
                                                    </inertia-link>
                                                </v-btn>
                                            </v-col>
                                            <v-col cols="12" md="3">
                                                <v-btn
                                                    bottom
                                                    class="rounded font-montserrat white--text"
                                                    large
                                                    color="#002e5b"
                                                    @click="
                                                        dialog_add_permission = true
                                                    "
                                                >
                                                    <v-icon>add</v-icon>
                                                    Nova Permissão
                                                </v-btn>
                                                <a
                                                    @click="
                                                        redirectPropostaPDF_permissoes()
                                                    "
                                                    v-if="
                                                        $vuetify.breakpoint
                                                            .mdAndUp
                                                    "
                                                >
                                                    <v-btn
                                                        color="red"
                                                        large
                                                        class="remover-link white--text font-weight-bold mx-2"
                                                        title=" Exportar lista em Pdf"
                                                    >
                                                        <v-icon left
                                                            >mdi
                                                            mdi-file-pdf-box</v-icon
                                                        >
                                                        PDF
                                                    </v-btn>
                                                </a>
                                            </v-col>
                                        </v-row>
                                        <v-data-table
                                            :headers="headersPermissions"
                                            :items="filtrerPermissoes"
                                            sort-by="name"
                                            elevation="0"
                                            class="opens-sans"
                                            :search="search"
                                        >
                                            <template
                                                v-slot:item.created_at="{
                                                    item,
                                                }"
                                            >
                                                <span>{{
                                                    item.created_at
                                                        | formatDateTime
                                                }}</span>
                                            </template>
                                            <template
                                                v-slot:item.updated_at="{
                                                    item,
                                                }"
                                            >
                                                <span>{{
                                                    item.updated_at
                                                        | formatDateTime
                                                }}</span>
                                            </template>
                                            <template
                                                v-slot:item.actions="{ item }"
                                            >
                                                <!--  <v-icon
                                                    small
                                                    @class="mr - 2"
                                                    @click="
                                                        editItemPermission(item)
                                                    "
                                                    color="blue"
                                                    >mdi-pencil</v-icon
                                                > -->
                                                <v-icon
                                                    small
                                                    @click="
                                                        deleteItemPermission(
                                                            item
                                                        )
                                                    "
                                                    color="red"
                                                    >mdi-delete</v-icon
                                                >
                                            </template>
                                        </v-data-table>
                                        <v-btn
                                            bottom
                                            class="white--text"
                                            color="#002e5b"
                                            fab
                                            fixed
                                            right
                                            @click="
                                                dialog_add_permission = true
                                            "
                                        >
                                            <v-icon>add</v-icon>
                                        </v-btn>
                                    </v-card-text>

                                    <!-- MODAL ADICIONAR PERMISSÃO-->
                                    <v-dialog
                                        v-model="dialog_add_permission"
                                        max-width="500px"
                                    >
                                        <v-card>
                                            <v-form ref="form" lazy-validation>
                                                <v-card-title
                                                    class="text-uppercase font-weight-bold"
                                                    elevation="2"
                                                >
                                                    <span class="headline">{{
                                                        formTitlePermission
                                                    }}</span>
                                                </v-card-title>

                                                <v-card-text>
                                                    <v-container>
                                                        <v-row class="mx-2">
                                                            <v-col
                                                                class="align-center justify-space-between"
                                                                cols="12"
                                                                md="12"
                                                            >
                                                                <v-text-field
                                                                    v-model="
                                                                        permission.name
                                                                    "
                                                                    :rules="
                                                                        rulesname
                                                                    "
                                                                    prepend-icon="mdi-lock"
                                                                    placeholder="Permissão"
                                                                />
                                                            </v-col>
                                                            <!--
                              <v-col cols="12" md="12">
                                <v-text-field :disabled="editedIndex == -1" prepend-icon="mdi-web" placeholder="Guard"
                                  v-model="permission.guard_name" :rules="rulesname" />
                              </v-col> -->
                                                        </v-row>
                                                    </v-container>
                                                </v-card-text>
                                            </v-form>

                                            <v-card-actions>
                                                <v-spacer></v-spacer>
                                                <v-btn
                                                    color="red darken-1"
                                                    text
                                                    @click="close"
                                                    >Cancelar</v-btn
                                                >
                                                <v-btn
                                                    color="#2C3A47"
                                                    text
                                                    type="submit"
                                                    @click="savePermissions()"
                                                    >Guardar</v-btn
                                                >
                                            </v-card-actions>
                                        </v-card>
                                    </v-dialog>
                                    <!-- MODAL ELIMINAR -->
                                    <v-dialog
                                        v-model="dialog_eliminar_permission"
                                        max-width="400"
                                    >
                                        <v-card>
                                            <v-card-title
                                                class="corprincipal dark white--text"
                                            >
                                                <span class="headline"
                                                    >Eliminar Registo</span
                                                >
                                            </v-card-title>

                                            <v-card-text>
                                                <br />
                                                <h5 class="text-danger">
                                                    Deseja eliminar este
                                                    registo?
                                                </h5>
                                            </v-card-text>

                                            <v-card-actions>
                                                <v-spacer></v-spacer>
                                                <v-btn
                                                    color="red darken-1"
                                                    text
                                                    @click="
                                                        dialog_eliminar_permission = false
                                                    "
                                                    >Não</v-btn
                                                >
                                                <v-btn
                                                    color="#2C3A47"
                                                    text
                                                    @click="
                                                        confirmDeleteItemPermission
                                                    "
                                                    >Sim</v-btn
                                                >
                                            </v-card-actions>
                                        </v-card>
                                    </v-dialog>
                                </v-card>
                            </v-tab-item>
                        </v-tabs-items>

                        <v-card-actions>
                            <v-spacer />
                            <v-btn
                                v-if="tab != 0"
                                color="#2C3A47"
                                text
                                @click="tab -= 1"
                            >
                                <v-icon>mdi-arrow-left</v-icon>Voltar
                            </v-btn>
                        </v-card-actions>
                    </v-card>
                </v-col>
            </v-row>
        </v-container>
    </Cliente>
</template>

<script>
import Cliente from "../Clientes/Cliente";
import Vue from "vue";
import { format, formatDistance } from "date-fns";

export default {
    props: ["msg", "roles", "permissions"],
    components: {
        Cliente,
    },

    data() {
        return {
            bar: true,

            dialog: false,
            dialog_add_role: false,
            dialog_add_permission: false,
            dialog_eliminar_role: false,
            dialog_edit_role: false,
            dialog_edit_permission: false,
            dialog_eliminar_permission: false,
            dialog_visualizar: false,
            user_id: "",
            dialogPerfil: false,

            tab: 0,
            items: [
                { tab: "Funções", content: "Funções" },
                { tab: "Permissões", content: "Permissões" },
            ],
            total: 0,
            options: {},
            url: "",
            loading: false,
            alert: { text: "", type: "" },
            search: "",

            permission: { name: "", guard_name: "web" },
            role: { name: "", guard_name: "web" },

            user_roles: [],
            user_permissions: [],
            busca_roles: null,
            busca_permission: null,

            search_roles: "",
            search_permissions: "",

            headers: [
                {
                    text: "ID",
                    align: "start",
                    sortable: true,
                    value: "id",
                },
                {
                    text: "Nome",
                    align: "start",
                    sortable: true,
                    value: "name",
                },
                {
                    text: "Username",
                    align: "start",
                    sortable: true,
                    value: "username",
                },
                { text: "E-mail", value: "email" },
                { text: "Telefone", value: "telefone" },

                { text: "Funções", value: "roles", sortable: false },
                { text: "Opções", value: "actions", sortable: false },
            ],

            singleSelect: false,
            headersRoles: [
                {
                    text: "Função",
                    align: "start",
                    sortable: false,
                    value: "name",
                },
                { text: "Ações", value: "actions", sortable: false },
            ],

            headersPermissions: [
                {
                    text: "Permissão",
                    align: "start",
                    sortable: false,
                    value: "name",
                },
                { text: "Ações", value: "actions", sortable: false },
            ],
            rulesname: [(v) => !!v || "Obrigatória."],

            foto: "",

            editedIndex: -1,
            estado: true,
            user_logado: {},
        };
    },

    computed: {
        user() {
            return this.$page.props.auth.user;
        },
        formTitleRole() {
            return this.editedIndex === -1 ? "Nova Função" : "Editar Função";
        },

        formTitlePermission() {
            return this.editedIndex === -1
                ? "Nova Permissão"
                : "Editar Permissão";
        },

        filtrerFuncoes() {
            if (this.busca_roles) {
                let result = this.roles.filter((item) => {
                    return (
                        item.name.toLowerCase().match(this.busca_roles) ||
                        item.created_at.toLowerCase().match(this.busca_roles) ||
                        item.id == this.busca_roles
                    );
                });

                return result ? result : [];
            } else {
                return this.roles;
            }
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

    mounted() {},

    created() {
        setTimeout(() => {
            this.loading = false;
        }, 1000);
    },
    computed: {
    user() {
      return this.$page.props.auth.user;
    },
  },
    methods: {
        validate() {
            return this.$refs.form.validate();
        },

        redirectPropostaPDF_funcoes: function () {
            window.open(
                // alert(JSON.stringify(this.query)),
                "/pdfs/listar-pdf-funcoes/"
            );
        },

        redirectPropostaPDF_permissoes: function () {
            window.open(
                // alert(JSON.stringify(this.query)),
                "/pdfs/listar-pdf-permissoes/"
            );
        },

        editItemRole(item) {
            this.editedIndex = this.roles.indexOf(item);
            this.role = Object.assign({}, item);

            this.dialog_add_role = true;
        },

        editItemPermission(item) {
            this.editedIndex = this.permissions.indexOf(item);
            this.permission = Object.assign({}, item);

            this.dialog_add_permission = true;
        },

        verDetalhes(item) {
            this.dialog_visualizar = true;

            this.user_logado = item;

            item.roles.forEach((role) => {
                this.user_roles.push(role.name);
            });

            item.permissions.forEach((permission) => {
                this.user_permissions.push(permission.name);
            });
        },

        deleteItemRole(item) {
            this.permission = Object.assign({}, item);
            this.dialog_eliminar_role = true;
        },

        confirmDeleteItemRole() {
            this.$inertia.delete(
                "/permission/delete-funcao/" + this.permission.id
            );
            this.dialog_eliminar_role = false;
        },

        deleteItemPermission(item) {
            this.permission = Object.assign({}, item);
            this.dialog_eliminar_permission = true;
        },

        confirmDeleteItemPermission() {
            this.$inertia.delete(
                "/permission/delete-permissao/" + this.permission.id
            );
            this.dialog_eliminar_permission = false;
        },

        close() {
            this.dialog = false;
            this.dialog_add_role = false;
            this.dialog_add_permission = false;
            this.role = { name: "", guard_name: "web" };
            this.permission = { name: "", guard_name: "web" };
            this.url = "";
            this.foto = "";
            setTimeout(() => {
                // this.user_logado = Object.assign({}, this.defaultItem)
                this.editedIndex = -1;
            }, 100);
        },
        // adicionar-funcao
        // saveRoles() {
        //   if (this.$refs["form"].validate()) {
        //     if (this.editedIndex > -1) {
        //       this.$inertia.put(`/permission/editar-funcao/${this.role.id} `, this.role, {
        //         onFinish: () => {
        //                 if(this.$page.props.flash.success!=null){
        //                     Vue.toasted.global.defaultSuccess({
        //                         msg: "" +this.$page.props.flash.success,
        //                     });
        //                 }
        //                 if (this.$page.props.flash.error != null) {
        //                     Vue.toasted.global.defaultError({
        //                         msg: "" + this.$page.props.flash.error,
        //                     })
        //                 }
        //             },

        //       });
        //       this.close();
        //     } else {
        //       this.$inertia.post("/permission/adicionar-funcao",
        //         this.role,{
        //         onFinish: () => {
        //           alert("oooo")
        //           if(this.$page.props.flash.success!=null){
        //                     Vue.toasted.global.defaultSuccess({
        //                         msg: "aaa",
        //                     });
        //                 }
        //                 }

        //       }),
        //       this.close();

        //     }
        //     }
        //   },
        save() {
            if (this.$refs["form"].validate()) {
                if (this.editedIndex > -1) {
                    this.$inertia.put(
                        "/permission/editar-funcao/" + this.role.id,
                        this.role
                        /*  {
                            onFinish: () => {
                                if (this.$page.props.flash.success != null) {
                                    Vue.toasted.global.defaultSuccess({
                                        msg:
                                            "" + this.$page.props.flash.success,
                                    });
                                }
                                if (this.$page.props.flash.error != null) {
                                    Vue.toasted.global.defaultError({
                                        msg: "" + this.$page.props.flash.error,
                                    });
                                }
                            },
                        } */
                    );
                    this.close();
                } else {
                    this.$inertia.post(
                        "/permission/adicionar-funcao",
                        this.role
                        /* {
                            onFinish: () => {
                                if (this.$page.props.flash.success != null) {
                                    Vue.toasted.global.defaultSuccess({
                                        msg:
                                            "" + this.$page.props.flash.success,
                                    });
                                }
                                if (this.$page.props.flash.error != null) {
                                    Vue.toasted.global.defaultError({
                                        msg: "" + this.$page.props.flash.error,
                                    });
                                }
                            },
                        } */
                    ),
                        this.close();
                }
            }
        },

        savePermissions() {
            if (this.$refs["form"].validate()) {
                if (this.editedIndex > -1) {
                    this.$inertia.put(
                        "/permission/editar-permissao/" + this.permission.id,
                        this.permission
                        /*  {
                            onFinish: () => {
                                if (this.$page.props.flash.success != null) {
                                    Vue.toasted.global.defaultSuccess({
                                        msg:
                                            "" + this.$page.props.flash.success,
                                    });
                                }
                                if (this.$page.props.flash.error != null) {
                                    Vue.toasted.global.defaultError({
                                        msg: "" + this.$page.props.flash.error,
                                    });
                                }
                            },
                        } */
                    );
                    this.close();
                } else {
                    this.$inertia.post(
                        "/permission/adicionar-permissao",
                        this.permission
                        /*  {
                            onFinish: () => {
                                if (this.$page.props.flash.success != null) {
                                    Vue.toasted.global.defaultSuccess({
                                        msg:
                                            "" + this.$page.props.flash.success,
                                    });
                                }
                                if (this.$page.props.flash.error != null) {
                                    Vue.toasted.global.defaultError({
                                        msg: "" + this.$page.props.flash.error,
                                    });
                                }
                            },
                        } */
                    ),
                        this.close();
                }
            }
        },

        editRole() {
            this.loading = true;
            this.$inertia.visit("/permission/editar-funcao" + this.role.id, {
                method: "put",
                data: { role: this.role },
                /*  onSuccess: () => {
                    this.loading = false;
                }, */
            });
        },

        editPermission() {
            this.loading = true;
            this.$inertia.visit(
                "/permission/editar-permissao" + this.permission.id,
                {
                    method: "put",
                    data: { permission: this.permission },
                    /* onSuccess: () => {
                        this.loading = false;
                    }, */
                }
            );
        },
    },
};
</script>

<style>
/* table {
    font-weight: bold;
} */

.corTitle {
    color: #002e5b;
}

.font-montserrat {
    font-family: Montserrat;
}
.opens-sans {
    font-family: "Open Sans";
}

.corprincipal {
    background-color: #00897b !important;
}

@import "vuetify/dist/vuetify.min.css";
</style>
