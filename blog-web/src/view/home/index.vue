<template>
    <div class="main-container">
        <div class="main">
            <div class="main-box">
                <div class="bannerBox">
                    <!-- 轮播图 -->
                    <el-carousel class="banner" :interval="5000" arrow="always">
                        <el-carousel-item v-for="(item, index) in bannerList" :key="index">
                            <router-link :to="'/article/' + item.id">
                                <img class="bannerImg" v-lazy="item.avatar" :key="item.avatar" />
                                <h3 class="title">{{ item.title }}</h3>
                            </router-link>
                        </el-carousel-item>
                    </el-carousel>
                </div>

                <div class="tuijian">
                    <SiteInfo />
                    <Notcie />
                </div>
            </div>

            <!-- 热门分类 -->
            <div class="hot_category">
                <el-tabs v-model="activeName" @tab-click="handleTabClick">
                    <el-tab-pane class="categoryItem" v-for="(item, index) in categoryList" :name="index + ''" :key="index">
                        <span slot="label">
                            <i :class="item.icon"></i>
                            {{ item.name }}
                        </span>
                    </el-tab-pane>
                </el-tabs>
            </div>


            <div class="content">
                <!-- 左侧内容 -->
                <div class="articleBox" v-if="articleList.length > 0">
                    <el-card class="articleItem" v-for="(item, index) in articleList" :key="item.id">
                        <div class="articleInfo">
                            <div class="articleInfo-item">
                                <el-tooltip class="item" effect="dark" content="原创文章" placement="top">
                                    <span v-if="item.isOriginal" class="original">
                                        <i class="el-icon-tickets"></i>
                                    </span>
                                </el-tooltip>

                                <span v-if="item.isStick" class="top">置顶</span>
                                <router-link :to="'/article/' + item.id">
                                    <h3>{{ item.title }}</h3>
                                </router-link>
                                <p>
                                    {{ item.summary }}
                                </p>
                            </div>
                            <router-link :to="'/article/' + item.id">
                                <div class="articleImgBox" style="">
                                    <img class="articleImg" v-lazy="item.avatar" :key="item.avatar">
                                </div>
                            </router-link>

                        </div>
                        <div class="bottumItem">
                            <div class="articleUser">
                                <el-avatar class="userAvatar" :src="item.userAvatar"></el-avatar>
                                <span>{{ item.username }}</span>
                            </div>

                            <div class="tag">

                                <el-tooltip class="item" effect="dark" content="文章分类" placement="top">
                                    <el-tag size="mini" @click="handleClike(item.categoryId, '/categorys')">
                                        <i class=" el-icon-folder-opened"></i> {{ item.categoryName }}
                                    </el-tag>
                                </el-tooltip>
                                <el-tooltip class="item" effect="dark" content="文章标签" placement="top">
                                    <el-tag :type="tagStyle[Math.round(Math.random() * 4)]" size="mini"
                                        v-for="tag in item.tagList" :key="tag.id" @click="handleClike(tag.id, '/tag')">
                                        <i class="el-icon-collection-tag"></i>
                                        {{ tag.name }}
                                    </el-tag>
                                </el-tooltip>


                            </div>

                            <div class="articleOhter">
                                <span class="item">
                                    <i class="el-icon-view"></i>
                                    <span class="name">阅读</span>{{ item.quantity }}
                                </span>
                                <span class="item">
                                    <i class="el-icon-chat-dot-round"></i>
                                    <span class="name">评论</span>{{ item.commentCount }}
                                </span>
                                <span class="item">
                                    <span v-if="item.isCollect">
                                        <i style="font-size: 1rem;" class="el-icon-star-on"></i>
                                        <span class="name">收藏</span>{{ item.collectCount }}
                                    </span>
                                    <span v-else>
                                        <i style="font-size: 1rem;" class="el-icon-star-off"></i>
                                        <span class="name">收藏</span>{{ item.collectCount }}
                                    </span>
                                </span>
                                <span class="item">
                                    <i style="font-size: 0.8rem;" class="iconfont icon-dianzan1"></i>
                                    <span class="name">赞</span>{{ item.likeCount }}
                                </span>
                                <span class="item">
                                    <i class="el-icon-time"></i>{{ item.formatCreateTime }}
                                </span>
                            </div>
                        </div>
                    </el-card>
                    <!-- 分页按钮 -->
                    <div>
                        <sy-pagination :pageNo="pageData.pageNo" :pages="pages" @changePage="handlePage" />
                    </div>

                </div>
                <sy-empty v-else message="很抱歉，暂无文章" />

                <!-- 右侧内容 -->
                <div class="rightBox">
                    <!-- 登录提示框 -->
                    <!-- <el-card v-if="!$store.state.userInfo" class="box-card">
                        <div style="margin-bottom: 15px;margin-top: 10px;">
                            登录网站，开启你的创作之旅：
                        </div>
                        <div style="margin-bottom: 15px;margin-top: 30px;">
                            <span>
                                <i class="el-icon-cloudy"></i>参与互动评论
                            </span>
                            <span style="margin-left: 20px;">
                                <i class="el-icon-cloudy"></i>发表优质文章
                            </span>

                            <el-button style="margin-top: 20px;width: 100%;" size="small" type="success"
                                @click="handleLogin">立即登录</el-button>
                        </div>
                    </el-card> -->
                    <!-- 个人信息 -->
                    <!-- <el-card v-else class="box-card myUserInfo">
                        <div style="margin-bottom: 15px;margin-top: 10px;">
                            <a href="javascript:;" @click="openUserInfoDrawer(null)" style="display: flex;">
                                <el-avatar style="border: 1px solid var(--border-line);"
                                    :src="$store.state.userInfo.avatar"></el-avatar>
                                <div class="userInfo">
                                    <p class="nickname">{{ $store.state.userInfo.nickname }}</p>
                                    <p class="intor">{{ $store.state.userInfo.intro ? $store.state.userInfo.intro
                                        : '这个博主很懒，什么都没有留下' }}</p>
                                </div>
                            </a>
                        </div>
                        <div style="margin-bottom: 15px;margin-top: 30px;display: flex;">
                            <span class="myArticle" @click="openUserInfoDrawer('article')">
                                <div>
                                    {{ $store.state.userInfo.articleCount }}
                                </div>
                                <div class="name">
                                    文章
                                </div>
                            </span>
                            <span class="myComment" @click="openUserInfoDrawer('comment')">
                                <div>
                                    {{ $store.state.userInfo.commentCount }}
                                </div>
                                <div class="name">
                                    评论
                                </div>
                            </span>
                            <span class="myNote" @click="openUserInfoDrawer('note')">
                                <div>
                                    {{ $store.state.userInfo.noteCount }}
                                </div>
                                <div class="name">
                                    笔记
                                </div>
                            </span>
                            <span class="myCollect" @click="openUserInfoDrawer('collect')">
                                <div>
                                    {{ $store.state.userInfo.collectCount }}
                                </div>
                                <div class="name">
                                    收藏
                                </div>
                            </span>
                            <span class="myFans">
                                <div>
                                    {{ $store.state.userInfo.fansCount }}
                                </div>
                                <div class="name">
                                    粉丝
                                </div>
                            </span>
                        </div>

                        <div class="qidayBox">
                            <span class="qidayFans">
                                <div class="name">
                                    7日新增粉丝量
                                </div>
                                <div>
                                    {{ $store.state.userInfo.qiDayFollowedCount }}
                                </div>
                            </span>
                            <span class="qidayYuedu">
                                <div class="name">
                                    7日新增阅读量
                                </div>
                                <div>
                                    0
                                </div>
                            </span>
                        </div>
                    </el-card> -->

                    <!-- 推荐文章 -->
                    <el-card class="box-card recomArticle">
                        <div class="clearfix">
                            <svg-icon icon-class="tuijian"></svg-icon>
                            <span>推荐文章</span>
                        </div>
                        <ul class="recomArticleUl">
                            <li v-for="(item, index) in    newArticleList   ">
                                <div class="article-item">
                                    <div class="recomCover">
                                        <router-link :to="'/article/' + item.id">
                                            <div class="imgBox">
                                                <img v-lazy="item.avatar" :key="item.avatar" />
                                            </div>
                                        </router-link>
                                    </div>
                                    <p class="info">
                                        <router-link class="tuijian-title" :to="'/article/' + item.id">
                                            {{ item.title }}
                                        </router-link>

                                        <span class="time">{{ item.createTime }}</span>
                                    </p>
                                </div>
                            </li>
                        </ul>
                    </el-card>

                    <!-- 关注我 -->
                    <el-card class="box-card guanzhu">
                        <div class="clearfix">
                            <svg-icon icon-class="guanzhume" class="title-svg"></svg-icon>
                            <span>关注我</span>
                        </div>
                        <ul class="guanzhuList">
                            <li v-show="isShow(2)">
                                <div class="guanzhu-item qq">
                                    <svg-icon icon-class="qq" />
                                    <a :href="'//wpa.qq.com/msgrd?v=3&amp;uin=' + $store.state.webSiteInfo.qqNumber + '&amp;site=qq&amp;menu=yes'"
                                        target="_blank">
                                        {{ $store.state.webSiteInfo.qqNumber }}
                                    </a>
                                    <span title="点击复制" @click="copy($store.state.webSiteInfo.qqNumber)"
                                        class="copyBtn name">
                                        QQ号
                                    </span>
                                </div>
                            </li>
                            <li v-show="isShow(6)">
                                <div class="guanzhu-item qqgroup">
                                    <svg-icon icon-class="qqgroup" />
                                    <a href="javascript:;">
                                        {{ $store.state.webSiteInfo.qqGroup }}
                                    </a>
                                    <span title="点击复制" @click="copy($store.state.webSiteInfo.qqGroup)" class="copyBtn name">
                                        QQ群
                                    </span>
                                </div>
                            </li>
                            <li v-show="isShow(3)">
                                <div class="guanzhu-item github">
                                    <svg-icon icon-class="github" />
                                    <a :href="$store.state.webSiteInfo.github" target="_blank">
                                        {{ $store.state.webSiteInfo.github }}
                                    </a>
                                    <span title="点击复制" @click="copy($store.state.webSiteInfo.github)" class="copyBtn name">
                                        github
                                    </span>
                                </div>
                            </li>
                            <li v-show="isShow(4)">
                                <div class="guanzhu-item gitee">
                                    <svg-icon icon-class="gitee" />
                                    <a :href="$store.state.webSiteInfo.gitee" target="_blank">
                                        {{ $store.state.webSiteInfo.gitee }}
                                    </a>
                                    <span title="点击复制" @click="copy($store.state.webSiteInfo.gitee)" class="copyBtn name">
                                        gitee
                                    </span>
                                </div>
                            </li>
                            <li v-show="isShow(1)">
                                <div class="guanzhu-item email">
                                    <svg-icon icon-class="email" />
                                    <a :href="'mailto:' + $store.state.webSiteInfo.email" target="_blank" title="邮箱">
                                        {{ $store.state.webSiteInfo.email }}
                                    </a>
                                    <span title="点击复制" @click="copy($store.state.webSiteInfo.email)" class="copyBtn name">
                                        邮箱
                                    </span>
                                </div>
                            </li>
                            <li v-show="isShow(5)">
                                <div class="guanzhu-item wechat">
                                    <svg-icon icon-class="wechat" /> {{ $store.state.webSiteInfo.wechat }}
                                    <span title="点击复制" @click="copy($store.state.webSiteInfo.wechat)" class="copyBtn name">
                                        微信
                                    </span>
                                </div>
                            </li>
                        </ul>
                    </el-card>

                    <!-- 标签墙 -->
                    <el-card class="box-card tag_container">
                        <div class="clearfix">
                            <svg-icon icon-class="tag"></svg-icon>
                            <span> 标签墙</span>
                            <a href="/tag" class="more">更多</a>
                        </div>
                        <div class="tag">
                            <span @click="handleClike(item.id, '/tag')" :style="{ backgroundColor: `${randomColor()}` }"
                                class="item" v-for="(item, index) in tagList" :key="index">
                                {{ item.name }}
                            </span>
                        </div>
                    </el-card>

                    <!-- 天气组件 -->
                    <el-card class="box-card weather">
                        <div class="clearfix">
                            <svg-icon icon-class="weather"></svg-icon>
                            <span> 今日天气</span>
                        </div>
                        <div id="he-plugin-standard"></div>
                    </el-card>

                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { fetchArticleList, featchHomeData, featchCategory } from '@/api'
import Notcie from '@/components/notice/index.vue'
import SiteInfo from '@/components/site/index.vue'
export default {
    components: {
        Notcie,
        SiteInfo
    },
    name: 'Home',
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
            centerDialogVisible: false,
            emojis: [],
            pageData: {
                pageNo: 1,
                pageSize: 8,
            },
            activeName: "0",
            bannerList: [],
            categoryList: [
                {
                    id: null,
                    name: "最新",
                    icon: "el-icon-news",
                    desc: "create_time"
                },
                {
                    id: null,
                    name: "最热",
                    icon: "el-icon-tableware",
                    desc: "quantity"
                }
            ],
            articleList: [],
            pages: 0,
            tagList: [],
            newArticleList: [],
            tagStyle: ['', 'success', 'info', 'warning', 'danger']

        };
    },
    created() {
        this.fetchArticleList()
        this.getHomeData()
        this.fetchCategoryList()
        this.insertWeather()
    },
    methods: {
        insertWeather() {
            window.WIDGET = {
                "CONFIG": {
                    "layout": "2",
                    "width": 230,
                    "height": 270,
                    "background": "2",
                    "dataColor": "000000",
                    "borderRadius": "5",
                    "key": "632bf35b75f643fda4f7154697df9f47"
                }
            }
            const script = document.createElement('script')
            script.src = 'https://widget.qweather.net/standard/static/js/he-standard-common.js?v=2.0'
            document.body.appendChild(script)
        },
        openUserInfoDrawer(value) {
            this.$store.state.userInfoDrawer.flag = true;
            this.$store.state.userInfoDrawer.name = value;
        },
        handleClike(id, path) {
            this.$router.push({ path: path, query: { id: id } })
        },
        randomColor() {
            var letters = '0123456789ABCDEF';
            var color = '#';
            do {
                for (var i = 0; i < 6; i++) {
                    color += letters[Math.floor(Math.random() * 16)];
                }
            } while (color === '#FFFFFF' || color === '#000000');
            return color;
        },
        isShow(type) {
            return this.$store.state.webSiteInfo.showList.indexOf(type) != -1
        },
        copy(value) {
            const clipboard = new this.Clipboard('.copyBtn', {
                text: () => value
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
        handleTabClick(tab) {

            let item = this.categoryList[tab.index]
            this.pageData.pageNo = 1
            this.pageData.categoryId = item.id
            this.pageData.orderByDescColumn = item.desc
            fetchArticleList(this.pageData).then(res => {
                this.articleList = res.data.records;
                this.pages = res.data.pages

            })
        },
        handleLogin() {
            this.$store.state.loginFlag = true
        },
        // 分页
        handlePage(val) {
            this.pageData.pageNo = val;
            this.fetchArticleList()
        },
        fetchArticleList() {
            fetchArticleList(this.pageData).then(res => {
                this.articleList.push(...res.data.records);
                this.pages = res.data.pages
            })
        },
        fetchCategoryList() {
            featchCategory().then(res => {
                this.categoryList.push(...res.data)
            })
        },
        getHomeData() {
            featchHomeData().then(res => {
                this.bannerList = res.extra.articles
                this.tagList = res.extra.tagCloud
                this.newArticleList = res.extra.newArticleList
            })
        },

        handleCategoryClike(item) {
            this.$router.push({ name: "/category", query: { id: item.id, name: item.name } })
        },

    },
}
</script>

<style lang="scss" scoped >
/deep/ .el-tabs__item {
    color: var(--article-color);
}

/deep/ .is-active {
    color: #409EFF;
}

/deep/ .el-tabs__nav-wrap::after {
    background-color: var(--background-color);
}

/deep/ .el-tabs__active-bar {
    background-color: var(--theme-color);
}

/deep/ .el-dialog {
    background-color: rgba(0, 0, 0, .5);
    border-radius: 10px;

    .el-dialog__header {
        .el-dialog__title {
            color: #fff;
        }
    }

    .el-dialog__body {
        background-color: rgb(140, 140, 140);

    }

    .conent {
        text-align: center;
    }

    .footer-item {
        color: #fff;
    }
}

.banner {
    position: relative;
    height: 420px;


    /deep/ .el-carousel__container {
        height: 100%;
    }

    .title {
        position: absolute;
        height: 50px;
        line-height: 50px;
        text-align: center;
        width: 100%;
        bottom: 50px;
        color: #fff;
        background: rgba(0, 0, 0, .3);
        z-index: 1;
    }

    .bannerImg {
        width: 100%;
        height: 100%;
    }
}


.main-container {
    display: flex;
    justify-content: center;

    @media screen and (max-width: 1118px) {
        padding-left: 10px;
        padding-right: 10px;

        .tuijian,
        .rightBox,
        .articleImg {
            display: none;
        }

        .main {
            width: 100%;
            margin-top: 70px;

            .bannerBox {
                width: 100%;

                .banner {
                    height: 200px;
                    border-radius: 5px;
                }
            }

            .articleInfo-item {
                width: 95%;

            }
        }
    }

    @media screen and (min-width: 1119px) {
        .main {
            width: 65%;
            margin-top: 80px;

            .bannerBox {
                width: 70%;

                /deep/ .banner {
                    border-radius: 5px;
                }
            }

            .articleInfo-item {
                width: 70%;
            }

            .articleImgBox {
                width: 180px;
                height: 110px;
                overflow: hidden;
                border: 1px solid var(--border-line);
                position: absolute;
                right: 30px;
                top: 20px;
                border-radius: 5px;

                &:hover .articleImg {
                    transform: scale(1.1);
                }

                .articleImg {
                    width: 100%;
                    height: 100%;
                    transition: all 0.5s;
                }
            }



            .tuijian {
                display: inline-block;
                width: 30%;
                height: 420px;
                margin-left: 20px;

                /deep/ .el-image {
                    width: 100%;
                    height: 47%;
                    cursor: pointer;

                    &:last-child {
                        margin-top: 20px;
                    }
                }

                /deep/ .wh_content_all {
                    background-color: var(--theme-color);
                    border-top-left-radius: 10px;
                    border-top-right-radius: 10px;

                }

            }

            .rightBox {
                width: 43%;
                margin-left: 20px;

                .box-card {
                    font-size: 16px;
                    padding: 12px;
                    background-color: var(--background-color);
                    color: var(--article-color);
                    margin-bottom: 15px;


                    &:hover {
                        .clearfix {
                            &::before {
                                content: '';
                                width: 70px;
                            }
                        }
                    }

                    .clearfix {
                        position: relative;
                        margin-bottom: 20px;

                        svg {
                            width: 22px;
                            height: 22px;
                            vertical-align: -5px;
                            margin-right: 5px;
                        }

                        &::before {
                            content: '';
                            width: 25px;
                            border: 2px solid #333;
                            position: absolute;
                            bottom: -10px;
                            transition: width .5s;
                        }
                    }

                }

                .myUserInfo {
                    a {
                        text-decoration: none;

                    }

                    .qidayBox {
                        display: flex;
                        background-color: var(--home-user-back-color);
                        padding: 10px 0;

                        .qidayFans,
                        .qidayYuedu {
                            width: 50%;
                        }
                    }

                    .userInfo {
                        margin-left: 10px;

                        .nickname {
                            color: var(--article-color);
                            font-weight: 700;
                        }

                        .intor {
                            font-size: 0.9rem;
                            color: var(--text-color);
                            margin-top: 2px;
                        }
                    }

                    .myArticle,
                    .myComment,
                    .myCollect,
                    .myNote,
                    .myFans,
                    .qidayFans,
                    .qidayYuedu {
                        text-align: center;
                        margin-left: 20px;
                        width: 20%;
                        cursor: pointer;

                        .name {
                            margin-top: 2px;
                        }
                    }

                    .qidayFans,
                    .qidayYuedu {
                        margin: 0;
                    }
                }

                .recomArticle {
                    color: var(--article-color);

                    .recomArticleUl {
                        display: flex;
                        padding: 10px;
                        list-style: none;
                        flex-wrap: wrap;

                        li {
                            width: 100%;
                            margin-bottom: 20px;

                            &:last-child {
                                margin-bottom: 10px;
                            }

                            &:hover {
                                /deep/ .el-image__inner {
                                    transform: scale(1.1);
                                }
                            }

                            .article-item {
                                height: 100%;
                                display: flex;

                                .info {
                                    display: flex;
                                    flex-direction: column;

                                    .tuijian-title {
                                        text-decoration: none;
                                        color: var(--article-color);
                                        overflow: hidden;
                                        text-overflow: ellipsis;
                                        display: -webkit-box;
                                        -webkit-box-orient: vertical;
                                        -webkit-line-clamp: 2;
                                        height: 50%;

                                        &:hover {
                                            color: var(--theme-color);
                                        }
                                    }


                                    .time {
                                        font-size: 0.8rem;
                                        color: var(--text-color);
                                        margin-top: 10px;
                                    }
                                }

                                .recomCover {
                                    //
                                    cursor: pointer;

                                    .imgBox {
                                        width: 120px;
                                        height: 75px;
                                        margin-right: 10px;
                                        border-radius: 5px;
                                        overflow: hidden;
                                        border: 1px solid var(--border-line);

                                        img {
                                            width: 100%;
                                            height: 100%;
                                            transition: all 0.5s;
                                            margin-right: 10px;
                                        }

                                        &:hover img {
                                            transform: scale(1.1);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                .guanzhu {
                    .guanzhuList {
                        padding: 15px;
                        list-style: none;

                        .guanzhu-item {
                            margin-bottom: 20px;
                            height: 40px;
                            line-height: 40px;
                            font-size: 12px;
                            display: flex;
                            position: relative;
                            border-radius: 3px;
                            border: 1px solid #333;

                            a {
                                text-decoration: none;
                                color: var(--text-color);
                                overflow: hidden;
                                text-overflow: ellipsis;
                                white-space: nowrap;
                                width: 100%;
                                flex: 1;

                                &:hover {
                                    color: var(--theme-color);
                                }
                            }

                            .name {
                                position: absolute;
                                right: 0;
                                width: 60px;
                                text-align: center;
                                cursor: pointer;
                                color: #fff;
                                transition: width .35s;
                            }

                            &:hover .name {
                                width: 80px;
                            }

                            svg {
                                width: 20px;
                                height: 20px;
                                margin-left: 5px;
                                position: relative;
                                bottom: -10px;
                                margin-right: 10px;
                            }
                        }

                        .github {
                            border-color: #606266;

                            .name {
                                background-color: #606266;
                            }
                        }

                        .gitee {
                            border-color: red;

                            .name {
                                background-color: red;
                            }
                        }

                        .email {
                            border-color: #F56C87;

                            .name {
                                background-color: #F56C87;
                            }
                        }

                        .wechat {
                            border-color: #67C23A;

                            .name {
                                background-color: #67C23A;
                            }
                        }

                        .qq {
                            border-color: #409EFF;

                            .name {
                                background-color: #409EFF;
                            }
                        }

                        .qqgroup {
                            border-color: #ea9518;

                            .name {
                                background-color: #ea9518;
                            }
                        }


                    }
                }

                .tag_container {

                    font-size: 0.9rem;
                    background-color: var(--background-color);


                    &:hover {
                        transition: all .3s;
                    }

                    .clearfix {
                        font-size: 16px;

                        .more {
                            float: right;
                            margin-right: 10px;
                            font-size: 13px;
                            color: var(--text-color);
                            text-decoration: none;

                            &:hover {
                                color: var(--theme-color);
                            }
                        }
                    }

                    .tag {

                        padding-bottom: 10px;
                        height: auto;
                        margin-top: 10px;

                        span {
                            text-decoration: none;
                            margin-right: 10px;
                            padding: 5px;
                            display: inline-block;
                            margin-bottom: 10px;
                            border-radius: 6px;
                            color: #fff;
                            cursor: pointer;
                            transition: all .3s;

                            &:hover {
                                border-radius: 0;
                            }
                        }
                    }

                }

                .weather {
                    /deep/ #he-plugin-standard {
                        width: 100% !important;
                        background-color: var(--background-color) !important;

                        span,
                        a {
                            color: var(--text-color) !important;
                        }
                    }
                }
            }
        }
    }

    .main {
        .main-box {
            width: 100%;
            display: flex;
        }

        .hot_category {
            margin-top: 30px;

            /deep/ .el-tabs__item:hover span {
                color: #409EFF;
            }
        }

        .content {
            display: flex;

            .articleBox {
                font-size: 1rem;
                width: 100%;

                .articleItem {
                    position: relative;
                    padding: 10px 5px 10px 15px;
                    background-color: var(--background-color);
                    margin-bottom: 20px;
                    transition: box-shadow .35s, transform .35s;

                    &:hover {
                        box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.2);
                        transform: translateY(-2px)
                    }


                    .articleInfo {

                        color: var(--article-color);

                        .original {
                            content: '';
                            position: absolute;
                            right: 0;
                            top: 0;
                            width: 0;
                            height: 0;
                            border-color: transparent #40c9c6;
                            /*上下颜色 左右颜色*/
                            border-width: 0 40px 40px 0;
                            border-style: solid;

                            i {
                                position: absolute;
                                top: 4px;
                                right: -37px;
                                font-size: 16px;
                                color: aquamarine;
                            }
                        }

                        .articleInfo-item {

                            height: 100px;

                            a {
                                color: var(--article-color);
                            }

                            .top {
                                background-image: -webkit-linear-gradient(0deg, #3ca5f6 0, #a86af9 100%);
                                padding-left: 5px;
                                padding-right: 5px;
                                display: inline-block;
                                border-top-right-radius: 5px;
                                border-bottom-left-radius: 5px;
                                font-size: 0.9rem;
                                margin-right: 5px;
                                color: #fff;
                            }

                            h3 {
                                cursor: pointer;
                                position: relative;
                                display: inline-block;

                                &::after {
                                    content: "";
                                    height: 2px;
                                    overflow: hidden;
                                    display: block;
                                    left: 0;
                                    bottom: -5px;
                                    position: absolute;
                                    width: 100%;
                                    background: var(--theme-color);
                                    transform: scaleX(0);
                                    transition: all 0.5s;
                                }

                                &:hover {
                                    &::after {
                                        transform: scaleX(1);
                                    }

                                    color: var(--theme-color);
                                }

                            }

                            p {
                                margin-top: 10px;
                                overflow: hidden;
                                text-overflow: ellipsis;
                                display: -webkit-box;
                                -webkit-box-orient: vertical;
                                -webkit-line-clamp: 3;
                            }
                        }

                    }

                    .bottumItem {
                        align-items: center;
                        display: flex;
                        margin-top: 20px;
                        flex-wrap: wrap;

                        .articleUser {
                            line-height: 50px;

                            span {
                                color: var(--theme-color);
                                margin-left: 3px;
                            }

                            .userAvatar {
                                vertical-align: middle;
                                border: 1px solid var(--border-line);
                                transition: transform .5s;

                                &:hover {
                                    transform: rotate(360deg);
                                }
                            }
                        }

                        .tag {
                            display: inline-block;
                            margin-left: 20px;

                            .el-tag {
                                margin-right: 8px;
                                cursor: pointer;
                            }
                        }

                        .articleOhter {
                            margin-left: 20px;
                            font-size: 0.8rem;
                            color: var(--text-color);

                            .item {
                                margin-right: 10px;

                                .name {
                                    margin-right: 3px;
                                }


                                i {
                                    margin-right: 3px;
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