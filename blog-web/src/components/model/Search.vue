<template>
    <el-dialog title="搜索文章" :visible.sync="dialogVisible" :close-on-click-modal="false">
        <div>
            <el-input v-model="pageData.keyword" @input="inputChage" placeholder="请输入内容"></el-input>
        </div>

        <div class="tagBox" v-if="!list.length">
            <div class="tag-title">标签搜索</div>
            <div>
                <a @click="handleToTag(tag.id)" :style="{ backgroundColor: `${randomColor()}` }" class="tag"
                    v-for="(tag, index) in tagList" :key="index">{{ tag.name }}</a>
            </div>
        </div>

        <div class="search-article">
            <div class="item" v-for="(item, index) in list" :key="index">
                <router-link :to="'/article/' + item.id">
                    <a class="xiahuaxian article-title" v-html="item.title"></a>
                </router-link>
                <p>{{ item.summary }}</p>
            </div>
            <!-- 分页按钮 -->
            <sy-pagination v-show="list.length" :pageNo="pageData.pageNo" :pages="pages" @changePage="handlePage"
                ref="pagin" />
        </div>
    </el-dialog>
</template>
   
<script>
import { searchArticle, fetchTagList } from '@/api'
export default {
    name: '',
    data() {
        return {
            pageData: {
                pageNo: 1,
                pageSize: 10,
                keyword: "",
            },
            pages: 0,
            list: [],
            tagList: []
        }
    },
    beforeDestroy() {
        this.$store.state.searchDialogVisible = false
    },
    computed: {
        dialogVisible: {
            set(value) {
                this.$store.state.searchDialogVisible = value;
            },
            get() {
                this.pageData.keyword = ""
                this.list = []
                if (this.$store.state.searchDialogVisible) {
                    this.getTagList()
                }
                return this.$store.state.searchDialogVisible;
            }
        },
    },
    created() {
        // console.log('------created--------');
    },
    methods: {
        handleToTag(id) {
            this.$store.state.searchDialogVisible = false
            this.$router.push({ path: "/tag", query: { id: id } })
        },
        inputChage(event) {
            this.pageData.keyword = event.replace(/\s/g, '')
            if (this.pageData.keyword == "") {
                this.list = []
                return
            }
            this.pageData.pageNo = 1
            //重新更新分页组件 不然分页组件存在问题
            this.$refs.pagin.handlePageNo(1)
            searchArticle(this.pageData).then(res => {
                this.list = res.data.records;
                this.pages = res.data.pages
            })
        },
        // 分页
        handlePage(val) {
            this.pageData.pageNo = val
            this.fetchArticleList()
        },
        fetchArticleList() {
            searchArticle(this.pageData).then(res => {
                this.list.push(...res.data.records);
                this.pages = res.data.pages
            })
        },
        getTagList() {
            fetchTagList().then(res => {
                this.tagList = res.data
            })
        },
        randomColor() {
            var letters = '0123456789ABCDEF';
            var color = '#';
            do {
                for (var i = 0; i < 6; i++) {
                    color += letters[Math.floor(Math.random() * 16)];
                }
            } while (color === '#FFFFFF' || color === '#000000');
            return color;
        },
    },
}
</script>
   
<style lang='scss' scoped>
/deep/ .el-dialog {
    border-radius: 5px;

    @media screen and (max-width: 1118px) {
        width: 90%;
    }

    @media screen and (min-width: 1119px) {
        width: 30%;
    }
}

.tagBox {
    margin-top: 15px;

    .tag-title {
        margin-bottom: 10px;
    }

    .tag {
        display: inline-block;
        border-radius: 5px;
        padding: 5px;
        margin-right: 5px;
        margin-bottom: 5px;
        color: #fff;
        transition: all .3s;

        &:hover {
            border-radius: 0;
            background-color: #000 !important;
        }
    }
}

.search-article {
    margin-top: 20px;

    .item {
        margin-bottom: 20px;

        a {
            text-decoration: none;
            color: var(--article-color);
        }
    }

    .article-title {
        font-size: 1.2rem;
        font-weight: 700;
        margin-bottom: 10px;
        display: inline-block;
        position: relative;
        padding-left: 20px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        max-width: 100%;

        &::before {
            content: "";
            width: 5px;
            height: 5px;
            border: 5px solid var(--theme-color);
            position: absolute;
            border-radius: 50%;
            left: 0;
            bottom: 3px;
        }

        &:hover {
            color: var(--theme-color);
        }
    }

    p {
        padding-left: 20px;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 2;
    }
}
</style>