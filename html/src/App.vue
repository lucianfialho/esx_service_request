<template>
  <div id="app">
    <service-request :requests="requests" />
  </div>
</template>

<script>
import ServiceRequest from './components/ServiceRequest';
// import Nui from './utils/Nui';

export default {
  name: 'app',
  components: {
    ServiceRequest,
  },
  data() {
    return {
      requests: []
    };
  },
  destroyed() {
    window.removeEventListener('message', this.listener);
  },
  mounted() {
    this.listener = window.addEventListener(
      'message',
      event => {
        const item = event.data || event.detail;
        
        if (item.type && item.type === 'request') {
          this.requests.push(item.request)
          
          setTimeout(() => {
            this.requests.shift()
          }, 10000);          
        }

        if (item.type && item.type === 'remove') {
          this.requests.shift()
        }
      },
      false,
    );
  },
  methods: {},
};
</script>

<style lang="scss">
/* Want nice animations? Check out https://github.com/asika32764/vue2-animate */
/* @import 'https://unpkg.com/vue2-animate/dist/vue2-animate.min.css'; */
html {
  background: transparent;
  overflow-y: hidden;
  
}

#app {
  display: flex;
  justify-content: flex-end;
}
</style>
