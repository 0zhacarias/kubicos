<template>
    <AdminLayout>

  <v-container>
<v-row>
   <v-card-text class="text-lg-h3 text-center pt-15 mt-16"> As outras opções estaram disponiveis depois que o processo da visita estiver terminada!<br/>
    Estatemos aguardando pelo seu retorno.
</v-card-text>
</v-row>
  </v-container>

                        

    </AdminLayout>
</template>

<script>
import AdminLayout from "../../../Templates/AdminLayout";
// import Perfil from "../Clientes/Perfil";
// import PerfilCliente from "../Clientes/PerfilCliente";
export default {
    props: [""],
    components: {
        AdminLayout,
    },
    data: () => ({
   
    }),

    computed: {
        user() {
            return this.$page.props.auth.user;
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
        initialize() { },

    },
};
</script>
<style>
.item-selected {
  background-color: #885cda;
}
</style>
