<template>
  <div class="request">
    <template v-for="(request, index) in requests">
      <div class="panel" :key="index">
        <div class="main">
          <div class="request">
            <b-icon
                pack="fas"
                :icon="request.config.icon"
                size="is-medium">
            </b-icon>
            <div class="content">
              <h2 class="title">{{request.config.title}}</h2>
              <div class="info">
                <p>{{request.config.message}}</p>
                <div class="hasAccept">
                  <b-tag type="is-success">Y</b-tag>
                  <!-- <b-tag type="is-danger" size="is-small">U</b-tag> -->
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
export default {
  name: 'service-request',
  props: {
    requests: {
      type: Array,
      required: true,
    },
  },
};
</script>

<style lang="scss">
/* Want nice animations? Check out https://github.com/asika32764/vue2-animate */
/* @import 'https://unpkg.com/vue2-animate/dist/vue2-animate.min.css'; */
  .panel {
    color: #fff;
    width: 25vw;
    min-width: 20vw;
    transform: perspective(1000px) rotateY(-10deg);
    box-sizing: border-box;
    margin: 2rem 3rem;
    
    .main {
      background: rgba($color: #000000, $alpha: 0.5);
      border-bottom-left-radius: 10px;
      border-bottom-right-radius: 10px;
      border-top-left-radius: 10px;
      border-top-right-radius: 10px;
      min-height: 10vh;
      display: flex;
    }

    .request {
       display: flex;
       flex-direction: row;
       align-items: center;
       align-content: center;
       min-height: 100%;
       width: 100%;
       .icon {
         padding: 0 2rem;
       }
      .content {
        width: 100%;
        display: flex;
        flex-direction: column;
        align-content: center;
        padding: 1rem 0;
        .title {
          font-size: 1rem;
          color: #fff;
          margin-bottom:0;
        }
        .info {
          display: flex;
          flex-direction: row;
          justify-content: space-between;
          .hasAccept {
            display: flex;
            flex-direction: row;
            justify-content: flex-end;
            margin-right: 1rem;
            .tag{
              max-width: 2rem;
              &:first-child {
                margin-right: 0.76rem;
              }
            }
          }
        }
        
      }
    }
   
}

</style>
