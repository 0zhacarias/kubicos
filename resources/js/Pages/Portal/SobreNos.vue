<template>
    <PortalLayout>
        <v-container>
            <span class="text-uppercase py-15" style="font-size: 30px" >
                    SOBRE NÓS</span>
        <v-card elevation="0">
        
               
                <v-card-text class="px-15 mx-15 text-h5">
                    Kubicos é uma plataforma web, que  tem o objectivo de servir como intermediário entre os proprietários, e os colaboradores de um imóveis e os interessados em comprar ou arrendar residências habitacionais. 
Inicialmente é um projecto startup, com sede em Luanda, criada em 2023, gerida pela grupo "BranZage".<br/>
A presente ferramenta foi desenvolvida pensando nas particularidades do contexto angolano, garantindo assim mais transparença e segurança em um processo de aquisição de um imóvel, podendo assim gerar declarações de compromisso e posterior-me o proprietário e o cliente validarem as acinaturas. 

                </v-card-text>
           

        </v-card>
    </v-container>
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
