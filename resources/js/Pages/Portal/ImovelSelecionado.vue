<template>
    <PortalLayout>
        <template>
            <div class="card-carousel" @mouseover="stopTimer" @mouseleave="restartTimer">
                <div class="progressbar" v-if="autoSlideInterval && showProgressBar">
                    <div :style="{ width: progressBar + '%' }"></div>
                </div>
                <div class="card-img">
                    <img :src="'/storage/' + currentImage" alt="">
                    <div class="actions">
                        <span @click="prevImage" class="prev">
                            &#8249;
                        </span>
                        <span @click="nextImage" class="next">
                            &#8250;
                        </span>
                    </div>
                </div>
                <div class="thumbnails">
                    <div v-for="(image, index) in  images" :key="image.id"
                        :class="['thumbnail-image', (activeImage == index) ? 'active' : '']" @click="activateImage(index)">
                        <img :src="'/storage/' + image.foto">
                    </div>
                </div>
            </div>
        </template>
        <v-div class="deep-purple lighten-2">
            <!--             <template >
                <v-carousel>
                    <v-carousel-item v-for="(item, i) in images" :key="i" :src="'/storage/' + item.foto" reverse-transition="fade-transition"
                        transition="fade-transition"></v-carousel-item>
                </v-carousel>
            </template> -->

            <v-row>
                <card class="white">
                    <v-col md="8" offset-md="2">
                        <v-card-subtitle class="">Arrendamento / Quarto / Cozinha Equipada / Leiria</v-card-subtitle>
                        <v-card-text class="text-h5 ">
                            <v-card-subtitle class="">Código:{{ imoveis.codigo_imovel }}</v-card-subtitle>
                            <v-card-title class="deep-purple lighten-5"> {{ imoveis.designacao }}</v-card-title>
                            <v-row>

                                <v-col cols="4"> <v-card-subtitle class="my-0 pt-3">Localização: {{ imoveis.localizacao
                                }}</v-card-subtitle></v-col>
                                <v-col cols="4"> <v-card-subtitle class="my-0 pt-3"> Condição do imovel: {{
                                    imoveis.condicao_imoveis.designacao }}</v-card-subtitle></v-col>
                                <!-- <v-col cols="3"> <v-card-subtitle class="my-0 pt-3"> Condição do imovel: {{ imovel.condicao_imoveis.designacao }}</v-card-subtitle></v-col> -->
                                <v-col cols="4"> <v-card-title
                                        class="my-0 py-0 justify-content-end text-h5 text-bold text-s">Preço: {{
                                            formatValor(imoveis.preco) }}</v-card-title></v-col>
                            </v-row>
                            <v-divider></v-divider>
                            <v-row>
                                <v-col cols="10">
                                    <v-chip-group v-model="selection" active-class="deep-purple accent-4 white--text"
                                        column>
                                        <v-chip><span class="mdi mdi-chart-areaspline-variant"> {{ imoveis.metros }}m <sup>2
                                                </sup>
                                            </span></v-chip>
                                        <v-chip><span class="mdi mdi-seat-individual-suite">{{ imoveis.suite }}
                                            </span>Dormitório</v-chip>
                                        <v-chip><span class="mdi mdi-car">{{ imoveis.numero_garagem
                                        }}</span>Garagem</v-chip>
                                        <v-chip><span class="mdi mdi-shower-head"></span> Banheiros</v-chip>
                                        <v-chip><span class="mdi mdi-countertop"></span> Cozinha</v-chip>
                                        <v-chip>
                                            <span class="mdi mdi-bed-double"></span>{{ imoveis.numero_banheiro }}
                                            Quartos</v-chip>
                                        <v-chip v-for="(actidade) in imoveis.actividade_imoveis" :key="actidade.id"
                                            :color="actidade.id == 1 ? 'indigo' : 'orange'" class="white--text">
                                            <span class="mdi mdi-sale" title="estado do imovel">
                                            </span>{{ actidade.operacao_imoveis.designacao }}
                                        </v-chip>

                                        <!-- Adicionar um campo na base de dado e solicitacao do imovel para restringir apenas o usuario a ver o estado da mudanca das solicitacoes -->
                                        <span v-if="user">
                                            <span v-if="imoveis.solicitacao_imoveis.length > 0">
                                                <span v-for="(solicitacao) in imoveis.solicitacao_imoveis"
                                                    :key="solicitacao.id">

                                                    <span
                                                        v-if="solicitacao.user_marca_visita == user.id && solicitacao.imoveis_id == imoveis.id">
                                                        <v-chip outlined title="estado do imóvel" class="white--text"
                                                            :color="getcor(solicitacao.estado_imoveis_id)"
                                                            v-if="user.id == solicitacao.user_marca_visita">
                                                            <span v-if="solicitacao.estado_imoveis_id == 8"
                                                                class="mdi mdi-archive-remove">Em negociacao</span>
                                                            <!-- <span v-if="solicitacao.estado_imoveis_id == 3" class="mdi mdi-archive-cog "></span> -->
                                                            <span v-if="solicitacao.estado_imoveis_id == 4"
                                                                class="mdi mdi-archive-eye">Visita pendentes</span>
                                                            <span v-if="solicitacao.estado_imoveis_id == 5"
                                                                class="mdi mdi-archive-refresh">{{ 'Visita confirmada'
                                                                }}</span>

                                                        </v-chip>
                                                    </span>
                                                    <v-chip
                                                        v-else-if="!solicitacao.user_marca_visita == user.id && !solicitacao.imoveis_id == imoveis.id"
                                                        outlined title="estado do imóvel" class="white--text"
                                                        :color="getcor(imoveis.estado_imoveis_id)">

                                                        <span v-if="imoveis.estado_imoveis_id == 1"
                                                            class="mdi mdi-archive-lock-open "></span>
                                                        <span v-if="imoveis.estado_imoveis_id == 2"
                                                            class="mdi mdi-archive-remove"></span>
                                                        <span v-if="imoveis.estado_imoveis_id == 5"
                                                            class="mdi mdi-archive-refresh"></span>

                                                        {{ imoveis.estado_imoveis.designacao }}
                                                    </v-chip>

                                                </span>
                                            </span>
                                            <v-chip v-else outlined title="estado do imóvel" class="white--text"
                                                :color="getcor(imoveis.estado_imoveis_id)">

                                                <span v-if="imoveis.estado_imoveis_id == 1"
                                                    class="mdi mdi-archive-lock-open "></span>
                                                <span v-if="imoveis.estado_imoveis_id == 2"
                                                    class="mdi mdi-archive-remove"></span>
                                                <span v-if="imoveis.estado_imoveis_id == 5"
                                                    class="mdi mdi-archive-refresh"></span>

                                                {{ imoveis.estado_imoveis.designacao }}
                                            </v-chip>
                                        </span>
                                        <v-chip v-else title="estado do imóvel" class="white--text"
                                            :color="getcor(imoveis.estado_imoveis_id)">
                                            <span v-if="imoveis.estado_imoveis_id == 1"
                                                class="mdi mdi-archive-lock-open "></span>
                                            <span v-if="imoveis.estado_imoveis_id == 2"
                                                class="mdi mdi-archive-remove"></span>
                                            <span v-if="imoveis.estado_imoveis_id == 5"
                                                class="mdi mdi-archive-refresh"></span>

                                            {{ imoveis.estado_imoveis.designacao }}
                                        </v-chip>

                                    </v-chip-group>
                                    <!--    </v-col>

                                        
                               <v-col cols="auto" > 
                                -->

                <span v-if="user ">
                    <span v-if="user.tipo_user_id !== 1">
                     <span v-if="imoveis.solicitacao_imoveis.length==1">
                        <v-btn v-for="solicitacao in imoveis.solicitacao_imoveis" :key="solicitacao"  text
                    v-if="solicitacao.user_marca_visita==user.id && solicitacao.imoveis_id==imoveis.id"
                    :disabled="solicitacao.user_marca_visita==user.id || solicitacao.imoveis_id==imoveis.id "
                    class="ml-auto" color="#4527A0" dense  @click="marcarVisita()">
                    {{(!solicitacao.user_marca_visita==user.id && solicitacao.imoveis_id==imoveis.id)? 'Marcação de visita' : 'Pedido de marcação feito' }} 

                          </v-btn>
                        </span>

                        <span v-else-if="imoveis.solicitacao_imoveis.length==2">
                        
                                <v-btn  text :disabled="imoveis.solicitacao_imoveis[1].user_marca_visita==user.id"
                    class="ml-auto" color="#4527A0" dense  @click="marcarVisita()">
                    {{imoveis.solicitacao_imoveis[1].user_marca_visita!==user.id? 'Marcação de visita' : 'Pedido de marcação feito' }} 
                          </v-btn>
                            </span>
                        <span v-else-if="imoveis.solicitacao_imoveis.length==3">
                            <v-btn  text :disabled="imoveis.solicitacao_imoveis[2].user_marca_visita==user.id"
                    class="ml-auto" color="#4527A0" dense  @click="marcarVisita()">
                    {{imoveis.solicitacao_imoveis[2].user_marca_visita!==user.id? 'Marcação de visita' : 'Pedido de marcação feito' }} 
                          </v-btn>
                        </span>
                        <span v-else-if="imoveis.solicitacao_imoveis.length==4">
                            <v-btn  text :disabled="imoveis.solicitacao_imoveis[3].user_marca_visita==user.id"
                    class="ml-auto" color="#4527A0" dense  @click="marcarVisita()">
                    {{imoveis.solicitacao_imoveis[3].user_marca_visita!==user.id? 'Marcação de visita' : 'Pedido de marcação feito' }} 
                          </v-btn>
                        </span>
                        <span v-else>
                            <v-btn text

                    class="ml-auto" color="#4527A0" dense  @click="marcarVisita()">
                    {{'Marcação de visita' }} 

                          </v-btn>
                        </span>
              </span>
            </span>
             <span v-else>
    
                 <template>

                    <v-btn  class="ml-auto" color="#4527A0" dense outlined @click="marcarVisita()">
                    
                    {{'Marcação de visita'}} 

                </v-btn>
             
                </template>
            </span>
                                </v-col>
                            </v-row>
                            <v-divider></v-divider>
                            <p class="text-body">Descrição do imóvel:</p>
                            <v-card-subtitle>
                                {{ imoveis.descricao }}
                            </v-card-subtitle>
                            <v-row class="pt-5">


                                <v-col cols="12" sm="4" md="4" v-if="imoveis.mobiliado === 'TRUE'">

                                    <span class="text-subtitle-1 text-bold">O Imóvel tem </span><br />
                                    <v-divider></v-divider>
                                    <span class="text-caption">Píscina</span><br />
                                    <span class="text-caption">Ginásio{{ }}</span><br />
                                    <span class="text-caption">Tanque de água{{ }}</span><br />
                                    <span class="text-caption">Elevador{{ }}</span>
                                    <span class="text-caption">Armario Embutido{{ }}</span>
                                    <span class="text-caption">Piso{{ }}</span>
                                </v-col>
                                <v-col sm="4" md="4">
                                    <span class="text-subtitle-1 text-bold">Imóvel mobiliado.</span><v-divider></v-divider>

                                    <span class="text-caption">Mesa e Cadeira</span><br />
                                    <span class="text-caption">Ar-condicionados</span><br />
                                    <span class="text-caption">Churrasqueira</span><br />
                                    <span class="text-caption">Gerador</span><br />
                                    <span class="text-caption">Maquina de lavar roupas</span><br />
                                    <!-- <p>Interfone</p> -->
                                </v-col>
                                <v-col sm="4" md="4">
                                    <span class="text-subtitle-1 text-bold">Piscina</span>
                                    <v-divider></v-divider>
                                    <span class="mdi mdi-check-circle-outline"></span><br />
                                    <span class="text-caption">Quadra poliesportiva</span><span
                                        class="mdi mdi-check-circle-outline"></span><br />
                                    <span class="text-caption">Cozinha equipada </span><span
                                        class="mdi mdi-check-circle-outline"></span><br />
                                    <span class="text-caption">Despesas incluídas (água, luz, gás e internet) </span><span
                                        class="mdi mdi-check-circle-outline"></span>
                                    <!-- <p>Interfone</p> -->
                                </v-col>

                            </v-row>
                            <v-divider></v-divider>
                        </v-card-text>
                    </v-col>
                </card>
                <v-col md="8" offset-md="2">
                    <template>
                        <!-- <v-card-title class="deep-purple lighten-5"> Descição do Imovel</v-card-title> -->
                        <v-card-subtitle>
                        <!-- <p>A prioridade são as pessoas!</p> -->

                        <p class="text-justify subtitle-1">
                            O seu voto de CONFIANÇA é o nosso compromisso.
                            Pautamo-nos pela objetividade e TRANSPARÊNCIA em todas as fases do processo,
                            proporcionando-lhe a
                            SEGURANÇA que merece.
                            Não há pessoas iguais, casas iguais nem negócios iguais.
                            Adaptamo-nos às suas necessidades.
                            INFORMAÇÃO e ACOMPANHAMENTO são as palavras-chave para a sua tomada de decisão.
                            Primamos por um serviço de qualidade e pela SATISFAÇÃO dos nossos clientes.
                        </p>

                        Notas:
                        <p class="text-justify">
                            *Se for consultor imobiliário, este imóvel está disponível para partilha de negócio.
                            Apresente aos seus clientes compradores e agende a sua visita.
                        </p>
                        *Para maior facilidade na identificação deste imóvel refira, por favor, o respetivo ID.
                        </v-card-subtitle>
                        <!-- <v-card-actions>


                            <inertia-link class="ml-auto" :href="`/portal/Solicitar-visita/${this.imovel.id}`">

                                <v-btn color="#4527A0" dense outlined> Solicitar visita</v-btn>
                            </inertia-link>

                        </v-card-actions> -->
                    </template>
                </v-col>

            </v-row>

            <template>

                <v-row justify="space-around" class="py-10">
                    <!--       <v-btn v-for="solicitacao in imoveis.solicitacao_imoveis" :key="solicitacao"  text
                    v-if="solicitacao.user_marca_visita==user.id && solicitacao.imoveis_id==imoveis.id"
                    :disabled="solicitacao.user_marca_visita==user.id || solicitacao.imoveis_id==imoveis.id "
                    class="ml-auto" color="#4527A0" dense  @click="marcarVisita()">
                    {{(!solicitacao.user_marca_visita==user.id && solicitacao.imoveis_id==imoveis.id)? 'Marcação de visita' : 'Pedido de marcação feito' }} 

                </v-btn> -->
                    <v-col cols="auto">
                        <span v-if="user">
                        <span  v-if="user.tipo_user_id !== 1">
                     <span v-if="imoveis.solicitacao_imoveis.length==1">
                        <v-btn v-for="solicitacao in imoveis.solicitacao_imoveis" :key="solicitacao"  text
                    v-if="solicitacao.user_marca_visita==user.id && solicitacao.imoveis_id==imoveis.id"
                    :disabled="solicitacao.user_marca_visita==user.id || solicitacao.imoveis_id==imoveis.id "
                    class="ml-auto" color="#4527A0" dense  @click="marcarVisita()">
                    {{(!solicitacao.user_marca_visita==user.id && solicitacao.imoveis_id==imoveis.id)? 'Marcação de visita' : 'Pedido de marcação feito' }} 

                          </v-btn>
                        </span>

                        <span v-else-if="imoveis.solicitacao_imoveis.length==2">
                            
                                <v-btn  text :disabled="imoveis.solicitacao_imoveis[1].user_marca_visita==user.id"
                    class="ml-auto" color="#4527A0" dense  @click="marcarVisita()">
                    {{imoveis.solicitacao_imoveis[1].user_marca_visita!==user.id? 'Marcação de visita' : 'Pedido de marcação feito' }} 
                          </v-btn>
                        </span>
                        <span v-else-if="imoveis.solicitacao_imoveis.length==3">
                            <v-btn  text :disabled="imoveis.solicitacao_imoveis[2].user_marca_visita==user.id"
                    class="ml-auto" color="#4527A0" dense  @click="marcarVisita()">
                    {{imoveis.solicitacao_imoveis[2].user_marca_visita!==user.id? 'Marcação de visita' : 'Pedido de marcação feito' }} 
                          </v-btn>
                        </span>
                        <span v-else-if="imoveis.solicitacao_imoveis.length==4">
                            <v-btn  text :disabled="imoveis.solicitacao_imoveis[3].user_marca_visita==user.id"
                    class="ml-auto" color="#4527A0" dense  @click="marcarVisita()">
                    {{imoveis.solicitacao_imoveis[3].user_marca_visita!==user.id? 'Marcação de visita' : 'Pedido de marcação feito' }} 
                          </v-btn>
                        </span>
                   
                        <span v-else>
                            <v-btn text

                    class="ml-auto" color="#4527A0" dense  @click="marcarVisita()">
                    {{'Marcação de visita' }} 

                          </v-btn>
                        </span>

               
              </span>
            </span>
             <span v-else>
    
                 <template>

                    <v-btn  class="ml-auto" color="#4527A0" dense outlined @click="marcarVisita()">
                    
                    {{'Marcação de visita'}} 

                </v-btn>
             
                </template>
            </span>
                    </v-col>

                    <v-dialog v-if="dialogMarcarVisita == true" v-model="dialogMarcarVisita"
                        transition="dialog-bottom-transition" max-width="700" persistent>


                        <!-- <template v-slot:activator="{ on, attrs }">

                    <v-btn v-bind="attrs" class="ml-auto" v-on="on" color="#4527A0" dense outlined
                        @click="marcarVisita()"> Solicitar visita</v-btn>

                </template> -->
                        <template>
                            <v-card>
                                <v-toolbar class="text-h6" color="primary" dark>Marcar visita</v-toolbar>
                                <!-- <v-card-text>
                        <div class="text-h2 pa-12">Hello world!</div>
                    </v-card-text> -->
                                <v-card-text>
                                    <!-- <v-container>
                                <v-row>
                                    <v-col cols="12" sm="6" md="6">
                                        <v-text-field outlined dense type="month" label="Dia da semana*"
                                            required></v-text-field>
                                    </v-col>
                                    <v-col cols="12" sm="6" md="6">
                                        <v-text-field outlined dense type="year" label="Legal middle name"
                                            hint="example of helper text only on focus"></v-text-field>
                                    </v-col>
                                    <v-col cols="12" sm="6" md="12">
                                        <v-text-field label="Legal last name*"
                                            hint="example of persistent helper text" persistent-hint
                                            required></v-text-field>
                                    </v-col>
                                </v-row>
                            </v-container> -->
                                    <v-row>
                                        <v-col>
                                            <v-date-picker v-model="visitar.data_visita" :format="DatePickerFormat"
                                                :min="new Date().toISOString().substring(0, 10)"
                                                class="mt-4"></v-date-picker>
                                        </v-col>
                                        <v-col>
                                            <v-time-picker v-model="visitar.hora_visita" :allowed-hours="allowedHours"
                                                :allowed-minutes="allowedMinutes" class="mt-4" format="24hr" scrollable
                                                min="8:30" max="17:00"></v-time-picker>
                                        </v-col>
                                        <v-col cols="12" sm="6" md="12">
                                            <v-text-field label="OBS:" hint="O campo é opcional" persistent-hint required
                                                v-model="visitar.designacao"></v-text-field>
                                        </v-col>
                                    </v-row>
                                    <!-- <small>*indicates required field</small> -->
                                </v-card-text>
                                <v-card-actions class="justify-end">
                                    <v-btn text @click="enviarSolicitacao()"
                                        :disabled="visitar.data_visita == null || visitar.hora_visita == null">Solicitar</v-btn>

                                    <v-btn text @click="dialogMarcarVisita = false">Fechar</v-btn>
                                </v-card-actions>
                            </v-card>
                        </template>
                    </v-dialog>
                    <template>
                        <v-row justify="center">
                            <v-dialog v-if="dialogLogin == true" v-model="dialogLogin" fullscreen hide-overlay
                                transition="dialog-bottom-transition">
                                <v-card>
                                    <v-toolbar dark color="primary">
                                        <v-btn icon dark @click="dialogLogin = false">
                                            <v-icon>mdi-close</v-icon>
                                        </v-btn>
                                        <v-toolbar-title>Voltar</v-toolbar-title>
                                        <v-spacer></v-spacer>
                                        <v-toolbar-items>
                                            <!-- <v-btn dark text @click="dialogLogin = false">
                                        Save
                                    </v-btn> -->
                                        </v-toolbar-items>
                                    </v-toolbar>
                                    <v-row align="center" justify="center">
                                        <v-col cols="12" md="6" lg="5">
                                            <v-container class=" alinnharcentro">

                                                <v-card align="center" justify="center" elevation="0" class="w-75">

                                                    <v-card-text class="text-h3"> SIG-VAI</v-card-text>
                                                    <v-card-text fluid class="justify-center">
                                                        <v-form v-model="isValid">
                                                            <v-row class="justify-center">
                                                                <v-col cols="12">
                                                                    <v-text-field :rules="[rules.required]"
                                                                        placeholder="Email ou telefone" outlined rounded
                                                                        label="Email" name="email" v-model="usuario.email"
                                                                        prepend-icon="mdi-account-circle" />
                                                                </v-col>
                                                                <v-col cols="12">
                                                                    <v-text-field :rules="[rules.required]" outlined rounded
                                                                        id="password" label="Palavra-Passe"
                                                                        v-model="usuario.password" name="password"
                                                                        prepend-icon="mdi-lock" :append-icon="showPassword
                                                                            ? 'mdi-eye'
                                                                            : 'mdi-eye-off'
                                                                            " :type="showPassword ? 'text' : 'password'
        " v-on:keyup.enter="login" @click:append="
        showPassword = !showPassword
        " required />
                                                                </v-col>
                                                                <span class="subtitle">--------------- Entrar com
                                                                    ---------------------
                                                                </span>
                                                                <v-col cols="12">
                                                                    <div class="text-center pb-3">
                                                                        <v-btn href="/auth/redirect" block rounded outlined
                                                                            x-large color="blue darken-1">
                                                                            <v-icon>mdi mdi-google</v-icon>
                                                                            Google
                                                                        </v-btn>
                                                                    </div>

                                                                    <v-alert outlined dismissible
                                                                        transition="scale-transition" text
                                                                        v-if="alert.type == 'success'" type="success">
                                                                        {{ alert.text }}
                                                                    </v-alert>
                                                                    <v-alert dismissible transition="scale-transition"
                                                                        outlined v-if="alert.type == 'error'" type="error">
                                                                        {{ alert.text }}
                                                                    </v-alert>

                                                                    <v-btn block rounded color="#4527A0" dark x-large
                                                                        @click="setLogin()" :disabled="!isValid">
                                                                        <v-icon>login</v-icon> Iniciar
                                                                        Sessão
                                                                    </v-btn>
                                                                </v-col>

                                                                <v-col cols="12" md="12">

                                                                </v-col>
                                                            </v-row>
                                                        </v-form>
                                                    </v-card-text>
                                                    <v-card-actions>
                                                        <p class="ml-4 pb-6 subtitle">
                                                            <a href="/reset-password" class="linkstilo">
                                                                Esqueci a minha senha!</a><br />
                                                            Não possui uma conta?<a href="/RegistrarConta"
                                                                class="linkstilo">
                                                                Cadastra AQUI!</a>
                                                        </p>

                                                    </v-card-actions>
                                                    <div class=" px-6">
                                                        <v-btn href="" rounded outlined color="deep-purple darken-3">
                                                            <a href="/" style="text-decoration: none; color: #4527A0; ">

                                                                <v-icon>mdi mdi-arrow-left-circle</v-icon>
                                                                Voltar
                                                            </a>
                                                        </v-btn>
                                                    </div>
                                                </v-card>
                                            </v-container>
                                        </v-col>
                                        <v-col cols="12" md="6" lg="7">
                                            <v-img src="/img/cms-image.jpg" :style="'height: 100vh; '" align="center"
                                                justify="center"
                                                gradient="to top right, rgba(10,115,201,.33), rgba(25,32,72,.7)">
                                                <v-container>
                                                    <v-row class="alinnharcentro white--text ">
                                                        <v-card-text>
                                                            <p class="text-h1 font-weight-bold p-0 m-0">SIG-VAI</p>
                                                            <p class="subtitle pb-5 m-0">Sistema de Gestão de Imóbiliaria
                                                                (Kubicos)
                                                            </p>
                                                            <p class="text-h5">Aumente sua receita com o nosso sistema</p>
                                                            <p>O SIG-VRIM é a plataforma de financiamento imobiliário que
                                                                <br />oferece crédito ao seu
                                                                cliente de uma maneira fácil e sem burocracia.
                                                            </p>

                                                        </v-card-text>

                                                    </v-row>

                                                </v-container>

                                            </v-img>
                                        </v-col>
                                    </v-row>
                                </v-card>
                            </v-dialog>
                        </v-row>
                    </template>
                    <v-overlay v-if="overlay">
                        <v-progress-circular indeterminate size="64"></v-progress-circular>
                    </v-overlay>


                    <template>
                        <div class="text-center">
                            <v-snackbar v-model="snackbar" :multi-line="multiLine" :timeout="4000" outlined
                                color="deep-purple accent-4">
                                {{ text }}
                                <v-btn color="indigo" text @click="snackbar = false">
                                    Close
                                </v-btn>
                            </v-snackbar>
                        </div>
                    </template>
                </v-row>
            </template>

        </v-div>
    </PortalLayout>
</template>

<script>
// import  Carousel from "../Carousel"
import PortalLayout from "../../Templates/PortalLayout";
import PortalIndex from './PortalIndex.vue';
export default {
    props: ["imoveis", 'startingImage', 'autoSlideInterval', 'showProgressBar', 'msg'],
    components: {
        PortalLayout,

    },
    data: () => ({
        rules: {
            required: (value) => !!value || "Campos obrigatório.",
        },
        selection: null,
        showPassword: false,
        isValid: true,
        overlay: false,
        rating: 4.3,
        usuario: {},
        alert: {
            text: "",
            type: ""
        },
        dialogLogin: false,

        dialogMarcarVisita: false,
        dias_data: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substring(0, 10),
        images: null,
        visitar: {
            data_visita: null,
            hora_visita: null
        },
        //Index of the active image
        activeImage: 0,
        //Hold the timeout, so we can clear it when it is needed
        autoSlideTimeout: null,
        //If the timer is stopped e.g. when hovering over the carousel
        stopSlider: false,
        //Hold the time left until changing to the next image
        timeLeft: 0,
        //Hold the interval so we can clear it when needed
        timerInterval: null,
        //Every 10ms decrease the timeLeft
        countdownInterval: 10,
        multiLine: true,
        snackbar: false,
        text: `Obrigado por fazer a marcação responderemos o mais rápido possível..`,
        vertical: true,
        slides: [
            'First',
            'Second',
            'Third',
            'Fourth',
            'Fifth',
        ],
        // dias_data:'',
        DatePickerFormat: 'dd/MM/yyyy',
        disabledDates: {
            to: new Date(Date.now() - 8640000)
        }
    }),

    mounted() {
        this.overlay = false
    },
    computed: {
        user() {
            return this.$page.props.auth.user;
        },
        currentImage() {
            this.timeLeft = this.autoSlideInterval;
            return this.images[this.activeImage].foto;
        },
        progressBar() {
            //Calculate the width of the progressbar
            return 100 - (this.timeLeft / this.autoSlideInterval) * 100;
        }
    },

    created() {
        // alert(this.dias_data)
        this.images = this.imoveis.fotos_imoveis
        //Check if startingImage prop was given and if the index is inside the images array bounds
        if (this.startingImage && this.startingImage >= 0
            && this.startingImage < this.images.length) {
            this.activeImage = this.startingImage;
        }

        //Check if autoSlideInterval prop was given and if it is a positive number
        if (this.autoSlideInterval
            && this.autoSlideInterval > this.countdownInterval) {
            //Start the timer to go to the next image
            this.startTimer(this.autoSlideInterval);
            this.timeLeft = this.autoSlideInterval;
            //Start countdown to show the progressbar
            this.startCountdown();
        }

    },

    watch: {

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

            return valorFormatado;
        },
        nextImage() {
            var active = this.activeImage + 1;
            if (active >= this.images.length) {
                active = 0;
            }
            this.activateImage(active);
        },
        // Go backwards on the images array 
        // or go at the last image
        prevImage() {
            var active = this.activeImage - 1;
            if (active < 0) {
                active = this.images.length - 1;
            }
            this.activateImage(active);
        },
        activateImage(imageIndex) {
            this.activeImage = imageIndex;
        },
        //Wait until 'interval' and go to the next image;
        startTimer(interval) {
            if (interval && interval > 0 && !this.stopSlider) {
                var self = this;
                clearTimeout(this.autoSlideTimeout);
                this.autoSlideTimeout = setTimeout(function () {
                    self.nextImage();
                    self.startTimer(self.autoSlideInterval);
                }, interval);
            }
        },
        //Stop the timer when hovering over the carousel
        stopTimer() {
            clearTimeout(this.autoSlideTimeout);
            this.stopSlider = true;
            clearInterval(this.timerInterval);
        },
        //Restart the timer(with 'timeLeft') when leaving from the carousel
        restartTimer() {
            this.stopSlider = false;
            clearInterval(this.timerInterval);
            this.startCountdown();
            this.startTimer(this.timeLeft);
        },
        //Start countdown from 'autoSlideInterval' to 0
        startCountdown() {
            if (!this.showProgressBar) return;
            var self = this;
            this.timerInterval = setInterval(function () {
                self.timeLeft -= self.countdownInterval;
                if (self.timeLeft <= 0) {
                    self.timeLeft = self.autoSlideInterval;
                }
            }, this.countdownInterval);
        },

        say() {
            this.dialogN = true
        },
        findimoveis(id) {
            window.location.href = "/portal/imovel-selecionado/" + btoa(btoa(btoa(id)));
            // alert(id);
        },
        marcarVisita() {

            this.overlay = true
            setTimeout(() => {
                this.overlay = false
                if (this.$page.props.auth.user !== null) {
                    this.dialogMarcarVisita = true;
                } else {
                    this.dialogLogin = true;
                }
            }, 3000)
        },
        setLogin() {
            //    this.$inertia.visit('/login', { data: { redirectRoute: window.location.href } });

            this.$inertia.post("/login", this.usuario, {
                onFinish: () => {
                    if (this.$page.props.flash.success != null) {
                        Vue.toasted.global.defaultSuccess({
                            msg:
                                "" + this.$page.props.flash.success,
                        });
                        // this.snackbar = true
                        // if (this.$page.props.auth.user !== null) {
                        // this.dialogMarcarVisita = true;
                        // }
                    }
                    if (this.$page.props.flash.error != null) {
                        Vue.toasted.global.defaultError({
                            msg: "" + this.$page.props.flash.error,
                        });
                    }
                    //             if (this.$page.props.auth.user !== null) {
                    //         this.dialogMarcarVisita = true;
                    //         // this.closeSave();
                    //    }
                    this.overlay = true
                    this.dialogLogin = false;
                    setTimeout(() => {
                        if (this.$page.props.auth.user !== null) {
                            this.dialogMarcarVisita = true;
                        }
                        this.overlay = false
                    }, 2000)
                },
            });

        },
        enviarSolicitacao() {

            this.visitar.imoveis_id = this.imoveis.id,
                // alert(this.imoveis.actividade_imoveis[0].id )
                this.visitar.actividade_imoveis_id = this.imoveis.actividade_imoveis[0].id
            // this.visitar.actividade_imoveis_id=this.imovel.actividade_imoveis[0].operacao_imoveis.i
            // :href="`/portal/Solicitar-visita/${this.imovel.id}` "
            // window.location.href = "/portal/Solicitar-visita/"+this.visitar;
            this.$inertia.post("/portal/solicitar-visita/", this.visitar, {
                onFinish: () => {
                    if (this.$page.props.flash.success != null) {
                        this.snackbar = true
                        this.dialogMarcarVisita = false;
                    }
                    if (this.$page.props.flash.error != null) {
                        Vue.toasted.global.defaultError({
                            msg: "" + this.$page.props.flash.error,
                        });
                    }

                },
            });

            // window.location.href = "/portal/Solicitar-visita/" + btoa(btoa(btoa(this.imovel.id)));
            // alert(this.imovel.id);
        },

        getdados() {
            axios
                .get("/imoveis/filtrar-imoveis", {
                    params: this.query,
                })
                .then((response) => {
                    this.dadostickets = response.data.ticket.data;
                    this.mensagem_lida = response.data.ticket.resposta_count;
                    this.empresas = response.data.empresas;
                    // this.resposta_nao = response.data.resposta_nao;
                    this.funcionario_tecnicos =
                        response.data.tecnicos_projectos;
                    this.funcionario_operadores =
                        response.data.funcionario_operadores;
                    this.modulos_projectos = response.data.modulos_projectos;
                    this.last_page = response.data.ticket.last_page;
                    this.totalTicket = response.data.ticket.total;
                })
                .catch((error) => {
                    //toastr.warning('Houve uma falha ao carregar os dados!...');
                });
        },
    },
};
</script>

<style scoped>
.custom-autocomplete .v-input__control {
    background-color: #ff0000;
    /* Substitua pelo código de cor desejado */
    color: #ffffff;
    /* Substitua pelo código de cor desejado */
}

.card-carousel {
    margin-top: 0.2%;
    user-select: none;
    position: relative;
}

.progressbar {
    display: block;
    width: 100%;
    height: 5px;
    position: absolute;
    background-color: rgba(221, 221, 221, 0.25);
    z-index: 1;
}

.progressbar>div {
    background-color: rgba(255, 255, 255, 0.52);
    height: 100%;
}

.thumbnails {
    display: flex;
    justify-content: center;
    flex-direction: row;
}

.thumbnail-image {
    display: flex;
    align-items: center;
    cursor: pointer;
    padding: 5px;
}

.thumbnail-image>img {
    width: 100%;
    height: 10rem;
    transition: all 250ms;
}

.thumbnail-image:hover>img,
.thumbnail-image.active>img {
    opacity: 0.6;
    box-shadow: 2px 2px 6px 1px rgba(0, 0, 0, 0.5);
}

.card-img {
    /* position: relative;
    margin-bottom: 1px; */
    width: auto;
}

.card-img>img {
    display: block;
    margin: auto;
    height: 60vh;
}

.actions {
    font-size: 1.5em;
    height: 40px;
    position: absolute;
    top: 50%;
    margin-top: -20px;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    color: #423397;
}

.actions>span {
    cursor: pointer;
    transition: all 250ms;
    font-size: 45px;
}

.actions>span.prev {
    margin-left: 5px;
}

.actions>span.next {
    margin-right: 5px;
}

.actions>span:hover {
    color: #eee;
}</style>
