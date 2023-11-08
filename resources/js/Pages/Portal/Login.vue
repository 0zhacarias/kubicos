<template>
    <v-app>

        <v-row align="center" justify="center">
            <v-col cols="12" md="6" lg="5">
                <v-container class=" alinnharcentro">

                    <v-card align="center" justify="center" elevation="0" class="w-75">

                        <v-card-text class="text-h3">KUBICOS </v-card-text>
                        <v-card-text fluid class="justify-center">
                            <v-form v-model="isValid">
                                <v-row class="justify-center">
                                    <v-col cols="12">
                                        <v-text-field :rules="[rules.required]" placeholder="Email" outlined rounded
                                            label="Email" name="email" v-model="user.email"
                                            prepend-icon="mdi-account-circle" />
                                    </v-col>
                                    <v-col cols="12">
                                        <v-text-field :rules="[rules.required]" outlined rounded id="password"
                                            label="Palavra-Passe" v-model="user.password" name="password"
                                            prepend-icon="mdi-lock" :append-icon="showPassword
                                                ? 'mdi-eye'
                                                : 'mdi-eye-off'
                                                " :type="showPassword ? 'text' : 'password'
        " v-on:keyup.enter="login" @click:append="
        showPassword = !showPassword
        " required />
                                    </v-col>
                                    <span class="subtitle">--------------- Entrar com ---------------------
                                    </span>
                                    <v-col cols="12">
                                        <!-- <template>
  <div>
    <a v-bind:href="authUrl" v-html="linkText"></a>
  </div>
</template> --><template>
                                            <div>
                                                <a href='/auth/redirect'>Login with Google</a>
                                            </div>
                                        </template>
                                        <div>
                                            <!-- <GoogleLogin :params="params"  :onSuccess="onSuccess" :onFailure="onFailure">Login</GoogleLogin> -->
                                            <!-- <GoogleLogin :params="params" :renderParams="renderParams"
                                                :onSuccess="onSuccess" :onFailure="onFailure"></GoogleLogin> -->

                                            <!-- <v-btn href="login/google" block rounded outlined x-large color="blue darken-1">
                                                <v-icon>mdi mdi-google</v-icon>
                                                Google
                                            </v-btn> -->
                                        </div>
                                        <v-alert outlined dismissible transition="scale-transition" text
                                            v-if="alert.type == 'success'" type="success">
                                            {{ alert.text }}
                                        </v-alert>
                                        <v-alert dismissible transition="scale-transition" outlined
                                            v-if="alert.type == 'error'" type="error">
                                            {{ alert.text }}
                                        </v-alert>

                                        <v-btn block rounded color="#4527A0" dark x-large @click="setLogin()"
                                            :disabled="!isValid">
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
                <v-img src="/img/cms-image.jpg" :style="'height: 100vh; '" align="center" justify="center"
                    gradient="to top right, rgba(10,115,201,.33), rgba(25,32,72,.7)">
                    <v-container>
                        <v-row class="alinnharcentro white--text ">
                            <v-card-text>
                                <p class="text-h1 font-weight-bold p-0 m-0">SIG-VAI</p>
                                <p class="subtitle pb-5 m-0">Sistema de Gestão de Imóbiliaria (Kubicos)</p>
                                <p class="text-h5">Aumente sua receita com o nosso sistema</p>
                                <p>O SIG-VRIM é a plataforma de financiamento imobiliário que <br />oferece crédito ao seu
                                    cliente de uma maneira fácil e sem burocracia.</p>

                            </v-card-text>

                        </v-row>

                    </v-container>

                </v-img>
            </v-col>
        </v-row>
    </v-app>
</template>

<script>
// import GoogleLogin from 'Vue-google-login';
export default {

    components: {
        // GoogleLogin
    },

    data: () => ({
        // authUrl: '$authUrl', // Substitua $authUrl pelo valor real
        // linkText: "Login google",
        alert: {
            text: "",
            type: ""
        },
        showPassword: false,
        isValid: true,
        overlay: false,
        user: {},
        previousUrls: [],
        rules: {
            required: (value) => !!value || "Campos obrigatório.",
        },
        params: {
            client_id: "390506223983-2km69qu9r8v3o9fu8mt5vqpgudpqgf9n.apps.googleusercontent.com"
        },
        // only needed if you want to render the button with the google ui
        renderParams: {
            width: 250,
            height: 50,
            longtitle: true
        },
    }),
    computed: {},

    created() {
        // setTimeout(() => {
        //     this.overlay = false;
        // }, 2000);
        // alert(JSON.stringify(response.data))
        // alert(JSON.stringify($root.$on('store-previous-url', this.storePreviousUrl)))
        this.$root.$on('store-previous-url', this.storePreviousUrl);
    },
    mounted() { },

    methods: {
        loginWithGoogle() {
            // Redirecionar para a rota de login do Laravel
            window.location.href = '/login/google';
        },
        onSuccess(googleUser) {
            console.log(googleUser);

            // This only gets the user information: id, name, imageUrl and email
            console.log(googleUser.getBasicProfile());
        },
        storePreviousUrl(url) {
            // Adiciona a nova URL à frente do array
            this.previousUrls.unshift(url);
            // alert(url);
            // Garante que o array tenha no máximo duas URLs armazenadas
            if (this.previousUrls.length > 2) {
                this.previousUrls.pop(); // Remove a URL mais antiga
            }
        },
        setLogin() {
            //    this.$inertia.visit('/login', { data: { redirectRoute: window.location.href } });
            // this.user.rotas=
            const url1 = this.previousUrls.pop();
            const url2 = this.previousUrls.pop();
            this.previousUrls.unshift();
            alert(this.previousUrls);
            // this.previousUrls.push(url);

            // Garantir que o array tenha no máximo duas URLs armazenadas
            if (this.previousUrls.length > 2) {
                this.previousUrls.shift(); // Remover a URL mais antiga
            }
            // this.previousUrl = window.location.href;
            //   alert( this.previousUrls);

            this.$inertia.post("/login", this.user, {});
        },
    },
};
</script>

<style scoped>
/* @import "vuetify/dist/vuetify.min.css"; */

/* @import "./assets/scss/_custom-variable.scss";
@import "./assets/scss/style.scss"; */
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
