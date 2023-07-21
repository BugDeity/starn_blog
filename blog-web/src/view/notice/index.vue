<template>
    <div class='sysnotice'>
        <div class="notice-container">
            <div class="left-toolbar">
                <div ref="leftIem" :class="pageData.type == index ? 'left-item active' : 'left-item'"
                    v-for="(item, index) in leftIems" :key="index" @click="handleClike(item, index)">
                    <i :class="item.icon"></i> {{ item.name }}
                </div>
            </div>
            <div class="rigth-toolbar">
                <div class="rigth-top">
                    <span class="top-title">
                        {{ title }}
                    </span>
                    <span class="clearAllbtn" @click="clearMessage(null)">
                        <i class="el-icon-delete"></i> 清空所有消息
                    </span>
                </div>

                <div v-if="noticeList.length">
                    <div class="rigth-bottom" v-for="(item, index) in noticeList" :key="index">
                        <div class="user-info">
                            <img v-if="item.noticeType" class="avatar" :src="item.fromUserAvatar" alt="">
                            <img v-else class="avatar" :src="$store.state.webSiteInfo.logo" alt="">
                            <span class="nickname" v-if="item.noticeType">{{ item.fromUserNickname }}</span>
                            <span class="nickname" v-else>系统</span>
                            <span class="user-item" v-if="item.noticeType">
                                <i class="el-icon-location"></i> IP属地:{{ splitIpAddress(item.ipSource) }}
                            </span>
                            <span class="user-item">
                                <i class="el-icon-time"></i> {{ item.createTimeStr }}
                            </span>
                            <span class="user-item" v-if="item.commentMark == 1">
                                <i class="el-icon-link"></i> 在文章 <span @click="handleArticleClick(item.articleId)"
                                    class="title">{{ item.articleTitle }}</span> 中，回复了你的评论
                            </span>
                            <span class="user-item" v-if="item.commentMark == 2">
                                <i class="el-icon-link"></i> 评论了你的文章: <span class="title"
                                    @click="handleArticleClick(item.articleId)">{{ item.articleTitle }}</span>
                            </span>
                            <span class="clearBtn" @click="clearMessage(item.id, index)">
                                <i class="el-icon-delete"></i>
                            </span>
                        </div>
                        <div class="content-box">
                            <div v-if="item.noticeType <= 1">
                                {{ item.content }}
                            </div>

                            <div v-if="item.noticeType == 2">
                                关注了你
                            </div>
                            <div v-if="item.noticeType == 3">
                                点赞了你的文章 <span class="title" @click="handleArticleClick(item.articleId)">" {{
                                    item.articleTitle
                                }} "</span>
                            </div>
                            <div v-if="item.noticeType == 4">
                                收藏了你的文章 <span class="title" @click="handleArticleClick(item.articleId)">" {{
                                    item.articleTitle
                                }} "</span>
                            </div>
                        </div>
                    </div>

                    <div class="page" v-if="pageData.pageNo < pages" @click="onPage">
                        <div>
                            加载更多
                        </div>
                    </div>
                    <div style="text-align: center;color: var(--text-color);margin-top: 20px;" v-else>
                        我也是有底线的--
                    </div>
                </div>
                <div class="empty-box" v-else>
                    <el-empty description="暂未新通知哦"></el-empty>
                </div>


            </div>
        </div>
    </div>
</template>
   
<script>
import { getMessageNotice, deleteMessage } from '@/api/im'
export default {
    name: '',
    data() {
        return {
            pageData: {
                pageNo: 1,
                pageSize: 5,
                type: this.$route.query.type ? this.$route.query.type : 0,
            },
            pages: 0,
            loading: [],
            leftIems: [
                {
                    name: "系统",
                    icon: "el-icon-setting"
                },
                {
                    name: "评论",
                    icon: "iconfont icon-pinglun"
                },
                {
                    name: "关注",
                    icon: "el-icon-view"
                },
                {
                    name: "点赞",
                    icon: "iconfont icon-dianzan1"
                },
                {
                    name: "收藏",
                    icon: "el-icon-star-off"
                },

            ],
            title: "系统",
            noticeList: []
        }
    },
    created() {
        // console.log('------created--------');
        this.title = this.leftIems[this.pageData.type].name
        this.getList()
    },
    methods: {
        onPage() {
            this.pageData.pageNo++;
            this.getList()
        },
        clearMessage(id, index) {
            this.$confirm('此操作将永久删除消息, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                lockScroll: false,
                type: 'warning'
            }).then(() => {
                this.openLoading()
                let params = {
                    id: id,
                    type: this.pageData.type
                }
                deleteMessage(params).then(res => {
                    if (index != null) {
                        this.$delete(this.noticeList, index);
                    } else {
                        this.noticeList = []
                    }
                    this.$message.success("删除成功")
                    this.loading.close()
                }).catch(err => {
                    this.$message.error(err.message)
                    this.loading.close()
                })
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '已取消删除'
                });
            });

        },
        handleArticleClick(id) {
            this.$router.push({ path: "articleInfo", query: { articleId: id } })
        },
        //截取地址
        splitIpAddress(address) {
            return address.split("|")[1]
        },
        handleClike(item, index) {
            this.$refs.leftIem[this.pageData.type].className = "left-item"
            this.$refs.leftIem[index].className += " active"
            this.title = item.name
            this.pageData.type = index
            this.pageData.pageNo = 1
            this.noticeList = []
            this.getList()
        },
        getList() {
            this.openLoading()
            getMessageNotice(this.pageData).then(res => {
                this.noticeList.push(...res.data.records)
                this.pages = res.data.pages
                this.loading.close()
            }).catch(err => {
                this.loading.close()
            })
        },
        // 打开加载层
        openLoading: function () {
            this.loading = this.$loading({
                lock: true,
                text: "正在加载中~",
                spinner: "el-icon-loading",
                background: "rgba(0, 0, 0, 0.7)",
                fullscreen: false
            });
        },
    },
}
</script>
   
<style lang='scss' scoped>
@media screen and (max-width: 1118px) {
    .sysnotice {
        padding: 5px;

        .notice-container {
            margin-top: 60px;
            width: 100%;

            .left-toolbar {
                width: 22%;

                .left-item {
                    margin-bottom: 20px;
                }
            }

            .avatar {
                width: 30px;
                height: 30px;
            }
        }
    }
}

@media screen and (min-width: 1119px) {
    .sysnotice {
        .notice-container {
            margin-top: 80px;
            width: 70%;

            .left-toolbar {
                width: 10%;

                .left-item {
                    padding: 10px;
                }
            }

            .avatar {
                width: 50px;
                height: 50px;
            }
        }
    }
}

.sysnotice {
    display: flex;
    justify-content: center;
    position: relative;

    .notice-container {
        padding: 20px;
        display: flex;
        background-color: var(--background-color);
        border-radius: 5px;
        color: var(--article-color);

        .left-toolbar {
            padding-right: 20px;
            border-right: 2px solid var(--border-line);
            text-align: center;


            .left-item {
                cursor: pointer;

                .icon-dianzan1 {
                    font-size: 0.9rem;
                }

                &:hover {
                    color: var(--theme-color);
                }
            }

            .active {
                color: var(--theme-color);
            }
        }

        .clearAllbtn,
        .clearBtn {
            cursor: pointer;
            float: right;
        }

        .rigth-toolbar {
            margin-left: 10px;
            width: 100%;

            .rigth-top {
                border-bottom: 2px solid var(--border-line);
                padding-bottom: 5px;

                .top-title {
                    font-weight: 700;
                }

                .clearAllbtn {
                    color: var(--text-color);
                }
            }

            .rigth-bottom {
                margin-top: 10px;

                .user-info {
                    position: relative;

                    .avatar {
                        vertical-align: middle;
                        border: 1px solid var(--border-line);
                        margin-right: 5px;
                        border-radius: 50%;
                    }

                    .nickname {
                        font-weight: 600;
                        color: var(--theme-color);
                    }

                    .user-item {
                        margin-left: 10px;
                        color: var(--text-color);
                        font-size: 0.8rem;
                    }

                    .clearBtn {
                        line-height: 50px;
                    }
                }

                .title {
                    cursor: pointer;
                    font-weight: 600;
                    font-style: italic;

                    &:hover {
                        color: var(--theme-color);
                    }
                }

                .content-box {
                    margin-left: 50px;
                    margin-top: 20px;
                    border-bottom: 2px solid var(--border-line);
                    padding-bottom: 20px;
                    color: var(--text-color);

                }
            }

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
        }
    }
}
</style>