import '@babel/polyfill'
import Vue from 'vue'
import './plugins/vuetify'
import App from './App.vue'
import router from './router'
import store from './store'
import axios from 'axios'
import VueBarcode from 'vue-barcode';

Vue.config.productionTip = false
axios.defaults.baseURL='http://localhost:63038/'
new Vue({
  router,
  store,
  'barcode': VueBarcode,
  render: h => h(App)
}).$mount('#app')
