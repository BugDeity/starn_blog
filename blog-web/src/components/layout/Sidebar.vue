<template>
    <div class="toolbar">
        <a href="javascript:void(0)" @click="handleGoIm" class="toolbar_item chat ">
            <el-tooltip class="item" effect="dark" content="聊天室" placement="left">
                <svg-icon icon-class="chat"></svg-icon>
            </el-tooltip>
        </a>

        <a href="javascript:void(0)" class="toolbar_item theme" @click="setSkin()">
            <el-tooltip class="item" effect="dark" content="切换主题" placement="left">
                <svg-icon v-if="skin == 'deep'" icon-class="shallow"></svg-icon>
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
import { setSkin, getSkin } from '@/utils/cookieUtil'
export default {
    data() {
        return {
            theme: true,
            showBtn: false, // 回到顶部，默认是false，就是隐藏起来
            skin: getSkin(),
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
        setSkin() {
            this.skin = getSkin()
            let val = ''
            if (this.skin == 'shallow') { //浅色模式
                val = 'deep'
            } else {
                val = 'shallow'
            }
            setSkin(val)
            this.skin = val
            this.$setSkin()
        },
        toTop() {
            let that = this;
            let scrollTop =
                window.pageYOffset ||
                document.documentElement.scrollTop ||
                document.body.scrollTop;
            that.scrollTop = scrollTop;
            if (scrollTop > 200) {
                this.showBtn = true;
            } else {
                this.showBtn = false;
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