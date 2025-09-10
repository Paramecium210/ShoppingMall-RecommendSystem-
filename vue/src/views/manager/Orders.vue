<template>
  <div>
    <div class="search">
      <el-input placeholder="Enter typeID" style="width: 200px" v-model="ordersId"></el-input>
      <el-button type="info" plain style="margin-left: 10px" @click="load(1)">Search</el-button>
      <el-button type="warning" plain style="margin-left: 10px" @click="reset">Reset</el-button>
    </div>

    <div class="operation">
      <el-button type="danger" plain @click="delBatch">Batch delete</el-button>
    </div>

    <div class="table">
      <el-table :data="tableData" stripe  @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center"></el-table-column>
        <el-table-column prop="id" label="No" width="80" align="center" sortable></el-table-column>
        <el-table-column label="Image">
          <template v-slot="scope">
            <div style="display: flex; align-items: center">
              <el-image style="width: 40px; height: 40px;" v-if="scope.row.goodsImg"
                        :src="scope.row.goodsImg" :preview-src-list="[scope.row.goodsImg]"></el-image>
            </div>
          </template>
        </el-table-column>
        <el-table-column width="120" prop="ordersId" label="ordersID" show-overflow-tooltip></el-table-column>
        <el-table-column width="90" prop="goodsName" label="GoodsName" show-overflow-tooltip></el-table-column>
        <el-table-column width="90" prop="goodsPrice" label="UnitPrice" show-overflow-tooltip>
          <template v-slot="scope">
             ￥{{scope.row.goodsPrice}}/{{scope.row.goodsUnit}}
          </template>
        </el-table-column>
        <el-table-column prop="num" label="GoodsNum" show-overflow-tooltip></el-table-column>
        <el-table-column width="100" prop="price" label="TotalPrice" show-overflow-tooltip></el-table-column>
        <el-table-column width="100" prop="businessName" label="Business" show-overflow-tooltip></el-table-column>
        <el-table-column width="90" prop="username" label="Consignee" show-overflow-tooltip></el-table-column>
        <el-table-column prop="useraddress" label="DeliveryAddress" show-overflow-tooltip></el-table-column>
        <el-table-column prop="phone" label="Phone" show-overflow-tooltip></el-table-column>
        <el-table-column prop="status" width="100" label="Status" show-overflow-tooltip></el-table-column>


        <el-table-column label="Operate" width="300px" align="center">
          <template v-slot="scope">
            <el-button plain type="primary" v-if="user.role === 'BUSINESS' && scope.row.status === 'Undelivered'" @click="updateStatus(scope.row,'Delivered')" size="mini">Deliver goods</el-button>
            <el-button plain type="danger" size="mini" @click=del(scope.row.id)>Delete</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script>
export default {
  name: "Notice",
  data() {
    return {
      tableData: [],  // 所有的数据
      pageNum: 1,   // 当前的页码
      pageSize: 10,  // 每页显示的个数
      total: 0,
      ordersId: null,
      form: {},
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      ids: []
    }
  },
  created() {
    this.load(1)
  },
  methods: {
    save() {   // 保存按钮触发的逻辑  它会触发新增或者更新
        this.$request({
          url: this.form.id ? '/orders/update' : '/orders/add',
          method: this.form.id ? 'PUT' : 'POST',
          data: this.form
        }).then(res => {
          if (res.code === '200') {  // 表示成功保存
            this.$message.success('保存成功')
            this.load(1)
            this.fromVisible = false
          } else {
            this.$message.error(res.msg)  // 弹出错误的信息
          }
        })
    },
    del(id) {   // 单个删除
      this.$confirm('您确定删除吗？', '确认删除', {type: "warning"}).then(response => {
        this.$request.delete('/orders/delete/' + id).then(res => {
          if (res.code === '200') {   // 表示操作成功
            this.$message.success('操作成功')
            this.load(1)
          } else {
            this.$message.error(res.msg)  // 弹出错误的信息
          }
        })
      }).catch(() => {
      })
    },
    handleSelectionChange(rows) {   // 当前选中的所有的行数据
      this.ids = rows.map(v => v.id)   //  [1,2]
    },
    delBatch() {   // 批量删除
      if (!this.ids.length) {
        this.$message.warning('请选择数据')
        return
      }
      this.$confirm('您确定批量删除这些数据吗？', '确认删除', {type: "warning"}).then(response => {
        this.$request.delete('/orders/delete/batch', {data: this.ids}).then(res => {
          if (res.code === '200') {   // 表示操作成功
            this.$message.success('操作成功')
            this.load(1)
          } else {
            this.$message.error(res.msg)  // 弹出错误的信息
          }
        })
      }).catch(() => {
      })
    },
    load(pageNum) {  // 分页查询
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/orders/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          ordersId: this.ordersId,
        }
      }).then(res => {
        this.tableData = res.data?.list
        this.total = res.data?.total
      })
    },
    reset() {
      this.ordersId = null
      this.load(1)
    },
    handleCurrentChange(pageNum) {
      this.load(pageNum)
    },
    handleAvatarSuccess(response, file, fileList) {
      // 把头像属性换成上传的图片的链接
      this.form.img = response.data
    },
    updateStatus(row,status) {
      this.form = row
      this.form.status = status
      this.save()
    }
  }
}
</script>

<style scoped>

</style>
