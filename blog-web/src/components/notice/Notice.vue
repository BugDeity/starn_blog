<!-- 公告栏组件 -->
<template>
    <div class="message" ref="msgBox" id="message" v-if="!noticeFlag">
        <span class="msg" ref="scrollMsg">
            <span class="title">
                <svg-icon icon-class="topNotice"></svg-icon>
                通知 :
            </span>
            <span class="content" v-html="notice.msg"></span>
            <span class="closeBtn" @click="closeMsg">
                关闭 <i class="el-icon-close"></i>
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
            noticeFlag: true,
            notice: {
                id: 2,
                msg: '发布文章按钮继续关闭。另外<a href="https://gitee.com/quequnlong/shiyi-blog">兄弟们去码云点点小星星，冲个1000 star 》》</a>',
            }
        }
    },
    created() {
        //this.handleScrollMsg()
        const noticeId = getNotice()
        if (noticeId != this.notice.id) {
            this.noticeFlag = false
        }
    },

    methods: {
        closeMsg() {
            setNotice(this.notice.id)
            var message = document.getElementById("message");
            message.style.opacity = 0;
            setTimeout(function () {
                message.style.display = "none";
            }, 500);//这里要等待过渡的0.5s，然后才消失
        },
        // //横向播放通知公告
        // handleScrollMsg() {
        //     let speed = 15//字体的整体滚动速度
        //     let box = this.$refs.msgBox
        //     let msg = this.$refs.scrollMsg

        //     let scroll = () => {
        //         if (msg.offsetLeft <= (- msg.offsetWidth)) {
        //             msg.style.left = box.offsetWidth + 'px'
        //         } else {
        //             msg.style.left = msg.offsetLeft - 1 + 'px'
        //         }
        //     }

        //     let timer = setInterval(scroll, speed)
        //     //鼠标移动到通知内容上暂停
        //     msg.onmouseover = () => {
        //         clearInterval(timer);
        //     }
        //     //移开继续滚动
        //     msg.onmouseout = () => {
        //         timer = setInterval(scroll, speed)
        //     }
        // },
    }
}
</script>
<style scoped lang='scss'>
.message {
    position: relative;
    line-height: 30px;
    color: #000;
    top: 70px;
    text-align: center;
    background-color: var(--theme-color);
    width: 100%;
    color: #fff;
    opacity: 1;
    transition: all 0.5s linear;
    z-index: 10;

    .msg {
        line-height: 30px;
        font-size: 14px;
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
                color: #fff;

            }
        }

        .closeBtn {
            margin-left: 15px;
            margin-right: 150px;
            cursor: pointer;
            float: right;
            font-weight: 400;
        }
    }
}
</style>


