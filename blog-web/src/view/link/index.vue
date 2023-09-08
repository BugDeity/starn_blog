<template>
    <div class="link-main">
        <el-card class="link-content">
            <h1>友情链接</h1>
            <h3 class="directory1">
                友链列表
                <span class="num"> {{ linkList.length }} 条</span>
                <span class="num">以下友链仅是时间排序，不分先后</span>
            </h3>
            <div class="links">
                <div class="linksItem" v-for="item in linkList">
                    <a class="item" target="_blank" :href="item.url">
                        <div class="avatarItem">
                            <img v-lazy="item.avatar" :key="item.avatar" />
                        </div>
                        <div class="item-content">
                            <span class="name">{{ item.name }}</span>
                            <div class="info">{{ item.info }}</div>
                        </div>
                    </a>
                </div>

            </div>
            <div class="infoBox">
                <div style="display: flex;position: relative;">
                    <h3 class="directory2">申请格式</h3>
                    <div class="btn-box" @click="handleAdd">
                        <svg-icon icon-class="add"></svg-icon>
                        加入友链
                    </div>

                </div>

                <div class="site">
                    <span>博客名称：{{ $store.state.webSiteInfo.name }}</span>
                    <span>博客简介：{{ $store.state.webSiteInfo.summary }}</span>
                    <span>
                        博客头像:
                        <a :href="$store.state.webSiteInfo.logo" target="_blank">
                            {{ $store.state.webSiteInfo.logo }}
                        </a>
                    </span>
                    <span>
                        博客地址:
                        <a :href="$store.state.webSiteInfo.webUrl" target="_blank">
                            {{ $store.state.webSiteInfo.webUrl }}
                        </a>
                    </span>

                </div>
            </div>
        </el-card>

        <el-dialog class="dialog" title="友情提示" :visible.sync="tipsDialogFormVisible" :lock-scroll="false">
            <div>
                申请友链之前请确保贵站点已经添加了本站点的友链，否则申请之后会被删除！
            </div>
            <div slot="footer" class="dialog-footer">
                <el-button @click="tipsDialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="handleOpenLink">确 定</el-button>
            </div>
        </el-dialog>

        <el-dialog title="申请友链" class="dialog" :visible.sync="dialogFormVisible" :lock-scroll="false">
            <el-form :model="form" :rules="rules" ref="ruleForm">
                <el-form-item label="网站名称" :label-width="formLabelWidth" prop="name">
                    <el-input v-model="form.name" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="网站简介" :label-width="formLabelWidth" prop="info">
                    <el-input v-model="form.info" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="网站地址" :label-width="formLabelWidth" prop="url">
                    <el-input v-model="form.url" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="网站头像" :label-width="formLabelWidth" prop="avatar">
                    <el-input v-model="form.avatar" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="邮箱地址" :label-width="formLabelWidth" prop="email">
                    <el-input v-model="form.email" autocomplete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="addLink">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>
<script>
import { featchLinks, addLink } from '@/api/link'
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
            linkList: [],
            dialogFormVisible: false,
            tipsDialogFormVisible: false,
            form: {},
            formLabelWidth: '80px',
            rules: {
                name: [
                    { required: true, message: '请输入网站名称', trigger: 'blur' },
                ],
                info: [
                    { required: true, message: '请输入网站简介', trigger: 'blur' },
                ],
                url: [
                    { required: true, message: '请输入网站地址', trigger: 'blur' },
                ],
                avatar: [
                    { required: true, message: '请输入网站头像', trigger: 'blur' },
                ],
                email: [
                    { required: true, message: '请输入邮箱地址', trigger: 'blur' },
                ],

            }
        }
    },

    created() {
        featchLinks().then(res => {
            this.linkList = res.data
        })
    },
    methods: {
        handleOpenLink() {
            this.tipsDialogFormVisible = false
            this.dialogFormVisible = true
        },
        handleAdd() {
            this.form = {}
            this.tipsDialogFormVisible = true
        },
        addLink() {
            this.$refs['ruleForm'].validate((valid) => {
                if (valid) {
                    addLink(this.form).then(res => {
                        this.dialogFormVisible = false
                        this.$message({ type: "success", message: "提交成功，请等待审核" });
                    }).catch(err => {
                    })
                } else {
                    console.log('error submit!!');
                    return false;
                }
            });


        },
    }
}
</script>
<style lang="scss" scoped>
.link-main {
    display: flex;
    justify-content: center;

    @media screen and (max-width: 1118px) {
        padding-left: 10px;
        padding-right: 10px;

        h1 {
            font-size: 1.2rem;
        }

        .directory1,
        .directory2 {
            font-size: 1rem;

        }

        .link-content {
            width: 100%;
            margin-top: 70px;

            .links {
                grid-template-columns: repeat(3, 1fr);
                width: 100%;

                .item {
                    width: 100%;
                    height: auto;
                }
            }
        }

        /deep/ .el-dialog {
            width: 95%;
            border-radius: 10px;
        }
    }

    @media screen and (min-width: 1119px) {
        .link-content {
            width: 65%;
            margin-top: 80px;

            h1 {
                font-size: 24px;
            }

            .directory1,
            .directory2 {
                font-size: 1.1rem;

            }

            .links {
                grid-template-columns: repeat(4, 1fr);
                margin-left: 30px;

                .item {
                    width: 85%;
                    height: 118px;
                }
            }

            .site {
                margin-left: 30px;
            }
        }

        /deep/ .el-dialog {
            width: 30%;
            border-radius: 10px;
        }
    }

    .link-content {
        padding: 20px;
        height: 100%;
        background-color: var(--background-color);

        &:hover {
            box-shadow: 5px 4px 8px 6px rgba(7, 17, 27, .06);
            transition: all .3s;
        }

        h1 {

            color: var(--article-color);
            text-align: center;
            padding-top: 40px;
            margin-bottom: 15px;
            word-break: break-word;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.25);
            font-weight: 500;
        }

        .directory1,
        .directory2 {
            margin-left: 10px;
            margin-top: 20px;
            line-height: 24px;
            font-weight: 500;
            color: var(--article-color);

            &::before {
                position: relative;
                display: inline-block;
                vertical-align: middle;
                content: "";
                top: -3px;
                margin-right: 8px;
                background-position: center;
                width: 20px;
                height: 20px;
                background-size: auto 100%;
                left: 0;
                background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAH1JREFUWEft1qENgDAQheH/JANg60DAJIgmrMFCzEEYgTFgDyRFIClp0yBf9evl8pl3RsYbp7BjNLHoMptljPiMZH3WAhKQgAQkIIGXQAXUT79cniHaNMa5draliqqojIID86nRHEtvbSqlBSQgAQlIQAISkECRAA746SC5Ad6XpiGnnOGPAAAAAElFTkSuQmCC);
            }

            .num {
                position: relative;
                top: -1px;
                display: inline-block;
                margin-left: 5px;
                padding: 0 5px;
                height: 18px;
                line-height: 18px;
                font-size: 12px;
                color: #909399;
                background: var(--friend-tip-color);
                border-radius: 3px;
            }
        }


        .links {
            margin-top: 20px;
            display: grid;
            gap: 15px;
            margin-bottom: 50px;
            border-radius: 10px;

            .linksItem {
                position: relative;
                border-radius: 10px;

                &::before {
                    content: "";
                    position: absolute;
                    top: 0;
                    right: 0;
                    bottom: 0;
                    left: 0;
                    background: var(--theme-color);
                    transition-timing-function: ease-out;
                    transition-duration: .35s;
                    transition-property: transform;
                    transform: scale(0);
                    border-radius: 10px;

                }

                .item {
                    display: inline-block;
                    text-decoration: none;
                    position: relative;
                    display: flex;
                    align-items: center;

                    .avatarItem {
                        height: 50px;
                        width: 50px;
                        margin: 0 10px;

                        img {
                            width: inherit;
                            height: inherit;
                            border-radius: 50%;
                            object-fit: cover;
                            margin: 3px 0;
                            margin-right: 8px;
                            vertical-align: middle;
                            transition: transform .35s;
                        }
                    }


                    .item-content {
                        width: 100%;
                        margin-left: 15px;

                        .info,
                        .name {
                            overflow: hidden;
                            text-overflow: ellipsis;
                            -webkit-line-clamp: 2;
                            display: -webkit-box;
                            -webkit-box-orient: vertical;
                            min-width: 60%;

                        }

                        .info {

                            color: var(--text-color);
                        }

                        .name {
                            position: relative;
                            font-weight: 700;
                            color: var(--article-color);
                            padding-bottom: 5px;
                            margin-bottom: 10px;

                            &::after {
                                content: "";
                                width: 50%;
                                height: 2px;
                                position: absolute;
                                bottom: 0;
                                left: 0;
                                background-color: var(--text-color);
                            }
                        }

                    }
                }

                &:hover {
                    &::before {
                        transform: scale(1);

                    }

                    .item-content .info,
                    .name {
                        color: #fff !important;
                    }

                    img {
                        transform: rotate(360deg);
                    }

                    box-shadow: 2px 2px 10px 5px #49b0f563;
                    transition: all 0.2s;

                }



            }


        }

        .infoBox {

            .btn-box {
                margin-left: 10px;
                color: var(--theme-color);
                font-size: 16px;
                margin-top: 20px;
                position: absolute;
                right: 0;
                line-height: 24px;
                cursor: pointer;

                svg {
                    width: 17px;
                    height: 17px;
                    vertical-align: -3px;
                }
            }
        }

        .site {
            background-color: #1d72f320;
            color: #1d72f3;
            border-left: 5px solid #1d72f3;
            margin-bottom: 50px;
            border-top-right-radius: 5px;
            border-bottom-right-radius: 5px;
            margin-top: 20px;

            a {
                text-decoration: none;
                color: var(--theme-color);

                &:hover {
                    color: crimson;
                }
            }

            span {
                padding: 5px 10px;
                display: block;
            }
        }
    }
}
</style>