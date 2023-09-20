<template>
  <div id="app">
    <router-view :key="$route.fullPath" />
  </div>
</template>

<script>

import { report } from '@/api'
import { setSkin, getSkin } from '@/utils/cookieUtil'
export default {
  name: 'App',

  created() {
    report().then(res => {
      this.$notify({
        title: '欢迎来自 ' + res.data.split("|")[2] + ' 的朋友',
        message: "但愿本博客能够值得你喜欢以及常来",
        type: 'success'
      });
    });
  },
  beforeCreate() {
    if (getSkin() == null) {
      setSkin("shallow")
    } else {
      setSkin(getSkin())
    }
  },
  mounted() {
    this.$setSkin()
  },

}
</script>

<style lang="scss" scoped>
#app {
  background: var(--body-color);
}
</style>
