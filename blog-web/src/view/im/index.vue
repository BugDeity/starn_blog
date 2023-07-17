<template>
    <div class="im-main">
        <div id="im" class="im-warpper">
            <el-card class="item">
                <!-- 标题 -->
                <div class="title">{{ title }}</div>
                <div class="messageBox" id="messageBox" ref="messageContainer">
                    <!-- 加载更多 -->
                    <div class="more" v-show="pageData.pageNo < totalPage">
                        <div v-if="isLoding" class="loading">
                            <div class="spinner"></div>
                        </div>
                        <div @click="handleMore" v-else>加载更多</div>
                    </div>
                    <!-- 消息内容框 -->
                    <div class="messageItem" v-for="(item, index) in  messageList " :key="index">
                        <!-- 左边消息框 别人发送的消息 -->
                        <div :class="item.isWithdraw ? 'withdraw' : 'left'" v-if="user && item.fromUserId != user.id">
                            <img :src="item.fromUserAvatar" @error="item.fromUserAvatar = errImg"
                                :title="item.fromUserNickname">
                            <div class="info">
                                <span class="nickname">
                                    {{ item.fromUserNickname }}
                                    <el-tooltip effect="dark" content="官方标签" placement="top" v-if="item.fromUserId == 1">
                                        <svg-icon class="tag" icon-class="guanfang"></svg-icon>
                                    </el-tooltip>
                                    <span v-if="item.ipSource" class="item"> <i class="el-icon-location-information"></i>
                                        IP属地:{{ splitIpAddress(item.ipSource) }}
                                    </span>
                                    <span class="item"> <i class="el-icon-time"></i> {{ item.createTimeStr }}</span>
                                </span>

                                <span v-if="!item.isWithdraw" v-html="item.content" class="messageContent"
                                    @contextmenu.prevent="openMenu($event, item, index)">
                                </span>
                                <span v-else style="color: var(--text-color);">
                                    " {{ item.fromUserNickname }} " 撤回了一条消息
                                </span>
                            </div>
                        </div>
                        <!-- 右边消息框 自己发送的消息 -->
                        <div :class="item.isWithdraw ? 'withdraw' : 'right'" v-else>

                            <div class="info">
                                <div class="nickname">
                                    <span class="item"><i class="el-icon-time"></i> {{ item.createTimeStr }}</span>
                                    <span v-if="item.ipSource" class="item"><i class="el-icon-location-information"></i>
                                        IP属地:{{ splitIpAddress(item.ipSource) }}
                                    </span>
                                    <el-tooltip effect="dark" content="官方标签" placement="top" v-if="item.fromUserId == 1">
                                        <svg-icon class="tag" icon-class="guanfang"></svg-icon>
                                    </el-tooltip>
                                    {{ item.fromUserNickname }}
                                </div>
                                <img :src="item.fromUserAvatar">
                                <span v-if="!item.isWithdraw" v-html="item.content" class="nowMessageContent"
                                    @contextmenu.prevent="openMenu($event, item, index)">
                                </span>
                                <span style="color: var(--text-color);" v-else>
                                    " {{ item.fromUserNickname }} " 撤回了一条消息
                                </span>

                            </div>
                        </div>
                    </div>
                </div>
                <!-- 输入框 -->
                <div class="input-box">
                    <!-- 输入选择 如表情、图片等 -->
                    <div class="selelctBox">
                        <span class="emoji">
                            <i class="iconfont icon-biaoqing" @click.stop="handleOpen"></i>

                            <el-upload class="avatar-uploader" :show-file-list="false" ref="upload" name="filedatas"
                                :action="uploadPictureHost" :http-request="uploadSectionFile" multiple>
                                <i class="iconfont icon-tupian"></i>
                            </el-upload>
                        </span>
                    </div>
                    <!-- 表情框 -->
                    <div class="emoji-wrapper" v-show="emojiShow">
                        <span :title="item.description" class="emojiItem" v-for="( item, index ) of  emojiList "
                            :key="index" @click.stop="addEmoji(item, $event)">
                            {{ item.emoji }}
                        </span>
                    </div>
                    <!-- 输入内容 -->
                    <textarea class="contentBox" placeholder="说点什么呢" v-model="text"></textarea>
                    <el-button class="btn" @click="send(text, 1)">发送[Ctrl+Enter]</el-button>
                </div>

                <ul v-show="visible" :style="{ left: left + 'px', top: top + 'px' }" class="contextmenu">
                    <li @click="clipboard" class="copyBtn">
                        <i class="el-icon-document-copy"></i> 复制
                    </li>
                    <li @click="translate">
                        <i class="iconfont icon-fanyi"></i>翻译
                    </li>
                    <li @click="withdraw">
                        <i class="iconfont icon-chehui"></i>撤回
                    </li>
                </ul>
            </el-card>
            <!-- 房间列表 -->
            <div class="online">
                <ul class="online-item">
                    <li ref="room" :class="!index ? 'onlineLi active' : 'onlineLi'" v-for="(item, index) in roomList"
                        :key="index">
                        <div class="room-list-item" @click="selectUserIm(item, index)">
                            <div class="room-list-item">
                                <img class="img" :src="item.avatar" alt="">
                                <div class="roomName">
                                    {{ item.nickname }}
                                </div>
                            </div>
                            <div class="readNum" v-if="item.readNum">
                                <span>{{ item.readNum }}</span>
                            </div>
                        </div>
                        <div class="close" @click="closeRoom(item.id, index)">
                            <span><i class="el-icon-close"></i></span>
                        </div>

                    </li>
                </ul>
            </div>
        </div>


    </div>
</template>

<script>
let socket;
import { upload } from '@/api'
import { getImHistory, getUserImHistoryList, send, getRoomList, addRoom, read, deleteRoom } from '@/api/im'
export default {

    data() {
        return {
            uploadPictureHost: process.env.VUE_APP_BASE_API + "/file/upload",
            websoketUrl: process.env.VUE_APP_WEBSOCKET_API,
            visible: false,
            isLoding: false,
            top: 0,
            left: 0,
            text: "",
            messageList: [],
            emojiList: [],
            emojiShow: false,
            errImg: "http://img.shiyit.com/1645512111007.png",
            user: this.$store.state.userInfo,
            totalPage: 0,
            isBackTop: false,
            message: null,
            selectIndex: null,
            title: "拾壹博客交流群",
            lastIndex: null,
            userId: this.$route.query.userId,
            pageData: {
                pageNo: 1,
                pageSize: 10
            },
            onlineUserList: [],
            roomList: [
                {
                    avatar: this.$store.state.webSiteInfo.logo,
                    nickname: "拾壹博客交流群"
                }
            ],
            selectUserOnline: null,
        }
    },

    mounted() {
        document.addEventListener("click", this.handleClose)
        window.addEventListener('keydown', this.handkeyEnter, true)//开启监听键盘按下事件
        document.getElementById("im").oncontextmenu = new Function("event.returnValue=false");

    },
    watch: {
        //   监听属性对象，newValue为新的值，也就是改变后的值
        visible(newValue, oldValue) {
            if (newValue) {
                document.body.addEventListener("click", this.closeMenu);
            } else {

                document.body.removeEventListener("click", this.closeMenu);
            }
        },
        user(newName) {
            if (typeof (newName) == 'string') {
                this.user = JSON.parse(newName)
            } else {
                this.user = newName
                //发送soket连接
                this.init()
            }
        },
        messageList() {
            if (this.isBackTop) {
                this.$refs.messageContainer.scrollTop = 0
                this.isBackTop = false
            } else {
                this.$nextTick(() => {
                    this.$refs.messageContainer.scrollTop = this.$refs.messageContainer.scrollHeight;
                })
            }

        }
    },
    created() {
        this.init()
        this.emojiList = require('@/assets/emoji.json');
    },
    methods: {
        closeRoom(id, index) {
            this.$confirm('此操作将把该聊天窗口删除, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                if (!id) {
                    this.$message.warning("群聊不允许删除!")
                    return;
                }
                deleteRoom(id).then(res => {
                    this.$delete(this.roomList, index);
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
        //发送图片
        uploadSectionFile: function (param) {
            this.files = param.file
            // FormData 对象
            var formData = new FormData()
            // 文件对象
            formData.append('multipartFile', this.files)
            upload(formData).then(res => {
                //上传之后发送消息
                let content = `<img src="${res.data}" alt="" class="messageImg" style="width: 150px;height: 150px;">`
                this.send(content, 2)
            })
        },
        //截取地址
        splitIpAddress(address) {
            return address.split("|")[1]
        },
        //选择用户单聊
        selectUserIm(item, index) {

            if (this.lastIndex != null) {
                this.$refs.room[this.lastIndex].className = "onlineLi"
            }
            this.$refs.room[0].className = "onlineLi"
            this.$refs.room[index].className += " active"
            this.lastIndex = index


            this.pageData.pageNo = 1

            //为空则是群聊
            if (!item.receiveId) {
                this.title = "拾壹博客交流群"
                this.messageList = []
                this.selectUserOnline = null;
                this.getHistoryList()
                return;
            }
            this.title = item.nickname
            this.pageData.fromUserId = this.user.id
            this.pageData.toUserId = item.receiveId
            this.messageList = []
            this.selectUserOnline = item
            getUserImHistoryList(this.pageData).then(res => {
                let arr = res.data.records
                for (let i = arr.length - 1; i >= 0; i--) {
                    this.messageList.push(arr[i])
                }
                this.totalPage = res.data.pages
            })
            //修改为已读
            read(item.receiveId)
            item.readNum = 0
        },
        //右击
        openMenu(e, item, index) {
            var x = e.pageX; //这个应该是相对于整个浏览器页面的x坐标，左上角为坐标原点（0,0）
            var y = e.pageY; //这个应该是相对于整个浏览器页面的y坐标，左上角为坐标原点（0,0）
            this.top = y;
            this.left = x;
            this.visible = true; //显示菜单
            this.message = item
            this.message.index = index
        },
        //撤回
        withdraw() {
            if (this.user.id != this.message.fromUserId) {
                this.$message.error('只能撤回自己发送的消息哦');
                return;
            }

            if (this.message.isWithdraw) {
                this.$message.error('消息已被撤回');
                return;
            }

            this.message.isWithdraw = 1
            this.message.content = "消息已撤回"

            let message = { code: this.selectUserOnline == null ? 2 : 1, messageData: this.message }
            send(JSON.stringify(message));  // 将组装好的json发送给服务端，由服务端进行转发
        },
        //翻译
        translate() {
            window.open("https://fanyi.baidu.com/?aldtype=16047#zh/en/" + this.message.content, '_blank')
        },
        //复制
        clipboard() {
            const clipboard = new this.Clipboard('.copyBtn', {
                text: () => this.message.content
            })
            clipboard.on('success', () => {
                this.$message.success("复制成功");
                clipboard.destroy()
            })
            clipboard.on('error', () => {
                this.$message.error('复制失败');
                clipboard.destroy()
            })
        },
        //关闭菜单
        closeMenu() {
            this.visible = false; //关闭菜单
        },
        //加载更多消息
        handleMore() {
            this.pageData.pageNo++;
            this.isBackTop = true
            this.isLoding = true
            if (this.selectUserOnline) {
                getUserImHistoryList(this.pageData).then(res => {
                    let arr = res.data.records
                    for (let i = arr.length - 1; i >= 0; i--) {
                        this.messageList.unshift(arr[i])
                    }
                    this.isLoding = false
                })
                return;
            }
            getImHistory(this.pageData).then(res => {
                let arr = res.data.records
                for (let i = 0; i < arr.length; i++) {
                    this.messageList.unshift(arr[i])
                }
                this.isLoding = false
            })
        },
        //获取群聊历史记录
        getHistoryList() {
            getImHistory(this.pageData).then(res => {
                let arr = res.data.records
                for (let i = arr.length - 1; i >= 0; i--) {
                    this.messageList.push(arr[i])
                }
                this.totalPage = res.data.pages
            })
        },
        //Ctrl+Enter事件
        handkeyEnter(event) {
            if (event.ctrlKey && event.keyCode == 13) {
                this.send(this.text)
            }
        },
        //打开表情框
        handleOpen() {
            this.emojiShow = !this.emojiShow
        },
        //关闭表情框
        handleClose(e) {
            if (e.target.className == "messageImg") {
                const imgs = [e.target.currentSrc]
                this.$imagePreview({
                    images: imgs,
                    index: imgs.indexOf(e.target.currentSrc)
                });
            }
            this.emojiShow = false
        },
        //添加表情
        addEmoji(obj, e) {
            this.text += obj.emoji;
            this.emojiShow = false
        },
        //发送消息
        send(content, type) {
            if (typeof (WebSocket) == "undefined") {
                console.log("您的浏览器不支持WebSocket");
            } else {
                console.log("您的浏览器支持WebSocket");
                if (!this.user) {
                    this.$message.error('请先登录');
                    this.$store.state.loginFlag = true
                    return;
                }
                if (!content) {
                    this.$message.error('请输入内容');
                    return;
                }

                let message = {
                    code: 2, messageData: {
                        fromUserId: this.user.id, content: content, fromUserAvatar: this.user.avatar,
                        fromUserNickname: this.user.nickname, type: type, isRead: 0
                    }
                }

                if (this.selectUserOnline != null) {
                    message = {
                        code: 1,
                        messageData: {
                            fromUserId: this.user.id,
                            fromUserAvatar: this.user.avatar,
                            fromUserNickname: this.user.nickname,
                            toUserId: this.selectUserOnline.receiveId,
                            toUserAvatar: this.selectUserOnline.avatar,
                            toUserNickname: this.selectUserOnline.nickname,
                            content: content,
                            type: type,
                            isRead: 0,
                        }
                    }
                }
                //发送消息
                send(JSON.stringify(message))
                //socket.send(JSON.stringify(message));  // 将组装好的json发送给服务端，由服务端进行转发
                // this.messageList.push(message)
                // 构建消息内容，本人消息
                this.text = "";
            }
        },
        //初始化socket
        init() {
            let _this = this;
            if (!_this.user) {
                this.$message.error('登录才能进行群聊');
                return;
            }
            if (typeof (WebSocket) == "undefined") {
                console.log("您的浏览器不支持WebSocket");
            } else {
                console.log("您的浏览器支持WebSocket");
                let socketUrl = _this.websoketUrl + "?userId=" + _this.user.id;
                if (socket != null) {
                    socket.close();
                    socket = null;
                }
                // 开启一个websocket服务
                socket = new WebSocket(socketUrl);
                //打开事件
                socket.onopen = function () {

                    console.log("websocket已打开");
                    //获取房间列表
                    getRoomList().then(res => {
                        _this.roomList.push(...res.data)
                    })
                    if (_this.userId != null) {
                        addRoom(_this.userId).then(res => {
                            if (res.data != null) {
                                _this.roomList.push(res.data)
                            }
                        }).catch(err => {
                            _this.$message.error(err.message)
                        })
                    }
                    //连接成功后获取历史聊天记录
                    _this.getHistoryList()

                };
                //  浏览器端收消息，获得从服务端发送过来的文本消息
                socket.onmessage = function (msg) {
                    console.log("收到数据====" + msg.data)
                    let data = JSON.parse(msg.data)

                    //群聊
                    if (data.code == 2) {
                        if (_this.selectUserOnline) {
                            return;
                        }
                        // 这是撤回的逻辑
                        if (data.index != null) {
                            _this.messageList[data.index].content = data.content
                            _this.messageList[data.index].isWithdraw = 1
                            return;
                        }
                        _this.messageList.push(data)
                        return;
                    }
                    //单聊
                    if (data.code == 1) {
                        for (let index = 0; index < _this.roomList.length; index++) {

                            const room = _this.roomList[index]
                            if (room.receiveId == data.fromUserId) {
                                _this.roomList[index].readNum++
                            }
                        }
                        if (!_this.selectUserOnline) {
                            return;
                        }
                        if (_this.selectUserOnline.receiveId == data.fromUserId || _this.selectUserOnline.receiveId == data.toUserId) {

                            //这是撤回的逻辑
                            if (data.index != null) {
                                _this.messageList[data.index].content = data.content
                                _this.messageList[data.index].isWithdraw = 1
                                return;
                            }
                            _this.messageList.push(data)
                            return;
                        }
                        return;
                    }
                };
                //关闭事件
                socket.onclose = function () {
                    console.log("websocket已关闭");

                };
                //发生了错误事件
                socket.onerror = function () {
                    console.log("websocket发生了错误");

                }
            }
        },
    }
}
</script>



<style lang="scss" scoped>
.loading {
    /* 加载中的样式 */
    position: relative;
    margin: 0 auto;
    margin-top: 20px;
}

.spinner {
    /* 转圈圈的样式 */
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 30px;
    height: 30px;
    border: 4px solid #ccc;
    border-top-color: var(--theme-color);
    border-radius: 50%;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    0% {
        transform: translate(-50%, -50%) rotate(0deg);
    }

    100% {
        transform: translate(-50%, -50%) rotate(360deg);
    }
}

.im-main {
    min-height: calc(100vh - 167px);
    display: flex;
    justify-content: center;
    position: relative;

    @media screen and (max-width: 1118px) {
        .im-warpper {
            width: 100%;
        }
    }

    @media screen and (min-width: 1119px) {
        .im-warpper {
            width: 60%;
        }
    }

    .im-warpper {
        color: var(--im-text-color);
        display: flex;
        border: 2px solid var(--border-line);
        height: 100%;
        margin-top: 80px;



        .online {
            width: 250px;
            background-color: var(--im-backgroudColor);
            border-left: 1px solid var(--border-line);
            background-color: #2e3238;
            padding: 10px;
            color: #fff;

            .onlineCount {
                padding: 10px;
            }

            .online-item {
                list-style: none;

                .onlineLi {
                    cursor: pointer;
                    padding: 5px;
                    line-height: 30px;
                    border-radius: 5px;
                    margin-top: 10px;
                    position: relative;

                    &:hover {
                        background-color: #ccc;

                        .close {
                            display: block;
                        }
                    }

                    .room-list-item {
                        display: flex;
                        align-items: center;

                        .roomName {
                            margin-left: 10px;
                        }
                    }

                    .readNum {
                        margin-left: 10px;
                        display: inline-block;
                        background-color: #e63131;
                        border-radius: 50%;
                        width: 25px;
                        height: 25px;
                        position: relative;


                        span {
                            position: absolute;
                            left: -3px;
                            top: -3px;
                        }
                    }

                    .close {
                        background-color: #fff;
                        color: #000;
                        width: 20px;
                        height: 20px;
                        border-radius: 50%;
                        position: absolute;
                        top: -15px;
                        right: -5px;
                        display: none;

                        span {
                            position: absolute;
                            top: -5px;
                            left: -8px;
                        }
                    }
                }

                .active {
                    background-color: #ccc;

                }

                img {
                    width: 30px;
                    height: 30px;
                    border-radius: 50%;
                    vertical-align: middle;
                }

                span {
                    line-height: 30px;
                    margin-left: 10px;
                }
            }
        }

        .item {
            background-color: var(--im-backgroudColor);
            width: 100%;
            box-shadow: none;


            .title {
                text-align: center;
                padding: 10px 0;
                font-size: 18px;
                color: var(--article-color);
                border-bottom: 1px solid #909399;
            }

            .messageBox,
            .emoji-wrapper {

                &::-webkit-scrollbar {
                    width: 5px;
                }

                &::-webkit-scrollbar-thumb {
                    background: linear-gradient(180deg, #F0BBC3, #10A44A);
                    border-radius: 5px;
                }
            }

            .messageBox {
                height: 500px;
                overflow: auto;

                .more {
                    text-align: center;
                    margin-top: 10px;
                    cursor: pointer;
                }

                .messageItem {
                    margin-top: 20px;
                    margin-bottom: 20px;

                    .withdraw {
                        text-align: center;

                        img,
                        .nickname {
                            display: none
                        }
                    }

                    .tag {
                        width: 20px;
                        height: 20px;
                        vertical-align: -5px;
                    }

                    .left {
                        padding: 5px 10px;
                        display: flex;

                        .info {
                            margin-left: 5px;
                            color: var(--text-color);

                            .nickname {
                                font-size: 0.8rem;
                                display: block;
                                margin-bottom: 3px;

                                .item {
                                    margin-left: 10px;
                                    font-size: 12px;
                                }
                            }
                        }
                    }

                    img {
                        width: 45px;
                        height: 45px;
                        border-radius: 50%;
                    }

                    .messageContent,
                    .nowMessageContent {
                        display: inline-block;
                        color: #555;
                        border-radius: 3px;
                        margin-top: 5px;
                        max-width: 400px;
                        padding: 8px;
                    }

                    .messageContent {
                        background-color: var(--im-box-backgroudColor);
                        border-radius: 2px 18px 18px;

                    }


                    .right {
                        margin: 2px;
                        padding: 5px 10px;
                        position: relative;
                        display: flex;
                        flex-direction: row-reverse;

                        .nowMessageContent {
                            background-color: var(--im-user-box-backgroudColor);
                            border-radius: 18px 2px 18px 18px;
                        }

                        img {
                            float: right;
                            margin-left: 10px;
                        }

                        .info {
                            float: right;
                            display: flex;
                            flex-direction: row-reverse;
                            flex-wrap: wrap;
                            color: var(--text-color);

                            .nickname {
                                display: inline-block;
                                text-align: right;
                                font-size: 0.8rem;
                                margin-bottom: 3px;
                                width: 100%;

                                .item {
                                    margin-right: 10px;
                                    font-size: 12px;
                                }

                            }
                        }
                    }
                }
            }



            .input-box {
                border-top: 1px solid #999;
                margin-top: 20px;
                position: relative;

                .selelctBox {
                    margin-top: 10px;

                    i {
                        cursor: pointer;
                        font-size: 20px;
                        margin-left: 20px;
                        color: var(--text-color);
                    }

                    /deep/ .avatar-uploader {
                        display: inline-block;
                    }

                }


                .emoji-wrapper {
                    background-color: var(--background-color);
                    width: 380px;
                    height: 200px;
                    overflow-y: auto;
                    border-radius: 5px;
                    position: absolute;
                    top: -220px;

                    .emojiItem {
                        cursor: pointer;
                        margin-bottom: 5px;
                        font-size: 1.5rem;
                        text-align: center;
                        display: inline-block;

                        &:hover {
                            background-color: #eeeeee;
                        }
                    }
                }

                .contentBox {
                    height: 160px;
                    width: 100%;
                    padding: 20px;
                    border: none;
                    outline: none;
                    resize: none;
                    background-color: var(--im-backgroudColor);
                    color: var(--text-color);
                    font-size: 14px;
                }

                .btn {
                    position: absolute;
                    right: 10px;
                    bottom: 10px;
                    width: auto;
                    height: 40px;
                    border-radius: 10px;
                    text-align: center;
                    line-height: 40px;
                    padding: 0 5px;
                    background-image: linear-gradient(to left, #80CBC4, #4DB6AC, #26A69A);
                }
            }

            .contextmenu {
                margin: 0;
                background: #fff;
                z-index: 3000;
                position: fixed; //关键样式设置固定定位
                list-style-type: none;
                padding: 5px 0;
                font-size: 14px;
                font-weight: 400;
                color: #333;
                box-shadow: 2px 2px 3px 0 rgba(0, 0, 0, 0.3);
                width: 150px;
                border-bottom-left-radius: 0 !important;
                border-bottom-right-radius: 0 !important;

                li {
                    margin: 0;
                    padding: 7px 16px;
                    cursor: pointer;
                    border-bottom: 1px solid #999;


                    &:hover {
                        background: #ddaec8;
                    }

                    &:last-child {
                        border: 0;
                    }

                    i {
                        margin-right: 3px;
                    }
                }


            }
        }
    }


}
</style>