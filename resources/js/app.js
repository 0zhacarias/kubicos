require('./bootstrap');
window.Vue = require('vue');

import vuetify from './vuetify';
import axios from 'axios';
import VueAxios from 'vue-axios';
import numeral from 'numeral';
import './config/msg';
// import numFormat from 'vue-filter-number-format';


import { format, formatDistance } from "date-fns";
import { pt } from "date-fns/locale";
import { App, plugin } from '@inertiajs/inertia-vue';
// import VueHtmlToPaper from 'vue-html-to-paper'
import Vue from 'vue'

// import { TiptapVuetifyPlugin } from 'tiptap-vuetify'
// don't forget to import CSS styles
// import 'tiptap-vuetify/dist/main.css'

import { createInertiaApp, Link } from '@inertiajs/inertia-vue';
// import { ValidationProvider } from 'vee-validate';
// import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate'
// Vue.component('ValidationProvider', ValidationProvider,'extend',extend,'ValidationObserver',ValidationObserver,'setInteractionMode',setInteractionMode );

// import VueSweetalert2 from 'vue-sweetalert2';
// import Swal from "sweetalert2/dist/sweetalert2.js";

// If you don't need the styles, do not connect
// import 'sweetalert2/dist/sweetalert2.min.css'
// than add in app.js this line
Vue.component("inertia-link", Link)
// Vue.use(TiptapVuetifyPlugin, {
//     // the next line is important! You need to provide the Vuetify Object to this place.
//     vuetify, // same as "vuetify: vuetify"
//     // optional, default to 'md' (default vuetify icons before v2.0.0)
//     iconsGroup: 'md'
// })
// Vue.use(VueSweetalert2);

// const Toast = Swal.mixin({
//     toast: true,
//     position: "top-end",
//     timer: 5000,
//     timerProgressBar: true,
//     showConfirmButton: false
// });

// Vue.filter('changeColor', value => {
//     let color = "gray";
//     switch (value) {
//         case "Pendente":
//             color = "orange";
//             break;

//         case "Cancelado":
//             color = "red";
//             break;
//         case "Aprovado":
//             color = "green";
//             break;
//         case "Iniciado":
//             color = "green";
//             break;
//         case "Rejeitado":
//             color = "red";
//             break;
//         case "Espera":
//             color = "orange";
//             break;
//         case "Concluido":
//             color = "green";
//             break;
//         case "Incompleto":
//             color = "orange"
//             break;
//         case "Actualizado":
//             color = "green";
//             break;
//         case "Desactualizado":
//             color = "orange";
//             break;
//         case "Sem Contrato":
//             color = "red";
//             break;
//         case "Validado":
//             color = "green";
//             break;



//     }
//     return color;

// });
// Vue.filter('formatInterval', (data_start, data_end) => {
//     return formatDistance(new Date(data_start), new Date(data_end), {
//         locale: pt
//     });
// });
// Vue.filter('formatDate', value => {
//     return format(new Date(value), "dd-LLLL-yyyy", {
//         locale: pt
//     });
// });


Vue.use(plugin)
// Vue.filter('numFormat', numFormat(numeral));



// const el = document.getElementById('app')
// Vue.use(VueAxios, axios, VueHtmlToPaper);


// new Vue({
//     vuetify,
//     render: h => h(App, {
//         props: {
//             initialPage: JSON.parse(el.dataset.page),
//             resolveComponent: name => require(`./Pages/${name}`).default,
//         },
//     }),
// }).$mount(el)

createInertiaApp({
    resolve: name => require(`./Pages/${name}`),
    setup({ el, App, props, plugin }) {
      Vue.use(plugin)

      new Vue({
        vuetify,
        render: h => h(App, props),
      }).$mount(el)
    },
})




// require('./bootstrap');

// window.Vue = require('vue').default;

// import Vue from 'vue'
// import vuetify from './vuetify' // path to vuetify export
// import { createInertiaApp } from '@inertiajs/inertia-vue'
// import { App, plugin } from '@inertiajs/inertia-vue';


// createInertiaApp({
//   resolve: name => require(`./Pages/${name}`),
//   setup({ el, App, props, plugin }) {
//     Vue.use(plugin)

//     new Vue({
//       vuetify,
//       render: h => h(App, props),
//     }).$mount(el)
//   },
// })
