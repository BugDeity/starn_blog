<template>
    <div class="userInfo-main">
        <el-drawer class="drawer" :append-to-body="true" title="我是标题" :with-header="false" :visible.sync="drawer"
            direction="rtl">
            <el-tabs style="height: calc(100vh - 50px);overflow: scroll;" v-model="activeName" tab-position="left"
                type="border-card" @tab-click="handeClike">

                <!-- 个人中心 -->
                <el-tab-pane name="user">
                    <span slot="label"><i class="el-icon-user-solid"></i> 个人中心</span>
                    <el-form label-position="left" label-width="60px" :model="form">
                        <el-form-item label="昵称：">
                            <el-upload class="avatar-uploader" :show-file-list="false" ref="upload" name="filedatas"
                                :action="uploadPictureHost" :before-upload="uploadBefore" :http-request="uploadSectionFile"
                                multiple>
                                <img v-if="form.avatar" style="width: 100%;height: 100%;" :src="form.avatar"
                                    class="imgAvatar">
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
                    <el-button type="primary" @click="update">提交</el-button>
                </el-tab-pane>

                <!-- 我的文章 -->
                <el-tab-pane name="article">
                    <span slot="label"><i class="el-icon-tickets"></i> 我的文章</span>
                    <el-timeline v-if="articleList.length">
                        <el-timeline-item :timestamp="item.createTime" placement="top" v-for="(item, index) in articleList"
                            :key="index">
                            <el-card class="myArticle">
                                <h4 @click="goArticleInfo(item.id)">{{ item.title }}</h4>
                                <div class="box">
                                    <div class="statu">
                                        <el-tag :type="statuTagStyle[item.isPublish]" size="small">{{
                                            statuTag[item.isPublish] }}</el-tag>
                                    </div>
                                    <div class="btn">
                                        <el-tooltip class="item" effect="dark" content="修改" placement="top-start">
                                            <el-button size="mini" @click="handleUpdateArticle(item.id)" type="primary"
                                                icon="el-icon-edit" circle></el-button>
                                        </el-tooltip>
                                        <el-tooltip class="item" effect="dark" content="删除" placement="top-start">
                                            <el-button size="mini" type="danger" icon="el-icon-delete"
                                                @click="deleteArticle(item.id, index)" circle></el-button>
                                        </el-tooltip>
                                    </div>
                                </div>
                            </el-card>
                        </el-timeline-item>
                        <!-- 分页按钮 -->
                        <div @click="handlePage('article')">
                            <Pagination :pageNo="pageData.pageNo" :pages="pages" />
                        </div>
                    </el-timeline>

                    <el-empty v-else description="暂未发表任何文章"></el-empty>
                </el-tab-pane>

                <!-- 我的收藏 -->
                <el-tab-pane name="collect">
                    <span slot="label"><i class="el-icon-star-off"></i> 我的收藏</span>
                    <el-timeline v-if="collectList.length">
                        <el-timeline-item :timestamp="item.createTime" placement="top" v-for="(item, index) in collectList"
                            :key="index">
                            <el-card class="myCollect">
                                <h4 @click="goArticleInfo(item.id)">{{ item.title }}</h4>
                                <div class="box">
                                    <div class="user">
                                        <el-avatar class="avatar" :size="40" :src="item.userAvatar">
                                            <img
                                                src="https://cube.elemecdn.com/e/fd/0fc7d20532fdaf769a25683617711png.png" />
                                        </el-avatar>
                                        <span class="nickname">{{ item.username }}</span>
                                    </div>
                                    <div class="btn">
                                        <el-tooltip class="item" effect="dark" content="取消收藏" placement="top-start">
                                            <el-button size="mini" type="danger" icon="el-icon-delete"
                                                @click="cancelCollect(item.id, index)" circle></el-button>
                                        </el-tooltip>
                                    </div>
                                </div>
                            </el-card>
                        </el-timeline-item>

                        <!-- 分页按钮 -->
                        <div @click="handlePage('collect')">
                            <Pagination :pageNo="pageData.pageNo" :pages="pages" />
                        </div>
                    </el-timeline>
                    <el-empty v-else description="暂未收藏文章"></el-empty>
                </el-tab-pane>

                <!-- 我的评论 -->
                <el-tab-pane name="comment">
                    <span slot="label"><i class="el-icon-chat-dot-round"></i> 我的评论</span>
                    <el-timeline v-if="commentList.length">
                        <el-timeline-item :timestamp="item.createTime" placement="top" v-for="(item, index) in commentList"
                            :key="index">
                            <el-card class="myComent">
                                <h4 @click="goArticleInfo(item.id)">{{ item.title }}</h4>
                                <div class="box">
                                    <div class="content">
                                        {{ item.commentContent }}
                                    </div>
                                </div>
                            </el-card>
                        </el-timeline-item>
                        <!-- 分页按钮 -->
                        <div @click="handlePage('comment')">
                            <Pagination :pageNo="pageData.pageNo" :pages="pages" />
                        </div>
                    </el-timeline>
                    <el-empty v-else description="暂未评论过文章"></el-empty>

                </el-tab-pane>

                <!-- 我的笔记 -->
                <el-tab-pane name="note">
                    <span slot="label"><i class="el-icon-notebook-1"></i> 我的笔记</span>
                    <el-timeline v-if="noteList.length">
                        <el-timeline-item :timestamp="item.createTime" placement="top" v-for="(item, index) in noteList"
                            :key="index">
                            <el-card class="myNote">
                                <div style="overflow: auto;zoom: 1;">
                                    <el-tag size="mini" v-if="item.categoryName">{{ item.categoryName }}</el-tag>
                                    <el-button @click="handleDeleteNote(item.id, index)" style="float: right;" type="danger"
                                        size="mini" icon="el-icon-delete" circle></el-button>
                                </div>
                                <v-md-preview :text="item.content" ref="preview" />
                            </el-card>
                        </el-timeline-item>

                        <!-- 分页按钮 -->
                        <div @click="handlePage('note')">
                            <Pagination :pageNo="pageData.pageNo" :pages="pages" />
                        </div>
                    </el-timeline>
                    <el-empty v-else description="暂未发布过笔记"></el-empty>

                </el-tab-pane>

                <!-- 我的反馈 -->
                <el-tab-pane name="feedback">
                    <span slot="label"><i class="el-icon-position"></i> 我的反馈</span>
                    <el-collapse value="1">
                        <el-collapse-item title="反馈须知" name="1">
                            <div>如碰到bug或者一些功能需求可再此向我反馈</div>
                        </el-collapse-item>
                    </el-collapse>
                    <div style="position: relative;height: 600px;">
                        <el-form style="" :rules="feedBackRules" ref="dataForm" label-position="left" :model="feedback">
                            <el-form-item label="反馈类型" prop="type">
                                <el-radio v-model="feedback.type" :label="1">需求</el-radio>
                                <el-radio v-model="feedback.type" :label="2">缺陷</el-radio>
                            </el-form-item>
                            <el-form-item label="标题" prop="title" label-width="25%">
                                <el-input placeholder="请输入标题" v-model="feedback.title" />
                            </el-form-item>
                            <div class="contentInput">
                                <el-form-item label="描述" prop="content" label-width="25%">
                                    <el-input :placeholder="feedback.type == 1 ? '请在此详细描述你的需求' : '请在此详细描述你的缺陷'" :rows="4"
                                        type="textarea" v-model="feedback.content" />
                                </el-form-item>
                            </div>
                            <el-button type="primary" @click="submit" round>确 定</el-button>
                        </el-form>
                    </div>
                </el-tab-pane>

                <!-- 修改密码 -->
                <el-tab-pane name="password">
                    <span slot="label"><i class="el-icon-unlock"></i> 修改密码</span>
                    <el-collapse value="1">
                        <el-collapse-item title="修改密码须知" name="1">
                            <div>此修改密码功能仅适用于账号和密码登录</div>
                            <div>对于第三方登录的账号，无法进行密码修改</div>
                        </el-collapse-item>
                    </el-collapse>
                    <el-form style="margin-top: 5px;" :rules="rules" ref="ruleForm" label-position="left"
                        label-width="100px" :model="form">
                        <el-form-item label="旧密码" prop="oldPassword">
                            <el-input v-model="form.oldPassword"></el-input>
                        </el-form-item>
                        <el-form-item label="新密码" prop="newPassword">
                            <el-input v-model="form.newPassword"></el-input>
                        </el-form-item>
                        <el-form-item label="确认密码" prop="new2Password">
                            <el-input v-model="form.new2Password"></el-input>
                        </el-form-item>
                    </el-form>
                    <el-button type="primary" @click="updatePassword" round>提交</el-button>
                </el-tab-pane>
            </el-tabs>
        </el-drawer>
    </div>
</template>
<script>
import {
    updateUserInfo, getUserInfo, upload, updatePassword, getMyArticle,
    deleteMyArticle, addFeedback
} from '@/api'
import { cancelCollect, getCollect } from '@/api/collect'
import { getMyNote, deleteNote } from '@/api/note'
import { getMyComment } from '@/api/comment'
import Pagination from '@/components/pagination/index.vue'
export default {
    components: {
        Pagination
    },
    data() {
        return {
            form: {},
            uploadPictureHost: process.env.VUE_APP_BASE_API + "/file/upload",
            // 加载层信息

            activeName: "user",
            statuTag: ['下架', '发布', '待审批'],
            statuTagStyle: ['danger', 'success', 'info'],
            files: {},
            articleList: [],
            collectList: [],
            commentList: [],
            noteList: [],
            pageData: {
                pageNo: 1,
                pageSize: 10
            },
            pages: 0,
            rules: {
                oldPassword: [
                    { required: true, message: '请输入旧密码', trigger: 'blur' },
                    { min: 3, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
                ],
                newPassword: [
                    { required: true, message: '请输入新密码', trigger: 'blur' }
                ],
                new2Password: [
                    { required: true, message: '请输入确认密码', trigger: 'blur' }
                ],
            },

            feedback: {
                type: 1,
                title: null,
                content: null
            },
            feedBackRules: {
                type: [
                    { required: true, message: '必填字段', trigger: 'blur' },
                ],
                title: [
                    { required: true, message: '必填字段', trigger: 'blur' },
                ],
                content: [
                    { required: true, message: '必填字段', trigger: 'blur' },
                ],
            },

        };
    },
    computed: {
        drawer: {
            set(value) {
                this.$store.state.userInfoDrawer.name = null;
                this.$store.state.userInfoDrawer.flag = value;
            },
            get() {
                if (this.$store.state.userInfoDrawer.flag) {
                    this.activeName = this.$store.state.userInfoDrawer.name ? this.$store.state.userInfoDrawer.name : 'user',
                        getUserInfo().then(res => {
                            this.form = res.data
                        })
                }
                return this.$store.state.userInfoDrawer.flag;
            }
        },
    },
    watch: {
        activeName(newValue) {
            this.pageData = {
                pageNo: 1,
                pageSize: 10

            }
            // 修改密码
            if (newValue == "password") {
            }
            if (newValue == "article") {
                this.articleList = []
                this.selectMyArticleList()
            }
            if (newValue == "feedback") {
                this.feedback = { type: 1 }
            }
            if (newValue == "collect") {
                this.collectList = []
                this.selectMyCollect()
            }

            if (newValue == "comment") {
                this.commentList = []
                this.selectMyComment()
            }
            if (newValue == "note") {
                this.noteList = []
                this.selectMyNote()
            }
        }
    },
    methods: {
        submit() {
            this.$refs['dataForm'].validate((valid) => {
                if (valid) {
                    addFeedback(this.feedback).then(res => {
                        this.$message.success("提交反馈成功");
                        this.closeDialog()
                    }).catch(err => {
                    })
                } else {
                }
            })
        },
        goArticleInfo(id) {
            this.close()
            this.$router.push({ path: '/articleInfo', query: { articleId: id } })
        },
        close() {
            this.$store.state.userInfoDrawer.flag = false;
            this.$store.state.userInfoDrawer.name = null;
        },
        handleUpdateArticle(id) {
            this.close()
            this.$store.state.articleDrawer.flag = true;
            this.$store.state.articleDrawer.id = id;

        },
        handleDeleteNote(id, index) {
            this.$confirm('确认删除吗？')
                .then(_ => {
                    deleteNote(id).then(res => {
                        this.noteList.splice(index, 1)
                        this.$message.success("删除成功")
                    }).catch(err => {
                    })
                })
                .catch(_ => {
                    this.$message.info("取消关闭")
                });
        },
        deleteArticle(id, index) {
            this.$confirm('确认删除吗？')
                .then(_ => {
                    deleteMyArticle(id).then(res => {
                        this.articleList.splice(index, 1)
                        this.$message.success("删除成功")
                    }).catch(err => {
                    })
                })
                .catch(_ => {
                    this.$message.info("取消关闭")
                });
        },
        updatePassword() {
            this.$refs['ruleForm'].validate((valid) => {
                if (valid) {
                    if (this.form.newPassword != this.form.new2Password) {
                        this.$message.error("确认密码和新密码不一致")
                        return;
                    }
                    updatePassword(this.form).then(res => {
                        this.$message({
                            message: "修改成功",
                            type: 'success'
                        });
                    }).catch(err => {
                    })
                } else {
                    console.log('error submit!!');
                    return false;
                }
            });

        },
        uploadBefore: function () {

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

        update() {
            updateUserInfo(this.form).then(res => {
                this.$message({
                    message: "修改成功",
                    type: 'success'
                });
            }).catch(err => {
            })
        },
        handlePage(type) {
            if (this.pageData.pageNo == this.pages) {
                return;
            }
            this.pageData.pageNo++
            if (type == "article") {
                this.selectMyArticleList()
            }
            if (type == "collect") {
                this.selectMyCollect()
            }

            if (type == "comment") {
                this.selectMyComment()
            }
            if (type == "note") {
                this.selectMyNote()
            }
        },
        selectMyArticleList() {

            getMyArticle(this.pageData).then(res => {
                this.articleList.push(...res.data.records);
                this.pages = res.data.pages

            }).catch(err => {
                console.log(err)
            })
        },
        selectMyCollect() {

            getCollect(this.pageData).then(res => {
                this.collectList.push(...res.data.records);
                this.pages = res.data.pages

            }).catch(err => {
                console.log(err)
            })
        },
        selectMyComment() {

            getMyComment(this.pageData).then(res => {
                this.commentList.push(...res.data.records);
                this.pages = res.data.pages

            }).catch(err => {
                console.log(err)
            })
        },
        selectMyNote() {

            getMyNote(this.pageData).then(res => {
                this.noteList.push(...res.data.records);
                this.pages = res.data.pages

            }).catch(err => {
                console.log(err)
            })
        },
        handeClike(event) {

        },
        cancelCollect(id, index) {
            this.$confirm('确认取消收藏吗？')
                .then(_ => {

                    cancelCollect(id).then(res => {
                        this.$message.success("取消收藏成功")
                        this.collectList.splice(index, 1)

                    }).catch(err => {
                    })
                })
                .catch(_ => {
                    this.$message.info("取消关闭")
                });

        }
    }
};
</script>
<style lang="scss" scoped>
@media screen and (max-width: 1118px) {
    /deep/ .el-drawer {
        width: 90% !important;
    }

    /deep/ .el-tabs__item {
        padding: 0 5px !important;
    }
}

/deep/ .el-tabs {
    height: -webkit-fill-available;
}

/deep/ .el-button {
    margin: 0 auto;
    display: block;
}

/deep/ .el-upload {
    width: 100%;
    height: 100%;
}

/deep/ .avatar-uploader {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
    width: 100px;
    height: 100px;
    text-align: center;
}

/deep/ .avatar-uploader:hover {
    border-color: #409EFF;
}

/deep/ .el-icon-plus {
    font-size: 28px;
    color: #8c939d;
    line-height: 100px;
}

/deep/ .avatar {
    width: 178px;
    height: 178px;
    display: block;
}

/deep/ .el-tabs__item {
    height: 50px;
    line-height: 50px;
    font-size: 1rem;
}

/deep/ .el-tabs__content {
    padding: 10px;
}

.myArticle,
.myCollect,
.myComent,
.myNote {
    padding: 10px;

    h4 {
        cursor: pointer;
    }

    .box {
        height: 40px;
        line-height: 40px;
        position: relative;
        margin-top: 20px;



        .btn {
            float: right;

            /deep/ .el-button {

                margin-left: 10px;
                display: inline-block;
            }
        }
    }
}

.myArticle {
    .statu {
        display: inline-block;
    }

}

.myCollect {
    .user {
        display: inline-block;

        .avatar {
            vertical-align: middle;
            display: inline-block;
        }

        .nickname {
            margin-left: 5px;
            color: var(--theme-color);
        }
    }
}

.myComent .box {
    height: 100%;
}

.myNote {
    /deep/ .vuepress-markdown-body {
        padding: 0;
    }
}
</style> 