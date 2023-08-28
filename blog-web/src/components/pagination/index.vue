<template>
    <div class=''>
        <!-- 分页按钮 -->
        <div class="page" v-if="pageNoProp < pages" @click="handlePage">
            加载更多
        </div>
        <div class="tips" v-else>
            我也是有底线的--
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
}
</style>