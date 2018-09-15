<template>
  <div>
    <h1>Lists (locking)</h1>
    <div>
      <h2>status</h2>
      <p>lock status: {{ lockingStatus }}</p>
      <p>get user comments: {{ getUserCommentStatus }}</p>
    </div>
    <div>
      <input v-model="seconds" placeholder="seconds(integer)" size="3"/>seconds
      <button class="btn" v-on:click="getUserComments(seconds)">Get User Comments</button>
      <button class="btn" v-on:click="updateUserComment(seconds)">Random update!</button>
    </div>
    <hr/>
    <div v-if="lists.length === 0">
      loading...
    </div>
    <div v-if="lists.length > 0">
      <table class="pure-table">
        <thead>
          <tr>
            <th>name</th>
            <th>email</th>
            <th>comment</th>
            <th>updated_at</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="list in lists" v-bind:key="list.name">
            <td>{{ list.name }}</td>
            <td>{{ list.email }}</td>
            <td>{{ list.comment }}</td>
            <td>{{ list.updated_at }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import Vue from 'vue/dist/vue.esm';
import axios from 'axios/dist/axios';
import VueAxios from 'vue-axios/dist/vue-axios.es5';

Vue.use(VueAxios, axios);

const lockingApiUrl = '/api/locking_in_transaction';
const apiUrl = '/api/get_user_comment';

export default {
  name: 'api',
  data() {
    return {
      lockingStatus: 'not locking',
      getUserCommentStatus: 'empty',
      lists: [],
      seconds: 10,
      isLoading: false
    }
  },
  methods: {
    updateUserComment: function(seconds=0) {
      this.lockingStatus = 'record locking!';
      Vue.axios.get(`${lockingApiUrl}?sleep_seconds=${seconds}`).then((response) => {
        this.lockingStatus = 'done';
      });
    },
    getUserComments: function(seconds=0) {
      this.lists = [];
      this.getUserCommentStatus = 'get user comments';
      Vue.axios.get(apiUrl).then((response) => {
        this.lists = response.data.lists;
        this.getUserCommentStatus = 'done';
      });
    }
  },
  beforeMount() {
    this.getUserComments(0);
  }
}
</script>