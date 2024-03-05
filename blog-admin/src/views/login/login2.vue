<template>
  <div class="login-container">
    <div class="login-box">
      <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form" auto-complete="on"
               label-position="left">
        <i class="top"></i><i class="bottom"></i>
        <div class="logo">
          <el-image src="https://img.siyit.com/logo11.png"></el-image>
          <h1 class="title">思易博客 欢迎您</h1>
        </div>


        <el-form-item prop="username">
          <el-input prefix-icon="el-icon-user-solid" v-model="loginForm.username" placeholder="用户名"
                    name="username" type="text" tabindex="1" auto-complete="on"/>
        </el-form-item>

        <el-form-item prop="password">
          <el-input prefix-icon="el-icon-lock" :key="passwordType" v-model="loginForm.password"
                    :type="passwordType" placeholder="密码" name="password" tabindex="2" auto-complete="on"
                    ref="password" @keyup.enter.native="handleLogin"/>
          <span class="show-pwd" @click="showPwd">
                            <svg-icon :icon-class="passwordType === 'password' ? 'eye' : 'eye-open'"/>
                        </span>
        </el-form-item>
        <!-- 滑块验证 -->
        <el-dialog title="请拖动滑块完成拼图" width="360px" :visible.sync="isShowSliderVerify"
                   :close-on-click-modal="false" @closed="refresh" append-to-body>
          <slider-verify ref="sliderVerify" @success="onSuccess" @fail="onFail" @again="onAgain"/>
        </el-dialog>

        <el-form-item prop="rememberMe">
          <el-checkbox v-model="loginForm.rememberMe">
            <span style="color: #000;">记住我</span>
          </el-checkbox>
        </el-form-item>

        <el-button :loading="loading" type="success" style="width:100%;margin-bottom:30px;"
                   @click.native.prevent="handleLogin">
          <span v-if="!loading">登 录</span>
          <span v-else>登 录 中...</span>
        </el-button>
<!--        <div style="">
          <span style="margin-right: 20px;">用户名: test</span>
          <span>密码: 123456</span>
        </div>-->
      </el-form>
    </div>
  </div>

</template>


<script>
import sliderVerify from './components/sliderVerify';
import {login} from '@/api/user'

export default {
  components: {sliderVerify},
  name: 'Login',
  data() {
    return {
      // 随机字符串
      nonceStr: '',
      // 验证值
      value: '',
      // 是否显示滑块验证
      isShowSliderVerify: false,
      loading: false,
      loginForm: {
        username: '',
        password: '',
        rememberMe: false,
        uuid: null,
        code: null,
      },
      passwordType: 'password',
      loginRules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'},
          {min: 3, max: 10, message: '长度在 3 到 10 个字符', trigger: 'blur'}
        ],
        password: [{required: true, trigger: 'blur', message: '请输入密码'}],
      },
    }
  },
  created() {
    // console.log('------created--------');
  },
  methods: {
    login() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          let that = this;
          that.loading = true
          login(that.loginForm).then(res => {
            let data = {token: res.data, rememberMe: that.loginForm.rememberMe}
            that.$store.dispatch('user/login', data).then(res => {
              that.$refs.sliderVerify.verifySuccessEvent();
              setTimeout(() => {
                that.isShowSliderVerify = false;
                that.$message.success('登录成功');
              }, 500);
              that.loading = false
              that.$router.push('/')
            })
          }).catch(err => {
            that.loading = false
            that.$refs.sliderVerify.verifyFailEvent();
          })
        } else {
          console.log('error submit!!')
          return false
        }
      })
    },
    keyupEnter() {
      document.onkeydown = e => {
        let _key = window.event.keyCode;
        if (_key === 13) {
          this.handleLogin()
        }
      }
    },
    showPwd() {
      if (this.passwordType === 'password') {
        this.passwordType = ''
      } else {
        this.passwordType = 'password'
      }
      this.$nextTick(() => {
        this.$refs.password.focus()
      })
    },
    /* 提交*/
    handleLogin() {
      let self = this;
      self.$refs.loginForm.validate((flag) => {
        self.isShowSliderVerify = flag;
      });
    },
    /* 滑动验证成功*/
    onSuccess(captcha) {
      Object.assign(this.loginForm, captcha);
      this.loginForm.nonceStr = captcha.nonceStr
      this.loginForm.value = captcha.value
      this.login();
    },
    /* 滑动验证失败*/
    onFail(msg) {
      console.log(msg)
      //this.message('error', msg || '验证失败，请控制拼图对齐缺口');
    },
    /* 滑动验证异常*/
    onAgain() {
      this.$message.error('滑动操作异常，请重试');
    },
    /* 刷新验证码*/
    refresh() {
      this.$refs.sliderVerify.refresh();
    },
    /* 提示弹框*/
    message(type, message) {
      this.$message({
        showClose: true,
        type: type,
        message: message,
        duration: 1500,
      });
    },
  },
}
</script>


<style lang="scss" rel="stylesheet/scss" scoped>
.login-container {
  background-size: cover;
  display: flex;
  justify-content: center; /* 水平居中 */
  align-items: center; /* 垂直居中 */
  height: 100%;
  width: 100%;
  background: whitesmoke url("./bg.svg");
}
::v-deep .el-image__inner{
  border-radius: 50% !important;
  width: 60px !important;;
  height: 60px !important;
  vertical-align: top;
}
$bg: #2d3a4b;
$dark_gray: #889aa4;
$light_gray: #eee;

@media screen and (max-width: 1118px) {
  .login-box {
    width: 80%;
  }

}


@media screen and (min-width: 1119px) {
  .login-box {
    width: 25%;
  }
}
.login-container {


    .img {
      height: 50px;
      position: relative;
      top: 40%;
      left: 20%;

      .svg-icon {
        width: 500px;
        height: 300px;
      }
    }

    .logo {
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 20px;
      .title {
        margin-left: 20px;
        color: #0aad52;
      }
    }

    .login-form {
      width: 500px;
      height: 450px;
      max-width: 100%;
      padding: 35px 35px 15px 35px;
      border-radius: 5px;
      margin: auto;
      position: relative;
      overflow: hidden;
      border: 1px solid #74efff;

      &::before {
        content: ' ';
        position: absolute;
        width: 4px;
        height: 100%;
        top: -100%;
        left: 0;
        background-image: linear-gradient(0deg,
            transparent,
            #ff74ba,
            transparent);
        animation: two 4s linear infinite;
      }

      &::after {
        content: ' ';
        position: absolute;
        width: 4px;
        height: 100%;
        bottom: -100%;
        right: 0;
        background-image: linear-gradient(360deg,
            transparent,
            #74efff,
            transparent);
        animation: four 4s linear 2s infinite;
      }

      i {
        position: absolute;
        display: inline-block;
        height: 4px;
        width: 100%;
      }

      .bottom {
        bottom: 0;
        left: -100%;
        background-image: linear-gradient(270deg,
            transparent,
            #b574ff,
            transparent);
        animation: one 4s linear 1s infinite;
      }

      .top {
        top: 0;
        right: -100%;
        background-image: linear-gradient(270deg,
            transparent,
            #74ff97,
            transparent);
        animation: three 4s linear 3s infinite;
      }
    }


    .show-pwd {
      position: absolute;
      right: 10px;
      top: 7px;
      font-size: 16px;
      color: $dark_gray;
      cursor: pointer;
      user-select: none;

      svg {
        vertical-align: 5px;
      }
    }

  .el-login-footer {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    text-align: center;
  }
}

@keyframes one {
  0% {
    left: -100%;
  }

  50%,
  100% {
    left: 100%;
  }
}

@keyframes two {
  0% {
    top: -100%;
  }

  50%,
  100% {
    top: 100%;
  }
}

@keyframes three {
  0% {
    right: -100%;
  }

  50%,
  100% {
    right: 100%;
  }
}

@keyframes four {
  0% {
    bottom: -100%;
  }

  50%,
  100% {
    bottom: 100%;

  }
}
</style>

