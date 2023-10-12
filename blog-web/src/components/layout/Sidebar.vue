<template>
    <div :class="className">
        <el-tooltip class="item" effect="dark" content="聊天室" placement="left">
            <a href="javascript:void(0)" @click="handleGoIm" class="toolbar_item chat ">
                <i class="el-icon-chat-dot-square"></i>
            </a>
        </el-tooltip>

        <el-tooltip class="item" effect="dark" content="切换主题" placement="left">
            <a href="javascript:void(0)" class="toolbar_item theme" @click="chageTheme">
                <i class="iconfont icon-taiyang" v-if="theme && theme == 'dark'"></i>
                <i class="iconfont icon-yueliang" v-else></i>
            </a>
        </el-tooltip>

        <el-tooltip class="item" effect="dark" content="全屏" placement="left">
            <a href="javascript:void(0)" title="全屏" class="toolbar_item back2top" @click="toFullOrExit">
                <i class="iconfont icon-tuichuquanping" v-if="isFullscreen"></i>
                <i class="iconfont icon-quanping" v-else></i>
            </a>
        </el-tooltip>

        <el-tooltip class="item" effect="dark" content="回到顶部" placement="left">
            <a href="javascript:void(0)" title="回到顶部" class="toolbar_item back2top" @click="backTop()">
                <i class="iconfont icon-shangjiantou"></i>
            </a>
        </el-tooltip>

    </div>
</template>
<script>
export default {
    data() {
        return {
            theme: sessionStorage.getItem("theme"),
            show: false,
            isFullscreen: false,
            className: "toolbar1"
        }
    },
    mounted() {
        window.addEventListener("scroll", this.toTop, true);
    },

    methods: {
        toFullOrExit() {
            this.isFullscreen = !this.isFullscreen
            if (this.isFullscreen) {
                this.requestFullScreen()
            } else {
                this.exitFullscreen()
            }
        },

        requestFullScreen() {
            let de = document.documentElement
            if (de.requestFullscreen) {
                de.requestFullscreen()
            } else if (de.mozRequestFullScreen) {
                de.mozRequestFullScreen()
            } else if (de.webkitRequestFullScreen) {
                de.webkitRequestFullScreen()
            }
        },
        exitFullscreen() {
            let de = document
            if (de.exitFullscreen) {
                de.exitFullscreen()
            } else if (de.mozCancelFullScreen) {
                de.mozCancelFullScreen()
            } else if (de.webkitCancelFullScreen) {
                de.webkitCancelFullScreen()
            }
        },
        handleGoIm() {
            if (!this.$store.state.userInfo) {
                this.$store.commit("setLoginFlag", true)
                return;
            }
            this.$router.push({ path: "/im" })
        },
        chageTheme() {
            this.theme = sessionStorage.getItem("theme")
            let val = ''
            if (this.theme && this.theme == 'light') { //浅色模式
                val = 'dark'
            } else {
                val = 'light'
            }
            this.theme = val
            sessionStorage.setItem('theme', val)
            document.documentElement.dataset.theme = val
        },
        toTop() {
            let scrollTop =
                window.pageYOffset ||
                document.documentElement.scrollTop ||
                document.body.scrollTop;

            let scroll = scrollTop - this.i;
            this.i = scrollTop;

            if (scrollTop <= 200) {
                this.className = "toolbar1 slideDown"
            }

            if (scroll > 0) {
                this.className = "toolbar1 slideUp"
            }

        },
        backTop() {
            var timer = setInterval(function () {
                let osTop =
                    document.documentElement.scrollTop || document.body.scrollTop;
                let ispeed = Math.floor(-osTop / 5);
                document.documentElement.scrollTop = document.body.scrollTop =
                    osTop + ispeed;
                this.isTop = true;
                if (osTop === 0) {
                    clearInterval(timer);
                }
            }, 30);
        },
    },
}
</script>

<style lang="scss" scoped>
.slideUp {
    right: 20px;
}

.slideDown {
    right: -80px;
}

.toolbar1 {
    position: fixed;
    bottom: 130px;
    z-index: 99;
    transition: all .8s;

    .toolbar_item {
        width: 25px;
        height: 25px;
        text-align: center;
        margin-bottom: 10px;
        display: block;
        font-size: 1.2rem;
        text-decoration: none;
        color: #fff;
        background-color: var(--theme-color);
        padding: 5px;
        border-radius: 5px;
        font-weight: 700;
    }

}
</style>