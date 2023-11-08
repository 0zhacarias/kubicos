<template>
    <PortalLayout>
        <v-card elevation="0">
            <!-- <v-card tile class="text-h5 deep-purple darken-3  white--text ">
                <span class="text-uppercase" style="font-size: 20px">
                    {{ formTitle }}</span>
            </v-card> -->
            <v-card-text>
                <v-container>
                    <v-stepper flat v-model="e1">
                        <v-stepper-header>
                            <v-stepper-step class="text-uppercase" :complete="e1 > 1" step="1">Dados do
                                Imovel</v-stepper-step>

                            <!-- <v-divider></v-divider> -->

                            <v-stepper-step class="text-uppercase" step="2" :complete="e1 > 2">Localização / Detalhe Extra
                                do
                                Imóvel</v-stepper-step>
                            <v-stepper-step class="text-uppercase" step="3" :complete="e1 > 3">Fotos & Documentação do
                                Imóvel</v-stepper-step>
                            <v-stepper-step class="text-uppercase" step="4" :complete="e1 > 4">Finalização</v-stepper-step>
                        </v-stepper-header>
                        <v-row>
                            <v-col sm="1" md="2" lg="2"></v-col>
                            <v-col sm="10" md="8" lg="8" offset-sm="0">
                                <v-stepper-items flat>
                                    <v-stepper-content step="1">
                                        <v-card class="mb-12" flat>
                                            <v-card-text align="center" justify="center">
                                                <v-btn class="corVender" outlined align="center" value="1"
                                                    v-model="imovel.venda_id" @click="venderImoveis()">
                                                    Vender</v-btn>
                                                <v-btn outlined value="2" v-model="imovel.arrendamento_id"
                                                    class="corArrendamento" @click="arrendarImoveis()">Arrendar</v-btn>

                                                <v-btn outlined value="1" v-model="imovel.proprietario_id"
                                                    @click="proprietario()" class="corProprietario"
                                                    v-if="this.getarrendar == true || this.getvender == true">
                                                    Proprietário</v-btn>
                                                <v-btn outlined value="2" v-model="imovel.colaborador_id"
                                                    @click="colaborador()" class="corColaborador"
                                                    v-if="this.getarrendar == true || this.getvender == true">Pambaleiro</v-btn>
                                            </v-card-text>

                                            <v-form ref="form" lazy-validation>
                                                <v-container
                                                    v-if="(this.getarrendar == true || this.getvender == true) && (getProprietario == true || getcolaborador == true)">
                                                    <!-- <v-card-text align="center" justify="center">
                                                        <v-btn outlined  v-model="proprietario" @click="proprietario()" class="corProprietario"> Proprietário</v-btn>
                                                        <v-btn outlined v-model="colaborador" @click="colaborador()" class="corColaborador">Pambaleiro</v-btn>
                                                    </v-card-text> -->

                                                    <v-row dense class="pt-10">
                                                        <span class="text-h5 "> Detalhes sobre o seu imóvel</span><br />
                                                        <span class="subtitle pb-10">Essas informações são importantes para
                                                            que seu anúncio
                                                            apareça corretamente nas buscas dos interessados.
                                                        </span>
                                                        <v-col cols="12" sm="6" md="6">
                                                            <v-autocomplete outlined dense :rules="tipoImovelRules"
                                                                label="Tipo de Imovel*" v-model="imovel.categoria_imoveis_id
                                                                    " :items="tipoImoveis" item-text="designacao"
                                                                item-value="id" item-color="red"></v-autocomplete>
                                                        </v-col>
                                                        <v-col cols="12" sm="6" md="6">
                                                            <v-autocomplete outlined dense :rules="tipologiaRules" required
                                                                label="Tipologia*" v-model="imovel.tipologia_id
                                                                    " :items="tipologiaImoveis" item-text="designacao"
                                                                item-value="id"></v-autocomplete>
                                                        </v-col>

                                                    </v-row>
                                                    <v-row>
                                                        <v-col cols="12" md="12">
                                                            <v-textarea v-model="imovel.designacao"
                                                                label="titulo do Anúcio*" outlined rows="2">

                                                            </v-textarea>
                                                        </v-col>
                                                    </v-row>
                                                    <v-row>
                                                        <v-col>
                                                            <v-row>
                                                                <v-col cols="12" sm="6" md="6">
                                                                    <span class="text-body-1 text-black indigo--text">Número
                                                                        de quartos</span><br />
                                                                    <span class="text-caption">Incluindo suítes</span>

                                                                </v-col>

                                                                <v-col cols="12" sm="2" md="2">

                                                                    <v-btn outlined dense color="indigo"
                                                                        @click="decrementquarto">
                                                                        -
                                                                    </v-btn>

                                                                </v-col>

                                                                <v-col cols="12" sm="2" md="2">
                                                                    <v-text-field dense color="indigo" outlined
                                                                        v-model="imovel.numero_quartos"
                                                                        :rules="numero_quartosRules"
                                                                        class="no-padding-messages no-padding-details v-messages.theme--light pa-1">

                                                                    </v-text-field>
                                                                </v-col>

                                                                <v-col cols="12" sm="2" md="2">
                                                                    <v-btn outlined dense color="indigo"
                                                                        @click="incrementquarto">
                                                                        +
                                                                    </v-btn>
                                                                </v-col>
                                                            </v-row>
                                                            <v-divider></v-divider>

                                                            <v-divider></v-divider>
                                                            <v-row>
                                                                <v-col cols="12" sm="6" md="6">
                                                                    <span class="text-body-1 text-black indigo--text">Número
                                                                        de banheiros</span><br />
                                                                    <span class="text-caption">Incluindo suítes</span>

                                                                </v-col>

                                                                <v-col cols="12" sm="2" md="2" class="text-right">

                                                                    <v-btn outlined dense color="indigo"
                                                                        @click="decrementbanheiro">
                                                                        -
                                                                    </v-btn>

                                                                </v-col>

                                                                <v-col cols="12" sm="2" md="2">
                                                                    <v-text-field dense color="indigo" outlined
                                                                        v-model="imovel.numero_banheiro"
                                                                        class="no-padding-messages no-padding-details v-messages.theme--light pa-1">

                                                                    </v-text-field>
                                                                </v-col>

                                                                <v-col cols="1" sm="2" md="2">
                                                                    <v-btn outlined dense color="indigo"
                                                                        @click="incrementbanheiro">
                                                                        +
                                                                    </v-btn>
                                                                </v-col>

                                                                <!-- <v-card-text>
                                                            <v-row align="center" justify="center">
                                                                <v-col cols="12">
                                                                    <p class="text-center">
                                                                        Rounded
                                                                    </p>
                                                                </v-col>

                                                            </v-row>
                                                        </v-card-text> -->
                                                            </v-row>
                                                            <v-divider></v-divider>

                                                            <v-divider></v-divider>
                                                            <v-row>
                                                                <v-col cols="12" sm="6" md="6">
                                                                    <span class="text-body-1 text-black indigo--text">Número
                                                                        de garagens</span><br />
                                                                    <span class="text-caption">Vagas para
                                                                        Carros(Opcional)</span>
                                                                </v-col>

                                                                <v-col cols="12" sm="2" md="2">

                                                                    <v-btn outlined dense color="indigo"
                                                                        @click="decrementGaragem">
                                                                        -
                                                                    </v-btn>

                                                                </v-col>

                                                                <v-col cols="12" sm="2" md="2">
                                                                    <v-text-field dense color="indigo" outlined
                                                                        v-model="imovel.numero_garagem"
                                                                        class="no-padding-messages no-padding-details v-messages.theme--light pa-1">
                                                                    </v-text-field>
                                                                </v-col>

                                                                <v-col cols="12" sm="2" md="2">
                                                                    <v-btn outlined dense color="indigo"
                                                                        @click="incrementGaragem">
                                                                        +
                                                                    </v-btn>
                                                                </v-col>

                                                                <!-- <v-card-text>
                                                            <v-row align="center" justify="center">
                                                                <v-col cols="12">
                                                                    <p class="text-center">
                                                                        Rounded
                                                                    </p>
                                                                </v-col>

                                                            </v-row>
                                                        </v-card-text> -->
                                                            </v-row>
                                                            <v-divider></v-divider>
                                                            <v-divider></v-divider>
                                                        </v-col>
                                                        <v-col>
                                                            <v-row>
                                                                <v-col cols="12" sm="6" md="6">
                                                                    <span
                                                                        class="text-body-1 text-black indigo--text">Quantidade
                                                                        de
                                                                        Cozinhas</span><br />
                                                                    <span class="text-caption">Opcional </span>

                                                                </v-col>

                                                                <v-col cols="12" sm="2" md="2" class="text-right">

                                                                    <v-btn dense outlined color="indigo"
                                                                        @click="decrementnumero_cozinha">
                                                                        -
                                                                    </v-btn>

                                                                </v-col>

                                                                <v-col cols="12" sm="2" md="2">
                                                                    <v-text-field dense color="indigo" outlined
                                                                        v-model="imovel.numero_cozinha"
                                                                        class="no-padding-messages no-padding-details v-messages.theme--light pa-1">
                                                                    </v-text-field>
                                                                </v-col>

                                                                <v-col cols="1" sm="2" md="2">
                                                                    <v-btn outlined dense color="indigo"
                                                                        @click="incrementnumero_cozinha">
                                                                        +
                                                                    </v-btn>
                                                                </v-col>
                                                            </v-row>
                                                            <v-divider></v-divider>
                                                            <v-divider></v-divider>
                                                            <v-row>
                                                                <v-col cols="12" sm="6" md="6">
                                                                    <span class="text-body-1 text-black indigo--text">Andar
                                                                        do imóvel</span><br />
                                                                    <span class="text-caption">Opcional </span>

                                                                </v-col>

                                                                <v-col cols="12" sm="2" md="2" class="text-right">

                                                                    <v-btn dense outlined color="indigo"
                                                                        @click="decrementnumero_andar">
                                                                        -
                                                                    </v-btn>

                                                                </v-col>

                                                                <v-col cols="12" sm="2" md="2">
                                                                    <v-text-field dense color="indigo" outlined
                                                                        v-model="imovel.numero_andar"
                                                                        class="no-padding-messages no-padding-details v-messages.theme--light pa-1">
                                                                    </v-text-field>
                                                                </v-col>

                                                                <v-col cols="1" sm="2" md="2">
                                                                    <v-btn outlined dense color="indigo"
                                                                        @click="incrementnumero_andar">
                                                                        +
                                                                    </v-btn>
                                                                </v-col>
                                                            </v-row>
                                                            <v-divider></v-divider>
                                                            <v-divider></v-divider>
                                                        </v-col>
                                                    </v-row>

                                                    <v-row>
                                                        <v-col cols="12" sm="6" md="7">
                                                            <span class="text-h6">Quantos m²</span><br />
                                                            <span class="subtitle">Informe a área útil. Você pode informar
                                                                um tamanho aproximado e alterar depois.</span> </v-col>

                                                        <v-col cols="12" sm="6" md="5">
                                                            <v-text-field dense color="indigo" outlined
                                                                v-model="imovel.metros" type="number"
                                                                class="no-padding-messages no-padding-details v-messages.theme--light pa-1">
                                                            </v-text-field>
                                                        </v-col>

                                                        <!-- <v-col cols="1" sm="2" md="1">
                                                            <v-btn outlined large color="indigo" @click="increMentmetros">
                                                                +
                                                            </v-btn>
                                                        </v-col> -->

                                                        <!-- <v-card-text>
                                                            <v-row align="center" justify="center">
                                                                <v-col cols="12">
                                                                    <p class="text-center">
                                                                        Rounded
                                                                    </p>
                                                                </v-col>

                                                            </v-row>
                                                        </v-card-text> -->
                                                    </v-row>
                                                    <v-divider></v-divider>
                                                    <v-divider></v-divider>

                                                    <v-row>
                                                        <v-col cols="12" md="6">
                                                            <v-autocomplete v-model="imovel.provincia" dense
                                                                :items="this.provincias" item-value="id"
                                                                item-text="designacao" label="Provincia**" outlined>

                                                            </v-autocomplete>
                                                        </v-col>
                                                        <v-col cols="12" md="6">
                                                            <v-autocomplete :items="this.municipios" item-value="id"
                                                                item-text="designacao" v-model="imovel.cidades"
                                                                label="Cidades*" dense outlined>

                                                            </v-autocomplete>
                                                        </v-col>
                                                        <v-col cols="12" md="12">
                                                            <v-text-field v-model="imovel.localizacao_geografica" dense
                                                                label="Rua, Bairo" outlined type="gps">

                                                            </v-text-field>
                                                        </v-col>

                                                    </v-row>
                                                </v-container>
                                            </v-form>
                                        </v-card>
                                        <v-card-actions>
                                            <v-spacer />
                                            <v-btn color="#6A1B9A"
                                                v-if="(getvender || getarrendar) && (getProprietario || getcolaborador)"
                                                outlined @click="continuar(2, 'form')">
                                                Continuar
                                            </v-btn>
                                        </v-card-actions>
                                    </v-stepper-content>
                                    <v-stepper-content step="2">
                                        <v-card flat>
                                            <v-form ref="form2" lazy-validation>
                                                <v-container>
                                                    <template>
                                                        <span class="text-h6">Quais os custos do imóvel?</span><br />
                                                        <span class="subtitle">Se não souber o valor exato, você pode
                                                            informar um aproximado e alterar depois.</span>
                                                    </template>
                                                    <v-row class="py-1">
                                                        <v-col cols="12" :md="this.getvender == true ? 6 : 4"
                                                            :lg="this.getvender == true ? 6 : 6">
                                                            <v-text-field v-model="imovel.preco" type="number" outlined
                                                                dense
                                                                :label="this.getvender == true ? 'Valor de venda do Imovel*' : 'Valor a ser Arrendado do Imovel*'"></v-text-field>
                                                        </v-col>

                                                        <v-col cols="12" :md="this.getvender == true ? 6 : 4"
                                                            v-if="this.getvender == true">
                                                            <v-text-field outlined dense label="Quantidade de prestações*"
                                                                v-model="imovel.quantidade_prestacoes"></v-text-field>
                                                        </v-col>
                                                        <v-col cols="12" :md="this.getarrendar == true ? 6 : 4"
                                                            v-if="this.getarrendar == true">
                                                            <v-autocomplete outlined label="Tempo de arrendamento" dense
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
                                                            v-if="this.getcolaborador == true && this.getarrendar == true">
                                                            <span>O pagamento referente a o arrendamento é o primeiro mês
                                                            </span>
                                                        </v-col>
                                                    </v-row>
                                                    <v-divider></v-divider>
                                                    <v-divider></v-divider>
                                                    <!-- <v-row> 
                                                        <v-col cols="5">
                                                            <span class="text-h6">Pagas Imposto Predial?</span>

                                                        </v-col>
                                                        <v-col cols="4" md="4" v-if="this.getImposto == true">
                                                            <v-text-field outlined dense
                                                                label="Valor pago do Imposto prediario*" v-model="imovel.imposto_predial
                                                                    "></v-text-field>
                                                        </v-col>
                                                        <v-col cols="3">
                                                            <span>
                                                                <v-btn elevation="0" outlined rounded
                                                                    v-model="imovel.simImP" @click="simIP()"
                                                                    class="simimposto_predial"> sim</v-btn>
                                                                <v-btn outlined rounded v-model="imovel.naoImP"
                                                                    @click="naoIP()"
                                                                    class="naocorimposto_predial">não</v-btn>
                                                            </span>
                                                        </v-col>


                                                    </v-row> 
                                                    <v-divider></v-divider>
                                                    <v-divider></v-divider>-->

                                                    <v-row>


                                                        <v-col cols="5">
                                                            <span class="text-h6">Qual o estado do imóvel?</span>

                                                        </v-col>
                                                        <v-col cols="7">
                                                            <span>
                                                                <v-btn elevation="0" outlined rounded
                                                                    v-model="imovel.condicao_imovel" @click="estadoNovo()"
                                                                    class="estadonovo"> Nova</v-btn>
                                                                <v-btn outlined rounded v-model="imovel.condicao_imovel"
                                                                    @click="estadoNaoAcabado()"
                                                                    class="estadonaoacabadol">Não acabada</v-btn>
                                                                <v-btn outlined rounded v-model="imovel.condicao_imovel"
                                                                    @click="estadoReabilitado()"
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
                                                                    @click="simMobiliado()" v-model="imovel.mobiliado"
                                                                    class="simmobiliado"> sim</v-btn>
                                                                <v-btn outlined rounded @click="naoMobiliado()"
                                                                    v-model="imovel.mobiliado"
                                                                    class="naomobiliado">não</v-btn>
                                                            </span>
                                                        </v-col>


                                                    </v-row>
                                                    <v-list subheader two-line flat v-if="this.mostrarMobiliado == true">
                                                        <v-subheader>Você vai deixar no imóvel alguns desses
                                                            itens?</v-subheader>

                                                        <v-row>
                                                            <!-- <v-col>
                                                            <v-list-item-group v-model="settings" multiple>
                                                            <v-list-item>
                                                                <template v-slot:default="{ active, }">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title>Ginásio</v-list-item-title>
                                                                        <v-list-item-subtitle>Allownotifications</v-list-item-subtitle>
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
                                                                        <v-list-item-title>Tanque da água</v-list-item-title>

                                                                    </v-list-item-content>
                                                                    <v-list-item-action>
                                                                        <v-checkbox :input-value="active"
                                                                            v-model="imovel.tanqueagua"
                                                                            style="background-color: #e9e5f5; border-radius: 10px;"
                                                                            color="primary"></v-checkbox>
                                                                    </v-list-item-action>

                                                                </template>
                                                            </v-list-item>
                                                            <v-list-item>
                                                                <template v-slot:default="{ active }">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title>Píscina </v-list-item-title>

                                                                    </v-list-item-content>
                                                                    <v-list-item-action>
                                                                        <v-checkbox :input-value="active"
                                                                            v-model="imovel.piscina"
                                                                            style="background-color: #e9e5f5; border-radius: 10px;"
                                                                            color="primary"></v-checkbox>
                                                                    </v-list-item-action>

                                                                </template>
                                                            </v-list-item>
                                                        </v-list-item-group>
                                                        </v-col> -->
                                                            <v-col> <v-list-item-group v-model="settings" multiple>
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
                                                                                    v-model="imovel.ar_condicionados"
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
                                                                </v-list-item-group></v-col>
                                                        </v-row>
                                                    </v-list>
                                                    <v-divider></v-divider>
                                                    <v-divider></v-divider>

                                                    <v-list subheader two-line flat>
                                                        <v-card-title>O Seu imovel possué esses itens?</v-card-title>
                                                        <v-list-item-group v-model="settings" multiple>
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
                                                            <v-list-item>
                                                                <template v-slot:default="{ active }">
                                                                    <v-list-item-content>
                                                                        <v-list-item-title>Píscina </v-list-item-title>

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
                                                                        <v-list-item-title>Elevador </v-list-item-title>

                                                                    </v-list-item-content>
                                                                    <v-list-item-action>
                                                                        <v-checkbox :input-value="active"
                                                                            v-model="imovel.elevador"
                                                                            style="background-color: #e9e5f5; border-radius: 10px;"
                                                                            color="primary"></v-checkbox>
                                                                    </v-list-item-action>

                                                                </template>
                                                            </v-list-item>
                                                        </v-list-item-group>
                                                    </v-list>
                                                    <v-card-actions>
                                                        <v-btn color="warning" @click="e1 = 1">Voltar</v-btn>

                                                        <v-spacer />
                                                        <v-btn color="#6A1B9A" outlined @click="continuar(3, 'form')">
                                                            Continuar
                                                        </v-btn>
                                                    </v-card-actions>
                                                </v-container>
                                            </v-form>
                                        </v-card>

                                    </v-stepper-content>
                                    <v-stepper-content step="3">
                                        <v-card flat>
                                            <v-form ref="form3" lazy-validation>
                                                <v-container>

                                                    <v-row dense class="py-10">
                                                        <v-col cols="12" sm="12">
                                                            <template>
                                                                <span class="text-h6">Fotos do Imóvel</span><br />
                                                                <span class="subtitle">Primeiro campo adicionar a foto
                                                                    principal e o segundo campo deve adicionar 10 fotos no
                                                                    máximo.</span>
                                                            </template>
                                                        </v-col>
                                                        <v-col cols="12" md="6" class="pb-10">
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

                                                        <template>
                                                            <span class="text-h6">Documentação do Imóvel </span><br />
                                                            <span class="subtitle">Ao divulgarmos esses dados iremos colocar
                                                                marca d'água no documento para proteger as
                                                                informações.</span>
                                                        </template>
                                                        <v-divider></v-divider>
                                                        <!-- <v-row>
                                                            <v-col cols="12" sm="6" md="4"><v-file-input
                                                                    accept="application/pdf,image/*" label="Registo Predial"
                                                                    v-model="imovel.registoPredial"
                                                                    hint="O campo é opcional" persistent-hint
                                                                    required></v-file-input></v-col>
                                                            <v-col cols="12" sm="6" md="4"><v-file-input
                                                                    accept="application/pdf,image/*" label="Matriz Predial"
                                                                    v-model="imovel.matrizpredial"
                                                                    hint="O campo é opcional" persistent-hint
                                                                    required></v-file-input></v-col>

                                                            <v-col cols="12" sm="6" md="4"><v-file-input
                                                                    accept="application/pdf,image/*"
                                                                    label="Termo de equitação"
                                                                    v-model="imovel.termoEquitacao"
                                                                    hint="O campo é opcional" persistent-hint
                                                                    required></v-file-input></v-col>

                                                            <v-col cols="12" sm="6" md="4"><v-file-input
                                                                    accept="application/pdf,image/*"
                                                                    label="Directo de Superficie"
                                                                    v-model="imovel.direitoSuperficie"
                                                                    hint="O campo é opcional" persistent-hint
                                                                    required></v-file-input>
                                                            </v-col>
                                                            <v-col cols="12" sm="6" md="4"><v-file-input
                                                                    accept="application/pdf,image/*" label="Escritura
                                                                    Pública" v-model="imovel.escrituraPublica"
                                                                    hint="Compra e venda" persistent-hint
                                                                    required></v-file-input>
                                                            </v-col>
                                                        </v-row> -->
                                                        <v-col cols="12" sm="6" md="4">

                                                            <template>
                                                                <v-file-input accept="application/pdf,image/*"
                                                                    label="Croquis dde Localização" v-model="imovel.croquis"
                                                                    hint="O campo é opcional"></v-file-input>
                                                            </template>
                                                        </v-col>
                                                        <v-col cols="12" md="12">
                                                            <template>
                                                                <v-file-input accept="image/*" label="Localização"
                                                                    v-model="imovel.localizacao"></v-file-input>
                                                            </template>

                                                        </v-col>
                                                        <v-col cols="12" md="12">
                                                            <template>
                                                                <v-file-input accept="application/pdf,image/*"
                                                                    label="Titulo de propriedade"
                                                                    v-model="imovel.tituloPropriedade"></v-file-input>
                                                            </template>
                                                        </v-col>
                                                    </v-row>
                                                </v-container>
                                            </v-form>
                                        </v-card>

                                        <v-card-actions>
                                            <v-btn color="warning" @click="e1 = 2">Voltar</v-btn>

                                            <v-spacer />
                                            <v-btn color="#6A1B9A" outlined @click="continuar(4, 'form')">
                                                Continuar
                                            </v-btn>
                                        </v-card-actions>
                                    </v-stepper-content>
                                    <v-stepper-content step="4">
                                        <v-card flat>
                                            <v-form ref="form4" lazy-validation>
                                                <v-container>
                                                    <v-row dense>
                                                        <template>
                                                            <span class="text-h1">JÁ NÃO SEI O QUE COLOCAR MAIS AQUI
                                                            </span><br />
                                                            <span class="subtitle">Ao divulgarmos esses dados iremos colocar
                                                                marca d'água no documento para proteger as
                                                                informações.</span>
                                                        </template>
                                                    </v-row>
                                                </v-container>
                                            </v-form>
                                        </v-card>

                                        <v-card-actions>
                                            <v-btn color="warning" @click="e1 = 3">Voltar</v-btn>

                                            <v-spacer />
                                            <v-btn class="bg-primary darken-4 white--text" @click="salvarImovel()">
                                                {{
                                                    editedIndex > -1
                                                    ? "Actualizar"
                                                    : "Guardar"
                                                }}
                                            </v-btn>
                                        </v-card-actions>
                                    </v-stepper-content>
                                </v-stepper-items>
                            </v-col>
                            <v-col sm="1" md="2" lg="2"></v-col>
                        </v-row>

                    </v-stepper>
                </v-container>
            </v-card-text>
            <template>
                <div class="text-center">
                    <v-snackbar v-model="snackbar" :multi-line="multiLine" :timeout="5000" outlined
                        color="deep-purple accent-4">
                        {{ text }}
                        <v-btn color="indigo" text @click="snackbar = false">
                            Close
                        </v-btn>
                    </v-snackbar>
                </div>
            </template>
        </v-card>
    </PortalLayout>
</template>

<script>
import PortalLayout from "../../Templates/PortalLayout";
export default {
    props: ["provincias", "municipios", 'tipologiaImoveis', 'tipoImoveis', 'startingImage', 'autoSlideInterval', 'showProgressBar'],
    components: {
        PortalLayout,
    },
    data: () => ({
        multiLine: true,
        snackbar: false,
        text: `O seu anuncio foi cadastrado com sucesso`,
        vertical: true,
        qquarto: "1",
        getarrendar: false,
        getvender: false,
        getImposto: false,
        getcolaborador: false,
        getProprietario: false,
        mostrarMobiliado: false,
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
        tipo_clientes: [{
            id: 1,
            designacao: "SINGULAR"
        },
        {
            id: 2,
            designacao: "EMPRESA"
        },
        ],
        loading: null,
        msg: null,
        imovel: {
            condicao_imovel: null,
            colaborador_id: null,
            proprietario_id: null,
            venda_id: null,
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
        defautImovel: {
            condicao_imovel: null,
            colaborador_id: null,
            proprietario_id: null,
            venda_id: null,
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
        items: [{
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
        dialogAddimovel: false,
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

        folders: [{
            subtitle: 'Jan 9, 2014',
            title: 'Photos',
            value: '1'
        },
        {
            subtitle: 'Jan 17, 2014',
            title: 'Recipes',
            value: '2'
        },
        {
            subtitle: 'Jan 28, 2014',
            title: 'Work',
            value: '3'
        },
        ],
    }),

    mounted() {
        this.loading = true;
        setTimeout(function () {
            this.loading = false;
        }, 4000);
        // alert(this.imovels);
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

        caracteristicas(item) {
            alert(item);
        },
        venderImoveis() {
            this.imovel.venda_id = true,
                this.imovel.arrendamento_id = false
            this.getarrendar = false;
            this.getregime = false;
            this.getvender = true;
            const corVender = document.querySelector(".corVender");
            const corArrendamente = document.querySelector(".corArrendamento");
            corVender.style.color = "white";
            corVender.style.background = "#4527A0";
            corArrendamente.style.color = "black";
            corArrendamente.style.background = "white"
            // alert(this.getvender)
        },
        arrendarImoveis() {
            this.imovel.venda_id = false,
                this.imovel.arrendamento_id = true
            this.getarrendar = true;
            this.getregime = true;
            this.getvender = false;
            // alert(this.getarrendar)
            const corVender = document.querySelector(".corVender");
            const corArrendamente = document.querySelector(".corArrendamento");
            corVender.style.color = "black";
            corVender.style.background = "white";
            corArrendamente.style.background = "#4527A0";
            corArrendamente.style.color = "white";

        },
        colaborador() {
            // this.getarrendar = true;
            // this.getregime = true;
            this.getcolaborador = true;
            this.getProprietario = true;
            this.imovel.proprietario_id = false;
            this.imovel.colaborador_id = true;
            // alert(this.getarrendar)
            const corColaborador = document.querySelector(".corColaborador");
            const corProprietario = document.querySelector(".corProprietario");
            corColaborador.style.color = "white";
            corColaborador.style.background = "#4527A0 ";
            corProprietario.style.background = "white";
            corProprietario.style.color = "black";

        },
        proprietario() {
            // this.getarrendar = true;
            // this.getregime = true;
            // this.getvender = false;
            // alert(this.getarrendar)
            this.imovel.proprietario_id = true;
            this.imovel.colaborador_id = false,
                this.getcolaborador = false;
            this.getProprietario = true;
            const corProprietario = document.querySelector(".corProprietario");
            const corColaborador = document.querySelector(".corColaborador");
            corProprietario.style.color = "white";
            corProprietario.style.background = "#4527A0";
            corColaborador.style.background = "white";
            corColaborador.style.color = "black";

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
            this.imovel.mobiliado = true
            this.mostrarMobiliado = true;
            const simmobiliado = document.querySelector(".simmobiliado");
            const naomobiliado = document.querySelector(".naomobiliado");
            simmobiliado.style.color = "white";
            simmobiliado.style.background = "#D1C4E9";
            naomobiliado.style.background = "white";
            naomobiliado.style.color = "black";
        },
        naoMobiliado() {
            this.imovel.mobiliado = false
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

        salvarImovel() {
            // this.loading = true;

            // alert(JSON.stringify(this.imovel)); // this.$inertia.post("/imovels", this.imovel, {});

            // axios
            //     .post("/portal/imoveis", this.imovel)
            //     .then((response) => {
            //         // this.loading = false;
            //         // alert(JSON.stringify(response.data));
            //         //   this.resposta = response.data
            //     })
            //     .catch(() => {
            //         // alert(JSON.stringify(response.data));

            //         //   console.log('Falha ao registar os dados na base de dados!...')
            //     });

            this.$inertia.post(
                "/portal/imoveis",
                this.imovel,
                {
                   
                    onFinish: () => {
                        if (this.$page.props.flash.success != null) {
                            Vue.toasted.global.defaultSuccess({
                                msg:
                                    "" + this.$page.props.flash.success,
                            });
                            this.snackbar = true
                            this.imovel=Object.assign({}, this.defautImovel);
                            this.e1 = 1
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
        showDialogAddimovel() {
            this.dialogAddimovel = true;
        },
        validate() {
            this.$refs.form.validate();
            this.$refs.form2.validate();
            this.$refs.form3.validate();
            this.$refs.form4.validate();
        },
        continuar(stepe, form) {
            if (this.$refs[form].validate()) {
                this.e1 = stepe;
            }
        },

        close() {
            this.morador = {};
            this.dialogAddimovel = false;
            this.$nextTick(() => {
                this.morador = Object.assign({}, this.defaultItem);
                this.editedIndex = -1;
            });
            setTimeout(() => {
                this.overlay = false;
            }, 2000);
        },

        increaseValue() {
            var value = parseInt(document.getElementById("idquarto").value, 10);
            alert(value)
            value = isNaN(value) ? 0 : value;
            value++;
            document.getElementById("idquarto").value = value;
        },

        decreaseValue() {
            var value = parseInt(document.getElementById("idquarto").value, 10);
            value = isNaN(value) ? 0 : value;
            value < 1 ? (value = 1) : "";
            if (value > 1) {
                value--;
            }
            document.getElementById("idquarto").value = value;
        },

        incrementquarto() {
            this.imovel.numero_quartos++;
        },
        decrementquarto() {
            if (this.imovel.numero_quartos > 0) {
                this.imovel.numero_quartos--;
            }
        },
        incrementnumero_andar() {
            this.imovel.numero_andar++;
        },
        decrementnumero_andar() {
            if (this.imovel.numero_andar > 0) {
                this.imovel.numero_andar--;
            }
        },
        incrementnumero_cozinha() {
            this.imovel.numero_cozinha++;
        },
        decrementnumero_cozinha() {
            if (this.imovel.numero_cozinha > 0) {
                this.imovel.numero_cozinha--;
            }
        },
        incrementbanheiro() {
            this.imovel.numero_banheiro++;
        },
        decrementbanheiro() {
            if (this.imovel.numero_banheiro > 0) {
                this.imovel.numero_banheiro--;
            }
        },
        decrementGaragem() {
            if (this.imovel.numero_garagem > 0) {
                this.imovel.numero_garagem--;
            }
        },
        incrementGaragem() {
            this.imovel.numero_garagem++;
        },
        increMentmetros() {
            this.imovel.metros++;
        },
        decrementMetros() {
            if (this.imovel.metros > 0) {
                this.imovel.metros--;
            }
        }

    },
};
</script>

<style>
.no-padding-messages .v-messages.theme--light,
.no-padding-details .v-text-field__details {
    padding: 0 !important;
    margin: 0px 0 0 0 !important;

}

;</style>
