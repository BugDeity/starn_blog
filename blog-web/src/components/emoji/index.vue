<template>
    <div class='emoji-container'>
        <div class="emojiBox" v-if="!type">
            <span class="emoji-item" v-for="(item, index) of emojiList" :key="index" @click="chooseEmoji(item.url)">
                <img :src="item.url" class="emoji" :title="item.name" />
            </span>
        </div>

        <div class="emojiBox" v-else>
            <el-upload class="avatar-uploader" action="https://jsonplaceholder.typicode.com/posts/" :show-file-list="false"
                :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload">
                <img v-if="imageUrl" :src="imageUrl" class="avatar">
                <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
        </div>

        <div class="btnBox">
            <el-radio-group v-model="type" @input="handleChage">
                <el-radio-button :label="0">表情</el-radio-button>
                <el-radio-button :label="1">收藏</el-radio-button>
            </el-radio-group>
        </div>
    </div>
</template>
   
<script>

export default {
    name: '',
    data() {
        return {
            emojiList: null,
            type: 0,
            imageUrl: ''
        }
    },
    created() {
        this.emojiList = require('@/assets/emoji.json');
    },
    methods: {
        handleChage(value) {

        },
        handleTabClick(index) {
            console.log(index)
            let btnList = document.getElementsByClassName("itemBtn")
            console.log(btnList.length)
            for (var i = 0; i < btnList.length; i++) {
                btnList[i].className = "itemBtn"
                if (i == index) {
                    btnList[i].className = "itemBtn active"
                }
            }
        },
        chooseEmoji(url) {
            this.$emit('chooseEmoji', url);
        },
        handleAvatarSuccess(res, file) {
            this.imageUrl = URL.createObjectURL(file.raw);
        },
        beforeAvatarUpload(file) {
            this.$notify({
                title: '通知',
                message: '待开发',
                type: 'info'
            });
            return
            const isJPG = file.type === 'image/jpeg';
            const isLt2M = file.size / 1024 / 1024 < 2;

            if (!isJPG) {
                this.$message.error('上传头像图片只能是 JPG 格式!');
            }
            if (!isLt2M) {
                this.$message.error('上传头像图片大小不能超过 2MB!');
            }
            return isJPG && isLt2M;
        }
    },
}
</script>
   
<style lang='scss' scoped>
/deep/ .avatar-uploader {
    .el-upload {
        border: 1px dashed #d9d9d9;
        border-radius: 6px;
        cursor: pointer;
        position: relative;
        overflow: hidden;

        &:hover {
            border-color: #409EFF;
        }
    }

    .avatar-uploader-icon {
        font-size: 28px;
        color: #8c939d;
        width: 90px;
        height: 90px;
        line-height: 90px;
        text-align: center;
    }

    .avatar {
        width: 90px;
        height: 90px;
        display: block;
    }
}


/deep/ .el-radio-button__inner {
    padding: 8px 15px !important;
}

.emoji-container {
    max-width: 400px;
    background-color: var(--background-color);
    border: 1px solid var(--border-line);
    padding: 5px;
    border-radius: 5px;

    .emojiBox {
        min-height: 150px;
        max-height: 150px;
        max-width: 400px;
        min-width: 400px;
        overflow-y: scroll;

        .emoji-item {
            cursor: url(https://img.shiyit.com/link.cur), pointer;
            display: inline-block;

            .emoji {
                padding: 3px;
                border-radius: 5px;
                width: 30px;
                height: 30px;

                &:hover {
                    background-color: rgb(221, 221, 221)
                }
            }
        }
    }

    .btnBox {
        margin-top: 10px;
        padding-top: 5px;
        border-top: 2px solid var(--border-line);
        color: var(--text-color);
    }


}
</style>