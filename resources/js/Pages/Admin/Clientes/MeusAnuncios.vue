<template>
    <Cliente>
        <!-- <v-subheader>Meus Anúcios</v-subheader> -->
        <v-container class="w-90 justify-space-around">
            <v-row>
                <v-col cols="12" md="12" class="pa-0  mt-15 indigo">
                    <v-card-actions>
                        <span class=" white--text text-bold text-h5">
                            Meus Anuncios {{ meus_imoveis.length }}
                        </span>

                        <v-spacer></v-spacer>
                        <v-card-title>
                            <v-text-field v-model="search" append-icon="mdi-magnify" label="Pesquisar" outlined dense dark
                                single-line hide-details></v-text-field>
                        </v-card-title>
                        <!-- <v-text-field v-model="imobiliaria.pesquisar" outlined dense label="Contacto*" type="text">
                        </v-text-field> -->
                        <v-btn icon elevation="5" color="indigo" class="white" outlined rounded title="Pesquisar"
                            @click="carregarDialogimobiliaria(item)">
                            <v-icon>
                                mdi-magnify
                            </v-icon>
                        </v-btn>
                        <v-btn icon color="indigo" outlined rounded class="white" title="Emitir Relatórios"
                            @click="emitirRelatoriosProcesso()">
                            <v-icon>
                                mdi mdi-file-document-multiple
                            </v-icon>
                        </v-btn>
                    </v-card-actions>
                </v-col>
                <!-- :lg="meus_imoveis.length > 3 ? 3 : 4" -->
                <v-col v-for="item in meus_imoveis" :key="item.id" cols="12" sm="12" md="4" lg="4">
                    <v-hover v-slot="{ hover }">

                        <v-card :loading="!loading" class=" elevation-10 pa-2 ma-3 border" :elevation="hover ? 10 : 0">
                            <!-- <v-img height="150" src="/img/pexels-dids-2969915.jpg"></v-img> -->
                            <v-img height="200" gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.2)" :src="'/storage/' +
                                item.foto_principal"></v-img>
                            <v-card-text class="mb-0 pb-0 indigo--text"> Código: {{ item.codigo_imovel }}</v-card-text>
                            <v-card-text class="my-0 py-0 "> Valor a pagar:
                                <v-card-title class="mt-0 py-0 indigo--text">
                                    {{ formatValor(item.preco) }},00 KZ
                                </v-card-title>
                            </v-card-text>
                            <v-card-text class="my-0 py-0"> Designação:
                                <v-card-text class="my-0 py-0 indigo--text text-h6" v-text="item.designacao"></v-card-text>
                            </v-card-text>
                            <v-card-text>
                                <!-- <v-row align="center" class="mx-0">
                                        <v-rating :value="4.5" color="amber" dense half-increments readonly
                                            size="14"></v-rating>
                                    </v-row> -->

                                <div>{{ item.descricao }}
                                </div>
                            </v-card-text>

                            <v-divider class="mx-1"></v-divider>

                            <!-- <v-card-title v-text="item.designacao"></v-card-title> -->

                            <v-card-actions class="pa-0 ma-0">
                                <v-chip-group v-model="selection" active-class="deep-purple accent-4 white--text" column>
                                    <v-chip><span class="mdi mdi-seat-individual-suite" title="Dormitório">{{
                                        item.numero_quartos
                                    }}</span></v-chip>
                                    <v-chip><span class="mdi mdi-seat-individual-suite" title="Dormitório">{{
                                        item.numero_sala_estar
                                    }}</span></v-chip>
                                    <v-chip><span class="mdi mdi-car" title="Garagem">{{ item.numero_garagem
                                    }}</span></v-chip>
                                    <v-chip><span class="mdi mdi-chart-areaspline-variant" title="Superficie ">{{
                                        item.metros
                                    }}<sup>2</sup></span></v-chip>

                                    <v-chip title="Cozinha"><span class="mdi mdi-countertop"></span>{{ item.cozinha
                                    }}</v-chip>
                                    <v-chip title="Quarto de Banho">
                                        <span class="mdi mdi-shower-head"></span>{{
                                            item.numero_banheiro }}</v-chip>
                                    <v-chip v-for="(actidade) in item.actividade_imoveis" :key="actidade.id"
                                        v-if="actidade.tempo_arrendar > 0">

                                        <span class="mdi mdi-timer-lock-outline" title="Arrendamento"></span>{{
                                            actidade.tempo_arrendar }} </v-chip>
                                    <v-chip title="estado do imóvel" class="white--text"
                                        :color="getcor(item.estado_imoveis_id)">
                                        <span v-if="item.estado_imoveis_id == 1" class="mdi mdi-archive-lock-open "></span>
                                        <span v-if="item.estado_imoveis_id == 2" class="mdi mdi-archive-remove"></span>
                                        <span v-if="item.estado_imoveis_id == 3" class="mdi mdi-archive-cog "></span>
                                        <span v-if="item.estado_imoveis_id == 4" class="mdi mdi-archive-eye"></span>
                                        <span v-if="item.estado_imoveis_id == 5" class="mdi mdi-archive-refresh"></span>

                                        {{ item.estado_imoveis.designacao }}</v-chip>
                                </v-chip-group>
                            </v-card-actions>

                            <v-card-actions class="justify-end">
                                <!-- <v-btn icon v-if="item.estado_imoveis_id == 4" color="indigo" outlined rounded
                                    title="Aprovar a visita do imóvel" @click="naoValidarProcesso(item.id)"
                                    v-model="validar_processo.aprovaVisita">
                                    <v-icon>
                                        mdi mdi-thumb-up-outline
                                    </v-icon>
                                </v-btn> -->
                                <v-btn v-if="user.tipo_user_id == 1 && item.estado_imoveis_id == 3" icon color="indigo"
                                    outlined rounded title="Validar processo do imóvel" @click="validaProcesso(item.id)">
                                    <v-icon>
                                        mdi mdi-handshake
                                    </v-icon>
                                </v-btn>
                                <v-btn v-if="user.tipo_user_id == 1 && item.estado_imoveis_id == 3" icon color="red" outlined
                                    rounded title="Não Validar o imóvel" @click="naoValidaProcesso(item.id)">
                                    <v-icon>
                                        mdi mdi-handshake
                                    </v-icon>
                                </v-btn>
                                <v-btn v-if="item.estado_imoveis_id == 1" icon color="deep-purple lighten-2" outlined
                                    rounded title="Editar Imóvel" @click="carregarDialogEditarImovel(item)">
                                    <v-icon>
                                        mdi mdi-pencil-outline
                                    </v-icon>
                                </v-btn>
                                <v-btn icon
                                    v-if="item.estado_imoveis_id !== 6 && item.estado_imoveis_id !== 7 && item.estado_imoveis_id !== 8"
                                    color="red" outlined rounded title="Remover o Imóvel" @click="deleteImovel(item)">
                                    <v-icon>
                                        mdi mdi-delete-outline
                                    </v-icon>
                                </v-btn>
                                <v-btn icon color="indigo" outlined rounded title="Emitir pdf do Imóvel"
                                    @click="emitirPDFAnuncio(item.id)">
                                    <v-icon>
                                        mdi mdi-file-document-multiple
                                    </v-icon>
                                </v-btn>

                            </v-card-actions>
                        </v-card>
                    </v-hover>
                </v-col>
            </v-row>
            <template>
                <v-row justify="center">
                    <v-dialog v-model="dialogEditar" persistent max-width="800px">
                        <v-card>
                            <v-card-title>
                                <span class="text-h5">Editar Imóvel</span>
                            </v-card-title>
                            <template>
                                <v-stepper v-model="e6" vertical>
                                    <v-stepper-step :complete="e6 > 1" step="1">
                                        Dados do Imovel
                                        <small>Summarize if needed</small>
                                    </v-stepper-step>

                                    <v-stepper-content step="1">
                                        <v-card>
                                            <v-container>

                                                <v-form ref="form" lazy-validation>
                                                    <v-row dense>
                                                        <v-col cols="12" sm="6" md="2">
                                                            <v-autocomplete dense :rules="tipoImovelRules" outlined
                                                                label="Tipo de Imovel*" v-model="imovel.operacao_id
                                                                    " :items="operacoes" item-text="designacao"
                                                                item-value="id" item-color="red"
                                                                required=""></v-autocomplete>
                                                        </v-col>
                                                        <v-col cols="12" sm="6" md="5">
                                                            <v-autocomplete dense :rules="tipoImovelRules" outlined
                                                                label="Tipo de Imovel*" v-model="imovel.categoria_imoveis_id
                                                                    " :items="tipoImoveis" item-text="designacao"
                                                                @change="getTipologia(imovel.categoria_imoveis_id)"
                                                                item-value="id" item-color="red"
                                                                required=""></v-autocomplete>
                                                        </v-col>
                                                        <v-col cols="12" sm="6" md="5">
                                                            <v-autocomplete dense :rules="tipologiaRules" required outlined
                                                                label="Tipologia*" v-model="imovel.tipologia_id
                                                                    " :items="tipologiaImoveis" item-text="designacao"
                                                                item-value="id"></v-autocomplete>
                                                        </v-col>

                                                    </v-row>
                                                    <v-row>
                                                        <v-col cols="12" md="12">
                                                            <v-textarea v-model="imovel.designacao"
                                                                label="titulo do Anúcio*" outlined dense rows="2">

                                                            </v-textarea>
                                                        </v-col>
                                                    </v-row>
                                                    <v-row>
                                                        <v-col cols="3" md="4">
                                                            <v-autocomplete v-model="imovel.provincia_id" outlined dense
                                                                :items="provincias" item-value="id" item-text="designacao"
                                                                label="Provincia**" @change="getMunicipio()">

                                                            </v-autocomplete>
                                                        </v-col>
                                                        <v-col cols="3" md="4">
                                                            <v-autocomplete :items="this.municipios" item-value="id"
                                                                item-text="designacao" v-model="imovel.cidade_id"
                                                                label="Cidades*" outlined dense>

                                                            </v-autocomplete>
                                                        </v-col>
                                                        <v-col cols="3" md="4">
                                                            <v-text-field v-model="imovel.localizacao_geografica" outlined
                                                                dense label="Rua, Bairo" type="gps">

                                                            </v-text-field>
                                                        </v-col>

                                                    </v-row>
                                                    <v-row>
                                                        <v-col cols="3" sm="3" md="2">
                                                            <v-text-field outlined dense color="indigo"
                                                                placeholder=" nº Quartos / suíte"
                                                                label="nº Quartos / suíte:" hint="O campo é opcional"
                                                                persistent-hint v-model="imovel.numero_quartos"
                                                                :rules="numero_quartosRules" type="number"
                                                                class="no-padding-messages no-padding-details v-messages.theme--light ">

                                                            </v-text-field>
                                                        </v-col>

                                                        <v-col cols="12" sm="12" md="2">
                                                            <v-text-field outlined dense color="indigo"
                                                                placeholder="nº banheiros" label="nº banheiros:"
                                                                hint="O campo é opcional" v-model="imovel.numero_banheiro"
                                                                type="number"
                                                                class="no-padding-messages no-padding-details v-messages.theme--light">

                                                            </v-text-field>
                                                        </v-col>
                                                        <v-col cols="12" sm="12" md="2">
                                                            <v-text-field outlined dense color="indigo"
                                                                placeholder="nº Sala de estar" label="nº Sala de estar:"
                                                                hint="Obrigatorio" v-model="imovel.numero_sala_estar"
                                                                type="number"
                                                                class="no-padding-messages no-padding-details v-messages.theme--light">

                                                            </v-text-field>
                                                        </v-col>
                                                        <v-col cols="12" sm="12" md="2">
                                                            <v-text-field outlined dense color="indigo"
                                                                placeholder="nº carros na garagem"
                                                                label="nº carros na garagem:" hint="O campo é opcional"
                                                                v-model="imovel.numero_garagem" type="number"
                                                                class="no-padding-messages no-padding-details v-messages.theme--light ">
                                                            </v-text-field>
                                                        </v-col>
                                                        <v-col cols="12" sm="12" md="2">
                                                            <v-text-field outlined dense color="indigo"
                                                                placeholder="nº cozinhas" label="nº cozinhas:"
                                                                hint="O campo é opcional" v-model="imovel.numero_cozinha"
                                                                type="number"
                                                                class="no-padding-messages no-padding-details v-messages.theme--light">
                                                            </v-text-field>
                                                        </v-col>
                                                        <v-col cols="12" sm="12" md="2">
                                                            <v-text-field outlined dense color="indigo"
                                                                placeholder="Numero de Andares" label="Numero de Andares"
                                                                v-model="imovel.numero_andar" type="number"
                                                                class="no-padding-messages no-padding-details v-messages.theme--light pa-0">
                                                            </v-text-field>
                                                        </v-col>
                                                        <v-col cols="12" sm="6" md="2">
                                                            <v-text-field placeholder="Área total do imóvel"
                                                                label="nº Quartos / suíte:" hint="O campo é opcional"
                                                                outlined dense color="indigo" v-model="imovel.metros"
                                                                type="number"
                                                                class="no-padding-messages no-padding-details v-messages.theme--light">
                                                            </v-text-field>
                                                        </v-col>
                                                    </v-row>
                                                </v-form>
                                            </v-container>
                                        </v-card>
                                        <!-- @click="e6 = 2" -->
                                        <v-card-actions class="justify-end">
                                            <v-btn color="indigo" class="white--text" @click="continuar(2, 'form')">
                                                Continue
                                            </v-btn>
                                        </v-card-actions>
                                    </v-stepper-content>

                                    <v-stepper-step :complete="e6 > 2" step="2">
                                        Localização /Detalhe Extra do Imóvel
                                    </v-stepper-step>

                                    <v-stepper-content step="2">
                                        <v-card flat>
                                            <v-form ref="form2" lazy-validation>
                                                <v-container>
                                                    <template>
                                                        <span class="text-h6">Quais os custos do imóvel?</span><br />
                                                        <span class="subtitle">Se não souber o valor exato, você pode
                                                            informar um aproximado e alterar depois.</span>
                                                    </template>
                                                    <v-row class="py-0">
                                                        <v-col cols="12" :md="this.operacao_id != 1 ? 6 : 4"
                                                            :lg="this.operacao_id !== 1 ? 6 : 6">
                                                            <v-text-field v-model="imovel.preco" outlined dense
                                                                :label="operacao_id == 1 ? 'Valor de venda do Imovel*' : 'Valor a ser Arrendado do Imovel*'"></v-text-field>
                                                        </v-col>

                                                        <v-col cols="12" :md="this.operacao_id != 1 ? 6 : 4"
                                                            v-if="this.operacao_id == 1">
                                                            <v-text-field outlined dense label="Quantidade de prestações*"
                                                                v-model="imovel.quantidade_prestacoes"></v-text-field>
                                                        </v-col>
                                                        <v-col cols="12" :md="this.operacao_id != 2 ? 6 : 4"
                                                            v-if="this.operacao_id == 2">
                                                            <v-autocomplete label="Tempo de arrendamento" outlined dense
                                                                :items="tipo_regimes" item-value="id" item-text="designacao"
                                                                v-model="imovel.tempo_arrendar
                                                                    " />
                                                        </v-col>
                                                        <!-- <v-col cols="12" md="4"
                                                            v-if="this.getcolaborador == true && this.getvender == true">
                                                            <v-text-field dense outlined type="number"
                                                                label="percentagem a receber do valor do Imóvel*" v-model="imovel.valor_colaborador
                                                                    "></v-text-field>
                                                        </v-col> -->
                                                        <v-col cols="12" md="12"
                                                            v-if="user.tipo_user_id == 4 && this.operacao_id == 2">
                                                            <span>O pagamento referente a o arrendamento é o primeiro mês
                                                            </span>
                                                        </v-col>
                                                    </v-row>
                                                    <v-divider></v-divider>
                                                    <v-divider></v-divider>
                                                    <v-row>
                                                        <v-col cols="5">
                                                            <span class="text-h6">Estado do imóvel?</span>

                                                        </v-col>
                                                        <v-col cols="7">
                                                            <span>
                                                                <v-btn elevation="0" outlined rounded small
                                                                    v-model="imovel.condicao_imoveis_id"
                                                                    @click="estadoNovo()" class="estadonovo"> Nova</v-btn>
                                                                <v-btn outlined rounded v-model="imovel.condicao_imoveis_id"
                                                                    small @click="estadoNaoAcabado()"
                                                                    class="estadonaoacabadol">Não
                                                                    acabada</v-btn>
                                                                <v-btn outlined rounded v-model="imovel.condicao_imoveis_id"
                                                                    small @click="estadoReabilitado()"
                                                                    class="estadoreabilitado">Reabilitada</v-btn>
                                                            </span>
                                                        </v-col>


                                                    </v-row>
                                                    <v-divider></v-divider>
                                                    <v-divider></v-divider>
                                                    <v-row>


                                                        <v-col cols="5">
                                                            <span class="text-h6">O Imóvel é mobiliado?</span>

                                                        </v-col>
                                                        <v-col cols="7">
                                                            <span>
                                                                <v-btn elevation="0" outlined rounded
                                                                    @click="simMobiliado()" small v-model="imovel.mobiliado"
                                                                    class="simmobiliado"> sim</v-btn>
                                                                <v-btn outlined rounded @click="naoMobiliado()" small
                                                                    v-model="imovel.mobiliado"
                                                                    class="naomobiliado">não</v-btn>
                                                            </span>
                                                        </v-col>


                                                    </v-row>
                                                    <v-list subheader two-line flat v-if="this.mostrarMobiliado == true">
                                                        <v-subheader class="text--center">Você vai deixar no imóvel alguns
                                                            desses
                                                            itens?</v-subheader>
                                                        <v-list-item-group v-model="settings" multiple>
                                                            <v-row>
                                                                <v-col>
                                                                    <v-list-item>
                                                                        <template v-slot:default="{ active }">
                                                                            <v-list-item-content>
                                                                                <v-list-item-title>Mesa e cadeiras de
                                                                                    jantar</v-list-item-title>
                                                                            </v-list-item-content>
                                                                            <v-list-item-action>
                                                                                <v-checkbox :input-value="active"
                                                                                    v-model="imovel.mesa_cadeira"
                                                                                    style="background-color: #e9e5f5; border-radius: 10px;"
                                                                                    color="primary"></v-checkbox>
                                                                            </v-list-item-action>

                                                                        </template>
                                                                    </v-list-item>
                                                                    <v-list-item>
                                                                        <template v-slot:default="{ active, }">
                                                                            <v-list-item-content>
                                                                                <v-list-item-title>Ar
                                                                                    Condicionados</v-list-item-title>
                                                                                <!-- <v-list-item-subtitle>Allownotifications</v-list-item-subtitle> -->
                                                                            </v-list-item-content>
                                                                            <v-list-item-action>
                                                                                <v-checkbox :input-value="active"
                                                                                    v-model="imovel.arcondicionados"
                                                                                    style="background-color: #e9e5f5; border-radius: 10px;"
                                                                                    color="primary"></v-checkbox>
                                                                            </v-list-item-action>

                                                                        </template>
                                                                    </v-list-item>

                                                                    <v-list-item>
                                                                        <template v-slot:default="{ active }">
                                                                            <v-list-item-content>
                                                                                <v-list-item-title>Maquina de lavar
                                                                                    Roupa</v-list-item-title>
                                                                            </v-list-item-content>
                                                                            <v-list-item-action>
                                                                                <v-checkbox :input-value="active"
                                                                                    v-model="imovel.maquina_lavar_roupa"
                                                                                    style="background-color: #e9e5f5; border-radius: 10px;"
                                                                                    color="primary"></v-checkbox>
                                                                            </v-list-item-action>

                                                                        </template>
                                                                    </v-list-item>

                                                                </v-col>
                                                                <v-col>

                                                                    <v-list-item>
                                                                        <template v-slot:default="{ active }">
                                                                            <v-list-item-content>
                                                                                <v-list-item-title>Churrasqueira</v-list-item-title>

                                                                            </v-list-item-content>
                                                                            <v-list-item-action>
                                                                                <v-checkbox :input-value="active"
                                                                                    v-model="imovel.churrasqueira"
                                                                                    style="background-color: #e9e5f5; border-radius: 10px;"
                                                                                    color="primary"></v-checkbox>
                                                                            </v-list-item-action>

                                                                        </template>
                                                                    </v-list-item>

                                                                    <v-list-item>
                                                                        <template v-slot:default="{ active }">
                                                                            <v-list-item-content>
                                                                                <v-list-item-title>Gerador
                                                                                    Industrial</v-list-item-title>

                                                                            </v-list-item-content>
                                                                            <v-list-item-action>
                                                                                <v-checkbox :input-value="active"
                                                                                    v-model="imovel.gerador"
                                                                                    style="background-color: #e9e5f5; border-radius: 10px;"
                                                                                    color="primary"></v-checkbox>
                                                                            </v-list-item-action>

                                                                        </template>
                                                                    </v-list-item>
                                                                    <v-list-item>
                                                                        <template v-slot:default="{ active }">
                                                                            <v-list-item-content>
                                                                                <v-list-item-title>piscina
                                                                                </v-list-item-title>

                                                                            </v-list-item-content>
                                                                            <v-list-item-action>
                                                                                <v-checkbox :input-value="active"
                                                                                    v-model="imovel.piscina"
                                                                                    style="background-color: #e9e5f5; border-radius: 10px;"
                                                                                    color="primary"></v-checkbox>
                                                                            </v-list-item-action>

                                                                        </template>
                                                                    </v-list-item>
                                                                </v-col>
                                                            </v-row>
                                                        </v-list-item-group>
                                                    </v-list>
                                                    <v-divider></v-divider>
                                                    <v-divider></v-divider>
                                                    <v-list subheader two-line flat>
                                                        <v-card-title>O seu imovel possué esses itens?</v-card-title>
                                                        <v-list-item-group v-model="settings" multiple>
                                                            <v-row>
                                                                <v-col>
                                                                    <v-list-item>
                                                                        <template v-slot:default="{ active, }">
                                                                            <v-list-item-content>
                                                                                <v-list-item-title>Ginásio</v-list-item-title>
                                                                                <!-- <v-list-item-subtitle>Allownotifications</v-list-item-subtitle> -->
                                                                            </v-list-item-content>
                                                                            <v-list-item-action>
                                                                                <v-checkbox :input-value="active"
                                                                                    v-model="imovel.ginasio"
                                                                                    style="background-color: #e9e5f5; border-radius: 10px;"
                                                                                    color="primary"></v-checkbox>
                                                                            </v-list-item-action>

                                                                        </template>
                                                                    </v-list-item>

                                                                    <v-list-item>
                                                                        <template v-slot:default="{ active }">
                                                                            <v-list-item-content>
                                                                                <v-list-item-title>Armários embutidos -
                                                                                    dormitório</v-list-item-title>

                                                                            </v-list-item-content>
                                                                            <v-list-item-action>
                                                                                <v-checkbox :input-value="active"
                                                                                    v-model="imovel.armario_embutido"
                                                                                    style="background-color: #e9e5f5; border-radius: 10px;"
                                                                                    color="primary"></v-checkbox>
                                                                            </v-list-item-action>

                                                                        </template>
                                                                    </v-list-item>

                                                                    <v-list-item>
                                                                        <template v-slot:default="{ active }">
                                                                            <v-list-item-content>
                                                                                <v-list-item-title>Tanque da
                                                                                    água</v-list-item-title>

                                                                            </v-list-item-content>
                                                                            <v-list-item-action>
                                                                                <v-checkbox :input-value="active"
                                                                                    v-model="imovel.tanqueagua"
                                                                                    style="background-color: #e9e5f5; border-radius: 10px;"
                                                                                    color="primary"></v-checkbox>
                                                                            </v-list-item-action>

                                                                        </template>
                                                                    </v-list-item>

                                                                </v-col>
                                                                <v-col>
                                                                    <v-list-item>
                                                                        <template v-slot:default="{ active }">
                                                                            <v-list-item-content>
                                                                                <v-list-item-title>Píscina
                                                                                </v-list-item-title>

                                                                            </v-list-item-content>
                                                                            <v-list-item-action>
                                                                                <v-checkbox :input-value="active"
                                                                                    v-model="imovel.piscina"
                                                                                    style="background-color: #e9e5f5; border-radius: 10px;"
                                                                                    color="primary"></v-checkbox>
                                                                            </v-list-item-action>

                                                                        </template>
                                                                    </v-list-item>
                                                                    <v-list-item>
                                                                        <template v-slot:default="{ active }">
                                                                            <v-list-item-content>
                                                                                <v-list-item-title>Elevador
                                                                                </v-list-item-title>

                                                                            </v-list-item-content>
                                                                            <v-list-item-action>
                                                                                <v-checkbox :input-value="active"
                                                                                    v-model="imovel.elevador"
                                                                                    style="background-color: #e9e5f5; border-radius: 10px;"
                                                                                    color="primary"></v-checkbox>
                                                                            </v-list-item-action>

                                                                        </template>
                                                                    </v-list-item>
                                                                    <v-list-item>
                                                                        <template v-slot:default="{ active }">
                                                                            <v-list-item-content>
                                                                                <v-list-item-title>
                                                                                    Re-Chão</v-list-item-title>

                                                                            </v-list-item-content>
                                                                            <v-list-item-action>
                                                                                <v-checkbox :input-value="active"
                                                                                    v-model="imovel.rechao"
                                                                                    style="background-color: #e9e5f5; border-radius: 10px;"
                                                                                    color="primary"></v-checkbox>
                                                                            </v-list-item-action>

                                                                        </template>
                                                                    </v-list-item>
                                                                </v-col>
                                                            </v-row>

                                                        </v-list-item-group>
                                                    </v-list>

                                                </v-container>
                                            </v-form>
                                        </v-card>
                                        <v-card-actions class="justify-end">
                                            <v-btn text @click="e6 = 1">
                                                Cancel
                                            </v-btn>
                                            <v-btn color="indigo" class="white--text" @click="continuar(3, 'form')">
                                                Continue
                                            </v-btn>

                                        </v-card-actions>

                                    </v-stepper-content>

                                    <v-stepper-step :complete="e6 > 3" step="3">
                                        Documentação do Imóvel
                                    </v-stepper-step>

                                    <v-stepper-content step="3">
                                        <v-card>
                                            <v-form ref="form3" lazy-validation>
                                                <v-container>

                                                    <v-row dense class="py-0">
                                                        <v-col cols="12" sm="12">
                                                            <template>
                                                                <span class="text-h6">Fotos do Imóvel</span><br />
                                                                <span class="subtitle">Primeiro campo adicionar a foto
                                                                    principal e o segundo campo deve adicionar 10 fotos no
                                                                    máximo.</span>
                                                            </template>
                                                        </v-col>
                                                        <v-col cols="12" md="6" class="pb-2">
                                                            <template>
                                                                <v-file-input accept="image/*" label="Foto principal" chips
                                                                    counter show-size v-model="imovel.foto_principal"
                                                                    :rules="multiplaImagemRules"></v-file-input>
                                                            </template>
                                                        </v-col>
                                                        <v-col cols="12" md="6">
                                                            <template>
                                                                <v-file-input accept="image/*"
                                                                    label="Fotos do Imóvel 10 fotos no máximo." chips close
                                                                    counter multiple show-size truncate-length="15"
                                                                    v-model="imovel.mutiplaImagem"></v-file-input>
                                                            </template>
                                                        </v-col>
                                                    </v-row>
                                                    <template>
                                                        <span class="text-h6">Documentação do Imóvel </span><br />
                                                        <span class="subtitle">Ao divulgarmos esses dados iremos colocar
                                                            marca d'água no documento para proteger as
                                                            informações.</span>
                                                    </template>
                                                    <v-divider></v-divider>
                                                    <v-row>
                                                        <v-col cols="12" sm="6" md="4"
                                                            v-if="imovel.categoria_imoveis_id == 2 && this.operacao_id == 1"><v-file-input
                                                                accept="application/pdf,image/*" label="Registo Predial"
                                                                v-model="imovel.registoPredial" hint="O campo é Obrigatório"
                                                                persistent-hint required></v-file-input></v-col>
                                                        <v-col cols="12" sm="6" md="4"
                                                            v-if="imovel.categoria_imoveis_id == 2"><v-file-input
                                                                accept="application/pdf,image/*" label="Matriz Predial"
                                                                v-model="imovel.matrizpredial" hint="O campo é opcional"
                                                                persistent-hint required></v-file-input></v-col>

                                                        <v-col cols="12" sm="6"
                                                            :md="imovel.categoria_imoveis_id == 2 ? 4 : 8"><v-file-input
                                                                accept="application/pdf,image/*"
                                                                label="Termo de Quitação (factura)"
                                                                v-model="imovel.termoEquitacao" hint="O campo é opcional "
                                                                persistent-hint required></v-file-input></v-col>

                                                        <v-col cols="12" sm="6" md="4" v-if="this.operacao_id == 1">
                                                            <v-file-input accept="application/pdf,image/*"
                                                                label="Directo de Superficie"
                                                                v-model="imovel.direitoSuperficie" hint="O campo é opcional"
                                                                persistent-hint required></v-file-input>
                                                        </v-col>
                                                        <v-col cols="12" sm="6" md="4"
                                                            v-if="this.operacao_id == 1"><v-file-input
                                                                accept="application/pdf,image/*" label="Escritura
                                                                    Pública" v-model="imovel.escrituraPublica"
                                                                hint="Compra e venda" persistent-hint
                                                                required></v-file-input>
                                                        </v-col>
                                                    </v-row>

                                                </v-container>
                                            </v-form>
                                        </v-card>
                                        <v-card-actions class="white--text justify-end">
                                            <v-btn text @click="e6 = 2">
                                                Cancel
                                            </v-btn>
                                        </v-card-actions>
                                    </v-stepper-content>
                                </v-stepper>
                            </template>
                            <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn color="red darken-1" text @click="fecharDialog()">
                                    fechar
                                </v-btn>
                                <v-btn color="blue darken-1" text @click="editarImovel()">
                                    Editar
                                </v-btn>
                            </v-card-actions>
                        </v-card>
                    </v-dialog>
                    <v-dialog v-if="dialogDelete" v-model="dialogDelete" max-width="500px">
                        <v-card>
                            <v-card-title class="text-h6">Tens a certeza de que desejas
                                eliminar?</v-card-title>
                            <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn rounded outlined color="indigo" @click="dialogDelete = false">Não</v-btn>
                                <v-btn rounded outlined color="red" @click="deleteItemConfirm()">Sim</v-btn>
                                <v-spacer></v-spacer>
                            </v-card-actions>
                        </v-card>
                    </v-dialog>
                </v-row>
            </template>
            <div class="text-center">
                <v-snackbar v-model="snackbarNaovalidado" :multi-line="multiLine" :timeout="8000" outlined
                    color="deep-purple accent-4">
                    {{ textnaovalidado }}
                    <v-btn color="indigo" text @click="snackbarNaovalidado = false">
                        Close
                    </v-btn>
                </v-snackbar>
                <v-snackbar v-model="snackbar" :multi-line="multiLine" :timeout="8000" outlined
                    color="deep-purple accent-4">
                    {{ textvalidado }}
                    <v-btn color="indigo" text @click="snackbar = false">
                        Close
                    </v-btn>
                </v-snackbar>
            </div>
        </v-container>
    </Cliente>
</template>

<script>
import Cliente from "../Clientes/Cliente";
export default {

    props: ["meus_imoveis", "provincias", 'tipoImoveis', 'operacoes'],
    components: {
        Cliente
    },
    data: () => ({
        dialogEditar: false,
        validar_processo: {},
        imovel: {
            condicao_imovel: null,
            venda_id: null,
            arrendamento_id: null,
            tituloPropriedade: null,
            localizacao: null,
            descricao: null,
            tipologia_id: null,
            categoria_imoveis_id: null,
            numero_quartos: 0,
            numero_cozinha: 0,
            numero_banheiro: 0,
            numero_garagem: 0,
            numero_andar: 0,
            metros: 0,
            designacao: null,
            localizacao_geografica: null,
            provincia_id: null,
            cidades: null,
            simImP: null,
            naoImP: null,
            tempo_arrendar: 0,
            quantidade_prestacoes: 0,
            dialogDelete: false,
            operacao_id: null,
            cidade_id: null,
            operacao_id: null,
            mobiliado: null,
            rechao: null,
            elevador: null,
            // estado_nao_acabado: null,

            imposto_predial: null,
            mesa_cadeira: null,
            armario_embutido: null,
            // armario_cozinha: null,
            piscina: null,
            // sofa: null,

        },
        defautImovel: {
            condicao_imovel: null,
            operacao_id: null,
            arrendamento_id: null,
            croquis: null,
            tituloPropriedade: null,
            localizacao: null,
            descricao: null,
            tipologia_id: null,
            categoria_imoveis_id: null,
            numero_quartos: 0,
            numero_cozinha: 0,
            numero_banheiro: 0,
            numero_garagem: 0,
            numero_andar: 0,
            metros: 0,
            designacao: null,
            localizacao_geografica: null,
            provincia: null,
            cidades: null,
            simImP: null,
            naoImP: null,
            tempo_arrendar: 0,
            quantidade_prestacoes: 0,
            // estado_nao_acabado: null,

            imposto_predial: null,
            mesa_cadeira: null,
            armario_embutido: null,
            // armario_cozinha: null,
            piscina: null,
            // sofa: null,

        },
        municipios: null,
        id_provincia: {},
        id_tipo_imovel: {},
        e6: 1,
        vertical: true,
        qquarto: "1",
        getarrendar: false,
        getvender: false,
        getImposto: false,
        getcolaborador: false,
        getProprietario: false,
        mostrarMobiliado: false,
        rules: {
            required: (value) => !!value || "Campos obrigatório.",
            max: (v) => v.length == 9 || "Tem que ter 9 caracteres",
            emailMatch: () => `The email and password you entered don't match`,
        },
        tipo_regimes: [{
            id: 1,
            designacao: "2 Meses"
        },
        {
            id: 2,
            designacao: "3 Meses"
        },
        {
            id: 3,
            designacao: "6 Meses"
        },
        {
            id: 4,
            designacao: "1 Ano"
        },
        {
            id: 5,
            designacao: "2 Anos"
        },
        {
            id: 6,
            designacao: "3 Anos"
        },
        {
            id: 7,
            designacao: "4 Anos"
        },
        {
            id: 8,
            designacao: "5 Anos"
        },
        {
            id: 9,
            designacao: "10 Anos"
        },
        {
            id: 10,
            designacao: "15 Anos"
        },
        ],
        loading: null,
        snackbar: false,
        textnaovalidado: `Descontinuidade do processo da negociação do Imóvel`,
        textvalidado: `Confirmaste a continuação da negociação do Imóvel Confirmaste a continuação da negociação do Imóvel`,
        snackbarNaovalidado: false,
    }),

    mounted() {
        this.loading = true;
        setTimeout(function () {
            this.loading = false;
        }, 2000);
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
        emitirRelatoriosProcesso() {
            window.open(
                "/emitir-relatorios-processo"
            )
        },
        emitirPDFAnuncio(item) {
            window.open(
                "/emitir-anuncio/" + item
            )
        },

        formatValor: function (atual) {
            const valorFormatado = Intl.NumberFormat("pt-br", {
                style: "currency",
                currency: "AOA",
            }).format(atual);
            const valorNumerico = valorFormatado.replace(/AOA/g, '').trim();
            return valorNumerico;
        },
        formatarDinheiro(valor) {
            return valor.toLocaleString('en-US', { style: 'currency', currency: 'AOA' });
        },
        validate() {
            this.$refs.form.validate();
            this.$refs.form2.validate();
            // this.$refs.form3.validate();
            // this.$refs.form4.validate();
        },
        continuar(stepe, form) {
            if (this.$refs[form].validate()) {
                this.e6 = stepe;
            }
        },
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

        /*        formatValor: function(atual){
               const valorFormatado = Intl.NumberFormat("pt-br", {
                   style: "currency",
                   currency: "AOA",
               }).format(atual);
       
               return valorFormatado;
             }, */
        // carregarDialogEditarImovel() {
        //     this.imovel = Object.assign({}, this.defaultimovel);
        //     this.dialogEditar = true;
        // },
        carregarDialogEditarImovel(item) {
            // item.control_projecto_tecnologia.forEach(elemento => {
            //     this.projectoTecnologia.push(elemento.tecnologia);
            // });
            // actividade=item.actividade_imoveis
            item.actividade_imoveis.forEach(actividade => {
                this.operacao_id = actividade.operacao_imoveis_id
            });
            // alert( item.actividade_imoveis)
            // alert(JSON.stringify(this.operacao_id));
            this.editedIndex = this.meus_imoveis.indexOf(item);
            this.imovel = Object.assign({}, item);

            // alert(JSON.stringify(this.imovel.mobiliado));
            this.dialogEditar = true;
            // let searchServico = this.servicos_por_pagar.find(function (elemento) {
            //     return elemento.id == servico_id;
            // });
            //Percorrer o item selecionado
            /*      item.control_projecto_tecnologia.forEach(elemento => {
                     this.projectoTecnologia.push(elemento.tecnologia);
                 });
                 //Percorrer a v-modal BackEnd
                 this.projectoTecnologia.forEach(element => {
                     this.backEnd.push(element.id)
                 })
                 //Percorrer a v-modal FrontEnt
     
                 this.projectoTecnologia.forEach(element => {
                     this.frontEnd.push(element.id)
                 })
                 //Percorrer a v-model Base de Dados
                 this.projectoTecnologia.forEach(element => {
                     this.baseDados.push(element.id)
                 }) */
        },
        validaProcesso(item) {
            this.validar_processo.imovel_id = item
            this.$inertia.post("/validar-imovel", this.validar_processo,
            )
            this.loading = true;
            this.snackbar = true;
        },
        naoValidaProcesso(item) {
            this.validar_processo.imovel_id = item
            this.$inertia.post("/nao-validar-imovel", this.validar_processo,
            )
            this.loading = true;
            this.snackbarNaovalidado = true;
        },
        deleteImovel(item) {

            this.editedIndex = this.meus_imoveis.indexOf(item);
            this.imovel = Object.assign({}, item);
            this.dialogDelete = true;
        },
        deleteItemConfirm() {

            this.$inertia.delete(
                "/portal/imoveis/" + this.imovel.id,
                {
                    onFinish: () => {
                        if (this.$page.props.flash.success != null) {
                            Vue.toasted.global.defaultSuccess({
                                msg: "" + this.$page.props.flash.success,
                            });
                        }
                        if (this.$page.props.flash.error != null) {
                            Vue.toasted.global.defaultError({
                                msg: "" + this.$page.props.flash.error,
                            });
                        }

                    },
                }
            );
            this.dialogDelete = false;
            this.imovel = Object.assign({}, this.defautImovel);
        },
        fecharDialog() {
            this.dialogEditar = false;
            this.imovel = Object.assign({}, this.defautImovel);
            this.e6 = 1
        },
        editarImovel() {
            this.$inertia.post("/portal/update-imoveis", this.imovel)

            // alert(JSON.stringify(this.imovel));
            // alert(this.imovel)
            // Crie um objeto FormData
            let formData = new FormData();
            formData.append('imovel', JSON.stringify(this.imovel.foto_principal));
            // formData.append('imovel', JSON.stringify(this.imovel));
            // Adicione fotos ao FormData (array de fotos)
            // for (let i = 0; i < this.imovel.mutiplaImagem.length; i++) {
            //     formData.append(`photos[${i}]`, this.photos[i]);
            // }

            // Adicione campos de arquivo PDF ao FormData
            /*      formData.append('foto_principal', this.foto_principal);
                 formData.append('registoPredial', this.registoPredial);
                 formData.append('matrizpredial', this.matrizpredial);
                 formData.append('direitoSuperficie', this.direitoSuperficie);
                 formData.append('termoEquitacao', this.termoEquitacao);
                 formData.append('escrituraPublica', this.escrituraPublica); */
            //  formData.append('imovel', this.imovel.id);

            // this.dialogEditar = true;

            // this.$inertia.post("/condominios", this.condominio, {});

            /*          axios
                         .post("/portal/update-imoveis",formData, {
                 headers: {
                   'Content-Type': 'multipart/form-data',
                 },})
                         .then((response) => {
                             this.loading = false;
                             alert(JSON.stringify(response.data));
                         })
                         .catch(() => {
                             alert(JSON.stringify(response.data));
                         });
                     
                     // location.reload(); */
            this.fecharDialog();
        },
        simIP() {
            this.imovel.simImP = true;
            this.imovel.naoImP = false
            this.getImposto = true;
            const simimposto_predial = document.querySelector(".simimposto_predial");
            const naocorimposto_predial = document.querySelector(".naocorimposto_predial");
            simimposto_predial.style.color = "white";
            simimposto_predial.style.background = "#D1C4E9";
            naocorimposto_predial.style.background = "white";
            naocorimposto_predial.style.color = "black";
        },
        naoIP() {
            this.imovel.simImP = false
            this.imovel.naoImP = true
            this.getImposto = false;
            const naocorimposto_predial = document.querySelector(".naocorimposto_predial");
            const simimposto_predial = document.querySelector(".simimposto_predial");
            naocorimposto_predial.style.color = "white";
            naocorimposto_predial.style.background = "#D1C4E9";
            simimposto_predial.style.background = "white";
            simimposto_predial.style.color = "black";
        },
        simMobiliado() {
            this.imovel.mobiliado = 1
            this.mostrarMobiliado = true;
            const simmobiliado = document.querySelector(".simmobiliado");
            const naomobiliado = document.querySelector(".naomobiliado");
            simmobiliado.style.color = "white";
            simmobiliado.style.background = "#D1C4E9";
            naomobiliado.style.background = "white";
            naomobiliado.style.color = "black";
        },
        naoMobiliado() {
            this.imovel.mobiliado = 2
            this.mostrarMobiliado = false;
            const simmobiliado = document.querySelector(".simmobiliado");
            const naomobiliado = document.querySelector(".naomobiliado");
            naomobiliado.style.color = "white";
            naomobiliado.style.background = "#D1C4E9";
            simmobiliado.style.background = "white";
            simmobiliado.style.color = "black";
        },
        estadoNovo() {
            this.imovel.condicao_imovel = 1
            const estadonovo = document.querySelector(".estadonovo");
            const estadonaoacabadol = document.querySelector(".estadonaoacabadol");
            const estadoreabilitado = document.querySelector(".estadoreabilitado");
            estadonovo.style.color = "white";
            estadonovo.style.background = "#D1C4E9";
            estadonaoacabadol.style.background = "white";
            estadonaoacabadol.style.color = "black";
            estadoreabilitado.style.background = "white";
            estadoreabilitado.style.color = "black";
        },
        estadoNaoAcabado() {
            this.imovel.condicao_imovel = 2
            const estadonaoacabadol = document.querySelector(".estadonaoacabadol");
            const estadonovo = document.querySelector(".estadonovo");
            const estadoreabilitado = document.querySelector(".estadoreabilitado");
            estadonaoacabadol.style.color = "white";
            estadonaoacabadol.style.background = "#D1C4E9";
            estadonovo.style.background = "white";
            estadonovo.style.color = "black";
            estadoreabilitado.style.background = "white";
            estadoreabilitado.style.color = "black";
        },
        estadoReabilitado() {
            this.imovel.condicao_imovel = 3
            const estadoreabilitado = document.querySelector(".estadoreabilitado");
            const estadonovo = document.querySelector(".estadonovo");
            const estadonaoacabadol = document.querySelector(".estadonaoacabadol");
            estadoreabilitado.style.color = "white";
            estadoreabilitado.style.background = "#D1C4E9";
            estadonovo.style.background = "white";
            estadonovo.style.color = "black";
            estadonaoacabadol.style.background = "white";
            estadonaoacabadol.style.color = "black";
        },

        getMunicipio() {
            this.id_provincia.id = this.imovel.provincia_id
            axios
                .post("/portal/municipios", this.id_provincia)
                .then((response) => {
                    this.municipios = response.data
                })
                .catch(() => {
                });
        },
        getTipologia(item) {
            this.id_tipo_imovel.id = item
            axios
                .post("/portal/tipo-tipologia", this.id_tipo_imovel)
                .then((response) => {
                    this.tipologiaImoveis = response.data
                })
                .catch(() => {
                });
        },
        salvarImovel() {
            this.$inertia.post(
                "/portal/imoveis",
                this.imovel,
                {

                    onFinish: () => {
                        this.snackbar = true
                        this.imovel = Object.assign({}, this.defautImovel);
                        this.e1 = 1
                        if (this.$page.props.flash.success != null) {
                            Vue.toasted.global.defaultSuccess({
                                msg:
                                    "" + this.$page.props.flash.success,
                            });


                        }
                        if (this.$page.props.flash.error != null) {
                            Vue.toasted.global.defaultError({
                                msg: "" + this.$page.props.flash.error,
                            });
                        }

                    },

                }
            );
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
<style></style>