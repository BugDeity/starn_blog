<template>
  <div>
    <el-dialog class="dialog" :close-on-click-modal="false" :show-close="false" :lock-scroll="false" title="反馈"
      :visible.sync="this.$store.state.feedbackDialogVisible">
      <el-form :rules="rules" ref="dataForm" label-position="left" :model="form">
        <el-form-item label="反馈类型" prop="type">
          <el-radio v-model="form.type" :label="1">提交需求</el-radio>
          <el-radio v-model="form.type" :label="2">反馈缺陷</el-radio>
        </el-form-item>
        <el-form-item label="联系邮箱" prop="email" :label-width="formLabelWidth">
          <el-input placeholder="请填写您的联系邮箱" v-model="form.email" />
        </el-form-item>
        <el-form-item label="标题" prop="title" :label-width="formLabelWidth">
          <el-input placeholder="请输入标题" v-model="form.title" />
        </el-form-item>
        <div class="contentInput">
          <el-form-item label="描述" prop="content" :label-width="formLabelWidth">
            <el-input :placeholder="form.type == 1 ? '请在此详细描述你的需求' : '请在此详细描述你的缺陷'" :rows="6" type="textarea"
              v-model="form.content" :label-width="formLabelWidth" />
            <a @click="screenshot" v-if="!form.imgUrl" style="color: #03a9f4;cursor: pointer;"><i
                class="el-icon-camera"></i> 截取页面</a>
            <img v-else :src="form.imgUrl">
          </el-form-item>
        </div>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="closeDialog">取 消</el-button>
        <el-button type="primary" @click="submit">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { addFeedback } from '@/api'
export default {
  data: function () {
    return {
      formLabelWidth: "80px",
      form: {
        type: 1,
        email: null,
        title: null,
        content: null,
        imgUrl: null
      },
      img: process.env.VUE_APP_IMG_API,
      rules: {
        type: [
          { required: true, message: '必填字段', trigger: 'blur' },
        ],
        email: [
          { required: true, message: '必填字段', trigger: 'blur' },
          { pattern: /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((.[a-zA-Z0-9_-]{2,3}){1,2})$/, message: '填写正确的邮箱' }
        ],
        title: [
          { required: true, message: '必填字段', trigger: 'blur' },
        ]
      },
    };
  },
  methods: {
    screenshot() {
      this.$message.info("待开发");
    },
    closeDialog() {
      this.form.type = 1
      this.form.email = null
      this.form.title = null
      this.form.content = null
      this.$store.commit("setFeedbackDialogVisible", false)
    },
    submit() {
      this.$refs['dataForm'].validate((valid) => {
        if (valid) {
          addFeedback(this.form).then(res => {
            this.$message.success("提交反馈成功");
            this.closeDialog()
          }).catch(err => {
          })
        } else {
        }
      })
    },
  },
  computed: {
    webSite() {
      return this.$store.state.webSiteInfo;
    },
  }
};
</script>
<style lang="scss" scoped>
@media screen and (max-width: 1118px) {
  /deep/ .el-dialog {
    width: 100%;
  }
}

@media screen and (min-width: 1119px) {
  /deep/ .el-dialog {
    width: 40%;
  }
}
</style>
