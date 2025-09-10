<template>
  <div class="main-content">
    <div style=" width: 80%; background-color: white;margin: 30px auto; border-radius: 20px">
      <div style="padding: 0 20px">
        <div style="font-weight: 800;font-size: 20px; color: #000000FF; line-height: 80px; border-bottom: #cccccc 1px solid; padding-left: 35px">My orders</div>
        <div style="margin: 20px 0; padding: 0 50px">
          <div class="table">
            <el-table :data="ordersData" strip>
              <el-table-column label="Image" width="100px">
                <template v-slot="scope">
                  <div style="display: flex;">
                    <el-image align="center" style="width: 80px; height: 60px; border-radius: 5px;" v-if="scope.row.goodsImg"
                              :src="scope.row.goodsImg" :preview-src-list="[scope.row.goodsImg]"></el-image>
                  </div>
                </template>
              </el-table-column>
              <el-table-column prop="ordersId" label="OrdersID"></el-table-column>
              <el-table-column prop="goodsName" label="Name">
                <template v-slot="scope">
                  <a :href="'/front/detail?id=' + scope.row.goodsId">{{scope.row.goodsName}}</a>
                </template>
              </el-table-column>
              <el-table-column prop="businessName" label="Business"></el-table-column>
              <el-table-column width="100" prop="goodsPrice"  label="Goods price">
                <template v-slot="scope">
                  {{scope.row.goodsPrice}}/{{scope.row.goodsUnit}}
                </template>
              </el-table-column>
              <el-table-column prop="num" label="Num"></el-table-column>
              <el-table-column width="100" prop="price" label="Total price"></el-table-column>
              <el-table-column width="100" prop="username" label="Consignee"></el-table-column>
              <el-table-column prop="useraddress" label="Delivery address"></el-table-column>
              <el-table-column prop="phone" label="Phone"></el-table-column>
              <el-table-column width="100" prop="status" label="Status"></el-table-column>
              <el-table-column label="Operate" align="center" width="300">
                <template v-slot="scope" >
                  <el-button size="mini" v-if="scope.row.status === 'Delivered'" type="primary" plain @click="finish(scope.row,'Finished')">Finish the order</el-button>
                  <el-button size="mini" v-if="scope.row.status === 'Finished'" type="primary" plain @click="addComment(scope.row)">Comment</el-button>
                  <el-button size="mini" type="danger" plain @click="del(scope.row.id)">Delete the order</el-button>
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
    <el-dialog title="Comment" :visible.sync="fromVisible" width="40%" :close-on-click-modal="false" destroy-on-close>
      <el-form :model="form" label-width="100px" style="padding-right: 50px" :rules="rules" ref="formRef">
        <el-form-item  label="Comment" prop="comment">
          <el-input type="textarea" v-model="form.content" placeholder="Enter your comment"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="fromVisible = false">Cancel</el-button>
        <el-button type="primary" @click="save">Confirm</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>



import router from "@/router";

export default {

  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      ordersData: [],
      pageNum: 1,   // 当前的页码
      pageSize: 10,  // 每页显示的个数
      total: 0,
      form: {},
      fromVisible: false
    }
  },
  mounted() {
    this.loadOrders(1)
  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    addComment(row){
      this.fromVisible = true
      this.form = row

    },
    save(){
      let data = {
        userId: this.user.id,
        goodsId: this.form.goodsId,
        businessId: this.form.businessId,
        content: this.form.content

      }
      this.$request.post('/comment/add', data).then(res => {
        if (res.code === '200'){
          this.$message.success("Comment successfully")
          this.fromVisible = false
          this.finish(this.form,'Commented')
          this.form = {}
        }else {
          this.$message.error(res.msg)
        }
      })
    },
    finish(row,status){
      this.form = row
      this.form.status = status
      this.$request.put('/orders/update',this.form).then(res => {
        if (res.code === '200') {
          this.$message.success('Success')
        }else {
          this.$message.error(res.msg)
        }
      })
    },
    del (id) {
      this.$request.delete('/orders/delete/' + id).then(res => {
        if (res.code === '200'){
          this.$message.success('Delete successfully')
          this.loadOrders(1)
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleCurrentChange(pageNum) {
      this.loadOrders(pageNum)
    },
    loadOrders(pageNum) {  // 分页查询
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/orders/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
        }
      }).then(res => {
        if (res.code === '200'){
          this.ordersData = res.data?.list
          this.total = res.data?.total
        }else {
          this.$message.error(res.msg)
        }

      })
    },
  }
}
</script>
