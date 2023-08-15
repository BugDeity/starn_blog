<!-- 公告栏组件 -->
<template>
    <div class="msg-box" ref="msgBox">

        <span class="msg" ref="scrollMsg">
            <span class="title">
                <svg-icon icon-class="topNotice"></svg-icon>
                通知 :
            </span>
            <span class="content" v-html="notice.msg"></span>
            <span class="closeBtn" @click="close">
                关闭 X
            </span>
        </span>
    </div>
</template>

<script>
import { setNotice, getNotice } from '@/utils/cookieUtil'
export default {
    name: 'NoticeBar',

    data() {
        return {
            notice: {
                id: 1,
                msg: '发布文章按钮暂时隐藏。另外<a href="https://gitee.com/quequnlong/shiyi-blog">兄弟们去码云点点小星星，冲个1000 star 》》</a>',
            }
        }
    },
    mounted() {
        this.handleScrollMsg()

    },

    methods: {
        close() {
            setNotice(this.notice.id)
            this.$emit("handleNotcieClose", false);
        },
        //横向播放通知公告
        handleScrollMsg() {
            let speed = 15//字体的整体滚动速度
            let box = this.$refs.msgBox
            let msg = this.$refs.scrollMsg

            let scroll = () => {
                if (msg.offsetLeft <= (- msg.offsetWidth)) {
                    msg.style.left = box.offsetWidth + 'px'
                } else {
                    msg.style.left = msg.offsetLeft - 1 + 'px'
                }
            }

            let timer = setInterval(scroll, speed)
            //鼠标移动到通知内容上暂停
            msg.onmouseover = () => {
                clearInterval(timer);
            }
            //移开继续滚动
            msg.onmouseout = () => {
                timer = setInterval(scroll, speed)
            }
        },
    }
}
</script>
<style scoped lang='scss'>
.msg-box {
    width: 100%;
    overflow: hidden;
    position: relative;
    height: 30px;
    text-align: right;
    line-height: 30px;
    color: var(--notice-color);



    .msg {
        position: absolute;
        line-height: 30px;
        font-size: 14px;
        white-space: nowrap;
        font-weight: 700;

        .title {

            margin-right: 15px;

            svg {
                width: 20px;
                height: 20px;
                vertical-align: -5px;
            }
        }

        .content {
            /deep/ a {
                text-decoration: none;
                color: var(--notice-color);
            }
        }

        .closeBtn {
            color: var(--theme-color);
            margin-left: 15px;
            cursor: pointer;
        }
    }
}
</style>


