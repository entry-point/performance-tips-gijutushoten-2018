<template>
  <div>
    <div class="loading" v-if="isLoading"></div>
    <h1>N+1を試す</h1>
    <div>
      <p>検索時間(秒) {{ searchTimeSeconds }} </p>
      <input type="checkbox" id="enable_n_plus_one" v-model="enableNPlusOne">
      <label for="enable_n_plus_one">N+1を利用する</label>
    </div>
    <div>
      <p>SQLを呼び出した数 = {{ sqlCallCount }}</p>
    </div>
    <div v-if="usersComments.length === 0">
      読み出し中
    </div>
    <div v-if="usersComments.length > 0">
      <div class="paginate-container">
        <paginate
          v-model="page"
          :pageCount="usersComments.length"
          :pageRange="3"
          :marginPages="2"
          :clickHandler="getUserInformation"
          :prevText="'Prev'"
          :nextText="'Next'"
          :containerClass="'pagination'"
          :pageClass="'page-item'">
        </paginate>
      </div>
      <table>
        <thead>
          <tr>
            <th>id</th>
            <th>名前</th>
            <th>コメント</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="uc in usersComments" :key="uc.id">
            <td>{{ uc.id }}</td>
            <td>{{ uc.name }}</td>
            <td>{{ uc.comment }}</td>
          </tr>
        </tbody>
      </table>
      <div class="paginate-container">
        <paginate
          v-model="page"
          :pageCount="usersComments.length"
          :pageRange="3"
          :marginPages="2"
          :clickHandler="getUserInformation"
          :prevText="'Prev'"
          :nextText="'Next'"
          :containerClass="'pagination'"
          :pageClass="'page-item'">
        </paginate>
      </div>
    </div>
  </div>
</template>

<script>
import Vue from 'vue/dist/vue.esm';
import axios from 'axios/dist/axios';
import VueAxios from 'vue-axios/dist/vue-axios.es5';
import Paginate from 'vuejs-paginate';
import Loading from 'vue-loading-overlay';
import 'vue-loading-overlay/dist/vue-loading.min.css';

Vue.use(VueAxios, axios);
Vue.component('paginate', Paginate)

const nPlusOneApi = '/api/n_plus_one';

export default {
  name: 'api',
  data: function() {
    return {
      page: 0,
      enableNPlusOne: false,
      usersComments: [],
      searchTimeSeconds: 0,
      sqlCallCount: 0,
      isLoading: false,
      fullPage: true
    }
  },
  components: {
    Loading
  },
  methods: {
    getUserInformation: function(page=1) {
      this.isLoading = true;
      Vue.axios.get(`${nPlusOneApi}?page=${page}&enable_n_plus_one=${
        this.enableNPlusOne ? 1 : 0
      }`).then((response) => {
        this.isLoading = false;
        this.usersComments = response.data.users_comments;
        this.searchTimeSeconds = response.data.search_time_seconds;
        this.sqlCallCount = response.data.sql_call_count;
      });
    }
  },
  beforeMount() {
    this.getUserInformation();
  }
}
</script>

<style lang="scss">
.pagination {
  display: inline-block;
  list-style-type: none;
  width: 100%;

  ul {
    list-style-type: none;
    float: left; 
  }
  li { display: inline; }
  a {
    float: left;
    padding: 8px 16px;
    text-decoration: none;
  }
}

// https://codepen.io/MattIn4D/pen/LiKFC
/* Absolute Center Spinner */
.loading {
  position: fixed;
  z-index: 999;
  height: 2em;
  width: 2em;
  overflow: show;
  margin: auto;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
}

/* Transparent Overlay */
.loading:before {
  content: '';
  display: block;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0,0,0,0.3);
}

/* :not(:required) hides these rules from IE9 and below */
.loading:not(:required) {
  /* hide "loading..." text */
  font: 0/0 a;
  color: transparent;
  text-shadow: none;
  background-color: transparent;
  border: 0;
}

.loading:not(:required):after {
  content: '';
  display: block;
  font-size: 10px;
  width: 1em;
  height: 1em;
  margin-top: -0.5em;
  -webkit-animation: spinner 1500ms infinite linear;
  -moz-animation: spinner 1500ms infinite linear;
  -ms-animation: spinner 1500ms infinite linear;
  -o-animation: spinner 1500ms infinite linear;
  animation: spinner 1500ms infinite linear;
  border-radius: 0.5em;
  -webkit-box-shadow: rgba(0, 0, 0, 0.75) 1.5em 0 0 0, rgba(0, 0, 0, 0.75) 1.1em 1.1em 0 0, rgba(0, 0, 0, 0.75) 0 1.5em 0 0, rgba(0, 0, 0, 0.75) -1.1em 1.1em 0 0, rgba(0, 0, 0, 0.5) -1.5em 0 0 0, rgba(0, 0, 0, 0.5) -1.1em -1.1em 0 0, rgba(0, 0, 0, 0.75) 0 -1.5em 0 0, rgba(0, 0, 0, 0.75) 1.1em -1.1em 0 0;
  box-shadow: rgba(0, 0, 0, 0.75) 1.5em 0 0 0, rgba(0, 0, 0, 0.75) 1.1em 1.1em 0 0, rgba(0, 0, 0, 0.75) 0 1.5em 0 0, rgba(0, 0, 0, 0.75) -1.1em 1.1em 0 0, rgba(0, 0, 0, 0.75) -1.5em 0 0 0, rgba(0, 0, 0, 0.75) -1.1em -1.1em 0 0, rgba(0, 0, 0, 0.75) 0 -1.5em 0 0, rgba(0, 0, 0, 0.75) 1.1em -1.1em 0 0;
}

/* Animation */

@-webkit-keyframes spinner {
  0% {
    -webkit-transform: rotate(0deg);
    -moz-transform: rotate(0deg);
    -ms-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@-moz-keyframes spinner {
  0% {
    -webkit-transform: rotate(0deg);
    -moz-transform: rotate(0deg);
    -ms-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@-o-keyframes spinner {
  0% {
    -webkit-transform: rotate(0deg);
    -moz-transform: rotate(0deg);
    -ms-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@keyframes spinner {
  0% {
    -webkit-transform: rotate(0deg);
    -moz-transform: rotate(0deg);
    -ms-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>