<template>
    <div class="photo-main">
        <div class="containner">
            <el-card class="titleBox">
                <div class="title">
                    <svg-icon icon-class="photo"></svg-icon> 我的图库
                </div>
                <div class="photo">
                    <div class="photoItem" v-for="(item, index) in photoAlbumList" :key="index">
                        <a :class="index == 0 ? 'active' : 'name'" @click="handleClike(item.id, index)" ref="photo">
                            {{ item.name }}</a>
                    </div>
                </div>
            </el-card>
            <div class="photoBox">
                <a href="javascript:;" @click="previewImg(item.url)" v-for="item in photoList" :key="item.id">
                    <img class="" :src="item.url" alt="" />
                    <span class="overlay"></span>
                    <span class="desc">
                        {{ item.info }}
                    </span>

                </a>
            </div>
        </div>

    </div>
</template>
<script>
import { featchPhotoAlbum, featchPhoto } from '@/api/photo'
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
            photoAlbumList: [],
            pageData: {
                pageNo: 1,
                pageSize: 10,
                photoAlbumId: null
            },
            photoList: [],
            imgList: [],

        }
    },
    created() {
        document.title = "我的图库";
        this.getPhotoAlbum()
        this.getPhotoList()
    },
    methods: {
        previewImg(img) {
            this.$imagePreview({
                images: this.imgList,
                index: this.imgList.indexOf(img)
            });
        },
        getPhotoAlbum() {
            featchPhotoAlbum().then(res => {
                this.photoAlbumList = res.data
                let photoAlbum = {
                    id: null,
                    name: "全部"
                }
                this.photoAlbumList.unshift(photoAlbum)
            })
        },
        getPhotoList() {
            featchPhoto(this.pageData).then(res => {
                this.photoList = res.data.records
                for (var i = 0; i < this.photoList.length; i++) {
                    this.imgList.push(this.photoList[i].url);
                }
            })
        },
        handleClike(phtotAlbumId, index) {
            for (var i = 0; i < this.$refs.photo.length; i++) {
                this.$refs.photo[i].className = "name"
            }
            this.$refs.photo[index].className = "active"
            this.pageData.photoAlbumId = phtotAlbumId;
            this.getPhotoList()
        }

    }
}
</script>
<style lang="scss" scoped>
.photo-main {
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

        /deep/ .el-card {
            overflow: inherit;
        }

        .titleBox {
            background-color: var(--background-color);
            height: auto;
            padding: 20px;
            position: relative;


            .title {
                position: absolute;
                top: 15px;
                left: -10px;
                height: 30px;
                padding: 0 12px;
                color: #fff;
                font-weight: 500;
                line-height: 30px;
                background: var(--theme-color);
                border-radius: 2px 2px 2px 0;
                box-shadow: 2px 5px 10px rgba(49, 58, 70, .15);
                user-select: none;

                &::before {
                    position: absolute;
                    bottom: -10px;
                    left: -10px;
                    border-color: var(--theme-color) transparent transparent;
                    border-style: solid;
                    border-width: 10px;
                    -webkit-transform: rotate(90deg);
                    transform: rotate(90deg);
                    content: "";
                }

                svg {
                    width: 20px;
                    height: 20px;
                    vertical-align: -3px;
                }
            }

            .photo {
                margin-top: 50px;
                margin-bottom: 20px;

                .photoItem {
                    display: inline-block;
                    height: auto;
                    padding: 5px 5px;
                    cursor: pointer;
                    margin-right: 20px;
                    position: relative;
                    font-size: 14px;

                    .active {

                        color: var(--text-color);
                        font-weight: 700;

                        &::after {
                            content: "";
                            overflow: hidden;
                            display: block;
                            left: 0;
                            bottom: 0;
                            position: absolute;
                            width: 100%;
                            height: 3px;
                            background: var(--theme-color);


                        }
                    }

                    .name {
                        color: var(--text-color);

                        &::after {
                            content: "";
                            overflow: hidden;
                            display: block;
                            left: 0;
                            bottom: 0;
                            position: absolute;
                            width: 100%;
                            height: 2px;
                            background: var(--theme-color);
                            transform: scaleX(0);
                            transition: all 0.5s;
                        }

                        &:hover::after {
                            transform: scaleX(1);
                        }
                    }

                }
            }
        }

        .photoBox {
            margin-top: 20px;

            a {
                display: inline-block;
                overflow: hidden;
                min-height: 50px;
                border-radius: 10px;
                margin: 10px;
                visibility: visible;
                width: 140px;
                height: 200px;
                min-height: 50px;
                overflow: hidden;
                position: relative;

                .overlay {
                    background: rgba(0, 0, 0, .3);
                    position: absolute;
                    top: 0;
                    right: 0;
                    bottom: 0;
                    left: 0;
                    opacity: 0;
                }

                .desc {
                    z-index: 2;
                    position: absolute;
                    top: 0;
                    right: 0;
                    bottom: 0;
                    left: 0;
                    padding: 5px;
                    opacity: 0;
                    text-align: center;
                    color: var(--baise);

                }

                &:hover {
                    box-shadow: 5px 4px 8px 6px rgba(2, 6, 10, 0.06);
                    transition: all .3s;

                    .desc {
                        opacity: 1;
                        transition: all 0.5s;
                    }

                    .overlay {
                        opacity: 1;
                    }

                    img {
                        transform: scale(1.2);

                    }
                }

                img {
                    object-fit: cover;
                    width: 100%;
                    height: 100%;
                    transition: all 0.5s;
                }
            }
        }
    }
}
</style>