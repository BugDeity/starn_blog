<template>
    <div class='notice' v-if="!flag">
        <div class="notcie-item" @click="handleClike">
            <span v-html="content"></span>
            <span class="btn">关闭 X</span>

        </div>
    </div>
</template>
   
<script>
import { setNotice, getNotice } from '@/utils/cookieUtil'
export default {
    name: '',
    data() {
        return {
            content: '<a href="https://gitee.com/quequnlong/shiyi-blog">兄弟们去码云点点小星星，冲个1000 star 》》</a>',
            flag: getNotice()
        }
    },

    created() {
        // console.log('------created--------');
    },
    methods: {
        handleClike() {
            setNotice("1")
            this.flag = true
        }
    },
}
</script>
   
<style lang='scss' >
@media screen and (max-width: 1118px) {
    .notcie-item {
        width: 95%;
        font-size: 0.9rem;
    }
}

@media screen and (min-width: 1119px) {
    .notcie-item {
        width: 99%;
    }
}

.notice {
    .notcie-item {
        position: absolute;
        top: 60px;
        padding: 5px;

        text-align: center;
        background-color: var(--theme-color);
        z-index: 999;
        color: #fff;
        cursor: pointer;

        a {
            text-decoration: none;
            color: #fff;
        }

        .btn {
            float: right;
        }
    }
}
</style>