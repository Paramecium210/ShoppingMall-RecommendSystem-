<template>
  <div class="container">
    <div style="width: 400px; padding: 30px; background-color: white; border-radius: 10px;">
      <div style="text-align: center; font-size: 20px; margin-bottom: 20px; color: #333">Welcome to Shopping Mall!</div>
      <el-form :model="form" :rules="rules" ref="formRef">
        <el-form-item prop="username">
          <el-input prefix-icon="el-icon-user" placeholder="Enter your account" v-model="form.username"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input prefix-icon="el-icon-lock" placeholder="Enter your password" show-password  v-model="form.password"></el-input>
        </el-form-item>
        <el-form-item>
          <el-select v-model="form.role" placeholder="Choose your role" style="width: 340px" >
            <el-option label="ADMIN" value="ADMIN"></el-option>
            <el-option label="BUSINESS" value="BUSINESS"></el-option>
            <el-option label="USER" value="USER"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button style="width: 100%; background-color: rgb(175,57,57); border-color: rgb(175,57,57); font-weight: bold; font-size: 20px; color: white" @click="login">Login</el-button>
        </el-form-item>
        <div style="display: flex; align-items: center">
         <div style="flex: 1"></div>
          <div style="flex: 5; text-align: right">
            Don't have an account?<a href="/register"> register here.</a>
         </div>
       </div>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  name: "Login",
  data() {
    return {
      form: { },
      rules: {
        username: [{ required: true, message: 'Enter your account', trigger: 'blur' },],
        password: [{ required: true, message: 'Enter your password', trigger: 'blur' },],
        role: [{ required: true, message: 'Choose your role', trigger: 'blur' },],
      }
    }
  },
  created() {

  },
  methods: {
    login() {
      this.$refs['formRef'].validate((valid) => {
        if (valid) {
          // 验证通过
          this.$request.post('/login', this.form).then(res => {
            if (res.code === '200') {
              let user = res.data
              localStorage.setItem("xm-user", JSON.stringify(user))  // 存储用户数据
              if (user.role === 'USER'){
                location.href = '/front/home'
              } else {
                location.href = '/home'
              }
              this.$message.success('Success')
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    }
  }
}
</script>

<style scoped>
.container {
  height: 100vh;
  overflow: hidden;
  background-image: url("@/assets/imgs/bg.png");
  background-size: cover;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666;
}
a {
  color: #2a60c9;
}
</style>