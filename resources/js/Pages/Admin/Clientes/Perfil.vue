<template>

    <!-- <v-app> -->
        <Cliente>
            <v-container v-if="editarform" class="w-75 justify-space-around">
                <v-subheader class="text-h5 text-bold mt-10 ">Meus Dados</v-subheader>
                <validation-observer ref="observer" v-slot="{ invalid }">
                    <form @submit.prevent="submit">
                        <v-row class="m-2">
                            <v-col cols="12">

                                <validation-provider v-slot="{ errors }" name="Name" rules="required|max:25">
                                    <v-text-field dense v-model="pessoa.nome" outlined :counter="10" :error-messages="errors"
                                        label="Nome Completo" required></v-text-field>
                                </validation-provider>
                            </v-col>
                            
                            <v-col cols="6"> <validation-provider v-slot="{ errors }" name="email" rules="required|email">
                                    <v-text-field :disabled="!pessoa.email==null" dense v-model="pessoa.email" outlined :error-messages="errors" label="E-mail"
                                        required></v-text-field>
                                </validation-provider>
                            </v-col>
                            <v-col cols="6"> <validation-provider v-slot="{ errors }" name="numeroelefone" :rules="{
                                required: true,
                                digits: 9,
                                regex: '^(9)\\d{8}$'
                            }">
                                    <v-text-field dense v-model="pessoa.numero_telefone" outlined :counter="9" :error-messages="errors"
                                        label="Numero do telefone" required></v-text-field>
                                </validation-provider></v-col>
                                <v-col cols="6"> <validation-provider v-slot="{ errors }" name="provincia" rules="required">
                                    <v-autocomplete outlined dense :error-messages="errors"
                                                                label="Provincia*" v-model="pessoa.provincia_id
                                                                    " :items="provincias" item-text="designacao"
                                                           
                                                                item-value="id" item-color="red" data-vv-name="provincia" required ></v-autocomplete>
                                </validation-provider>
                  
                            </v-col>
                            <v-col cols="6">
                                    <v-text-field dense v-model="pessoa.numero_identificacao" outlined :error-messages="errors" label="Bilhete de identidade"
                               
                                    :rules="biRules"
                                    >
                                        
                                    </v-text-field>
                            </v-col>
                           
                            <v-col cols="12"><v-divider></v-divider>
                                Dados Profissionais 
                                <v-divider></v-divider></v-col>
                            
                            <v-col v-if="pessoa.usuario.tipo_user_id!=5 || pessoa.usuario.tipo_user_id==6 || pessoa.usuario.tipo_user_id==1" :cols="associado==true? 2:6"> 
                                <validation-provider v-slot="{ errors }" name="tipousuario" rules="required">
                                <v-select dense v-model="pessoa.usuario.tipo_user_id" outlined  @change="escolherTipoCorretor()" :items="tipoUsuario" :error-messages="errors"
                                       item-value="id" item-text="designacao" label="Tipo de usuário" data-vv-name="Tipo de usuário" required></v-select>
                                </validation-provider>
                            </v-col>
                            <v-col :cols="associado==true? 2:3" v-if="associado==true"> <validation-provider v-slot="{ errors }" name="codigocorretor" rules="required|codigocorretor">
                                    <v-text-field  dense v-model="pessoa.codigo_profissional" outlined :error-messages="errors" label="Código do corretor"
                                        required></v-text-field>
                                </validation-provider>
                            </v-col>

                            <v-col cols="4" v-if="associado==true"> <validation-provider v-slot="{ errors }" name="nomeImobiliaria" rules="required|nomeImobiliaria">
                                <v-select dense v-model="pessoa.imobiliaria_id" outlined :items="items" :error-messages="errors"
                                        label="Nome da Imóbiliaria" data-vv-name="Nome da Imóbiliaria" required></v-select>
                                </validation-provider>
                            </v-col>

                            <v-col v-if="pessoa.usuario.tipo_user_id==3 || pessoa.usuario.tipo_user_id==4" :cols="associado==true? 4:6"> <validation-provider v-slot="{ errors }" name="placa" rules="required">
                                    <v-select dense v-model="pessoa.zona_actuacao" :items="placa" outlined :error-messages="errors" label="Zona de actuaçao"
                                        required></v-select>
                                </validation-provider>
                            </v-col>
                            <v-col cols="12"> <v-btn class="mr-4 justify-end" type="submit" :disabled="invalid">
                                    Atulizar
                                </v-btn>
                                <v-btn @click="clear">
                                    limpar
                                </v-btn></v-col>




                        </v-row>
                    </form>
                </validation-observer>
            </v-container>
    </Cliente>
    <!-- </v-app> -->
</template>

<script>
import Cliente from "../Clientes/Cliente";
// import { extend,setInteractionMode } from 'vee-validate';
import { required, digits, email, max, regex } from 'vee-validate/dist/rules'
import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate'
setInteractionMode('eager')

extend('digits', {
    ...digits,
    message: '{_field_} precisa de  {length} digitos ({_value_})',
})

extend('required', {
    ...required,
    message: 'O campo não pode estar vazio',
})

extend('max', {
    ...max,
    message: '{_field_} may not be greater than {length} characters',
})

extend('regex', {
    ...regex,
    message: '{_field_} {_value_} Não compre com as restrições',
})

extend('email', {
    ...email,
    message: 'Email invalido',
})



export default {
    props: ["cliente",'pessoa', 'provincias','startingImage', 'autoSlideInterval', 'showProgressBar', 'msg','tipoUsuario'],
    components: {
        Cliente,
        ValidationProvider,
        ValidationObserver,
    },
    data: () => ({
        name: '',
        phoneNumber: '',
        email: '',
        select: null,
        tipoCorretor: [
            'Proprietario',
            'Corrector',
            'Pambaleiro',
            'Cliente',
        ],
        checkbox: null,
        editarform:true,
        associado:false,
        biRules: [(v) =>  /^\d{9}[A-Z]{2}\d{3}$/.test(v) || "Nao corresponde com o padrao do BI"],
        placa: ['Rangel', 'Benfica', 'Cazenga', 'BO',
         'Marçal', 'Vila-lice', 'Nova Urbanização de Cacuado', 
         'Maianga', 'Rangel', 'Benfica', 'Cazenga', 'BO',
         'Cassenda', 'Benfica', 'Cazenga', 'Outros',],
    }),
    computed: {
    user() {
      return this.$page.props.auth.user;
    },
  },
    methods: {
        submit() {
            this.$refs.observer.validate()
            axios.post("/clientes/atualizar-perfil",this.pessoa, 
            )
            .then((response) => {
                    this.loading = false;
                     alert(JSON.stringify("Dados atualizado com sucesso."));
                })
                
                .catch(() => {
                    alert(JSON.stringify(response.data));

                    //   console.log('Falha ao registar os dados na base de dados!...')
                });
            // alert(JSON.stringify(this.pessoa))
            window.location.reload()
            this.clear();
        },
        escolherTipoCorretor(){
if(this.pessoa.usuario.tipo_user_id==5){
    this.associado=true
     //alert(this.pessoa.usuario.tipo_user_id=='Associado');
}else{

    this.associado=false         
}
        },
        clear() {
            this.name = ''
            this.phoneNumber = ''
            this.email = ''
            this.select = null
            this.checkbox = null
            this.$refs.observer.reset()
        },
    },
}
</script>
<style>

/* @import "vuetify/dist/vuetify.min.css"; */
</style>