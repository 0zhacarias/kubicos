<template>
  <PortalLayout>
    <v-row>
      <v-col cols="12" sm="4" md="4" lg="3">
        <template>
          <v-card class="mx-auto mt-15 ml-15" tile>
            <v-list rounded>
              <!-- <v-subheader>REPORTS</v-subheader> -->
              <v-container>
                <v-list-item-group v-model="selectedItem" color="primary">
                  <v-list-item  href="/clientes/meu-perfil"  active-class="deep-purple--text">
                    <v-list-item-icon>
                      <v-icon>mdi-account</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                      <v-list-item-title> Meus Dados</v-list-item-title>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item v-if="user.can['Gerir Funcionario']"  href="/pessoa"  active-class="deep-purple--text">
                    <v-list-item-icon>
                      <v-icon>mdi-account</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                      <v-list-item-title> Funcionarios</v-list-item-title>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item  v-if="user.can['Gerir Imóbiliaria']" href="/imobiliaria" 
                    active-class="deep-purple--text">
                    <v-list-item-icon>
                      <v-icon>mdi-clock</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                      <v-list-item-title > Imóbiliaria</v-list-item-title> 
                    
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item v-if="user.can['Gerir Anúncios']" href="/clientes/meus-anuncios" 
                    active-class="deep-purple--text">
                    <v-list-item-icon>
                      <v-icon>mdi-clock</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                      <v-list-item-title v-if="user.tipo_user_id == 1"> Anúncios</v-list-item-title> 
                      <v-list-item-title v-else>Meus Anúncios</v-list-item-title> 
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item  v-if="user.can['Gerir Processos'] "  href="/clientes/meus-processo"
                    active-class="deep-purple--text">
                    <v-list-item-icon>
                      <v-icon>mdi-clock</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                      <v-list-item-title>Minhas Solicitações</v-list-item-title>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item v-if="user.can['Gerir Permissões']" href="/clientes/permissoes"  
                    active-class="deep-purple--text" >
                    <v-list-item-icon>
                      <v-icon>mdi mdi-cash</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content>
                      <v-list-item-title> Permições</v-list-item-title>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item v-if="user.can['Gerir Relatórios']" 
                    active-class="deep-purple--text">
                    <v-list-item-icon>
                      <v-icon>mdi mdi-cash</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content >
                      <v-list-item-title  >Relatório </v-list-item-title>
                    </v-list-item-content>
                  </v-list-item>
                </v-list-item-group>
              </v-container>
            </v-list>

          </v-card>
        </template>

      </v-col>
      <v-col cols="12" sm="8" md="8" lg="9">
        <v-main>
          <slot align="center" justify="center" />
        </v-main>
      </v-col>
    </v-row>
  </PortalLayout>
</template>

<script>
import PortalLayout from "../../../Templates/PortalLayout";

export default {
  props: ["meus_imoveis", "imoveis_processos", "cliente","provincias"],
  components: {
    PortalLayout,
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
    initialize() { },

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
