<template>
  <div>
    <h1>ロック状態を確認する</h1>
    <div>
      <p>
        サイコロの目
        <span style="margin-left: 20px;">{{ diceRoll }}</span>
        最終更新日時
        <span style="margin-left: 20px;">{{ diceLastUpdate }}</span>
      </p>
    </div>
    <div>
      <button v-on:click="updateDiceRoll" class="btn primary">更新をする</button>
    </div>
  </div>
</template>

<script>
import Vue from 'vue/dist/vue.esm';
import axios from 'axios/dist/axios';
import VueAxios from 'vue-axios/dist/vue-axios.es5';
import { format, parse } from 'date-fns';

Vue.use(VueAxios, axios);

const shootDiceApiUrl = '/api/shoot_dice';

export default {
  name: 'api',
  data() {
    return {
      seconds: 10,
      isLoading: false,
      diceRoll: '',
      diceLastUpdate: '',
    }
  },
  methods: {
    getDiceRoll: function() {
      Vue.axios.get(shootDiceApiUrl).then((response) => {
        this.diceRoll = response.data.dice_log.roll;
        this.diceLastUpdate = format(parse(response.data.dice_log.updated_at), 'YYYY-MM-DD HH:mm:ss');
      })
    },
    updateDiceRoll: function() {
      let token = document.getElementsByName('csrf-token')[0].getAttribute('content');
      axios.defaults.headers.common["X-CSRF-Token"] = token;
      Vue.axios.post(shootDiceApiUrl).then((response) => {
        this.diceRoll = response.data.dice_log.roll;
        this.diceLastUpdate = format(parse(response.data.dice_log.updated_at), 'YYYY-MM-DD HH:mm:ss');
      })
    },
  },
  beforeMount() {
    this.getDiceRoll();
  }
}
</script>