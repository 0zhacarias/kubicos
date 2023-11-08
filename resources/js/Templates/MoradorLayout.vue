<template>
  <v-app>
    
   <div>
    <v-app-bar
      color="blue accent-4"
      dense
      dark
    >
      <v-app-bar-nav-icon></v-app-bar-nav-icon>

      <v-toolbar-title>MUTUE CONDOMÍNIOS</v-toolbar-title>

      <v-spacer></v-spacer>


      <v-btn icon>
        <v-icon>mdi-magnify</v-icon>
      </v-btn>

      <v-menu
        left
        bottom
      >
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            icon
            v-bind="attrs"
            v-on="on"
          >
            <v-icon>mdi-dots-vertical</v-icon>
          </v-btn>
        </template>

        <v-list>
          <v-list-item
            v-for="n in 5"
            :key="n"
            @click="() => {}"
          >
            <v-list-item-title>Option {{ n }}</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-app-bar>
    </div>


    <v-main id="#scrolling-techniques-3">
      <!-- Provides the application the proper gutter -->
      <v-container>
        <!-- <v-overlay :value="overlay">
          <v-img src="/img/loader4.gif"></v-img>
        </v-overlay> -->
        <slot />
      </v-container>
    </v-main>
  </v-app>
</template>
<script>
import { defineComponent } from '@vue/composition-api'
// import { required, digits, email, max, regex } from 'vee-validate/dist/rules'
// import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate'
export default defineComponent({
  setup() {
    
  },
})
</script>


<style>
@import "vuetify/dist/vuetify.min.css";
</style>