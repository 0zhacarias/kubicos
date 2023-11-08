import Vue from 'vue'
//import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import 'material-design-icons-iconfont/dist/material-design-icons.css'
import '@fortawesome/fontawesome-free/css/all.css'
import '@mdi/font/css/materialdesignicons.css'
import Vuetify from 'vuetify'


/* import Vuetify from 'vuetify/lib'; */
//import Vuetify from 'vuetify/lib'
// não se esqueça de importar estilos CSS

// Os estilos CSS do Vuetify

Vue.use(Vuetify)


export default new Vuetify({
    icons: {
        iconfont: 'md',
        iconfont: 'fa',
        iconfont: 'mdiSvg',
        iconfont: 'fa4',
        iconfont: 'mdi',
    },
    theme: {

        themes: {
            light: {
                primary: '191654', //'#2b5876',//2b5876
                secondary: '#696969',
                accent: '#8c9eff',
                error: '#b71c1c',
            },
        },
    },

//   /*   components:{
//         Icon,
//     }, */
})
