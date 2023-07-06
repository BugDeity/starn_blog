import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)
export default new Vuex.Store({
  state: {
    skin: 'shallow',//shallow浅色模式  //deep深色模式
    loginFlag: false,
    drawer: false,
    searchDrawer: false,
    siteAccess: 0,
    visitorAccess: 0,
    userInfoDrawer: false,
    userInfo: null,
    isCommentFlag: false,
    articleDrawer: {
      flag: false,
      id: null
    },
    webSiteInfo: {
      loginTypeList: "",
      showList: "",
    },
    hotArticles: {},
  },
  mutations: {
    closeModel(state) {
      state.loginFlag = false;
    },
    isCommentFlag(state, newValue) {
      state.isCommentFlag = newValue
    },
    setWebSiteInfo(state, newValue) {
      state.webSiteInfo = newValue
    },
    setHotArticles(state, newValue) {
      state.hotArticles = newValue
    },
    setSkin(state, newValue) {
      state.skin = newValue
    },
    setDrawer(state, newValue) {
      state.drawer = newValue
    },
    setUserInfoDrawer(state, newValue) {
      state.userInfoDrawer = newValue
    },
    setSearchDrawer(state, newValue) {
      state.searchDrawer = newValue
    },
    setLoginFlag(state, newValue) {
      state.loginFlag = newValue
    },
    setUserInfo(state, newValue) {
      state.userInfo = newValue
    },
  },

  // actions: {
  //   setSkin(context, value) {
  //     // 修改getskin的值
  //     context.commit('getskin', value)
  //   }
  // },
})