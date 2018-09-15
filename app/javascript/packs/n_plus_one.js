import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router/dist/vue-router.esm';

Vue.use(VueRouter);

import Index from './n_plus_one/index.vue';

const routes = [
  { path: '', component: Index },
  { path: '/', component: Index },
  { path: '*', redirect: '/'}
];

const router = new VueRouter({
  routes
});

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
  }).$mount('#app');
});
