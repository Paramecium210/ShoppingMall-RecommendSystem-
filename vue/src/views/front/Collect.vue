<template>
  <div class="main-content">
    <div style=" width: 70%; background-color: white;margin: 30px auto; border-radius: 20px">
      <div style="padding: 0 20px">
        <div style="font-weight: 800;font-size: 20px; color: #000000FF; line-height: 80px; border-bottom: #cccccc 1px solid; padding-left: 35px">My collection</div>
        <div style="margin: 20px 0; padding: 0 50px">
          <div class="table">
            <el-table :data="collectData" strip>
              <el-table-column label="Image" width="150px">
                <template v-slot="scope">
                  <div style="display: flex;">
                    <el-image align="center" style="width: 80px; height: 60px; border-radius: 5px;" v-if="scope.row.goodsImg"
                              :src="scope.row.goodsImg" :preview-src-list="[scope.row.goodsImg]"></el-image>
                  </div>
                </template>
              </el-table-column>
              <el-table-column prop="goodsName" label="Name"></el-table-column>
              <el-table-column prop="businessName" label="Business"></el-table-column>
              <el-table-column prop="goodsPrice" label="Price"></el-table-column>
              <el-table-column label="Operate" align="center" width="180">
                <template v-slot="scope">
                  <el-button size="mini" type="danger" plain @click="del(scope.row.id)">Delete collection</el-button>
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
      collectData: [],
      pageNum: 1,   // 当前的页码
      pageSize: 10,  // 每页显示的个数
      total: 0,
    }
  },
  mounted() {
    this.loadCollect(1)
  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    del (id) {
      this.$request.delete('/collect/delete/' + id).then(res => {
        if (res.code === '200'){
          this.$message.success('Delete successfully')
          this.loadCollect(1)
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleCurrentChange(pageNum) {
      this.loadCollect(pageNum)
    },
    loadCollect(pageNum) {  // 分页查询
      if (pageNum) this.pageNum = pageNum
      this.$request.get('/collect/selectPage', {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
        }
      }).then(res => {
        if (res.code === '200'){
          this.collectData = res.data?.list
          this.total = res.data?.total
        }else {
          this.$message.error(res.msg)
        }

      })
    },
  }
}
</script>
