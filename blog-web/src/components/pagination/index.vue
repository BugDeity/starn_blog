<template>
    <div class=''>
        <!-- 分页按钮 -->
        <div class="page" v-if="pageNoProp < pages" @click="handlePage">
            加载更多
        </div>
        <div class="tips" v-else>
            <div class="divider"></div>
            <div class="content">没有更多内容了</div>
            <div class="divider"></div>
        </div>
    </div>
</template>
   
<script>

export default {
    props: {
        pageNo: {
            type: Number,
            default: 0
        },
        pages: {
            type: Number,
            default: 0
        },
        changePage: {
            type: Function,
            default: () => { }
        }
    },
    name: '',
    data() {
        return {
            pageNoProp: this.pageNo
        }
    },
    created() {
        // console.log('------created--------');
    },
    methods: {
        handlePage() {
            this.pageNoProp++;
            this.$emit('changePage', this.pageNoProp);
        },
    },
}
</script>
   
<style lang='scss' scoped>
.page {
    text-align: center;
    background-color: rgba(0, 0, 0, .8);
    width: 120px;
    height: 30px;
    line-height: 30px;
    border-radius: 50px;
    margin: 0 auto;
    margin-top: 20px;
    cursor: pointer;
    color: #fff;
}

.tips {
    text-align: center;
    color: var(--text-color);
    display: flex;
    align-items: center;

    .divider {
        display: inline-block;
        width: 100%;
        background-color: #ccc;
        height: 1px;
    }

    .content {
        display: inline-block;
        width: 300px;
        font-size: 14px;
    }
}
</style>