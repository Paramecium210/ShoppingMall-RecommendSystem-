<template>
  <div class="manager-container">
    <!--  头部  -->
    <div class="manager-header">
      <div class="manager-header-left">
        <img src="@/assets/imgs/logo.png" style="border-radius: 30px"/>
        <div class="title">Management System</div>
      </div>

      <div class="manager-header-center">
        <el-breadcrumb separator-class="el-icon-arrow-right">
          <el-breadcrumb-item :to="{ path: '/' }">Home</el-breadcrumb-item>
          <el-breadcrumb-item :to="{ path: $route.path }">{{ $route.meta.name }}</el-breadcrumb-item>
        </el-breadcrumb>
      </div>

      <div class="manager-header-right">
        <el-dropdown placement="bottom">
          <div class="avatar">
            <img :src="user.avatar || 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'" />
            <div>{{ user.name ||  'ADMIN' }}</div>
          </div>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item @click.native="goToPerson">Personal Information</el-dropdown-item>
            <el-dropdown-item @click.native="$router.push('/password')">Modify Password</el-dropdown-item>
            <el-dropdown-item @click.native="logout">Log Out</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </div>

    <!--  主体  -->
    <div class="manager-main">
      <!--  侧边栏  -->
      <div class="manager-main-left" style="width: 240px">
        <el-menu width="500" :default-openeds="['info', 'user']" router style="border: none" :default-active="$route.path">
          <el-menu-item index="/home">
            <i class="el-icon-s-home"></i>
            <span slot="title">Home</span>
          </el-menu-item>
          <el-submenu index="info">
            <template slot="title">
              <i class="el-icon-menu"></i><span>Information Management</span>
            </template>
            <el-menu-item v-if="user.role === 'ADMIN'" index="/notice">Notice</el-menu-item>
            <el-menu-item v-if="user.role === 'ADMIN'" index="/type">Type</el-menu-item>
            <el-menu-item index="/goods">Goods</el-menu-item>
            <el-menu-item index="/orders">Orders management</el-menu-item>
            <el-menu-item index="/comment">Comment management</el-menu-item>
          </el-submenu>

          <el-submenu v-if="user.role === 'ADMIN'" index="user">
            <template slot="title">
              <i class="el-icon-menu"></i><span>Role management</span>
            </template>
            <el-menu-item index="/admin">Admin</el-menu-item>
            <el-menu-item index="/business">Business</el-menu-item>
            <el-menu-item index="/user">User</el-menu-item>
          </el-submenu>
        </el-menu>
      </div>

      <!--  数据表格  -->
      <div class="manager-main-right">
        <router-view @update:user="updateUser" />
      </div>
    </div>

  </div>
</template>

<script>
export default {
  name: "Manager",
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
    }
  },
  created() {
    if (!this.user.id) {
      this.$router.push('/login')
    }
  },
  methods: {
    updateUser() {
      this.user = JSON.parse(localStorage.getItem('xm-user') || '{}')   // 重新获取下用户的最新信息
    },
    goToPerson() {
      if (this.user.role === 'ADMIN') {
        this.$router.push('/adminPerson')
      }
      if (this.user.role === 'BUSINESS') {
        this.$router.push('/businessPerson')
      }
    },
    logout() {
      localStorage.removeItem('xm-user')
      this.$router.push('/login')
    }
  }
}
</script>

<style scoped>
@import "@/assets/css/manager.css";
</style>