<template>
    <v-app>

        <v-row align="center" justify="center">
            <v-col cols="12" md="7">
                <v-img src="/img/cms-image.jpg" :style="'height: 100vh; '" align="center" justify="center"
                    gradient="to top right, rgba(10,115,201,.33), rgba(25,32,72,.7)">
                    <v-container>
                        <v-row class="alinnharcentro white--text ">
                            <v-card-text>
                                <p class="text-h1 font-weight-bold p-0 m-0">KUBICOS</p>
                                <p class="subtitle pb-5 m-0">Sistema de Gestão de Imóbiliaria (SIG-VAI)</p>
                                <p class="text-h5">Aumente sua receita com o nosso sistema</p>
                                <p>O ZAP+Fin é a plataforma de financiamento imobiliário que <br />oferece crédito ao seu
                                    cliente de uma maneira fácil e sem burocracia.</p>

                            </v-card-text>

                        </v-row>

                    </v-container>

                </v-img>
            </v-col>
            <v-col cols="12" md="5">

                <v-container class=" alinnharcentro">

                    <v-card align="center" justify="center" elevation="0" class="w-75">

                        <v-card-text class="text-h3"> SIG-VAI</v-card-text>
                        <v-card-text fluid class="justify-center">
                            <v-form v-model="isValid">
                                <v-row class="justify-center">
                                    <template>
                                        <v-tabs v-model="tab" color="indigo" centered class="text-h2 py-3 text-h2"
                                            show-arrows icons-and-text >
                                            <v-tab class="text-h6 px-lg-6 px-md-2 px-sm-1 text-h2 text-lowercase  indigo--text"
                                                @click="cliente()">Cliente</v-tab>
                                            <v-tab color="indigo"  class="text-h6 px-lg-6 px-md-2 px-sm-1 text-lowercase indigo--text"
                                                @click="pambaleiro()">Pambaleiro</v-tab>
                                            <v-tab class="text-h6 px-lg-6 px-md-2 px-sm-1 text-h2 text-lowercase  indigo--text"
                                                @click="proprietario()">Proprietário</v-tab>
                                            <v-tab class="text-h6 px-lg-6 px-md-2 px-sm-1 text-lowercase  indigo--text"
                                                @click="corrector()">Corrector</v-tab>
                                        </v-tabs>
                                    </template>
                                    <v-col cols="12">
                                        <v-text-field :rules="[rules.required]" placeholder="Nome completo*" outlined
                                            rounded label="Nome completo*" name="name" v-model="user.name"
                                            prepend-icon="mdi-account-circle" />
                                    </v-col>
                                    <v-col cols="12">
                                        <v-text-field :rules="emailRules" placeholder="Email/ nº telefone*" outlined
                                            rounded label="Email ou Nº Telefone" name="email" v-model="user.email"
                                            prepend-icon="mdi-account-circle" />
                                    </v-col>
                                    <v-col cols="12">
                                        <v-text-field :rules="[rules.required]" outlined rounded id="Palavra-Passe"
                                            label="Palavra-Passe" v-model="user.password" name="password"
                                            prepend-icon="mdi-lock" :append-icon="showPassword
                                                ? 'mdi-eye'
                                                : 'mdi-eye-off'
                                                " :type="showPassword ? 'text' : 'password'
        " v-on:keyup.enter="login" @click:append="
        showPassword = !showPassword
        " required />
                                    </v-col>
                                    <v-col cols="12" v-if="this.getimobiliaria">
                                        <v-autocomplete :rules="[rules.required]" outlined rounded id="espacotrabalho"
                                            :label="getcorrector ? 'Nome da Imóbiliaria' : 'Nome da Placa'"
                                            v-model="user.zona_trabalho" name="zona_trabalho"
                                            :items="getcorrector ? tipoImoveis : placa" prepend-icon="mdi-lock"
                                            item-color="indigo" required />
                                    </v-col>
                                    <span class="subtitle">--------------- Entrar com ---------------------
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
                                            v-if="alert" type="success">
                                            {{ alert.text }}
                                        </v-alert>
                                        <v-alert dismissible transition="scale-transition" outlined
                                            v-if="alertError" type="error">
                                            Escolhe o tipo de utilizador
                                        </v-alert>

                                        <v-btn block rounded color="indigo" dark x-large @click="setLogin()"
                                            :disabled="!isValid"><v-icon>login</v-icon> Iniciar
                                            Sessão</v-btn>
                                    </v-col>

                                    <v-col cols="12" md="12">

                                    </v-col>
                                </v-row>
                            </v-form>
                        </v-card-text>
                        <!-- <v-card-actions> -->
                        <!-- <p class="ml-4 pb-6 subtitle">
                                <a href="/reset-password" class="linkstilo">
                                    Esqueci a minha senha!</a><br />
                                Não possui uma conta?<a href="/reset-password" class="linkstilo">
                                    Cadastra AQUI!</a>
                            </p> -->

                        <!-- </v-card-actions> -->
                        <div>
                            <v-btn href="" rounded outlined color="indigo">
                                <a href="/logar" style="text-decoration: none; color: #4527A0; ">


                                    <v-icon>mdi mdi-arrow-left-circle</v-icon>
                                    Voltar
                                </a>
                            </v-btn>
                        </div>
                    </v-card>
                </v-container>
            </v-col>

        </v-row>
    </v-app>
</template>

<script>


export default {
    components: {

    },

    data: () => ({
        alert: false,
        alertError: false,
        showPassword: false,
        isValid: true,
        overlay: false,
        getimobiliaria: false,
        getcorrector: false,
        user: {
            zona_trabalho:null,
            // tipo_user_id:2,
        },
        rules: {
            required: (value) => !!value || "Campos obrigatório.",
        },
        emailRules: [
            (value) => /.+@.+\..+/.test(value) || /^\d{9}$/.test(value)|| "E-mail ou numero de telefone válido",
                    ],

        placa: ['Rangel', 'Benfica', 'Cazenga', 'BO',
         'Marçal', 'Vila-lice', 'Nova Urbanização de Cacuado', 
         'Maianga', 'Rangel', 'Benfica', 'Cazenga', 'BO',
         'Cassenda', 'Benfica', 'Cazenga', 'Outros',],

        tipoImoveis: ['Imooliveira', 'AAfrica', 
        'KindaHome', 'ImoBeto'],
    }),
    computed: {},

    // created() {
    //     setTimeout(() => {
    //         this.overlay = false;
    //     }, 2000);
    // },
    mounted() { },

    methods: {
        pambaleiro() {
            this.user.tipo_user_id = 4
            this.getimobiliaria = true;
            this.getcorrector = false;
            // alert(this.user.tipo_user_id)
        },
        corrector() {
            this.user.tipo_user_id = 5
            this.getimobiliaria = true;
            this.getcorrector = true;
        },
        proprietario() {
            this.user.tipo_user_id = 3
            this.getimobiliaria = false;
        },
        cliente() {
            this.user.tipo_user_id = 2
            this.getimobiliaria = false;
        },
        setLogin() {
            // alert(this.user.tipo_user_id)
            if(this.user.tipo_user_id==null){
                this.alertError=true
            }else{
                this.$inertia.post("register", this.user, {

});
            }
            // window.sessionStorage.setItem('redirectRoute', this.$route.fullPath),
            
            // if(response.status === 201){
            //     this.alert(1)
            // }
            // alert(1)
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

}</style>
