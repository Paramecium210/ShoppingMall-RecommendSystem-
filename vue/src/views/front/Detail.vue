<template>
  <div class="main-content">
    <div style="width: 60%; background-color: white;height: 1000px; margin: 20px auto; border-radius: 15px;">
      <div style="padding: 15px 20px">
        <el-row :gutter="20">
          <el-col :span="12">
            <img :src="goodsData.img" alt="" style="width: 100%; height: 400px; border-radius: 20px"  >
          </el-col>
          <el-col :span="12">
            <div style="font-size: 40px; font-weight: 900; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical">{{goodsData.name}}</div>
            <div style="color: #666666FF; margin-top: 5px">Count: {{goodsData.count}}</div>
            <div style="color: red; margin-top: 15px">Price: <span style="font-size: 20px">{{goodsData.price}} / {{goodsData.unit}}</span></div>
            <div style="margin-top: 20px">
              <img src="@/assets/imgs/ad.png" style="width: 65%; height: 150px">
            </div>
            <div style="color: #666666FF;margin-top: 20px">Merchant: {{goodsData.businessName}}</div>
            <div style="color: #666666FF;margin-top: 20px">Type:<a href="#" @click="navTo('/front/type?id=' + goodsData.typeId)"> {{goodsData.typeName}}</a></div>
            <div style="margin-top: 15px">
              <el-button type="warning" @click="addCart">Add to Cart</el-button>
              <el-button type="warning" @click="collect">Collect</el-button>
            </div>
          </el-col>
        </el-row>
      </div>
      <div style="padding: 15px 15px; font-size: 30px; font-weight: 400">
        <el-tabs v-model="activeName" >
          <el-tab-pane label="Comment" name="first">
            <div style="margin-top: 10px">
              <div style="margin-top: 20px" v-for="item in commentData">
                <div style="display: flex">
                  <div style="width: 40px">
                    <img :src="item.userAvatar" alt="" style="height: 40px; width: 40px; border-radius: 50%">
                  </div>
                  <div style="width: 200px; margin-left: 10px">
                    <div style="font-weight: 700; font-size: 20px; color: #000000FF">{{item.userName}}</div>
                    <div style="font-size:15px;color: #7A7A7AFF">{{item.time}}</div>
                  </div>
                </div>
                <div style="margin-top: 15px;font-size: 16px">{{ item.content }}</div>
              </div>
            </div>
          </el-tab-pane>
        </el-tabs>
      </div>
    </div>
  </div>
</template>

<script>


export default {

  data() {
    let goodsId = this.$route.query.id
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      goodsId: goodsId,
      goodsData:{},
      activeName: 'first',
      commentData: []
    }
  },
  mounted() {
    this.loadGoods()
    this.loadComment()
  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    loadComment(){
      this.$request.get('/comment/selectByGoodsId?id=' + this.goodsId).then(res => {
        if (res.code === '200'){
          this.commentData = res.data

        }else {
          this.$message.error(res.msg)
        }
      })
    },
    addCart() {
      let data = {
        num: 1,
        goodsId: this.goodsId,
        userId: this.user.id,
        businessId: this.goodsData.businessId
      }
      this.$request.post('/cart/add',data).then(res => {
        if (res.code === '200'){
          this.$message.success('Success')
        }else {
          this.$message.error(res.msg)
        }
      })
    },
    collect() {
      let data = {
        userId: this.user.id,
        businessId: this.goodsData.businessId,
        goodsId: this.goodsId
      }
      this.$request.post('/collect/add',data).then(res => {
        if (res.code === '200') {
          this.$message.success('Collect successfully')
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    loadGoods() {
      this.$request.get('/goods/selectById?id=' + this.goodsId).then(res =>{
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
