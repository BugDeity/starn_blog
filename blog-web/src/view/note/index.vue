<template>
    <div class='note-wapper'>
        <div class="main">
            <div class="note">
                <div class="tag">
                    <ul>
                        <li>
                            全部
                        </li>
                        <li>
                            日常开发
                        </li>
                    </ul>
                </div>
                <div class="rigthBox">
                    <div class="sendBox">
                        <el-input type="textarea" :autosize="{ minRows: 5, maxRows: 100 }"
                            placeholder="请输入笔记内容,支持【Markdown】语法" v-model="content">
                        </el-input>
                        <div class="btn">
                            <el-button type="primary" @click="addNote">发布笔记</el-button>
                        </div>
                    </div>


                    <div class="noteItem">
                        <ul v-if="noteList.length > 0">
                            <li class="item" v-for="(item, index) in noteList" :key="index">
                                <div class="userInfo">
                                    <el-avatar class="avatar" :src="item.avatar"></el-avatar>
                                    <span class="username">{{ item.nickname }}</span>
                                    <span class="time">{{ item.createTime }}</span>
                                </div>
                                <div class="content">
                                    <v-md-preview :text="item.content" ref="preview" />
                                </div>

                            </li>
                        </ul>
                        <el-empty v-else description="本站暂未发布任何笔记"></el-empty>
                        <!-- 分页按钮 -->
                        <div class="page" v-if="pageData.pageNo < pages" @click="handlePage">
                            加载更多
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>
</template>
   
<script>
import { getNote, insertNote } from '@/api'
export default {
    name: '',
    data() {
        return {
            pageData: {
                pageNo: 1,
                pageSize: 10
            },
            pages: 0,
            noteList: [],
            loading: [],
            content: null
        }
    },

    created() {
        this.getNoteList()
    },
    methods: {
        handlePage() {
            this.pageData.pageNo++
            this.getNoteList()
        },
        addNote() {
            if (this.content == null || this.content == "") {
                this.$message.error("内容不能为空！");
                return;
            }
            this.openLoading()
            insertNote(this.content).then(res => {
                this.content = null
                this.$message.success("发布笔记成功");
                this.loading.close()
                this.getNoteList()
            }).catch(err => {
                this.$message.error(err.message);
                this.loading.close()
            })
        },
        getNoteList() {
            this.openLoading()
            getNote(this.pageData).then(res => {
                this.noteList.push(...res.data.records)
                this.pages = res.data.pages
                this.loading.close()
            }).catch(err => {
                this.$message.error(err.message);
                this.loading.close()
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
    },
}
</script>
   
<style lang="scss" scoped>
@media screen and (max-width: 1118px) {
    .note-wapper {
        display: flex;
        justify-content: center;
        position: relative;

        .main {
            margin-top: 60px;
            width: 100%;
            height: 100%;

            .note {
                display: flex;
                padding: 10px;

                ul {
                    list-style: none;
                }

                .tag {
                    display: none;
                }

                .rigthBox {
                    width: 100%;

                    .sendBox {
                        background-color: var(--background-color);
                        height: auto;
                        padding: 10px;
                        overflow: auto;
                        zoom: 1;
                        border-radius: 5px;

                        /deep/ .el-textarea__inner {
                            background-color: var(--background-color) !important;
                            color: var(--article-color);
                            border: 1px solid #2c3e50;
                        }

                        .btn {
                            float: right;
                            height: 50px;
                            margin-top: 10px;
                        }
                    }

                    .noteItem {
                        margin-top: 20px;

                        ul {

                            .item {
                                background-color: var(--background-color);
                                margin-bottom: 15px;
                                border-radius: 5px;

                                .content {
                                    color: var(--article-color);

                                    /deep/ .v-md-pre-wrapper {
                                        margin: 0;
                                    }

                                    /deep/ .vuepress-markdown-body {
                                        padding: 0 !important;
                                        background-color: var(--background-color) !important;
                                        color: var(--article-color);
                                    }
                                }

                                .userInfo {
                                    align-items: center;
                                    height: 50px;
                                    line-height: 50px;
                                    margin-bottom: 15px;

                                    .avatar {
                                        vertical-align: middle;
                                        border: 1px solid var(--border-line);
                                        margin-right: 10px;
                                    }

                                    .username {
                                        color: var(--theme-color);

                                    }

                                    .time {
                                        font-size: 0.8rem;
                                        color: var(--text-color);
                                        margin-left: 15px;
                                    }
                                }
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
        }
    }
}

@media screen and (min-width: 1119px) {
    .note-wapper {
        display: flex;
        justify-content: center;
        position: relative;

        .main {
            margin-top: 80px;
            width: 70%;
            height: 100%;

            .note {
                display: flex;

                ul {
                    list-style: none;
                }

                .tag {
                    width: 18%;
                    margin-right: 20px;

                    li {
                        margin-bottom: 20px;
                        cursor: pointer;
                        padding: 10px;
                        text-align: center;
                        color: var(--article-color);

                        &:hover {
                            background-color: #c3c3c3;
                            color: var(--theme-color);
                        }
                    }
                }

                .rigthBox {
                    width: 100%;

                    .sendBox {
                        background-color: var(--background-color);
                        height: auto;
                        padding: 20px;
                        overflow: auto;
                        zoom: 1;
                        border-radius: 5px;

                        /deep/ .el-textarea__inner {
                            background-color: var(--background-color) !important;
                            color: var(--article-color);
                        }

                        .btn {
                            float: right;
                            height: 50px;
                            margin-top: 10px;
                        }
                    }

                    .noteItem {
                        margin-top: 20px;

                        ul {

                            .item {
                                background-color: var(--background-color);
                                padding: 10px;
                                margin-bottom: 15px;
                                transition: box-shadow .35s, transform .35s;
                                border-radius: 5px;

                                &:hover {
                                    box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.2);
                                    transform: translateY(-2px)
                                }

                                .content {
                                    color: var(--article-color);

                                    /deep/ .vuepress-markdown-body {
                                        padding: 0 !important;
                                        background-color: var(--background-color) !important;
                                        color: var(--article-color);
                                    }
                                }

                                .userInfo {
                                    align-items: center;
                                    height: 50px;
                                    line-height: 50px;
                                    margin-bottom: 15px;

                                    .avatar {
                                        vertical-align: middle;
                                        border: 1px solid var(--border-line);
                                        margin-right: 10px;
                                    }

                                    .username {
                                        color: var(--theme-color);

                                    }

                                    .time {
                                        font-size: 0.8rem;
                                        color: var(--text-color);
                                        margin-left: 15px;
                                    }
                                }
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
        }
    }
}
</style>