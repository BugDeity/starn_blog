<template>
    <div class="tag-warpper">
        <div class="main">
            <div class="header">
                <span>目前共计{{ tagList.length }}个标签,继续加油</span>
            </div>
            <div id="time-line">
                <div class="item" v-for="(item, index) in tagList" :key="index" @click="handleClick(item.id, index)">
                    <div :class="handleChoose(item, index) ? 'item-index active' : 'item-index'" ref="tag">{{ item.name }}
                    </div>
                </div>
            </div>
            <div class="article" v-infinite-scroll="load" infinite-scroll-immediate="false"
                :infinite-scroll-disabled="isInfiniteScroll" :infinite-scroll-distance="5">
                <el-timeline style="margin-left: 5px;" v-if="articleList.length">
                    <el-timeline-item :timestamp="item.createTime" placement="top" v-for="(item, index) in articleList"
                        :key="index">
                        <el-card
                            style="padding: 15px;background-color: var(--background-color);border: 1px solid var(--border-line);">
                            <h4 @click="handleArticleClike(item.id)" class="title">{{ item.title }}</h4>
                            <div class="bottumItem">
                                <div class="articleUser">
                                    <el-avatar class="userAvatar" :src="item.userAvatar"></el-avatar>
                                    <span>{{ item.username }}</span>
                                </div>

                                <div class="tag">
                                    <el-tag style="margin-right: 8px; cursor: pointer;"
                                        :type="tagStyle[Math.round(Math.random() * 4)]" size="small"
                                        v-for="tag in item.tagList" :key="tag.id">{{ tag.name
                                        }}</el-tag>
                                </div>
                            </div>

                        </el-card>
                    </el-timeline-item>
                    <div v-if="this.pageData.pageNo >= this.pageTotal" style="text-align: center;color: var(--text-color);">
                        我也是有底线的~~~</div>
                </el-timeline>
                <el-empty v-else description="暂时没有该分类的文章"></el-empty>
            </div>
        </div>
    </div>
</template>


<script>
import { fetchArticleList, fetchTagList } from '@/api'
export default {
    metaInfo: {
        meta: [{
            name: 'keyWords',
            content: "拾壹博客,开源博客,www.shiyit.com"  //变量或字符串
        }, {
            name: 'description',
            content: "一个专注于技术分享的博客平台,大家以共同学习,乐于分享,拥抱开源的价值观进行学习交流"
        }]
    },
    data() {
        return {
            tagList: [],
            pageData: {
                pageNo: 1,
                pageSize: 5,
                tagId: this.$route.query.id,
            },
            // 加载层信息
            loading: [],
            articleList: [],
            pageTotal: 0,
            isInfiniteScroll: false, // 控制滚动禁用
            tagStyle: ['', 'success', 'info', 'warning', 'danger']
        };
    },
    created() {
        document.title = "文章标签";
        this.fetchTagList()
    },

    methods: {
        handleChoose(item, index) {
            if (this.pageData.tagId) {
                return item.id == this.pageData.tagId
            }
            return index == 0;
        },
        handleArticleClike(id) {
            this.$router.push({ path: '/articleInfo', query: { articleId: id } })
        },
        load() {

            if (this.pageData.pageNo < this.pageTotal) {
                this, this.pageData.pageNo++;
                this.fetchArticleList()
            }
        },
        handleClick(id, index) {
            for (var i = 0; i < this.$refs.tag.length; i++) {
                this.$refs.tag[i].className = "item-index"
            }
            this.$refs.tag[index].className = "item-index active"
            this.pageData.tagId = id
            this.pageData.pageNo = 1
            this.articleList = []
            this.fetchArticleList()
        },
        fetchTagList() {
            this.openLoading()
            fetchTagList().then(res => {
                this.tagList = res.data
                if (!this.pageData.tagId) {
                    this.pageData.tagId = this.tagList[0].id
                }
                this.fetchArticleList()
                this.loading.close()
            })
        },
        fetchArticleList() {
            fetchArticleList(this.pageData).then(res => {
                this.articleList.push(...res.data.records)
                this.pageTotal = res.data.pages
            })
        },
        // 打开加载层
        openLoading: function () {
            this.loading = this.$loading({
                lock: true,
                text: "正在加载中~",
                spinner: "el-icon-loading",
                background: "rgba(0, 0, 0, 0.7)"
            });
        },
    }
};
</script>
<style lang="scss" scoped>
.tag-warpper {
    display: flex;
    justify-content: center;
    position: relative;

    @media screen and (max-width: 1118px) {
        .main {
            margin-top: 70px;
            width: 100%;

            #time-line {
                float: left;
                width: 30%;

            }

            .article {
                width: 70%;
                overflow-y: scroll;
            }
        }
    }

    @media screen and (min-width: 1119px) {
        .main {
            margin-top: 80px;
            width: 65%;

            #time-line {
                float: left;
                width: 17%;

            }

            .article {
                width: 80%;
            }
        }
    }

    .main {

        .header {
            text-align: center;
            margin-bottom: 20px;
            padding: 10px;
            color: var(--theme-color);
            font-size: 1rem;
            font-weight: bold;
            border-bottom: 2px solid #e4e7ed;

            span {
                margin-right: 20px;
            }
        }

        .article {
            float: left;
            height: 800px;
            overflow-y: scroll;

            .title {
                color: var(--text-color);
                cursor: pointer;

                &:hover {
                    color: var(--theme-color);
                }
            }

            /deep/ .el-timeline-item__timestamp {
                color: var(--text-color);
                font-weight: bold;
                font-size: 0.8rem;
            }

            .bottumItem {
                align-items: center;
                height: 50px;
                display: flex;
                margin-top: 20px;

                .articleUser {
                    line-height: 50px;
                    font-size: 0.8rem;

                    span {
                        color: var(--theme-color);
                        margin-left: 3px;
                    }

                    .userAvatar {
                        vertical-align: top;
                        border: 1px solid var(--border-line);
                        transition: transform .5s;

                        &:hover {
                            transform: rotate(360deg);
                        }
                    }
                }

                .tag {
                    display: inline-block;
                    margin-left: 20px;
                }
            }

            .tag-item {
                margin-top: 20px;
                margin-right: 5px;
            }
        }

        #time-line {
            float: left;
        }

        .item {
            margin-left: 30px;
            /*用左边margin显示时间线*/
            width: calc(100% - 30px);
            /*因为左边部分用于显示时间线，所以右边部分减去30px*/
            height: auto;
            /*高度由内容决定*/
            position: relative;
            margin-bottom: 30px;
            cursor: pointer;

            &::before {
                content: "";
                width: 11px;
                height: 11px;
                border-radius: 100%;
                background-color: var(--theme-color);
                position: absolute;
                left: -15px;
            }

            &:last-child::after {
                display: none;
            }

            &::after {
                content: "";
                width: 3px;
                height: calc(100% + 30px);
                /*加上10px是item底部的margin*/
                background-color: var(--theme-color);
                position: absolute;
                top: 0;
                left: -11px;
            }

            &:hover {


                &::before {
                    transform: scale3d(1.2, 1.2, 1);
                    background-color: var(--theme-color);
                }

                &::after {
                    transform: scale3d(1.1, 1, 1);
                    background-color: var(--theme-color);
                }

                .item-index {
                    transform: scale3d(1.01, 1.01, 1);
                    color: var(--theme-color);
                }
            }


            .item-index {
                line-height: 12px;
                font-size: 14px;
                position: relative;
                color: var(--text-color);
                margin-left: 10px;
            }

            .active {
                color: var(--theme-color);
            }

            .item-content {
                width: 100%;
                height: auto;
                /*由内容决定*/
                font-size: 16px;
                position: relative;
                white-space: pre-wrap;
                /*保留空白符序列，但是正常地进行换行*/
                word-wrap: break-word;
                /*在长单词或 URL 地址内部进行换行*/
            }
        }
    }

}
</style>