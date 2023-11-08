<template>
    <v-app id="inspire">
        <v-app-bar app color="deep-purple darken-3 "  class="white--text" flat>
            <!-- <v-btn
                text
                icon
                class="blue-grey lighten-4"
                @click="drawer = !drawer"
                outlined
            >
                <v-icon>mdi-dots-vertical</v-icon>
            </v-btn>
             <v-text>
        Menu
      </v-text> 
            <v-spacer /> -->

               <a href="/home" style="text-decoration: none"><v-avatar size="60" color="white"><v-icon
                                 large>home</v-icon></v-avatar>
                       <span class="white--text text-bold text--darken-3"> KUBICO - (SIG-VAI)</span></a>

                
                <v-spacer/>
            
            <v-btn text class="white--text">
                {{ user.name }}
                <!-- <v-icon>mdi-magnify</v-icon> -->

            </v-btn>

            <v-btn icon class="white--text">
                <v-icon
                    title="Ver Notificações"
                    left
                    v-if="totalNotificacoes > 0"
                    color="#000"
                    dense
                    >notifications</v-icon
                >
                <v-icon left v-else color="#fff">notifications</v-icon>
            </v-btn>
           
            <v-btn class="white--text" @click="logout" title="Terminar Sessão" icon>
                <v-icon >mdi-export</v-icon>
            </v-btn>
      
        </v-app-bar>

        <!-- <v-navigation-drawer
            style="color: white"
            app
            v-model="drawer"
            color="#607d8b "
            hide-overlay
        >
            <br />
            <v-img
                contain
                :aspect-ratio="16 / 9"
                src="https://demos.creative-tim.com/vuetify-material-dashboard/favicon.ico"
            >
            </v-img>
            <v-divider></v-divider>
            <v-row align="end" justify="center" align-content="bottom">
                <v-col class="text-center">
                    <div class="body-1 mt-2">{{ user.name }}</div>
                </v-col>
            </v-row>
            <v-divider></v-divider>
            <inertia-link href="/home" style="text-decoration: none">
                <v-list-item link style="color: white">
                    <v-list-item-icon>
                        <v-icon style="color: white">dashboard</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title>INÍCIO</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
            </inertia-link>

            <inertia-link href="/condominios" style="text-decoration: none">
                <v-list-item link style="color: white">
                    <v-list-item-icon>
                        <v-icon style="color: white">home</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title>CONDOMÍNIOS</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
            </inertia-link>

            <inertia-link href="/moradores" style="text-decoration: none">
                <v-list-item link style="color: white">
                    <v-list-item-icon>
                        <v-icon style="color: white">group</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title>MORADORES</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
            </inertia-link>

            <inertia-link href="/teste" style="text-decoration: none">
                <v-list-item link style="color: white">
                    <v-list-item-icon>
                        <v-icon style="color: white">assignment</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-list-item-title>FACTURAS</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
            </inertia-link>

            <v-list>
                <v-list-group
                    prepend-icon="mdi-account-group-outline"
                    no-action
                    color="white"
                >
                    <template v-slot:activator>
                        <v-list-item-content style="color: white">
                            <v-list-item-title>UTILIZADORES</v-list-item-title>
                        </v-list-item-content>
                    </template>

                    <v-list-item>
                        <v-list-item-icon>
                            <v-icon style="color: white">list</v-icon>
                        </v-list-item-icon>

                        <v-list-item-content>
                            <v-list-item-title>
                                <inertia-link
                                    style="text-decoration: none; color: white"
                                    class="color-text-link remover-link"
                                    href="/utilizadores"
                                >
                                    Listar
                                </inertia-link>
                            </v-list-item-title>
                        </v-list-item-content>
                    </v-list-item>
                </v-list-group>
            </v-list>

            <template v-slot:append>
                <div class="pa-2">
                    <v-btn outlined color="white" @click="logout" block>
                        <v-icon>mdi-logout</v-icon>
                        Sair
                    </v-btn>
                </div>
            </template>
        </v-navigation-drawer> -->

        <v-main id="#scrolling-techniques-2" class="grey lighten-3">
            <!-- <v-container> -->
                <slot />
            <!-- </v-container> -->
        </v-main>
    </v-app>
</template>
<script>
// import { required, digits, email, max, regex } from 'vee-validate/dist/rules'
// import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate'
export default {
    data() {
        return {
            drawer: true,
            mini: true,
            totalNotificacoes: 0,
        };
    },

    computed: {
        user() {
            return this.$page.props.auth.user;
        },
    },

    created() {},

    methods: {
        logout() {
            axios.post("/logout").then((response) => {
                window.location.reload();
            });
        },
    },
};
</script>

<style>
</style>
