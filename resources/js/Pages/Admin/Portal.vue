<template>
    <AdminLayout>
        <div class="heroBlock" name="carrousel">
            <v-carousel cycle hide-delimiters>
                <v-carousel-item v-for="(item, i) in items" :key="i" :src="item.src" reverse-transition="fade-transition"
                    transition="fade-transition">
                    <v-row class="title fill-height hidden-xs-only" align="center" justify="center">{{ item.title }}</v-row>
                </v-carousel-item>
            </v-carousel>
        </div>
        <v-card class="pa-0 mt-n15 mr-n2 mx-auto" >
            <v-row style="margin-top:-100px">
                <v-col>
                    <v-autocomplete auto-select-first chips clearable rounded solo>
                    </v-autocomplete>
                </v-col>
                <v-col>
                    <v-autocomplete auto-select-first chips clearable rounded solo>
                    </v-autocomplete>
                </v-col>
                <v-col>
                    <v-autocomplete auto-select-first chips clearable rounded solo>
                    </v-autocomplete>
                </v-col>
                <v-col>
                    <v-autocomplete auto-select-first chips clearable rounded solo>
                    </v-autocomplete>
                </v-col>
            </v-row>

        </v-card>
        <v-card outlined>

            <div class="block latestPostBlock" name="nossos-clientes">
                <v-container>
                    <h2 class="text-center">Nosso Clientes</h2>
                    <v-row>
                        <v-col v-for="item in clientes" :key="item.id" cols="12" md="4">
                            <v-card outlined class="mx-auto">
                                <v-img class="white--text align-end" height="200px" :src="item.src">
                                    <v-card-title>{{ item.title }}</v-card-title>
                                </v-img>
                                <v-card-subtitle class="pb-0">{{
                                    item.subtitle
                                }}</v-card-subtitle>
                                <v-card-text class="text--primary">
                                    <div>{{ item.description }}</div>
                                </v-card-text>
                                <v-card-actions>
                                    <v-btn color="primary" text>Mais</v-btn>
                                </v-card-actions>
                            </v-card>
                        </v-col>
                    </v-row>
                </v-container>
            </div>
        </v-card>
        <v-card outlined>
            <div class="staticHero">
                <!-- <v-img src="../assets/images/img14.jpg"> -->
                <v-row align="end" class="lightbox white--text pa-2 fill-height">
                    <v-col>
                        <v-container>
                            <div class="headline">Contactos</div>
                        </v-container>
                    </v-col>
                </v-row>
                </v-img>
            </div>
            <div class="block">
                <v-container>
                    <v-form ref="form" v-model="valid" lazy-validation>
                        <v-text-field v-model="name" :counter="10" :rules="nameRules" label="Nome Completo"
                            required></v-text-field>
                        <v-text-field v-model="email" :rules="emailRules" label="Email" required></v-text-field>
                        <v-textarea v-model="message" :rules="messageRules" label="Mensagem por enviar"
                            required></v-textarea>
                        <v-btn :disabled="!valid" color="primary" class="mr-4" @click="validate">Enviar Mensagem</v-btn>
                        <v-btn outlined color="error" class="mr-4" @click="reset">Limpar Formulário</v-btn>
                    </v-form>
                </v-container>
            </div>
            <div class="googlemap">
                <iframe
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d16705.802661855836!2d-0.14290489950731525!3d51.50711704027593!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x47d8a00baf21de75%3A0x52963a5addd52a99!2sLondon!5e0!3m2!1sen!2suk!4v1577041400110!5m2!1sen!2suk"
                    width="100%" height="450"></iframe>
            </div>
        </v-card>
    </AdminLayout>
</template>
<script>
import AdminLayout from "../../Templates/AdminLayout.vue";
export default {
    components: {
        AdminLayout,
    },
    data: () => ({
        valid: true,
        name: "",
        nameRules: [
            (v) => !!v || "Name is required",
            (v) =>
                (v && v.length <= 10) || "Name must be less than 10 characters",
        ],
        email: "",
        emailRules: [
            (v) => !!v || "Email é obrigatório!",
            (v) => /.+@.+\..+/.test(v) || "E-mail must be valid",
        ],
        message: "",
        messageRules: [
            (v) => !!v || "Mensagem é obrigatório!",
            (v) => (v && v.length >= 10) || "Deve conter mais de 10 caracteres",
        ],

        items: [
            {
                src: "https://cdn.quasar.dev/img/quasar.jpg",
                title: "Criatividade",
            },
            {
                src: "https://cdn.quasar.dev/img/parallax1.jpg",
                title: "Rapidez",
            },
            {
                src: "https://cdn.quasar.dev/img/parallax2.jpg",
                title: "Profissionalismo",
            },
        ],
        show: false,
        clientes: [
            {
                id: 1,
                title: "CLIENTE 1",
                subtitle: "Localização 1",
                description:
                    "His ubique laboramus ne. Expetenda assueverit sed ad. Id nec malis lucilius delicatissimi. Nec assum sonet suscipit ex, diam deterruisset ut usu, ad dicat fabellas aliquando eam.",
                src: "https://cdn.quasar.dev/img/parallax2.jpg",
            },
            {
                id: 2,
                title: "CLIENTE 2",
                subtitle: "Localização 2",
                description:
                    "Sea ad habemus assueverit, omnes platonem convenire sit et, at integre pericula quo. Facete adolescens definitionem cu qui, in putant aliquid fierent ius.",
                src: "https://cdn.quasar.dev/img/parallax2.jpg",
            },
            {
                id: 3,
                title: "CLIENTE 3",
                subtitle: "LOCALIZAÇÃO 3",
                description:
                    "Aliquam albucius mei ei, debitis torquatos et pro, eos natum scribentur no. Putant verear constituto te qui. Adolescens persequeris vim ei. Vel nullam reprimique te.",
                src: "https://cdn.quasar.dev/img/parallax2.jpg",
            },
        ],
    }),

    mounted() { },
    methods: {
        validate() {
            if (this.$refs.form.validate()) {
                this.snackbar = true;
            }
        },
        reset() {
            this.$refs.form.reset();
        },
    },
    computed: {
        user() {
            return this.$page.props.auth.user;
        },
    },
};
</script>
