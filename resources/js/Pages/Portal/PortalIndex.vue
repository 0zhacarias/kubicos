<template>
    <PortalLayout>

        <template class="pb-0 ">

            <v-toolbar-title class="deep-purple darken-3 elevation-0 imagens">
                 <!-- :style="'border-radius: 0px 0px 0px 350px; height:70vh'" -->
                            <v-img  gradient="to top right, rgba(255,115,201,.1), rgba(25,32,72,.6)"
                                :style="'white-space:nowrap; padding:0;max-width: 100%;height:75vh; position:relative;top:10px; ; border-radius: 0 80px 0px 60px;'"
                                src="/img/angola.jpg" >
                <!-- <v-card-title>
                 <span class="headline">Título do Card</span> 
                </v-card-title> -->
                <v-row class="p-0">
                    <v-col cols="12" sm="2" md="4" :style="' white-space:nowrap; padding:0; '">                       
                    </v-col>
                    <v-col cols="12" sm="10" md="8" class="container--fluid">
                        <v-card elevation="0" color="transparent" class="white--text textotela pt-15">
                            <h1>
                                <p class="text-bold text-justify">No Kubico tem.</p>
                            </h1>
                            <h2> O imóvel que deseja e o que procuras está aqui</h2>
                            <p class="text-h4 pt-3 text-justify">compra, arrenda ou vende o seu imóvel residencial.</p>
                            <v-row  class="px-5 tamanhotela">
                                <v-col cols="8" sm="0">
                                    <template>
                                    <v-tabs v-model="filtrar.servico" centered class="text-h2 py-lg-10" show-arrows background-color="transparent"
                                        dark icons-and-text center-active>
                                        <v-tab class="text-h6 px-lg-6 px-md-2 px-sm-1 " >Comprar</v-tab>
                                        <v-tab class="text-h6 px-lg-6 px-md-2 px-sm-1 ">Arrendar</v-tab>
                                        <v-tab class="text-h6 px-lg-6 px-md-2 px-sm-1 " >Meio periódo</v-tab>
                                    </v-tabs>
                                </template>
                                </v-col>
                              <v-row>
                                <v-col cols="4" md="4"  sm="0" class="opens-sans" >
                                    <v-autocomplete color="indigo" outlined rounded auto-select-first chips clearable deletable-chips
                                        small-chips item-text="designacao" item-value="id" prepend-icon=""  v-model="filtrar.provincia_id"
                                        :items="provincias"
                                       
                                        hide-details
                                        label="Localização" class="indigo lighten-5">
                                    </v-autocomplete>
                                </v-col>
                                <v-col cols="4" md="4" class="opens-sans mb-n8">
                                    <v-autocomplete outlined rounded auto-select-first chips clearable deletable-chips v-model="filtrar.tipo_imovel"
                                        small-chips item-text="designacao" item-value="id" :items="tipo_imoveis"
                                        prepend-icon="" label="Estado" full-width hide-details class="indigo lighten-5">
                                    </v-autocomplete>
                                </v-col>
                                <v-col cols="2" md="2">
                                    <v-btn rounded x-large  class="bottom-gradient"  @click="FiltrarImoveis()">
                                        pesquisar
                                    </v-btn>
                                </v-col>
                            </v-row>
                            </v-row>

                        </v-card>




                    </v-col>

                </v-row>
            </v-img>
            </v-toolbar-title>
        </template>
        <!-- Lançamentos mais recentes -->
        <template>
            <v-container>
                <v-row no-gutters justify="pt-15" :style="'justify-content: center;'" class="pt-14">
                    <v-toolbar-title class="deep-purple darken-3">

                        <v-card-title class="Centralizar-linha">Lançamentos mais recentes</v-card-title>
                    </v-toolbar-title>
                    <v-col v-for="item in novos_imoveis" :key="item.id" cols="12" sm="12" md="" class="mx-1"
                        :lg="novos_imoveis.length <= 3 ? 6 : 4" :style="'max-width: min-content;'">
                        <v-hover v-slot="{ hover }">

                            <v-card class="mx-5 my-2 elevation-10" max-width="320" @click="findImoveis(item.id)"
                                :elevation="hover ? 10 : 0">
                                <v-img height="150" :src="'/storage/' + item.foto_principal"></v-img>

                       <!--          <v-card-title>{{ item.title }}</v-card-title>
                                <v-card-subtitle class="text--subtitle">Código:{{ item.codigo_imovel }}</v-card-subtitle>
                                <v-card-subtitle class="text--subtitle">{{ item.designacao }}</v-card-subtitle>
 --><v-card-text class="mb-0 pb-0 indigo--text"> Código: {{ item.codigo_imovel }}</v-card-text>
 <v-card-text class="my-0 py-0 "> Valor a pagar:
                                <v-card-title class="mt-0 py-0 indigo--text">
                                    {{ formatValor(item.preco) }} KZ
                                </v-card-title>
                            </v-card-text>
                            <v-card-text class="my-0 py-0"> Designação:
                                <v-card-text class="my-0 py-0 indigo--text" v-text="item.designacao"></v-card-text>
                            </v-card-text>
                                <v-card-text>
                                    <v-row align="center" class="mx-0">
                                        <v-rating :value="4.5" color="amber" dense half-increments readonly
                                            size="14"></v-rating>
                                    </v-row>

                                    <!-- <div>Small plates, salads & sandwiches - an intimate setting with 12 indoor seats plus
                                        patio seating.
                                    </div> -->
                                </v-card-text>

                                <v-divider class="mx-4"></v-divider>

                                <v-card-text>
                                    <v-chip-group v-model="selection" active-class="deep-purple accent-4 white--text"
                                        column>
                                        <v-chip><span class="mdi mdi-seat-individual-suite" title="Dormitório">{{ item.suite
                                        }}</span></v-chip>
                                        <v-chip><span class="mdi mdi-car" title="Garagem">{{
                                            item.numero_garagem }}</span></v-chip>
                                        <v-chip><span class="mdi mdi-chart-areaspline-variant" title="Superficie ">{{
                                            item.metros
                                        }}<sup>2</sup></span></v-chip>

                                        <v-chip title="Cozinha"><span class="mdi mdi-countertop"></span>{{
                                            item.cozinha }}</v-chip>
                                        <v-chip title="Quarto de Banho">
                                            <span class="mdi mdi-shower-head"></span>{{
                                                item.numero_banheiro }}</v-chip>
                                        <v-chip v-for="(actidade) in item.actividade_imoveis" :key="actidade.id"
                                            v-if="actidade.tempo_arrendar > 0">

                                            <span class="mdi mdi-timer-lock-outline" title="Arrendamento"></span>{{
                                                actidade.tempo_arrendar }} </v-chip>
                                  <!--       <v-chip :color="getcor(item.estado_imoveis_id)" title="estado do imovel" class="white--text">
                                            <span v-if="item.estado_imoveis_id == 1" class="mdi mdi-archive-lock-open "></span>
                                            <span v-if="item.estado_imoveis_id == 2" class="mdi mdi-archive-remove"></span>
                                            <span v-if="item.estado_imoveis_id == 3" class="mdi mdi-archive-cog "></span>
                                            <span v-if="item.estado_imoveis_id == 4" class="mdi mdi-archive-eye"></span>
                                            <span v-if="item.estado_imoveis_id == 5" class="mdi mdi-archive-refresh"></span>

                                            {{ item.estado_imoveis.designacao }} </v-chip> -->
    <!--                                         <span v-if="item.solicitacao_imoveis.length > 0">
    <span v-for="(solicitacao) in item.solicitacao_imoveis" :key="solicitacao.id" 
                                            >
                                            <v-chip outlined
                                            title="estado do imóvel" class="white--text" :color="getcor(solicitacao.estado_imoveis_id)" 
                                            v-if="user && user.id == solicitacao.user_marca_visita">
                                                <span v-if="solicitacao.estado_imoveis_id == 8"
                                                    class="mdi mdi-archive-remove">Em negociacao</span>
                                        <span v-if="solicitacao.estado_imoveis_id == 4"
                                                    class="mdi mdi-archive-eye">Visita pendentes</span>
                                                <span v-if="solicitacao.estado_imoveis_id == 5"
                                                    class="mdi mdi-archive-refresh">{{ 'Visita confirmada' }}</span>

                                            </v-chip>
                                            <v-chip v-else
                                            title="estado do imóvel" class="white--text" :color="getcor(item.estado_imoveis_id)">
                                               
                                        <span v-if="item.estado_imoveis_id == 1" class="mdi mdi-archive-lock-open "></span>
                                        <span v-if="item.estado_imoveis_id == 2" class="mdi mdi-archive-remove"></span>
                                        <span v-if="item.estado_imoveis_id == 5" class="mdi mdi-archive-refresh"></span>
                                        <span v-if="item.estado_imoveis_id == 6" class="mdi mdi-archive-refresh"></span>
                                        <span v-if="item.estado_imoveis_id == 7" class="mdi mdi-archive-refresh"></span>

                                        {{ item.estado_imoveis.designacao }}
                                            </v-chip>
                                           </span>
</span>
<v-chip v-else title="estado do imóvel" class="white--text"
                                        :color="getcor(item.estado_imoveis_id)">
                                        <span v-if="item.estado_imoveis_id == 1" class="mdi mdi-archive-lock-open "></span>
                                        <span v-if="item.estado_imoveis_id == 2" class="mdi mdi-archive-remove"></span>
                                        <span v-if="item.estado_imoveis_id == 5" class="mdi mdi-archive-refresh"></span>
                                        <span v-if="item.estado_imoveis_id == 6" class="mdi mdi-archive-refresh"></span>
                                        <span v-if="item.estado_imoveis_id == 7" class="mdi mdi-archive-refresh"></span>

                                        {{ item.estado_imoveis.designacao }}
                                    </v-chip> -->
                                    <span v-if="item.solicitacao_imoveis.length > 0">
    <span v-for="(solicitacao) in item.solicitacao_imoveis" :key="solicitacao.id" 
                                            >
                                            <span v-if="user">
                                            <span v-if="solicitacao.user_marca_visita ==user.id && solicitacao.imoveis_id==item.id">
                                            <v-chip  outlined
                                            title="estado do imóvel" class="white--text" :color="getcor(solicitacao.estado_imoveis_id)" v-if="user.id == solicitacao.user_marca_visita">
                                                <span v-if="solicitacao.estado_imoveis_id == 8"
                                                    class="mdi mdi-archive-remove">Em negociacao</span>
                                                <!-- <span v-if="solicitacao.estado_imoveis_id == 3" class="mdi mdi-archive-cog "></span> -->
                                                <span v-if="solicitacao.estado_imoveis_id == 4"
                                                    class="mdi mdi-archive-eye">Visita pendentes</span>
                                                <span v-if="solicitacao.estado_imoveis_id == 5"
                                                    class="mdi mdi-archive-refresh">{{ 'Visita confirmada' }}</span>

                                            </v-chip>
                                             </span>
                                             <v-chip v-else-if="!solicitacao.user_marca_visita ==user.id && !solicitacao.imoveis_id==item.id"  outlined
                                            title="estado do imóvel" class="white--text" :color="getcor(item.estado_imoveis_id)">
                                               
                                        <span v-if="item.estado_imoveis_id == 1" class="mdi mdi-archive-lock-open "></span>
                                        <span v-if="item.estado_imoveis_id == 2" class="mdi mdi-archive-remove"></span>
                                        <span v-if="item.estado_imoveis_id == 5" class="mdi mdi-archive-refresh"></span>

                                        {{ item.estado_imoveis.designacao }}
                                            </v-chip>
                                           </span>
                                        </span>
                    </span>
                        <v-chip v-else title="estado do imóvel" class="white--text"
                                        :color="getcor(item.estado_imoveis_id)">
                                        <span v-if="item.estado_imoveis_id == 1" class="mdi mdi-archive-lock-open "></span>
                                        <span v-if="item.estado_imoveis_id == 2" class="mdi mdi-archive-remove"></span>
                                        <span v-if="item.estado_imoveis_id == 5" class="mdi mdi-archive-refresh"></span>

                                        {{ item.estado_imoveis.designacao }}
                                    </v-chip>
                                    </v-chip-group>
                                </v-card-text>
                            </v-card>
                        </v-hover>
                    </v-col>
                    <v-row class="mb-10" justify="end">
                        <v-col cols="7">

                        </v-col>
                        <v-spacer />
                        <v-col cols="5">
                            <v-pagination @input="paginacao(page)" v-model="page" :length="last_page" circle></v-pagination>
                        </v-col>
                    </v-row>
                    </v-col>
                </v-row>
            </v-container>
        </template>

        <!-- Lançamentos próximos a você -->
        <template>
            <v-toolbar-title class="deep-purple darken-3 elevation-0">

                <v-card-title class="Centralizar-linha ">Lançamentos próximos a você</v-card-title>
            </v-toolbar-title>
            <v-container>
                <v-row no-gutters justify="pt-15" :style="'justify-content: center;'" class="pt-14">
                    <v-col v-for="item in mais_proximos" :key="item.id" cols="12" sm="12" md="" class="mx-1"
                        :lg="mais_proximos.length <= 3 ? 6 : 4" :style="'max-width: min-content;'">
                        <v-hover v-slot="{ hover }">

                            <v-card :loading="loading" class="mx-5 my-12 elevation-10" max-width="320"
                                @click.stop="findImoveis(item.id)" :elevation="hover ? 10 : 0">
                                <v-img height="150" :src="'/storage/' + item.foto_principal"></v-img>
                                <v-card-text class="mb-0 pb-0 indigo--text"> Código: {{ item.codigo_imovel }}</v-card-text>
 <v-card-text class="my-0 py-0 "> Valor a pagar:
                                <v-card-title class="mt-0 py-0 indigo--text">
                                    {{ formatValor(item.preco) }},00 KZ
                                </v-card-title>
                            </v-card-text>
                            <v-card-text class="my-0 py-0"> Designação:
                                <v-card-text class="my-0 py-0 indigo--text" v-text="item.designacao"></v-card-text>
                            </v-card-text>
                                <v-card-text>
                                    <v-row align="center" class="mx-0">
                                        <v-rating :value="4.5" color="amber" dense half-increments readonly
                                            size="14"></v-rating>
                                    </v-row>

                                    <!-- <div>Small plates, salads & sandwiches - an intimate setting with 12 indoor seats plus
                                        patio seating.
                                    </div> -->
                                </v-card-text>

                                <v-divider class="mx-4"></v-divider>

                                <v-card-text>
                                    <v-chip-group v-model="selection" active-class="deep-purple accent-4 white--text"
                                        column>
                                        <v-chip><span class="mdi mdi-seat-individual-suite" title="Dormitório">{{ item.suite
                                        }}</span></v-chip>
                                        <v-chip><span class="mdi mdi-car" title="Garagem">{{
                                            item.numero_garagem }}</span></v-chip>
                                        <v-chip><span class="mdi mdi-chart-areaspline-variant" title="Superficie ">{{
                                            item.metros
                                        }}<sup>2</sup></span></v-chip>

                                        <v-chip title="Cozinha"><span class="mdi mdi-countertop"></span>{{
                                            item.cozinha }}</v-chip>
                                        <v-chip title="Quarto de Banho">
                                            <span class="mdi mdi-shower-head"></span>{{
                                                item.numero_banheiro }}</v-chip>
                                        <v-chip v-for="(actidade) in item.actividade_imoveis" :key="actidade.id"
                                            v-if="actidade.tempo_arrendar > 0">

                                            <span class="mdi mdi-timer-lock-outline" title="Arrendamento"></span>{{
                                                actidade.tempo_arrendar }} </v-chip>
                                        <v-chip :color="getcor(item.estado_imoveis_id)" title="estado do imovel" class="white--text">
                                            <span v-if="item.estado_imoveis_id == 1"
                                                class="mdi mdi-archive-lock-open "></span>
                                            <span v-if="item.estado_imoveis_id == 2" class="mdi mdi-archive-remove"></span>
                                            <span v-if="item.estado_imoveis_id == 3" class="mdi mdi-archive-cog "></span>
                                            <span v-if="item.estado_imoveis_id == 4" class="mdi mdi-archive-eye"></span>
                                            <span v-if="item.estado_imoveis_id == 5" class="mdi mdi-archive-refresh"></span>

                                            {{ item.estado_imoveis.designacao }} </v-chip>
                                    </v-chip-group>
                                </v-card-text>

                                <!-- <v-card-actions>
                                    <v-btn color="deep-purple lighten-2" text>

                                    </v-btn>
                                </v-card-actions> -->
                            </v-card>
                        </v-hover>
                    </v-col>
                    <v-row class="mb-10" justify="end">
                        <v-col cols="7">

                        </v-col>
                        <v-spacer />
                        <v-col cols="5">
                            <v-pagination @input="paginacaoImovelProximo(pageProximo)" v-model="pageProximo"
                                :length="last_page_proximo"></v-pagination>
                        </v-col>
                    </v-row>

                </v-row>
            </v-container>
        </template>

        <template>
            <v-toolbar-title class="deep-purple darken-3 elevation-0">

                <v-card-title class="Centralizar-linha ">Parcerias com as Imóbiliarias </v-card-title>
            </v-toolbar-title>
            <v-container>
                <v-row no-gutters  :style="'justify-content: center;'">
                    <v-col v-for="item in imobiliarias" :key="item.id" cols="12" sm="12" md="" class="mx-1"
                        :lg="mais_proximos.length <= 3 ? 4 : 3" :style="'max-width: min-content;'">
                        <v-hover v-slot="{ hover }">

                            <v-card :loading="loading" class="mx-5 my-12 elevation-10" max-width="320"
                                :elevation="hover ? 5 : 2">
                                <v-img height="100" src="/img/Aaa.png"></v-img>
                            <v-card-text class="my-0 py-0"> Nome da Imobiliaria:
                                <v-card-text class="my-0 py-0 indigo--text" v-text="item.designacao"></v-card-text>
                                <v-card-text class="my-0 py-0 indigo--text">NIF: {{ item.nif }}</v-card-text>
                            </v-card-text>
                                <v-card-text>
                                    <v-row align="center" class="mx-0">
                                        <v-rating :value="4.5" color="amber" dense half-increments readonly
                                            size="14"></v-rating>
                                    </v-row>
                                </v-card-text>

                                <v-divider class="mx-4"></v-divider>

                            </v-card>
                        </v-hover>
                    </v-col>
    <!--                 <v-row class="mb-10" justify="end">
                        <v-col cols="7">

                        </v-col>
                        <v-spacer />
                        <v-col cols="5">
                            <v-pagination @input="paginacaoImovelProximo(pageProximo)" v-model="pageProximo"
                                :length="last_page_proximo"></v-pagination>
                        </v-col>
                    </v-row> -->

                </v-row>
            </v-container>
            <v-container>
                <v-row no-gutters justify="pa-0" :style="'justify-content: center;'">
               
                    <v-row :style="'justify-content: center;'">
                        <h2 class="mx-1 text-center">Municipios</h2>
                        <v-col @click.stop="findImoveisProvincia(item.id)" v-for="item in provincias" :key="item.id"
                            class="mx-1 text-center" :lg="provincias.length <= 8 ? 6 : 3">
                            <v-hover v-slot="{ hover }">
                                <v-card class="elevation-1" width="320" color="transparent" :elevation="hover ? 2 : 0">
                                    <v-card-title class="justify-center">{{ item.designacao }}</v-card-title>
                                </v-card>
                            </v-hover>
                        </v-col>
                    </v-row>
                </v-row>

                <v-divider></v-divider>
            </v-container>
            <template>
                <div class="text-center">
                    <v-overlay v-if="overlay">
                        <v-progress-circular indeterminate size="64"></v-progress-circular>
                    </v-overlay>
                </div>
            </template>
        </template>
 </PortalLayout>
</template>

<script>
import AdminLayout from "../../Templates/AdminLayout";
import PortalLayout from "../../Templates/PortalLayout";
export default {
    props: ['startingImage', 'autoSlideInterval', 'showProgressBar'],

    components: {
        AdminLayout,
        PortalLayout,
    },
    data: () => ({
        page: 1,
        pageProximo: 1,
        last_page: 1,
        last_page_proximo: 1,
        total_imoveis_proximos: 1,
        provincias: [],
        tipo_imoveis: [],
        imobiliarias: [],
        total_tmoveis: 0,
        novos_imoveis: [],
        mais_proximos: [],
        filtrar:{},
        valid: true,
        name: "",
        overlay: false,

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
            // {
            //     src: "https://cdn.quasar.dev/img/quasar.jpg",
            //     title: "Criatividade",
            // },
            // {
            //     src: "https://cdn.quasar.dev/img/parallax1.jpg",
            //     title: "Rapidez",
            // },
            // {
            //     src: "https://cdn.quasar.dev/img/parallax2.jpg",
            //     title: "Profissionalismo",
            // },
        ],
    }),
    watch: {
        overlay(val) {
            val && setTimeout(() => {
                this.overlay = false
            }, 3000)
        },
    },
    mounted() { },
    created() {
        this.paginacao()
        this.paginacaoImovelProximo()
        this.getcor(estado_imoveis_id)

    },
    methods: {
        getcor(estado_imoveis_id) {
            if (estado_imoveis_id == 1) {
                return 'green'
            } else if (estado_imoveis_id == 2) {
                return 'deep-orange darken-4'
            } else if (estado_imoveis_id == 3) {
                return 'blue-grey darken-4'
            } else if (estado_imoveis_id == 4) {
                return 'yellow darken-3'
            } else if (estado_imoveis_id == 5) {
                return 'deep-purple darken-2'
            } else if (estado_imoveis_id == 6) {
                return 'red darken-4'
            } else if (estado_imoveis_id == 7) {
                return 'red darken-4'
            } else if (estado_imoveis_id == 8) {
                return 'amber accent-4'
            }
        },
        formatValor: function (atual) {
            const valorFormatado = Intl.NumberFormat("pt-br", {
                style: "currency",
                currency: "AOA",
            }).format(atual);
            const valorNumerico = valorFormatado.replace(/AOA/g, '').trim();
            return valorNumerico;
        },
        findImoveis(id) {
            this.overlay = true
            setTimeout(() => {  
                this.overlay = false
                window.location.href = "/portal/imovel-selecionado/" + btoa(btoa(btoa(id)));
            }, 2000)
        },
        findImoveisProvincia(id) {
            this.overlay = true
            setTimeout(() => {  
                this.overlay = false
                window.location.href = "/portal/imoveis-provincia/" + id;
            }, 2000)
  
        },
        FiltrarImoveis() {
            this.overlay = true
            setTimeout(() => {  
                this.overlay = false
                this.$inertia.get("/portal/filtrar-imoveis-portal", this.filtrar, {});
                // window.location.href = "/portal/filtra-imoveis-portal/" + this.filtrar;
            }, 2000)
            // window.location.href = "/portal/imoveis-provincia/" + id;
        },
        validate() {
            if (this.$refs.form.validate()) {
                this.snackbar = true;
            }
        },
        // reset() {
        //     this.$refs.form.reset();
        // },
        paginacao(page = 1) {
            axios
                .get("/portal/imoveisPaginacao?page=" + page, {
                })
                .then((response) => {
                    // alert(JSON.stringify(response.data.data))
                    this.novos_imoveis = response.data.novos_imoveis.data;
                    this.last_page = response.data.novos_imoveis.last_page;
                    this.total_imoveis = response.data.novos_imoveis.total;
                })
                .catch((error) => {
                    console.log(error);
                });
        },
        paginacaoImovelProximo(pageProximo = 1) {
            axios
                .get("/portal/imoveisProximoPaginacao?page=" + pageProximo, {
                })
                .then((response) => {
                    // alert(JSON.stringify(response.data.data))

                    this.mais_proximos = response.data.mais_proximos.data;
                    this.last_page_proximo = response.data.mais_proximos.last_page;
                    // this.total_imoveis_proximos = response.data.mais_proximos.total;
                    this.provincias = response.data.provincias;
                    this.tipo_imoveis = response.data.tipo_imoveis;
                    this.imobiliarias = response.data.imobiliarias;

                })
                .catch((error) => {
                    console.log(error);
                });
        },
    },
    computed: {
        user() {
            return this.$page.props.auth.user;
        },
        col() {
            switch (this.$vuetify.breakpoint.name) {
                case "xs":
                    return 12;
                case "sm":
                    return 6;
                case "md":
                    return 3;
                case "lg":
                    return 3;
                case "xl":
                    return 3;
            }
        },

    },
};
</script>

<style>
table {
    font-weight: bolder;
}

.container {
    position: relative;
}

/* .center {
  position: relative;
  top: -150px;
  width: 100%;
  text-align: center;
  font-size: 18px;
} */
.borda-white {
    border: 2px solid rgb(255, 255, 255)
}

.imoveisListado {
    background-image: linear-gradient(to bottom right, #0077c2, #0093ff);
    margin: 0;

}

.Centralizar-linha {
    /* display: flex; */
    align-items: center;
    justify-content: center;
    color: aliceblue;
    font-size: 2rem;
    /* max-width: max-content; */

}

/* div.container6 p {
  margin: 0 } */
.circulo {
    border-bottom-right-radius: 10px;
    /* background-image:linear-gradient(to bottom right, #0077c2, #0093ff) */
}

@media(max-width: 768px){
    .textotela>h1{
        color: #6943af;
        padding: 5%;
        font-size: 3.5rem;
    }
    .textotela>h2{
        padding-left: 5%;
        font-size: 1srem;
    }
    .textotela>p{
        padding-left: 5%;
        font-size: 1px !important;
    }
    .tamanhotela{
        display: none;
 
    }
    
   .imagens{
   border-radius: 0px 0px 0px 20px; 
   height:70vh;
    /* border-radius: 0px 0px 0px 100px; */
        /* display: none; */
    }
   };
@media(min-width: 769px) and (max-width: 1024px){

   .imagens{
   border-radius: 0px 0px 0px 350px; 
   height:70vh;
    /* border-radius: 0px 0px 0px 100px; */
        /* display: none; */
    }
   };
@media(min-width: 1025px){

   .imagens{
   border-radius: 0px 0px 0px 350px; 
   height:70vh;
    /* border-radius: 0px 0px 0px 100px; */
        /* display: none; */
    }
   };
</style>
