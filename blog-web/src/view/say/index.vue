<template>
    <div class="say-main">
        <div class="containner">
            <div class="cover">
                <img src="https://img-img.lwgzs.cn/img/3/zwbo/2022/12/d53aeb78abc8-scaled.jpg" alt="">
                <div class="info">说说</div>
            </div>
            <div class="contentBox">
                <div class="sayItem" v-for="(item, index) in sayList" :key="index">
                    <div class="avatar">
                        <el-avatar :src="item.avatar" alt=""></el-avatar>
                    </div>
                    <div class="rigthBox">
                        <div class="nickname">
                            {{ item.nickname }}
                            <el-tooltip class="item" effect="dark" content="博主" placement="right">
                                <svg-icon icon-class="bozhu"></svg-icon>
                            </el-tooltip>
                        </div>
                        <p class="content" v-html="item.content"></p>
                        <div v-if="item.imgUrl" :class="ckeckImgClass(item.imgUrl)">
                            <img @click="handlePreviewImg(item.imgUrl, imgItem)" v-if="checkImg(item.imgUrl)"
                                v-for="(imgItem, imgIndex) in splitImg(item.imgUrl)" :key="imgIndex" :src="imgItem" alt="">
                        </div>


                        <div class="bottomBox">
                            <div v-if="item.address" class="address">
                                <a>
                                    <i class="el-icon-location-outline"></i> {{ item.address }}
                                </a>
                            </div>
                            <span class="time">
                                <i class="el-icon-time"></i> {{ item.createTimeStr }}
                            </span>
                            <div class="operate" ref="operate">
                                <a class="like" v-if="!item.isLike" @click="sayLike(item)">
                                    <i class="iconfont icon-dianzan"></i> 赞
                                </a>
                                <a class="like" v-else @click="canLike(item)">
                                    <i class="iconfont icon-quxiaodianzan"></i> 取消
                                </a>
                                <span class="fgx"></span>
                                <a class="commentBtn" @click="handleShowCommentBox(null, item.id, index)">
                                    <i class="el-icon-chat-dot-square"></i> 评论
                                </a>
                            </div>
                            <a class="operateBtn" @click="handleShowOperate(index)">
                                <i class="el-icon-more"></i>
                            </a>
                        </div>
                        <div class="interaction">
                            <div v-if="item.userLikeList.length"
                                :class="item.userLikeList.length ? 'like-container is_border' : 'like-container'">
                                <span v-for="(user, user_index) in item.userLikeList" :key="user_index">
                                    <i class="iconfont icon-dianzan"></i> {{ user.nickname }}
                                    <span v-if="user_index < item.userLikeList.length - 1">，</span>
                                </span>
                            </div>
                            <div class="commentBox">
                                <div class="commentItem " v-for="(comment, comment_index) in item.sayCommentVOList"
                                    :key="comment_index" v-if="item.sayCommentVOList.length">
                                    <div>
                                        <span class="username" v-if="!comment.replyUserId">
                                            {{ comment.nickname }}：
                                        </span>


                                        <span v-else>
                                            <span class="username">{{ comment.nickname }}</span>
                                            回复
                                            <span class="username">{{ comment.replyUserNickname }}：</span>
                                        </span>
                                        <span class="content" v-html="comment.content"
                                            @click="handleShowCommentBox(comment, item.id, index)">
                                        </span>
                                    </div>
                                </div>

                                <div class="conetntInputBox" ref="conetntInputBox">
                                    <div class="">
                                        <el-input type="textarea" :placeholder="placeholder" v-model="comment.content">
                                        </el-input>

                                        <a @click="showEmoji = !showEmoji"> <svg-icon icon-class="emoji1"></svg-icon></a>
                                        <a class="sendBtn" @click="sayComment">发送</a>

                                    </div>
                                    <div class="emoji-wrapper" v-if="showEmoji">
                                        <Emoji @chooseEmoji="handleChooseEmoji" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</template>
<script>
import { getSayList, sayLike, sayComment } from '@/api/say'
import Emoji from '@/components/emoji'
export default {
    components: {
        Emoji
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
    data() {
        return {
            sayList: [],
            pageData: {
                pageNo: 1,
                pageSize: 10,
            },
            pages: 0,
            showOperate: false,
            lastIndex: null,
            content: "",
            showEmoji: false,
            showCommentBox: false,
            placeholder: "请输入内容",
            comment: {
                replyUserId: null,
                replyUserNickname: null,
                sayId: null,
                content: ""
            },
            commentIndex: null,
            commentLastIndex: null,
        }
    },
    mounted() {
        // window.setTimeout(() => {
        //     document.addEventListener("click", this.handleClose)
        // }, 500)
    },
    created() {
        this.getSayList()
    },
    methods: {
        sayComment() {
            if (!this.comment.content) {
                this.$notify({
                    title: '警告',
                    message: "请输入评论内容",
                    type: 'warning'
                });
                return
            }
            sayComment(this.comment).then(res => {
                this.$refs.conetntInputBox[this.commentLastIndex].style.display = "none"
                this.showCommentBox = false
                this.$notify({
                    title: '成功',
                    message: "评论成功",
                    type: 'success'
                });
                let comment = {
                    userId: this.$store.state.userInfo.id,
                    nickname: this.$store.state.userInfo.nickname,
                    replyUserId: this.comment.replyUserId,
                    replyUserNickname: this.comment.replyUserNickname,
                    content: this.comment.content,
                }
                this.sayList[this.commentIndex].sayCommentVOList.push(comment)
                this.comment = {}
            })
        },
        handleShowCommentBox(comment, sayId, index) {
            console.log(this.$refs.conetntInputBox)
            if (this.commentLastIndex != null && this.commentLastIndex != index) {
                this.$refs.conetntInputBox[this.commentLastIndex].style.display = "none"
            }
            if (this.commentLastIndex == index) {
                if (this.$refs.conetntInputBox[index].style.display == "block") {
                    this.$refs.conetntInputBox[index].style.display = "none"
                } else {
                    this.$refs.conetntInputBox[index].style.display = "block"
                }
            } else {
                this.$refs.conetntInputBox[index].style.display = "block"
            }
            this.commentLastIndex = index

            if (comment) {
                this.placeholder = "回复" + comment.nickname + ":"
                this.comment.replyUserId = comment.userId
                this.comment.replyUserNickname = comment.nickname
            } else {
                this.comment.replyUserId = null
                this.comment.replyUserNickname = null
                this.placeholder = "请输入内容"
            }
            this.commentIndex = index
            this.comment.sayId = sayId
            this.showCommentBox = !this.showCommentBox

        },
        //添加表情
        handleChooseEmoji(value) {
            this.comment.content += value
            this.showEmoji = false
        },
        //关闭操作框
        handleClose(e) {
            if (e.target.className != "el-icon-more" && e.target.className != "operateBtn") {

                if (this.lastIndex != null) {
                    this.$refs.operate[this.lastIndex].style = "display:none"
                }
            }
        },
        handleShowOperate(index) {
            if (this.lastIndex != null && this.lastIndex != index) {
                this.$refs.operate[this.lastIndex].style.display = "none"
            }
            if (this.lastIndex == index) {
                if (this.$refs.operate[index].style.display == "block") {
                    this.$refs.operate[index].style.display = "none"
                } else {
                    this.$refs.operate[index].style.display = "block"
                }
            } else {
                this.$refs.operate[index].style.display = "block"
            }
            this.lastIndex = index

        },
        canLike(say) {
            sayLike(say.id).then(res => {
                let index = null;
                for (let i = 0; i < say.userLikeList.length; i++) {
                    let id = say.userLikeList[i].id
                    if (this.$store.state.userInfo.id == id) {
                        index = i
                        break;
                    }
                }
                if (index != null) {
                    this.$delete(say.userLikeList, index)
                }
                say.isLike = false
                this.$notify({
                    title: '成功',
                    message: res.data,
                    type: 'success'
                });
            })
        },
        sayLike(say) {
            sayLike(say.id).then(res => {
                say.userLikeList.push({
                    id: this.$store.state.userInfo.id,
                    nickname: this.$store.state.userInfo.nickname
                })
                say.isLike = true
                this.$notify({
                    title: '成功',
                    message: res.data,
                    type: 'success'
                });
            })
        },
        handlePreviewImg(imgs, img) {
            let imgList = this.splitImg(imgs)
            this.$imagePreview({
                images: imgList,
                index: imgList.indexOf(img)
            });
        },
        getSayList() {
            getSayList(this.pageData).then(res => {
                this.sayList.push(...res.data.records)
                this.pages = res.data.pages
            })
        },
        checkImg(img) {
            return this.splitImg(img).length > 0
        },
        ckeckImgClass(img) {
            let length = this.splitImg(img).length
            if (length == 1) {
                return "contentImg grid-1"
            } else if (length == 2) {
                return "contentImg grid-2"
            } else {
                return "contentImg grid-3"
            }
        },
        splitImg(img) {
            let imgs = img.split(",")
            var r = imgs.filter(function (s) {
                return s && s.trim();
            });
            return r;
        },
    }
}
</script>
<style lang="scss" scoped>
.say-main {
    display: flex;
    justify-content: center;

    @media screen and (max-width: 1118px) {
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

        .cover {
            width: 100%;
            height: 380px;
            position: relative;

            img {
                border-radius: 5px;
                width: 100%;
                height: 100%;
            }

            .info {
                position: absolute;
                top: 50%;
                left: 50%;
                font-size: 25px;
                font-weight: 700;
            }
        }

        .contentBox {
            margin-top: 20px;
            width: 100%;


            .sayItem {
                padding: 10px;
                background-color: var(--background-color);
                display: flex;
                margin-bottom: 10px;
                border-radius: 5px;
                position: relative;

                .avatar {


                    /deep/ img {

                        vertical-align: top;
                    }
                }

                .rigthBox {
                    padding-left: 10px;
                    display: flex;
                    flex-direction: column;
                    width: 100%;

                    .nickname {
                        color: var(--theme-color);

                        svg {
                            width: 18px;
                            height: 18px;
                            vertical-align: -3px;
                        }
                    }

                    .content {
                        margin-top: 10px;
                    }

                    .grid-1 {
                        grid-template-columns: repeat(1, 0fr);

                        img {
                            width: 300px;
                            height: 250px;
                        }
                    }

                    .grid-2 {
                        grid-template-columns: repeat(2, 0fr);

                        img {
                            width: 300px;
                            height: 250px;
                        }
                    }

                    .grid-3 {
                        grid-template-columns: repeat(3, 0fr);

                        img {
                            width: 180px;
                            height: 180px;
                        }
                    }

                    .contentImg {
                        display: grid;
                        margin-top: 10px;

                        img {
                            border-radius: 5px;
                            cursor: zoom-in;
                            margin-bottom: 10px;
                            margin-right: 10px;
                        }
                    }



                    .bottomBox {
                        margin-top: 20px;
                        position: relative;
                        color: var(--text-color);

                        .address {
                            color: #5597bd;
                            margin-bottom: 10px;
                        }

                        .time,
                        .address {
                            font-size: 14px;
                        }

                        .operateBtn {
                            position: absolute;
                            right: 20px;
                            display: inline-block;
                            background-color: #f7f7f7;
                            padding: 0 5px;
                        }

                        .operate {
                            position: absolute;
                            right: 55px;
                            bottom: -8px;
                            display: inline-block;
                            background-color: #4b5153;
                            padding: 8px;
                            border-radius: 5px;
                            display: none;

                            &::after {
                                content: '';
                                position: absolute;
                                right: -15px;
                                bottom: 10px;
                                width: 0;
                                height: 0;
                                border-width: 8px;
                                border-style: solid;
                                border-color: transparent transparent transparent #4b5153;
                            }

                            a {
                                padding: 0 10px;
                                color: #fff;
                                position: relative;

                                &:hover {
                                    color: var(--theme-color);
                                }
                            }

                            .like::after {
                                content: "";
                                width: 2px;
                                height: 100%;
                                background-color: #373d40;
                                position: absolute;
                                right: 0;
                            }

                        }
                    }

                    .interaction {
                        background-color: #f7f7f7;
                        margin-top: 15px;
                        border-radius: 5px;


                        .like-container {
                            padding: 8px 0;
                            padding-left: 10px;

                            span {
                                font-size: 14px;
                                color: #576b95;
                            }
                        }



                        .is_border {
                            border-bottom: 1px dashed rgb(126, 120, 120);
                        }

                        .commentBox {
                            padding: 10px;

                            .commentItem {
                                margin-bottom: 5px;

                                .username {
                                    color: #5597bd;
                                }


                            }
                        }

                        .conetntInputBox {
                            border: 1px solid #67C23A;
                            width: 50%;
                            border-radius: 5px;
                            background-color: var(--background-color);
                            position: relative;
                            min-height: 100px;
                            display: none;

                            .emoji-wrapper {}

                            /deep/ textarea {
                                border: none;
                                background-color: var(--background-color);
                                resize: none;
                            }

                            svg {
                                width: 20px;
                                height: 20px;
                                position: absolute;
                                right: 80px;
                                bottom: 20px;
                            }

                            .sendBtn {
                                display: inline-block;
                                background-color: #67C23A;
                                color: #fff;
                                padding: 5px 8px 5px 8px;
                                border-radius: 5px;
                                position: absolute;
                                right: 20px;
                                bottom: 15px;
                            }
                        }

                    }
                }
            }

        }
    }
}
</style>