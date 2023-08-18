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
                                <el-button size="small" type="primary" @click="addNote">发布笔记</el-button>
                            </div>
                        </div>
                        <div>
                            <h4 style="color: #FFA000">Tips:由于笔记是记录代码中的部分知识，所以请不要随意发布无用笔记，无用笔记随时会被删除掉</h4>
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
                            <!-- 分页按钮 -->
                            <div @click="handlePage">
                                <Pagination :pageNo="pageData.pageNo" :pages="pages" />
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
import Pagination from '@/components/pagination/index.vue'
export default {
    components: {
        Pagination
    },
    metaInfo: {
        meta: [{
            name: 'keyWords',
            content: "拾壹博客,开源博客,www.shiyit.com"  //变量或字符串
        }, {
            name: 'description',
            content: "一个专注于技术分享的博客平台,大家以共同学习,乐于分享,拥抱开源的价值观进行学习交流"
        }]
    },
    name: '',
    data() {
        return {
            pageData: {
                pageNo: 1,
                pageSize: 10,
                categoryId: null
            },
            pages: 0,
            noteList: [],

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
                lockScroll: false,
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

            getNote(this.pageData).then(res => {
                this.noteList.push(...res.data.records)
                this.pages = res.data.pages

            }).catch(err => {

            })
        },
        addNote() {
            if (this.content == null || this.content == "") {
                this.$message.error("内容不能为空！");
                return;
            }

            let note = {
                content: this.content,
                categoryId: this.chooseCategory ? this.chooseCategory.id : null
            }
            insertNote(note).then(res => {
                this.content = ""
                this.$message.success("发布笔记成功");
                this.pageData.pageNo = 1

                this.getNoteList()
            }).catch(err => {

            })
        },
        getNoteList() {

            getNote(this.pageData).then(res => {
                this.noteList = res.data.records
                this.pages = res.data.pages

            }).catch(err => {

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
   
<style lang="scss" scoped>
/deep/ .el-dropdown-menu__item:hover {
    background-color: var(--background-color);
}

/deep/ .el-input__inner {
    background-color: var(--background-color);
}


.note-wapper {
    display: flex;
    justify-content: center;
    position: relative;

    @media screen and (max-width: 1118px) {
        padding-left: 10px;
        padding-right: 10px;

        /deep/ .vuepress-markdown-body div[class*=v-md-pre-wrapper-] {
            margin: 0;
        }

        .main {
            margin-top: 70px;
            width: 100%;
            height: 100%;

            .categoryBox {
                display: none;
            }

            .rigthBox {
                width: 100%;
            }
        }
    }

    @media screen and (min-width: 1119px) {
        .main {
            margin-top: 80px;
            width: 65%;
            height: 100%;

            .categoryBox {
                width: 8%;
                margin-right: 30px;
                position: fixed;
            }

            .rigthBox {
                width: 75%;
            }

            .noteItem,
            .sendBox {
                margin-left: 20px;
            }
        }
    }

    .main {
        height: 100%;


        .note {
            display: flex;

            ul {
                list-style: none;
            }

            .categoryBox {

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
                margin: 0 auto;

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
                        border-color: var(--border-line);
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
                }
            }
        }
    }
}
</style>