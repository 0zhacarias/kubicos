<template>
    <v-app>
        <!-- <div>
            <v-app-bar
                app
                class="app-header position-relative navbar-light header1"
                flat
            >
                <v-container class="py-0 fill-height">
                    <div class="logo">
                        <a href="/">
                            <v-avatar color="#00B0FF" size="56"
                                ><v-icon color="white">home</v-icon></v-avatar
                            >
                        </a>
                    </div>

                    <v-spacer></v-spacer>
                    <v-btn class="d-block d-md-none" text>
                        <v-app-bar-nav-icon />
                    </v-btn>
                    <v-btn
                        class="d-none d-lg-flex btn-custom-nm ml-5"
                        outlined
                        color="#00B0FF"
                        href="/auth/login"
                        elevation="0"
                    >
                        Login
                    </v-btn>

                    <v-btn
                        class="d-none d-lg-flex btn-custom-nm ml-5"
                        color="#00B0FF"
                        href="/condominio/create"
                        elevation="0"
                    >
                        Novo Condominio
                    </v-btn>
                </v-container>
            </v-app-bar>
        </div> -->

        <v-toolbar flat class="header1 elevation-0 py-0" color="deep-purple darken-3 ">
            <v-toolbar-title><a href="/" style="text-decoration: none"><v-avatar size="40"
                        color="deep-purple darken-3"><v-icon color="white" large>home</v-icon></v-avatar>
                    <span class="white--text hidden-xs-only"> KUBICOS - (SIG-VAI)</span>
                </a>
            </v-toolbar-title>
            <v-spacer class=""></v-spacer>
            <v-toolbar-items>
                <v-btn @click="storePreviousUrl('/portal/listaImoveisArrendamentos')"
                    class="d-none d-lg-flex btn-custom-nm ml-5" color="#fff" href="/portal/listaImoveisArrendamentos"
                    elevation="0" text>
                    Arrendar
                </v-btn>

                <v-btn @click="storePreviousUrl('/portal/listaImoveisCompras')" dense
                    class="d-none d-lg-flex btn-custom-nm ml-5" color="#fff" href="/portal/listaImoveisCompras"
                    elevation="0" text>
                    Comprar
                </v-btn>
                <v-btn dense v-if="user == null" @click="anuncios()" class="d-none d-lg-flex btn-custom-nm ml-5" color="#fff"
                    elevation="0" text>
                    Anunciar
                </v-btn>
                <v-btn dense v-if="user !== null && user.can['Gerir Anúncios']" @click="anuncios()"
                    class="d-none d-lg-flex btn-custom-nm ml-5" color="#fff" elevation="0" text>
                    Anunciar
                </v-btn>
            </v-toolbar-items>
            <v-toolbar-items>
                <v-btn v-if="user == null" class="d-none d-lg-flex btn-custom-nm ml-5" color="#fff" @click="loginDialog()"
                    elevation="0" text>
                    Login
                </v-btn>

                <!-- <v-btn v-if="user==null" dense class="d-none d-lg-flex btn-custom-nm ml-5" color="#fff"
                    href="/RegistrarConta" elevation="0" text>
                    Cadastrar
                </v-btn> -->

                <!-- <v-btn v-if="user!==null" text dense class="white--text text-lowercase" href="/perfil"> -->
                <v-btn v-if="user !== null" text href="/perfil" dense class="d-none d-lg-flex btn-custom-nm ml-5 "
                    color="#fff">
                    <v-icon class="mdi mdi-account-reactivate white--text" title="Perfil">

                    </v-icon>
                    {{ user.name }}<br />
                    <!-- {{ user.email}} -->
                </v-btn>
                <v-btn dense class="d-none d-lg-flex btn-custom-nm ml-5 " color="#fff" href="/sobre-nos" elevation="0" text>
                    Sobre Nós
                </v-btn>
                <v-btn class="white--text hidden-xs-only" v-if="user !== null" @click="logout" title="Terminar Sessão" icon>
                    <v-icon>mdi-export{{ }}</v-icon>
                </v-btn>
            </v-toolbar-items>
            <div class="hidden-sm-and-up">
                <v-menu offset-y>
                    <template v-slot:activator="{ on }">
                        <v-app-bar-nav-icon v-on="on" class="white--text"></v-app-bar-nav-icon>
                    </template>
                    <v-list class="responsiveMenu">
                        <v-list-item>
                            <v-list-item-title><router-link to="/">Home</router-link></v-list-item-title>
                        </v-list-item>
                        <v-list-item>
                            <v-list-item-title><router-link to="/about">Arrendamento</router-link></v-list-item-title>
                        </v-list-item>
                        <v-list-item>
                            <v-list-item-title><router-link to="/contact">Anuciar</router-link></v-list-item-title>
                        </v-list-item>
                        <v-list-item>
                            <v-list-item-title><router-link to="/logout">sair</router-link></v-list-item-title>
                        </v-list-item>
                        <v-list-item>
                            <v-list-item-title href="/sobre-nos" ><router-link to="/sobre-nos">sair</router-link></v-list-item-title>
                        </v-list-item>
                    </v-list>
                </v-menu>
            </div>
        </v-toolbar>


        <v-main class=" grey lighten-5 scroll-y pb-0" fluid>
            <!-- <v-container> -->
            <slot align="center" justify="center" />
            <!-- </v-container> -->
        </v-main>

        <div class="text-center">
            <v-menu v-model="dialogContacto" :close-on-content-click="false" :nudge-width="50" offset-y nudge-top="600">
                <template v-slot:activator="{ on, attrs }">
                    <v-fab-transition>
                        <v-btn v-bind="attrs" v-on="on" v-show="!hidden" class="deep-purple" dark fixed bottom right fab>
                            <v-icon>mdi mdi-email-fast-outline</v-icon>
                        </v-btn>

                    </v-fab-transition>
                </template>

                <v-card class="" max-width="300">
                    <v-list>
                        <v-list-item>
                            <!-- <v-list-item-avatar>
                                <img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John">
                            </v-list-item-avatar> -->

                            <v-list-item-content>
                                <v-list-item-title class="subtitle-1 text-h5">KUBICOS</v-list-item-title>
                                <v-list-item-subtitle>Para adicionar a sua Zona de atuação ou a Imóbiliaria que pertences
                                    informe no formulário</v-list-item-subtitle>
                            </v-list-item-content>

                            <!-- <v-list-item-action>
                                <v-btn :class="fav ? 'red--text' : ''" icon @click="fav = !fav">
                                    <v-icon>mdi-heart</v-icon>
                                </v-btn>
                            </v-list-item-action> -->
                        </v-list-item>
                    </v-list>

                    <v-divider></v-divider>
                    <v-col cols="12"> <validation-provider v-slot="{ errors }" name="Numero do telefone" :rules="{
                        required: true,
                        digits: 9,
                        // regex: '^(244)\\d{9}$'
                        regex: '^(9)\\d{8}$'
                    }">
                            <v-text-field v-model="phoneNumber" outlined :counter="9" :error-messages="errors" dense
                                label="Phone Number" required></v-text-field>
                        </validation-provider></v-col>
                    <v-col cols="12"> <validation-provider v-slot="{ errors }" name="email" rules="required|email">
                            <v-text-field v-model="email" outlined :error-messages="errors" dense label="E-mail"
                                required></v-text-field>
                        </validation-provider>
                    </v-col>
                    <v-col cols="12"> <validation-provider v-slot="{ errors }" name="email" rules="required|email">
                            <v-textarea rows="2" v-model="email" outlined :error-messages="errors" dense label="E-mail"
                                required></v-textarea>
                        </validation-provider>
                    </v-col>
                    <v-list>
                        <!--
                        <v-list-item>
                            <v-list-item-action>
                                <v-switch v-model="message" color="purple"></v-switch>
                            </v-list-item-action>
                            <v-list-item-subtitle>Para adicionar a sua Zona de atuação ou a Imóbiliaria que pertences informe no formulário</v-list-item-subtitle>
                        </v-list-item> -->

                        <!-- <v-list-item>
                            <v-list-item-action>
                                <v-switch v-model="hints" color="purple"></v-switch>
                            </v-list-item-action>
                            <v-list-item-title>Enable hints</v-list-item-title>
                        </v-list-item> -->
                    </v-list>

                    <v-card-actions>
                        <v-spacer></v-spacer>

                        <v-btn text color="red" @click="dialogContacto = false">
                            Fechar
                        </v-btn>
                        <v-btn color="indigo" text @click="dialogContacto = false">
                            Enviar
                        </v-btn>
                    </v-card-actions>
                </v-card>
            </v-menu>
        </div>

        <v-container>
            <template>
                <v-row justify="center">
                    <v-dialog v-if="dialogLogin == true" v-model="dialogLogin" fullscreen hide-overlay
                        transition="dialog-bottom-transition">
                        <v-card>
                            <v-toolbar dark color="primary">
                                <v-btn icon dark @click="dialogLogin = false">
                                    <v-icon>mdi-close</v-icon>
                                </v-btn>
                                <v-toolbar-title>Voltar</v-toolbar-title>
                                <v-spacer></v-spacer>
                                <v-toolbar-items>
                                    <!-- <v-btn dark text @click="dialogLogin = false">
                                        Save
                                    </v-btn> -->
                                </v-toolbar-items>
                            </v-toolbar>
                            <v-row align="center" justify="center">
                                <v-col cols="12" md="6" lg="5">
                                    <v-container class=" alinnharcentro">

                                        <v-card align="center" justify="center" elevation="0" class="w-75">

                                            <v-card-text class="text-h3"> SIG-VAI</v-card-text>
                                            <v-card-text fluid class="justify-center">
                                                <v-form v-model="isValid">
                                                    <v-row class="justify-center">
                                                        <v-col cols="12">
                                                            <v-text-field :rules="[rules.required]"
                                                                placeholder="Email ou telefone" outlined rounded
                                                                label="Email" name="email" v-model="usuario.email"
                                                                prepend-icon="mdi-account-circle" />
                                                        </v-col>
                                                        <v-col cols="12">
                                                            <v-text-field :rules="[rules.required]" outlined rounded
                                                                id="password" label="Palavra-Passe"
                                                                v-model="usuario.password" name="password"
                                                                prepend-icon="mdi-lock" :append-icon="showPassword
                                                                    ? 'mdi-eye'
                                                                    : 'mdi-eye-off'
                                                                    " :type="showPassword ? 'text' : 'password'
        " v-on:keyup.enter="login" @click:append="
        showPassword = !showPassword
        " required />
                                                        </v-col>
                                                        <span class="subtitle">--------------- Entrar com
                                                            ---------------------
                                                        </span>
                                                        <v-col cols="12">
                                                            <div class="text-center pb-3">
                                                                <v-btn href="/auth/redirect" block rounded outlined x-large
                                                                    color="blue darken-1">
                                                                    <v-icon>mdi mdi-google</v-icon>
                                                                    Google
                                                                </v-btn>
                                                            </div>

                                                            <v-alert outlined dismissible transition="scale-transition" text
                                                                v-if="alert.type == 'success'" type="success">
                                                                {{ alert.text }}
                                                            </v-alert>
                                                            <v-alert dismissible transition="scale-transition" outlined
                                                                v-if="alert.type == 'error'" type="error">
                                                                {{ alert.text }}
                                                            </v-alert>

                                                            <v-btn block rounded color="#4527A0" dark x-large
                                                                @click="setLogin()" :disabled="!isValid">
                                                                <v-icon>login</v-icon> Iniciar
                                                                Sessão
                                                            </v-btn>
                                                        </v-col>

                                                        <v-col cols="12" md="12">

                                                        </v-col>
                                                    </v-row>
                                                </v-form>
                                            </v-card-text>
                                            <v-card-actions>
                                                <p class="ml-4 pb-6 subtitle">
                                                    <a href="/reset-password" class="linkstilo">
                                                        Esqueci a minha senha!</a><br />
                                                    Não possui uma conta?<a href="/RegistrarConta" class="linkstilo">
                                                        Cadastra AQUI!</a>
                                                </p>

                                            </v-card-actions>
                                            <div class=" px-6">
                                                <v-btn href="" rounded outlined color="deep-purple darken-3">
                                                    <a href="/" style="text-decoration: none; color: #4527A0; ">

                                                        <v-icon>mdi mdi-arrow-left-circle</v-icon>
                                                        Voltar
                                                    </a>
                                                </v-btn>
                                            </div>
                                        </v-card>
                                    </v-container>
                                </v-col>
                                <v-col cols="12" md="6" lg="7">
                                    <v-img src="/img/cms-image.jpg" :style="'height: 100vh; '" align="center"
                                        justify="center" gradient="to top right, rgba(10,115,201,.33), rgba(25,32,72,.7)">
                                        <v-container>
                                            <v-row class="alinnharcentro white--text ">
                                                <v-card-text>
                                                    <p class="text-h1 font-weight-bold p-0 m-0">SIG-VAI</p>
                                                    <p class="subtitle pb-5 m-0">Sistema de Gestão de Imóbiliaria (Kubicos)
                                                    </p>
                                                    <p class="text-h5">Aumente sua receita com o nosso sistema</p>
                                                    <p>O SIG-VRIM é a plataforma de financiamento imobiliário que
                                                        <br />oferece crédito ao seu
                                                        cliente de uma maneira fácil e sem burocracia.
                                                    </p>

                                                </v-card-text>

                                            </v-row>

                                        </v-container>

                                    </v-img>
                                </v-col>
                            </v-row>
                        </v-card>
                    </v-dialog>
                </v-row>
            </template>


                        <v-dialog transition="dialog-top-transition" v-model="dialogVerificarInformacoes" max-width="600" v-if="this.dialogVerificarInformacoes == true">
                                <v-card>
                                    <v-toolbar color="primary" dark>Opening from the top</v-toolbar>
                                    <v-card-text>
                                        <div class="text-h4 pa-12">Para poderes fazer o anúncio deves prencher alguns campos importante!!</div>
                                    </v-card-text>
                                    <v-card-actions class="justify-end">
                                        <v-btn text @click="this.dialogVerificarInformacoes.value = false">Close</v-btn>
                                        <v-btn text href="/clientes/meu-perfil" >Ir no Perfil</v-btn>
                                    </v-card-actions>
                                </v-card>
                        </v-dialog>


            <v-card-text class="text-center">
                <v-btn v-for="icon in icons" :key="icon" icon>
                    <v-icon color="#6A1B9A" size="24px">{{ icon }}</v-icon>
                </v-btn>
            </v-card-text>
            <v-card-text class="text-center">
                Kubicos é um site classificado para facilitar a compra, venda e aluguel de residências habitacionais em
                zonas u
                rbanas de Angola.
                <v-divider></v-divider>
                {{ new Date().getFullYear() }}-
                <strong>SIG-VAI
                    <span class="font-weight-light">(Sistema de Gestão de Venda e Arrendamento de Imóveis)</span>
                </strong>
            </v-card-text>

        </v-container>
    </v-app>
</template>
<script>
// import { Link } from "@inertiajs/inertia-vue";
import { required, digits, email, regex } from 'vee-validate/dist/rules'
import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate'
setInteractionMode('eager')

extend('digits', {
    ...digits,
    message: '{_field_} precisa de  {length} digitos e deve começar com número 9. ({_value_})',
})

extend('required', {
    ...required,
    message: 'O campo não pode estar vazio',
})
extend('regex', {
    ...regex,
    message: '{_field_} {_value_} Não compre com as restrições (990987634)',
})

extend('email', {
    ...email,
    message: 'Email invalido',
})
export default {
    props: ['provincias', 'startingImage', 'autoSlideInterval', 'showProgressBar', 'msg', 'tipoUsuario'],
    components: {
        ValidationProvider,
        ValidationObserver,
    },
    data() {
        return {
            usuario: {},
            icons: [
                "fab fa-facebook",
                "fab fa-twitter",
                "fab fa-google-plus",
                "fab fa-linkedin",
                "fab fa-instagram",
            ],
            dialogContacto: false,
            drawer: true,
            mini: true,
            totalNotificacoes: 0,

            dialogLogin: false,
            dialogVerificarInformacoes: false,
            notifications: false,
            sound: true,
            widgets: false,

            rules: {
                required: (value) => !!value || "Campos obrigatório.",
            },
            showPassword: false,
            isValid: true,
            overlay: false,

            alert: {
                text: "",
                type: ""
            },
        };
    },

    mounted() {

    },

    computed: {
        user() {
            return this.$page.props.auth.user;
        },
    },
    created() {


    },
    methods: {
        // storePreviousUrl(url) {
        // Emite um evento global com a URL
        // this.$root.$emit('store-previous-url', url);
        // },
        loginDialog() {

            this.dialogLogin = true;
        },
        anuncios() {
            if (this.$page.props.auth.user !== null) {
                if (this.user.pessoa.provincia_id) {

                    this.$inertia.get('/portal/imoveis').then((response) => {
                    // window.location.reload();
                }).catch((error) => {
                    console.log(error);
                    // Tratamento de erro, se necessário
                });
                }else{
                    this.dialogVerificarInformacoes = true
                }


            } else {
                this.dialogLogin = true;
            }

        },

        logar() {
            this.$inertia.get("/logar").then((response) => {
                // window.location.reload();
            }).catch((error) => {
                console.log(error);
                // Tratamento de erro, se necessário
            });
            // href="/logar"
        },
        setLogin() {
            this.$inertia.post("/login", this.usuario, {
                // preserveState: true,
                // preserveScroll: true,
            });
            this.dialogLogin = false;
        },
        logout() {
            axios.post("/logout").then((response) => {
                window.location.reload();
            }).catch((error) => {
                console.log(error);
                // Tratamento de erro, se necessário
            });
        },
        perfilUsuario() {
            axios.get("/perfil-usuario").then((response) => {
                window.location.reload();
            }).catch((error) => {
                console.log(error);
                // Tratamento de erro, se necessário
            });
            // this.$inertia.post("/login", this.usuario, {});
        }
    },
};
</script>
<style>
body {
    font-family: 'Poppins-Regular';
}

.alinnharcentro {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100vh;
    /* Define a altura total da janela para centralizar verticalmente */
}

.linkstilo {
    text-decoration: none !important;
    color: #4527A0;

}
</style>
