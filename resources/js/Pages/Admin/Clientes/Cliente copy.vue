<template>
<PortalLayout>
    <v-row>
        <v-col cols="12" sm="4" md="4" lg="2">
            <template>
  <v-card
    class="mx-auto"
    max-width="300"
    tile
  >
    <v-list rounded >
      <v-subheader>REPORTS</v-subheader>
      <v-container>
      <v-list-item-group
        v-model="selectedItem"
        color="primary"
      > 
        <v-list-item  v-model="meusDados"  @click="selectItem('meusDados') "  active-class="deep-purple--text"
        >
          <v-list-item-icon>
            <v-icon >mdi-account</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title> Meus Dados</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item  v-model="meusAnuncios"  @click="selectItem('meusAnuncios') "  active-class="deep-purple--text"
        >
          <v-list-item-icon>
            <v-icon >mdi-clock</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>Meus Anúncios</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item  v-model="imoveisProcesso"  @click="selectItem('imoveisProcesso') " active-class="deep-purple--text"
        >
          <v-list-item-icon>
            <v-icon >mdi-clock</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>Imoveis em processo</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item  v-model="meusPagamentos"  @click="selectItem('meusPagamentos') " active-class="deep-purple--text"
        >
          <v-list-item-icon>
            <v-icon >mdi mdi-cash</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title> Meus Pagamentos</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list-item-group>
    </v-container>
    </v-list>

  </v-card>
</template>

        </v-col>
        <v-col cols="12" sm="8" md="8" lg="10">
          <v-subheader v-if="this.linhaSelecionado==null" class="text-h5 text-bold mt-10 ">Meu Perfil</v-subheader>
          <a class="btn btn-primary" href="/pdf-declaracao">Export to PDF</a>
        
                <perfil v-if="this.linhaSelecionado==='meusDados'" :cliente="cliente">
                </perfil>
            
                <MeusAnuncios v-if="this.linhaSelecionado==='meusAnuncios'" :meus_anuncios="meus_imoveis">
                </MeusAnuncios>
                <imoveisProcesso class="" v-if="this.linhaSelecionado==='imoveisProcesso' " :minha_compra_arrendamentos="imoveis_processos">
                </imoveisProcesso>
                <meusPagamentos class="" v-if="this.linhaSelecionado==='meusPagamentos'">
                </meusPagamentos>
            
        </v-col>
    </v-row>
    </PortalLayout>
</template>

<script>
import PortalLayout from "../../../Templates/PortalLayout";
import Perfil from "../Clientes/Perfil";
import MeusAnuncios from "../Clientes/MeusAnuncios";
import imoveisProcesso from "../Clientes/MeusImoveisProcesso";
import meusPagamentos from "../Clientes/MeusPagamentos"
// import PerfilCliente from "../Clientes/PerfilCliente";
export default {
    props: ["meus_imoveis","imoveis_processos" ,"cliente"],
    components: {
        PortalLayout,
        Perfil,
        // PerfilCliente,
        MeusAnuncios,
        imoveisProcesso,
        meusPagamentos,
    },
    data: () => ({
        items: [{
                text: "Início",
                disabled: false,
                href: "/home",
            },
            {
                text: "Listar Moradores",
                disabled: true,
                href: "/",
            },
        ],
        e1: 1,
        steps: 3,
        editedIndex: -1,
        dialogNovoCadastro: false,
        linhaSelecionado: null,
        meusDados: 1,
        meusAnuncios: 2,
        imoveisProcesso: 3,
        meusPagamentos: 4,
        selectedItem: null,
      items: [
        { text: 'Real-Time', icon: 'mdi-clock' },
        { text: 'Audience', icon: 'mdi-account' },
        { text: 'Conversions', icon: 'mdi-flag' },
      ],
    }),

    computed: {
        user() {
            return this.$page.props.auth.user;
        },
        formTitle() {
            return this.editedIndex === -1 ? "Novo Cadastro" : "Editar ";
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
        initialize() {},

        novo_registo() {
            this.dialogNovoCadastro = true;
        },
        meuPerfil() {
            alert(1);
        },
        selectItem(item) {
            this.linhaSelecionado = item;
            //   alert(item)
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
            this.dialogNovoCadastro = false;
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

<style>
.item-selected {
    background-color: #885cda;
}
</style>
