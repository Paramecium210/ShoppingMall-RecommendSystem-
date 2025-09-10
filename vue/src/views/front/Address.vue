<template>
  <div class="main-content">
    <div style=" width: 70%; background-color: white;margin: 30px auto; border-radius: 20px">
      <div style="padding: 0 20px">
        <div style="display: flex; font-weight: 800;font-size: 20px; color: #000000FF; line-height: 80px; border-bottom: #cccccc 1px solid; padding-left: 35px">
          <div style="flex: 8" >My address</div>
          <div style="flex: 2;">
            <el-button type="warning" round @click="addAddress()">Add my address</el-button>
          </div>
        </div>
        <div style="margin: 20px 0; padding: 0 50px">
          <div class="table">
            <el-table :data="addressData" strip>
              <el-table-column prop="username" label="Consignee"></el-table-column>
              <el-table-column prop="useraddress" label="Shipping address"></el-table-column>
              <el-table-column prop="phone" label="Phone"></el-table-column>
              <el-table-column label="Operate" align="center" width="180">
                <template v-slot="scope">
                  <el-button size="mini" type="primary" plain @click="edit(scope.row)">Edit</el-button>
                  <el-button size="mini" type="danger" plain @click="del(scope.row.id)">Delete</el-button>
                </template>
              </el-table-column>
            </el-table>


            <div class="pagination" style="margin: 20px 0; padding-bottom: 20px">
              <el-pagination
                  background
                  @current-change="handleCurrentChange"
                  :current-page="pageNum"
                  :page-sizes="[5, 10, 20]"
                  :page-size="pageSize"
                  layout="total, prev, pager, next"
                  :total="total">
              </el-pagination>
            </div>
          </div>
        </div>
      </div>
    </div>

    <el-dialog title="My address" :visible.sync="formVisible" width="40%" :close-on-click-modal="false" destroy-on-close>
      <el-form :model="form" label-width="100px" style="padding-right: 50px" :rules="rules" ref="formRef">

        <el-form-item label="Consignee" prop="username">
          <el-input v-model="form.username" placeholder="Consignee"></el-input>
        </el-form-item>
        <el-form-item label="Address" prop="useraddress">
          <el-input v-model="form.useraddress" placeholder="Shipping address"></el-input>
        </el-form-item>
        <el-form-item label="Phone" prop="phone">
          <el-input v-model="form.phone" placeholder="Phone"></el-input>
        </el-form-item>

      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="formVisible = false">Cancel</el-button>
        <el-button type="primary" @click="save">Confirm</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>



export default {

  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      addressData: [],
      pageNum: 1,   // 当前的页码
      pageSize: 10,  // 每页显示的个数
      total: 0,
      formVisible : false,
      form: {},
      rules: {
        username: [
          {required: true, message: 'Enter your name', trigger: 'blur'},
        ],
        useraddress: [
          {required: true, message: 'Enter your address', trigger: 'blur'},
        ],
        phone: [
          {required: true, message: 'Enter your phone', trigger: 'blur'},
        ]
      },
    }
  },
  mounted() {
    this.loadAddress(1)
  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    edit (row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.formVisible = true
    },
    save() {   // 保存按钮触发的逻辑  它会触发新增或者更新
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          this.form.userId = this.user.id
          this.$request({
            url: this.form.id ? '/address/update' : '/address/add',
            method: this.form.id ? 'PUT' : 'POST',
            data: this.form
          }).then(res => {
            if (res.code === '200') {  // 表示成功保存
              this.$message.success('success')
              this.loadAddress(1)
              this.formVisible = false
            } else {
              this.$message.error(res.msg)  // 弹出错误的信息
            }
          })
        }
      })
    },
    addAddress() {
      this.form = {}
      this.formVisible = true
    },
    del (id) {
      this.$request.delete('/address/delete/' + id).then(res => {
        if (res.code === '200'){
          this.$message.success('Delete successfully')
          this.loadAddress(1)
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleCurrentChange(pageNum) {
      this.loadAddress(pageNum)
    },
    loadAddress(pageNum) {  // 分页查询
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/address/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
        }
      }).then(res => {
        if (res.code === '200'){
          this.addressData = res.data?.list
          this.total = res.data?.total
        }else {
          this.$message.error(res.msg)
        }

      })
    },
  }
}
</script>
