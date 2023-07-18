<template>
    <div class='note-wapper'>
        <div class="main">
            <div class="note">
                <div class="categoryBox">
                    <ul>
                        <li ref="categoryRef" :class="index ? 'category_item' : 'active'" @click="handleClike(item, index)"
                            v-for="(item, index) in categoryList" :key="index">
                            {{ item.name }}
                        </li>

                    </ul>
                </div>
                <div class="rigthBox">
                    <div class="sendBox">
                        <el-input type="textarea" :autosize="{ minRows: 5, maxRows: 100 }"
                            placeholder="请输入笔记内容,支持【Markdown】语法" v-model="content">
                        </el-input>

                        <div class="bottom">
                            <span class="category">
                                <span class="item" @click="generateCode">
                                    <i class="iconfont icon-code"></i> 代码块
                                </span>
                                <el-dropdown trigger="click" placement="bottom-start">
                                    <span class="el-dropdown-link item" style="cursor: pointer;">
                                        <i class="el-icon-position"></i>
                                        笔记分类
                                    </span>
                                    <el-dropdown-menu slot="dropdown">
                                        <el-dropdown-item command="a">
                                            <el-select v-model="chooseIndex" placeholder="请选择" @change="handleChange">
                                                <el-option v-for="(item, index) in categoryList" :key="item.id"
                                                    :label="item.name" :value="index">
                                                </el-option>
                                            </el-select>
                                        </el-dropdown-item>
                                    </el-dropdown-menu>
                                </el-dropdown>
                                <el-tag style="margin-left: 10px;" v-if="chooseCategory" type="success" size="small">{{
                                    chooseCategory.name }}</el-tag>
                            </span>
                            <div class="btn">
                                <div class="emoji-wrapper" v-show="chooseEmoji">
                                    <Emoji @chooseEmoji="handleChooseEmoji" />
                                </div>
                                <span class="emojiBtn" @click.stop="chooseEmoji = !chooseEmoji">
                                    <svg-icon icon-class="emoji1"></svg-icon>
                                </span>
                                <el-button size="small" type="primary" @click="addNote">发布笔记</el-button>
                            </div>
                        </div>
                        <div>
                            <span style="color: #67c23a;">tips:由于笔记是记录代码中的部分知识，所以请不要随意发布无用笔记，无用笔记随时会被删除掉</span>
                        </div>
                    </div>


                    <div class="noteItem">
                        <ul v-if="noteList.length > 0">
                            <li class="item" v-for="(item, index) in noteList" :key="index">
                                <div class="userInfo">
                                    <el-avatar class="avatar" :src="item.avatar"></el-avatar>
                                    <span class="username">{{ item.nickname }}</span>
                                    <span class="time"> <i class="el-icon-time"></i> {{ item.createTimeStr }}</span>
                                    <span class="categoryItem" v-if="item.categoryName">
                                        <el-tag style="float: right;" size="small">
                                            {{ item.categoryName }}
                                        </el-tag>
                                    </span>

                                </div>
                                <div class="content">
                                    <v-md-preview v-highlight :text="item.content" ref="preview" />
                                </div>
                                <div class="content-btn">
                                    <span v-if="$store.state.userInfo.id == item.userId"
                                        @click="handleDelete(item.id, index)">删除</span>
                                </div>
                            </li>
                            <div v-if="pageData.pageNo == pages" style="text-align: center;color: var(--text-color);">
                                我也是有底线的~~~</div>
                            <!-- 分页按钮 -->
                            <div class="page" v-else @click="handlePage">
                                加载更多
                            </div>
                        </ul>
                        <el-empty v-else description="暂未发布笔记"></el-empty>

                    </div>

                </div>

            </div>
        </div>
    </div>
</template>
   
<script>
import { getNote, insertNote, deleteNote } from '@/api/note'
import { featchCategory } from '@/api'
import Emoji from '@/components/emoji'
export default {
    components: {
        Emoji
    },
    name: '',
    data() {
        return {
            pageData: {
                pageNo: 1,
                pageSize: 8,
                categoryId: null
            },
            pages: 0,
            chooseEmoji: false,
            noteList: [],
            loading: [],
            categoryList: [],
            chooseIndex: 0,
            chooseCategory: {
                id: null,
                name: "全部"
            },
            content: ""
        }
    },
    mounted() {

        //添加代码复制按钮复制成功提示
        document.addEventListener("click", e => {
            if (e.target.className != "iconfont icon-biaoqing") {
                this.chooseEmoji = false
            }
            if (e.target.className === "v-md-copy-code-btn") {
                this.$message.success("复制成功")
            }
        })
    },
    created() {
        featchCategory().then(respose => {
            this.categoryList.push(...respose.data)
            this.categoryList.unshift(
                {
                    id: null,
                    name: "全部"
                })
        })
        this.getNoteList()
    },
    methods: {
        handleDelete(id, index) {
            this.$confirm('此操作将永久删除该笔记, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                deleteNote(id).then(respose => {
                    this.$delete(this.noteList, index);
                    this.$message({
                        type: 'success',
                        message: '删除成功!'
                    });
                })
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '已取消删除'
                });
            });
        },
        handleChange(index) {
            this.chooseCategory = this.categoryList[index]
        },
        generateCode() {
            this.content += "```使用Enter换行```"
        },
        handleClike(item, index) {
            for (var i = 0; i < this.$refs.categoryRef.length; i++) {
                this.$refs.categoryRef[i].className = "category_item"
            }
            this.$refs.categoryRef[index].className = "active"
            this.chooseCategory = item
            this.chooseIndex = index

            this.pageData.pageNo = 1
            this.pageData.categoryId = item.id
            this.getNoteList()
        },
        handlePage() {
            this.pageData.pageNo++
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
        addNote() {
            if (this.content == null || this.content == "") {
                this.$message.error("内容不能为空！");
                return;
            }
            this.openLoading()
            let note = {
                content: this.content,
                categoryId: this.chooseCategory ? this.chooseCategory.id : null
            }
            insertNote(note).then(res => {
                this.content = ""
                this.$message.success("发布笔记成功");
                this.pageData.pageNo = 1
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
                this.noteList = res.data.records
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
        handleChooseEmoji(value) {
            this.content += value
            this.chooseEmoji = false
        },
    },
}
</script>
   
<style lang="scss" scoped>
/deep/ .el-dropdown-menu__item:hover {
    background-color: var(--background-color);
}

/deep/ .el-input__inner {
    background-color: var(--background-color);
}

@media screen and (max-width: 1118px) {
    /deep/ .vuepress-markdown-body div[class*=v-md-pre-wrapper-] {
        margin: 0;
    }

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

                .categoryBox {
                    display: none;
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

                        .bottom {
                            height: 50px;
                            margin-top: 10px;
                            position: relative;

                            .category {
                                font-size: 0.9rem;
                                color: #8a8888;
                            }

                            .btn {
                                float: right;
                                align-items: center;

                                .emoji-wrapper {
                                    position: absolute;
                                    top: -140px;
                                    left: 0px;
                                }

                                .emojiBtn {
                                    cursor: pointer;

                                    svg {
                                        width: 20px;
                                        height: 20px;
                                        margin-right: 10px;
                                        vertical-align: -5px;
                                    }
                                }
                            }
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

                .categoryBox {
                    width: 8%;
                    margin-right: 30px;
                    position: fixed;

                    .category_item,
                    .active {
                        margin-bottom: 5px;
                        cursor: pointer;
                        padding: 8px;
                        text-align: center;
                        color: var(--article-color);
                    }

                    .category_item:hover {
                        background-color: #c3c3c3;
                        color: var(--theme-color);
                    }

                    .active {
                        background-color: var(--theme-color);
                        color: var(--baise);
                    }

                }

                .rigthBox {
                    width: 75%;
                    margin: 0 auto;

                    .sendBox {
                        background-color: var(--background-color);
                        height: auto;
                        padding: 20px;
                        overflow: auto;
                        zoom: 1;
                        border-radius: 5px;
                        margin-left: 20px;

                        /deep/ .el-textarea__inner {
                            background-color: var(--background-color) !important;
                            color: var(--article-color);
                        }

                        .bottom {
                            height: 50px;
                            margin-top: 10px;
                            position: relative;

                            .category {
                                font-size: 0.9rem;

                                .item {
                                    cursor: pointer;
                                    margin-right: 20px;
                                    color: var(--text-color);
                                }
                            }

                            .btn {
                                float: right;
                                align-items: center;

                                .emoji-wrapper {
                                    position: absolute;
                                    top: -140px;
                                    left: 0px;
                                }

                                .emojiBtn {
                                    cursor: pointer;

                                    svg {
                                        width: 20px;
                                        height: 20px;
                                        margin-right: 10px;
                                        vertical-align: -5px;
                                    }
                                }

                            }
                        }
                    }

                    .noteItem {
                        margin-top: 20px;
                        margin-left: 20px;

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

                                .content-btn {
                                    padding-left: 20px;
                                    padding-top: 10px;

                                    span {
                                        color: var(--text-color);
                                        cursor: pointer;

                                        &:hover {
                                            color: var(--theme-color);
                                        }
                                    }
                                }

                                .userInfo {
                                    align-items: center;
                                    height: 50px;
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