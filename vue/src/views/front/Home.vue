<template>
  <div class="main-content">
      <div class="head-color" ></div>
    <div style="display: flex">
      <div class="left"></div>
      <div style="width: 66%; margin-bottom: 50px; background-color: white">
        <div style="color: #FE0137FF; font-size: 16px; font-weight: bold; margin: 15px 0 15px 18px">Market</div>
        <div style="display: flex; margin: 0 25px">
          <div style="flex: 2; margin-right: 50px">
            <el-card>
              <div style="display: flex; color: #666666FF; margin: 14px 0" v-for="item in typeDate">
                <img :src="item.img" alt="" style="height: 20px; width: 20px">
                <div style="margin-left: 10px; margin-top: 3px; font-size: 14px"><a href="#" @click="navTo('/front/type?id=' + item.id)" >{{ item.name }}</a></div>
              </div>
            </el-card>

          </div>
          <div style="flex: 5; margin-right: 50px">
            <div style="margin-top: 15px; height: 100px" class="welcome-text" >
                <transition name="fade" style="margin-top: 200px">
                <h2 v-if="showText" > Hi,{{user.name}}</h2>
                </transition>
            </div>
            <div >
              <el-carousel :interval="4000" type="card" height="400px">
                <el-carousel-item v-for="item in topData" >
                  <a href="#" @click="navTo('/front/detail?id=' + item.id)"><img :src="item.img" alt="" style="height: 400px; width: 100%; border-radius: 15px"></a>
                </el-carousel-item>
              </el-carousel>
            </div>
          </div>
        </div>
        <div style="margin: 40px 0 0 15px; height: 40px; background-color: #04BF04FF; font-size: 20px; color: white; width: 230px; font-weight: bold;line-height: 15px; text-align: center; border-radius: 20px;padding-top: 12px">Popular Products</div>
        <div style="margin: 10px 5px 0 5px">
          <el-row>
            <el-col :span="5" v-for="item in goodsData">
              <img @click="navTo('/front/detail?id=' + item.id)" :src="item.img" alt="" style="width: 100%;height: 175px;border-radius: 10px;border: #cccccc 1px solid">
              <div style="margin-top: 15px; font-weight: 500; font-size: 16px; width: 160px; color: #000000FF; text-overflow: ellipsis; overflow: hidden; white-space: nowrap">{{item.name}}</div>
              <div style="margin-top: 5px; font-size: 20px; color: #FF5000FF">￥{{item.price}}/{{item.unit}}</div>
            </el-col>
          </el-row>
        </div>
        <div style="margin: 40px 0 0 15px; height: 40px; background-color: #04BF04FF; font-size: 20px; color: white; width: 230px; font-weight: bold;line-height: 15px; text-align: center; border-radius: 20px;padding-top: 12px">Maybe you like</div>
        <div style="margin: 10px 5px 0 5px">
          <el-row>
            <el-col :span="5" v-for="item in recommendData">
              <img @click="navTo('/front/detail?id=' + item.id)" :src="item.img" alt="" style="width: 100%;height: 175px;border-radius: 10px;border: #cccccc 1px solid">
              <div style="margin-top: 15px; font-weight: 500; font-size: 16px; width: 160px; color: #000000FF; text-overflow: ellipsis; overflow: hidden; white-space: nowrap">{{item.name}}</div>
              <div style="margin-top: 5px; font-size: 20px; color: #FF5000FF">￥{{item.price}}/{{item.unit}}</div>
            </el-col>
          </el-row>
        </div>
      </div>

      <div class="right"></div>
    </div>
  </div>
</template>

<script>


export default {

  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      typeDate:[],
      goodsData: [],
      carousel_top: [
          require('@/assets/imgs/carousel_top2.jpg'),
          require('@/assets/imgs/carousel_top.jpg'),
          require('@/assets/imgs/carousel_top3.jpg'),
      ],
      showText: false,
      recommendData: [],
      topData: []
    }
  },
  mounted() {
    this.loadTop();
    this.loadType();
    this.loadGoods();
    this.loadRecommend();
    setTimeout(() => {
      this.showText = true
    },300)//延迟显示文字
  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    loadTop() {
      this.$request.get('/goods/selectTop').then( res => {
        if (res.code === '200') {
          this.topData = res.data
        }else {
          this.$message.error(res.msg)
        }
      })
    },
    loadRecommend() {
      this.$request.get('/goods/recommend').then(res => {
        if (res.code === '200'){
          this.recommendData = res.data
        }else {
          this.$message.error(res.msg)
        }
      })
    },
    loadType() {
      this.$request.get('/type/selectAll').then( res => {
        if (res.code === '200') {
          this.typeDate = res.data
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    loadGoods() {
      this.$request.get('/goods/selectTop15').then(res => {
        if (res.code === '200'){
          this.goodsData = res.data
        }else {
          this.$message.error(res.msg)
        }
      })
    },
    navTo(url) {
      location.href = url
    }
  }
}
</script>

<style scoped>
.fade-enter-active,.fade-leave-active {
  transition: opacity 3s ease;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}


.head-color{
  height: 60px;
  background-color: #C566F6FF;
}
.main-content{
  min-height: 100vh;
  background-size: 100%;
  background-image: url('@/assets/imgs/img.png');
}
.left{
  width: 17%;
  background-repeat: no-repeat;
  background-image: url('@/assets/imgs/left-img.png');
}

.right{
  width: 17%;
  background-repeat: no-repeat;
  background-image: url('@/assets/imgs/right-img.png');
}
.welcome-text {
  text-align: center;
  font-size: 40px;
  color: #8E735B;
  top: 200px;
}
.el-col-5{
  width: 20%;
  max-width: 20%;
  padding: 10px 10px;
}
</style>