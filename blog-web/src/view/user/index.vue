<template>
    <div class='user-main'>
        <div class="user-warpper">
            <div class="userBox">
                <div class="backgroupImg">
                    <img v-lazy="user.bjCover" :key="user.bjCover">
                    <div class="more">
                        <div class="menu">
                            <ul>
                                <li @click="handleUpdateInfo">
                                    <i class="el-icon-edit"></i> 修改资料
                                </li>
                                <li @click="handleClikeMoreData">
                                    <i class="el-icon-user"></i> 更多资料
                                </li>
                                <li>
                                    <el-upload class="avatar-uploader" :show-file-list="false" ref="upload" name="filedatas"
                                        :action="uploadPictureHost" :http-request="uploadBjCoverFile" multiple>
                                        <i class="el-icon-camera"></i> 修改封面
                                    </el-upload>
                                </li>
                            </ul>
                        </div>
                        <i class="el-icon-more-outline moreBtn"></i>
                    </div>

                </div>
                <div class="user-item">
                    <div class="toolbar">
                        <img class="cover" :src="user.avatar" alt="">
                    </div>
                    <div class="userInfo">
                        <div class="nickname">
                            昵称：<span>{{ user.nickname }}</span>
                            <el-tooltip class="item" effect="dark" content="LV1" placement="top">
                                <span>
                                    <svg-icon icon-class="level1"></svg-icon>
                                </span>
                            </el-tooltip>

                        </div>
                        <div class="desc">
                            个人简介：{{ user.intro ? user.intro : "这家伙很懒，什么都没有写..." }}
                        </div>
                    </div>
                </div>
            </div>
            <el-card class="bottom-box" style="background-color: var(--background-color);">
                <div class="title">
                    <ul>
                        <li ref="btn" :class="index == 0 ? 'active' : ''" @click="btnClike(index)"
                            v-for="(item, index) in btnList" :key="index">
                            <span class="item-title">
                                <i :class="item.icon"></i> {{ item.name }}
                            </span>
                        </li>
                    </ul>

                </div>
                <!-- <div class="btnBox">
                    <div class="btn" @click="handleClike(1)">发布</div>
                    <div class="btn" @click="handleClike(2)">待审核</div>
                    <div class="btn" @click="handleClike(0)">下架</div>
                </div> -->
                <div class="articleBox" v-if="dataList.length">
                    <div>
                        <div v-if="pageData.index != 2" class="article" v-for="(item, index) in dataList" :key="index">
                            <router-link :to="'/article/' + item.id">
                                <div class="article-cover">
                                    <img v-lazy="item.avatar" :key="item.avatar">
                                </div>
                            </router-link>

                            <div class="article-info">
                                <router-link :to="'/article/' + item.id">
                                    <div class="article-title">
                                        {{ item.title }}
                                    </div>
                                </router-link>

                                <div class="article-desc">
                                    {{ item.summary }}
                                </div>
                                <div class="article-tag">
                                    <el-tag size="small" @click="handleClike(item.categoryId, '/categorys')">
                                        <i class=" el-icon-folder-opened"></i> {{ item.categoryName }}
                                    </el-tag>
                                    <el-tag :type="tagStyle[Math.round(Math.random() * 4)]" size="small"
                                        v-for="tag in item.tagList" :key="tag.id" @click="handleClike(tag.id, '/tag')">
                                        <i class="el-icon-collection-tag"></i> {{ tag.name }}
                                    </el-tag>
                                </div>
                                <div class="article-user">
                                    <span class=" item">
                                        <i class=" el-icon-user"></i>
                                        <span class="nickname">{{ item.username }}</span>
                                    </span>

                                    <span class="time item">
                                        <i class="el-icon-time"></i>{{ item.createTime }}
                                    </span>

                                </div>

                            </div>
                            <span class="articleBtn">
                                <div v-if="pageData.index == 0">
                                    <el-tooltip class="item" effect="dark" content="修改文章" placement="top">
                                        <el-button type="primary" size="mini" @click="handleUpdateArticle(item.id)"
                                            icon="el-icon-edit" circle></el-button>
                                    </el-tooltip>
                                    <el-tooltip class="item" effect="dark" content="删除文章" placement="top">
                                        <el-button type="danger" size="mini" @click="handleDeleteArticle(index, item.id)"
                                            icon="el-icon-delete" circle></el-button>
                                    </el-tooltip>
                                </div>

                                <el-tooltip v-if="pageData.index == 1" class="item" effect="dark" content="取消收藏"
                                    placement="top">
                                    <el-button type="danger" size="mini" @click="handleCanCollect(index, item.id)"
                                        icon="el-icon-delete" circle></el-button>
                                </el-tooltip>
                            </span>
                        </div>
                        <!-- 笔记列表 -->
                        <div v-if="pageData.index == 2" class="note" v-for="(item, index) in dataList" :key="index">
                            <div style="width: 100%;">
                                <span class="time">
                                    <i class="el-icon-time"></i> {{ item.createTime }}
                                </span>
                                <span style="float: right;">
                                    <el-tag style="margin-right: 10px;" size="small" v-if="item.categoryName">{{
                                        item.categoryName }}</el-tag>
                                    <el-tooltip class="item" effect="dark" content="删除笔记" placement="top">
                                        <el-button type="danger" size="mini" @click="handleDeleteNote(index, item.id)"
                                            icon="el-icon-delete" circle></el-button>
                                    </el-tooltip>
                                </span>
                            </div>
                            <v-md-preview :text="item.content" ref="preview" v-highlight />
                        </div>
                    </div>

                    <!-- 分页按钮 -->
                    <sy-pagination :pageNo="pageData.pageNo" :pages="pages" @changePage="onPage" />
                </div>
                <div v-else>
                    <sy-empty />
                </div>
            </el-card>
        </div>
        <el-dialog title="个人信息" :visible.sync="dialogTableVisible" :lock-scroll="false" :close-on-click-modal="false">
            <div style="">
                <div class="dialogItem item">
                    <span>
                        昵称：{{ form.nickname }}
                    </span>
                    <span>
                        简介：{{ form.intro }}
                    </span>
                </div>

                <div class="dialogItem item">
                    <span>
                        邮箱： {{ form.email }}
                    </span>
                    <span>
                        性别： 保密
                    </span>
                </div>
                <div class="dialogItem item">
                    <span>
                        地址： {{ form.address }}
                    </span>
                    <span>
                        个人网站： {{ form.webSite }}
                    </span>
                </div>
                <div class="item">
                    注册时间：{{ form.registerTime }}
                </div>
                <div class="item">
                    最后登录：{{ form.lastLoginTime }}
                </div>
            </div>
        </el-dialog>

        <!-- 修改资料弹出框 -->
        <el-dialog title="修改资料" center :visible.sync="editDialogTableVisible" :lock-scroll="false"
            :close-on-click-modal="false">
            <el-form label-position="left" label-width="60px" :model="form">
                <el-form-item label="昵称：">
                    <el-upload class="avatar-uploader" :show-file-list="false" ref="upload" name="filedatas"
                        :action="uploadPictureHost" :http-request="uploadSectionFile" multiple>
                        <img v-if="form.avatar" style="width: 50%;height: 50%;" :src="form.avatar" class="imgAvatar">
                        <i v-else class="el-icon-plus avatar-img-icon"></i>
                    </el-upload>
                </el-form-item>
                <el-form-item label="昵称：">
                    <el-input v-model="form.nickname"></el-input>
                </el-form-item>
                <el-form-item label="简介：">
                    <el-input v-model="form.intro"></el-input>
                </el-form-item>
                <el-form-item label="站点：">
                    <el-input v-model="form.webSite"></el-input>
                </el-form-item>
                <el-form-item label="邮箱">
                    <el-input v-model="form.email"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button type="primary" @click="updateUserInfo">提交</el-button>
            </span>
        </el-dialog>
    </div>
</template>
   
<script>
import {
    updateUserInfo, getUserInfo, upload, getMyArticle,
    deleteMyArticle
} from '@/api'
import { cancelCollect, getCollect } from '@/api/collect'
import { getMyNote, deleteNote } from '@/api/note'
export default {
    name: '',
    data() {
        return {
            user: this.$store.state.userInfo,
            uploadPictureHost: process.env.VUE_APP_BASE_API + "/file/upload",
            dataList: [],
            pageData: {
                pageNo: 1,
                pageSize: 10,
                index: 0
            },
            form: {},
            files: {},
            dialogTableVisible: false,
            editDialogTableVisible: false,
            tagStyle: ["success", "warning", "danger", "info"],
            btnList: ["文章", "收藏", "笔记"],
            btnList: [
                {
                    icon: "el-icon-document",
                    name: "文章"
                },
                {
                    icon: "el-icon-star-off",
                    name: "收藏"
                },
                {
                    icon: "el-icon-reading",
                    name: "笔记"
                },
            ],
        }
    },
    created() {
        this.selectAricleList()
    },
    methods: {

        updateUserInfo() {
            updateUserInfo(this.form).then(res => {
                this.user = this.form
                this.$message.success("修改成功")
                this.editDialogTableVisible = false
            })
        },
        handleClike(id, path) {
            this.$router.push({ path: path, query: { id: id } })
        },
        handleUpdateInfo() {
            this.handleBefore()
            this.editDialogTableVisible = true
        },
        handleClikeMoreData() {
            this.handleBefore()
            this.dialogTableVisible = true
        },
        handleBefore() {
            getUserInfo().then(res => {
                this.form = res.data
            })
        },
        handleUpdateArticle(id) {
            this.$store.state.articleDrawer.flag = true;
            this.$store.state.articleDrawer.id = id;
        },
        handleCanCollect(index, id) {
            this.$confirm('确认取消收藏该文章吗？', '提示', {
                lockScroll: false,
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            })
                .then(_ => {
                    cancelCollect(id).then(res => {
                        this.dataList.splice(index, 1)
                        this.$message.success("取消收藏成功")
                    })
                })
                .catch(_ => {
                    this.$message.info("取消关闭")
                });
        },
        handleDeleteArticle(index, id) {
            this.$confirm('确认删除该文章吗？', '提示', {
                lockScroll: false,
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            })
                .then(_ => {
                    deleteMyArticle(id).then(res => {
                        this.dataList.splice(index, 1)
                        this.$message.success("删除成功")
                    })
                })
                .catch(_ => {
                    this.$message.info("取消关闭")
                });
        },
        handleDeleteNote(index, id) {
            this.$confirm('确认删除该笔记吗？', '提示', {
                lockScroll: false,
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            })
                .then(_ => {
                    deleteNote(id).then(res => {
                        this.dataList.splice(index, 1)
                        this.$message.success("删除成功")
                    })
                })
                .catch(_ => {
                    this.$message.info("取消关闭")
                });
        },
        onPage() {
            this.pageData.pageNo++;
            this.before()
        },
        btnClike(index) {
            for (var i = 0; i < this.$refs.btn.length; i++) {
                this.$refs.btn[i].className = ""
            }
            this.$refs.btn[index].className = "active"
            this.dataList = []
            this.pageData.pageNo = 1
            this.pageData.index = index
            this.before()
        },
        before() {
            switch (this.pageData.index) {
                case 0:
                    this.selectAricleList()
                    break;
                case 1:
                    this.selectCollectionList()
                    break;
                case 2:
                    this.selectNoteList()
                    break;
                default:
                    this.selectAricleList()
                    break;
            }
        },
        selectAricleList(type) {
            if (type) {
                this.pageData.type = type
            }
            getMyArticle(this.pageData).then(res => {
                this.dataList.push(...res.data.records);
                this.pages = res.data.pages

            }).catch(err => {
                console.log(err)
            })
        },
        selectCollectionList() {
            getCollect(this.pageData).then(res => {
                this.dataList.push(...res.data.records);
                this.pages = res.data.pages
            })
        },
        selectNoteList() {
            getMyNote(this.pageData).then(res => {
                this.dataList.push(...res.data.records);
                this.pages = res.data.pages
            })
        },
        uploadBjCoverFile: function (param) {
            this.files = param.file
            // FormData 对象
            var formData = new FormData()
            // 文件对象
            formData.append('multipartFile', this.files)
            upload(formData).then(res => {
                let user = {
                    id: this.user.id,
                    bjCover: res.data
                }
                updateUserInfo(user).then(res => {
                    this.user.bjCover = res.data
                    this.$message.success("修改成功")
                })
            })

        },
        uploadSectionFile: function (param) {
            this.files = param.file
            // FormData 对象
            var formData = new FormData()
            // 文件对象
            formData.append('multipartFile', this.files)
            upload(formData).then(res => {
                this.form.avatar = res.data
            })

        },
    },
}
</script>
   
<style lang='scss' scoped>
/deep/ .vuepress-markdown-body {
    background-color: var(--background-color);
    color: var(--article-color);
}

/deep/ .el-dialog {
    .el-dialog__body {
        padding: 10px 20px;
    }

    .item {
        margin-bottom: 10px;
    }

    .dialogItem {
        display: flex;

        span {
            width: 50%;
        }
    }
}

.user-main {
    display: flex;
    justify-content: center;

    @media screen and (max-width: 1118px) {
        padding: 10px;

        /deep/ .el-dialog {
            width: 90%;
            border-radius: 10px;

            .dialogItem {
                display: flex;

                span {
                    width: 50%;
                }
            }
        }

        .user-warpper {
            width: 100%;
            margin-top: 80px;
        }

        .article-cover {
            display: none;
        }
    }

    @media screen and (min-width: 1119px) {
        /deep/ .el-dialog {
            width: 30%;
            border-radius: 10px;

            .dialogItem {
                display: flex;

                span {
                    width: 50%;
                }
            }
        }

        .user-warpper {
            width: 65%;
            margin-top: 80px;
        }

        .article-cover {
            width: 160px;
            height: 110px;
            cursor: pointer;
            overflow: hidden;
            border: 1px solid var(--border-line);


            img {
                height: 100%;
                width: 100%;
                border-radius: 5px;
                transition: all 0.5s;
            }



            &:hover {
                img {
                    transform: scale(1.1);
                }
            }
        }
    }

    .user-warpper {
        display: flex;
        flex-direction: column;
    }

    .userBox {
        border-radius: 10px;
        background-color: var(--background-color);

        .backgroupImg {
            position: relative;
            width: 100%;

            img {
                width: 100%;
                height: 400px;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;

            }

            .more {
                position: absolute;
                right: 20px;
                bottom: 15px;
                color: #fff;
                cursor: pointer;

                .menu {
                    background-color: var(--background-color);
                    color: var(--text-color);
                    padding: 10px 0;
                    border-radius: 5px;
                    font-size: 0.9rem;
                    width: 100px;
                    text-align: center;
                    position: absolute;
                    right: 0px;
                    bottom: 15px;
                    display: none;
                    animation: fade-in 0.3s linear 1;

                    @keyframes fade-in {
                        0% {
                            transform: scale(0);
                        }

                        100% {
                            transform: scale(1);
                        }
                    }

                    ul {
                        list-style: none;
                    }

                    li {
                        padding: 5px;

                        &:hover {
                            color: var(--theme-color);
                            background-color: #eee;
                        }

                    }
                }

                &:hover {
                    .moreBtn {
                        color: var(--theme-color);
                    }

                    .menu {
                        display: block;

                    }

                }
            }
        }

        .user-item {
            height: 80px;
            display: flex;
            margin-bottom: 20px;
            position: relative;

            .toolbar {
                padding: 5px;
                background-color: var(--background-color);
                border-radius: 5px;
                width: 150px;
                margin-top: -80px;
                margin-left: 50px;
            }

            .cover {
                object-fit: cover;
                width: 100%;
                height: 100%;
            }

            .userInfo {
                margin: 20px;
                color: var(--article-color);
                font-style: italic;

                .nickname {

                    margin-bottom: 10px;


                    svg {
                        width: 35px;
                        height: 35px;
                        vertical-align: -12px;
                    }

                    span {
                        margin-right: 5px;
                        font-weight: 700;
                        background: radial-gradient(circle at 49.86% 48.37%, #0090ff 0, #0089ff 3.33%, #3a82ff 6.67%, #717aff 10%, #9371fb 13.33%, #ae67ef 16.67%, #c45de1 20%, #d652d2 23.33%, #e448c2 26.67%, #ef3eb0 30%, #f7369e 33.33%, #fd318c 36.67%, #ff317a 40%, #ff3569 43.33%, #fd3d57 46.67%, #f94646 50%, #f35035 53.33%, #ea5a22 56.67%, #e16308 60%, #d56d00 63.33%, #c97500 66.67%, #bb7d00 70%, #ac8300 73.33%, #9d8900 76.67%, #8c8f00 80%, #7a9300 83.33%, #669700 86.67%, #4f9b00 90%, #309e0e 93.33%, #00a029 96.67%, #00a23d 100%);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                    }
                }

                .desc {

                    font-size: 0.9rem;
                }
            }
        }

    }


    .bottom-box {
        border-radius: 10px;
        margin-top: 20px;
        padding: 10px;
        min-height: 500px;

        .title {
            padding: 10px;

            ul {
                display: flex;
                list-style: none;

                li {
                    margin-right: 20px;
                    cursor: pointer;
                    color: var(--text-color);

                    &:hover {
                        color: var(--theme-color);
                    }

                    .item-title {
                        margin-right: 5px;
                    }
                }

                .active {
                    color: var(--theme-color);
                    font-weight: 700;
                    font-style: italic;
                }
            }

            border-bottom: 1px solid var(--border-line);
        }

        .btnBox {
            padding: 10px;

            .btn {
                display: inline-block;
                margin-right: 10px;
                background-color: rgba(136, 136, 136, .1);
                padding: 6px;
                border-radius: 5px;
                font-size: 0.9rem;
                color: var(--text-color);
                cursor: pointer;

                &:hover {
                    background-color: var(--theme-color);
                    color: #fff;
                }
            }
        }

        .articleBox {
            height: 100%;
            padding: 10px;

            .article {
                display: flex;
                padding: 10px;
                border-bottom: 2px dashed var(--border-line);
                margin-bottom: 20px;
                border-radius: 5px;

                &:last-child {
                    border-bottom: 0;
                }

                .articleBtn {
                    margin-left: 150px;
                    width: 20%;
                    text-align: right;
                    display: none;
                }



                &:hover {
                    .articleBtn {
                        display: block;
                    }

                    background-color: #9093994a;
                }





                .article-info {
                    margin-left: 20px;
                    width: 70%;

                    a {
                        text-decoration: none;
                        color: var(--article-color);
                    }

                    .article-title {
                        font-size: 1.1rem;
                        font-weight: 600;

                        &:hover {
                            color: var(--theme-color);
                            cursor: pointer;
                        }
                    }

                    .article-desc {
                        overflow: hidden;
                        text-overflow: ellipsis;
                        display: -webkit-box;
                        -webkit-box-orient: vertical;
                        -webkit-line-clamp: 2;
                        margin-bottom: 10px;
                        margin-top: 5px;
                        color: var(--text-color);
                    }

                    .article-tag {
                        .el-tag {
                            margin-right: 5px;
                            cursor: pointer;
                        }
                    }

                    .article-user {
                        display: flex;
                        align-items: center;
                        margin-top: 10px;

                        .nickname {
                            color: var(--theme-color);
                        }

                        .item {
                            padding: 0 5px;
                            color: var(--text-color);

                            i {
                                margin-right: 5px;
                            }
                        }
                    }
                }


            }

            .note {
                margin-bottom: 20px;
                border-bottom: 2px dashed var(--border-line);

                &:last-child {
                    border-bottom: 0;
                }

                .time {
                    color: var(--text-color);
                }
            }
        }
    }
}
</style>