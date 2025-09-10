<template>
  <div>
    <!--头部-->
    <div class="front-header">
      <div class="front-header-left" >
        <img src="@/assets/imgs/logo.png" alt="" @click="navTo('/front/home')">
        <div class="title" @click="navTo('/front/home')">Shopping Mall</div>
      </div>
      <div class="front-header-center" style="text-align: right">
        <el-input style="width: 200px" placehold="Enter the GoodsName" v-model="name"></el-input>
        <el-button type="primary" style="margin-left: 5px" @click="search">Search</el-button>
      </div>
      <div class="front-header-right">
        <div v-if="!user.username">
          <el-button @click="$router.push('/login')">Log in</el-button>
          <el-button @click="$router.push('/register')">Register</el-button>
        </div>
        <div v-else>
          <el-dropdown>
            <div class="front-header-dropdown">
              <img @click="navTo('/front/person')" :src="user.avatar" alt="">
              <div style="margin-left: 10px">
                <span>{{ user.name }}</span><i class="el-icon-arrow-down" style="margin-left: 5px"></i>
              </div>
            </div>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item>
                <div style="text-decoration: none" @click="navTo('/front/collect')">Collection</div>
              </el-dropdown-item>
              <el-dropdown-item>
                <div style="text-decoration: none" @click="navTo('/front/address')">Address</div>
              </el-dropdown-item>
              <el-dropdown-item>
                <div style="text-decoration: none" @click="navTo('/front/orders')">Orders</div>
              </el-dropdown-item>
              <el-dropdown-item>
                <div style="text-decoration: none" @click="navTo('/front/cart')">Cart</div>
              </el-dropdown-item>
              <el-dropdown-item>
                <div style="text-decoration: none" @click="logout">Log out</div>
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>
    </div>
    <!--主体-->
    <div class="main-body">
      <router-view ref="child" @update:user="updateUser" />
    </div>
  </div>

</template>

<script>

export default {
  name: "FrontLayout",

  data () {
    return {
      top: '',
      notice: [],
      user: JSON.parse(localStorage.getItem("xm-user") || '{}'),
      name: null
    }
  },

  mounted() {
    this.loadNotice()
  },
  methods: {
    search() {
      let name =this.name?this.name : ''
      location.href = '/front/search?name=' + name

    },
    loadNotice() {
      this.$request.get('/notice/selectAll').then(res => {
        this.notice = res.data
        let i = 0
        if (this.notice && this.notice.length) {
          this.top = this.notice[0].content
          setInterval(() => {
            this.top = this.notice[i].content
            i++
            if (i === this.notice.length) {
              i = 0
            }
          }, 2500)
        }
      })
    },
    updateUser() {
      this.user = JSON.parse(localStorage.getItem('xm-user') || '{}')   // 重新获取下用户的最新信息
    },
    navTo(url) {
      location.href = url
    },
    // 退出登录
    logout() {
      localStorage.removeItem("xm-user");
      this.$router.push("/login");
    },
  }

}
</script>

<style scoped>
  @import "@/assets/css/front.css";
</style>