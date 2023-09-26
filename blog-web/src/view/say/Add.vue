<template>
    <div class='say-add'>
        <div class="containner">
            <div class="title">
                发布说说
            </div>
            <el-form style="display: flex;" :rules="rules" ref="ruleForm" label-position="left" label-width="80px"
                :model="form">
                <div class="say-left">
                    <el-form-item label="关联图片：" prop="imgUrl" label-width="120">
                        <el-upload :action="uploadPictureHost" :before-upload="uploadBefore" list-type="picture-card"
                            :http-request="uploadSectionFile" :on-remove="handleRemove">
                            <i class="el-icon-plus"></i>
                        </el-upload>
                    </el-form-item>

                    <el-form-item label="内容" label-width="150" prop="content">
                        <el-input type="textarea" :autosize="{ minRows: 10 }" class="contentInput" placeholder="请输入说说内容"
                            v-model="form.content">
                        </el-input>
                    </el-form-item>

                </div>
                <div class="say-right">
                    <el-form-item label="关联地址" prop="address">
                        <el-input v-model="form.address"></el-input>
                    </el-form-item>
                    <el-form-item label="开放查看" prop="isPublic">
                        <el-radio v-model="form.isPublic" label="0">未开放</el-radio>
                        <el-radio v-model="form.isPublic" label="1">开放</el-radio>
                    </el-form-item>
                    <div style="text-align: center;">
                        <button v-if="$store.state.userInfo.id == 1" type="button" class="btn"
                            @click="submitForm">发布</button>
                        <span v-else class="noBtn">暂无发布权限</span>
                    </div>
                </div>

            </el-form>
        </div>
    </div>
</template>
   
<script>
import { insertSay } from '@/api/say'
import { upload } from '@/api'
export default {
    name: '',
    data() {
        return {
            uploadPictureHost: process.env.VUE_APP_BASE_API + "/file/upload",
            files: {},
            dialogImageUrl: '',
            dialogVisible: false,
            form: {
                imgUrl: '',
                isPublic: "1"
            },
            loading: [],
            rules: {
                content: [
                    { required: true, message: '请输入内容', trigger: 'blue' }
                ],
                isPublic: [
                    { required: true, message: '请选择公开类型', trigger: 'blue' }
                ],
            }
        };
    },
    methods: {
        handleRemove(file, fileList) {
            this.form.imgUrl.replace(file.url, '')
        },
        uploadBefore: function () {
            this.openLoading()
        },
        submitForm() {
            this.$refs['ruleForm'].validate((valid) => {
                if (valid) {
                    insertSay(this.form).then(res => {
                        this.$notify({
                            title: '通知',
                            message: '添加说说成功',
                        });
                        this.$router.push({ path: "/say" })
                    })
                } else {
                    return false;
                }
            });
        },
        uploadSectionFile: function (param) {
            this.files = param.file
            // FormData 对象
            var formData = new FormData()
            // 文件对象
            formData.append('multipartFile', this.files)
            upload(formData).then(res => {
                this.form.imgUrl += res.data + ","
            })
            this.loading.close()
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
}
</script>
   
<style lang='scss' scoped>
.say-add {
    display: flex;
    justify-content: center;

    @media screen and (max-width: 1118px) {
        padding: 0 5px;

        .containner {
            width: 100%;
            margin-top: 80px;

        }
    }

    @media screen and (min-width: 1119px) {
        .containner {
            width: 60%;
            margin-top: 80px;
        }
    }

    .containner {
        padding: 10px;

        .title {
            margin-bottom: 15px;
            color: var(--text-color);
        }

        .say-left,
        .say-right {
            background-color: var(--background-color);
            border-radius: 5px;
            padding: 10px;
        }

        .say-left {

            margin-right: 20px;
            width: 100%;

            .el-textarea {
                width: 92%;
            }

            /deep/ .contentInput textarea {
                resize: none;
                background-color: var(--background-color);
            }
        }

        .say-right {
            width: 35%;
            height: 100%;

            .btn {
                padding: 5px;
                width: 50%;
                border-radius: 50px;
                background: linear-gradient(135deg, #59c3fb 10%, #268df7 100%);
                border: none;
                margin: 0 auto;
            }

            .noBtn {
                color: var(--text-color);
            }
        }

    }
}
</style>