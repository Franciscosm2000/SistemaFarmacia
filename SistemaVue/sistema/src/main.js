import '@babel/polyfill'
import Vue from 'vue'
import './plugins/vuetify'
import App from './App.vue'
import router from './router'
import store from './store'
import axios from 'axios'
import VueBarcode from 'vue-barcode';
import 'material-design-icons-iconfont/dist/material-design-icons.css' ;

Vue.config.productionTip = false
axios.defaults.baseURL='http://localhost:63038/'
new Vue({
  router,
  store,
  'barcode': VueBarcode,
   iconfont: 'md',
  render: h => h(App)
}).$mount('#app')
