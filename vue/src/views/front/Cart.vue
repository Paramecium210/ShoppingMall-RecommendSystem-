<template>
  <div class="main-content">
    <div style=" width: 70%; background-color: white;margin: 30px auto; border-radius: 20px">
      <div style="padding: 0 20px">
        <div style="display: flex; font-weight: 800;font-size: 20px; color: #000000FF; line-height: 80px; border-bottom: #cccccc 1px solid; padding-left: 35px">
          <div style="flex: 1; margin-left: 20px">My cart</div>
          <div style="flex: 1; margin-left: 100px">
            <el-select v-model="addressId" placeholder="Choose your address" style="width: 70%" >
              <el-option v-for="item in addressData" :label="item.useraddress" :value="item.id"></el-option>
            </el-select>
          </div>
          <div style="flex: 1;font-size: 15px;margin-right: 20px; ">
            Selected products ￥{{totalPrice}}<el-button @click="pay" style="margin-left: 10px" type="danger" round >Order</el-button>
          </div>
        </div>
        <div style="margin: 20px 0; padding: 0 50px">
          <div class="table">
            <el-table :data="cartData" strip @selection-change="handleSelectionChange">
              <el-table-column type="selection" width="55" align="center"></el-table-column>
              <el-table-column label="Image" width="150px">
                <template v-slot="scope">
                  <div style="display: flex;">
                    <el-image align="center" style="width: 80px; height: 60px; border-radius: 5px;" v-if="scope.row.goodsImg"
                              :src="scope.row.goodsImg" :preview-src-list="[scope.row.goodsImg]"></el-image>
                  </div>
                </template>
              </el-table-column>
              <el-table-column prop="goodsName" label="Name">
                <template v-slot="scope">
                  <a :href="'/front/detail?id=' + scope.row.goodsId">{{scope.row.goodsName}}</a>
                </template>
              </el-table-column>
              <el-table-column prop="businessName" label="Business"></el-table-column>
              <el-table-column prop="goodsPrice" label="Price"></el-table-column>
              <el-table-column prop="num" label="Number">
                <template v-slot="scope">
                  <el-input-number v-model="scope.row.num" @change="handleChange(scope.row)" :min="1" style="width: 100px"></el-input-number>
                </template>
              </el-table-column>
              <el-table-column label="Operate" align="center" width="180">
                <template v-slot="scope">
                  <el-button size="mini" type="danger" plain @click="del(scope.row.id)">Delete goods</el-button>
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
  </div>
</template>

<script>



export default {

  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
      cartData: [],
      pageNum: 1,   // 当前的页码
      pageSize: 10,  // 每页显示的个数
      total: 0,
      addressId: null,
      addressData: [],
      totalPrice: 0,
      selectData: []
    }
  },
  mounted() {
    this.loadCart(1)
    this.loadAddress()
  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    pay() {
      if (!this.addressId){
        this.$message.warning('Please choose address')
        return
      }
      if (!this.selectData || this.selectData.length === 0) {
        this.$message.warning('Please choose goods')
        return
      }
      let data = {
        userId : this.user.id,
        addressId: this.addressId,
        status: 'Undelivered',
        cartData: this.selectData
      }
      this.$request.post('/orders/add',data).then(res => {
        if (res.code === '200'){
          this.$message.success('Order successfully')
          this.loadCart(1)
        }else {
          this.$message.error(res.msg)
        }
      })

    },
    handleChange() {
      this.totalPrice = 0
      this.selectData.forEach(item => {
        this.totalPrice += item.goodsPrice * item.num
      })
    },
    handleSelectionChange(rows) {
      this.totalPrice = 0
      this.selectData = rows
      this.selectData.forEach(item => {
        this.totalPrice += item.goodsPrice * item.num
      })
    },
    loadAddress() {
      this.$request.get('/address/selectAll').then(res => {
        if (res.code === '200'){
          this.addressData = res.data
        }else {
          this.$message.error(res.msg)
        }
      })
    },
    del (id) {
      this.$request.delete('/cart/delete/' + id).then(res => {
        if (res.code === '200'){
          this.$message.success('Delete successfully')
          this.loadCart(1)
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleCurrentChange(pageNum) {
      this.loadCart(pageNum)
    },
    loadCart(pageNum) {  // 分页查询
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/cart/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
        }
      }).then(res => {
        if (res.code === '200'){
          this.cartData = res.data?.list
          this.total = res.data?.total
        }else {
          this.$message.error(res.msg)
        }

      })
    },
  }
}
</script>
