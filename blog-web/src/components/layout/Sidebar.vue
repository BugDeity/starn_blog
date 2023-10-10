<template>
    <div class="toolbar">
        <a href="javascript:void(0)" @click="handleGoIm" class="toolbar_item chat ">
            <el-tooltip class="item" effect="dark" content="聊天室" placement="left">
                <svg-icon icon-class="chat"></svg-icon>
            </el-tooltip>
        </a>

        <a href="javascript:void(0)" class="toolbar_item theme" @click="chageTheme">
            <el-tooltip class="item" effect="dark" content="切换主题" placement="left">
                <svg-icon v-if="theme && theme == 'dark'" icon-class="shallow"></svg-icon>
                <svg-icon v-else icon-class="deep"></svg-icon>
            </el-tooltip>
        </a>

        <a href="javascript:void(0)" title="回到顶部" class="toolbar_item back2top" @click="backTop()" v-if="showBtn">
            <el-tooltip class="item" effect="dark" content="回到顶部" placement="left">
                <svg-icon icon-class="topBar"></svg-icon>
            </el-tooltip>
        </a>
    </div>
</template>
<script>
export default {
    data() {
        return {
            showBtn: false, // 回到顶部，默认是false，就是隐藏起来
            theme: sessionStorage.getItem("theme"),
            show: false,
        }
    },
    mounted() {
        window.addEventListener("scroll", this.toTop, true);
    },

    methods: {
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
            this.showBtn = scrollTop > 200
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
.toolbar {
    position: fixed;

    a {
        display: block;
        height: 50px;
        position: relative;
    }


    .toolbar_item {
        pointer-events: auto;
        visibility: visible;
        position: fixed;
        right: 30px;
        margin-bottom: 10px;

        svg {
            position: absolute;
            width: 25px;
            height: 25px;
            top: 9px;
            right: 10px;
        }
    }

    .theme {
        bottom: 150px;
    }

    .chat {
        bottom: 250px;
        right: 0px;

        svg {
            width: 100px !important;
            height: 100px !important;
        }
    }

    .back2top {
        bottom: 100px;
        right: 30px;
        animation: fade-in 0.3s linear 1;
    }


    @keyframes fade-in {
        0% {
            transform: translateX(48px)
        }

        100% {
            transform: translateX(0)
        }
    }
}
</style>