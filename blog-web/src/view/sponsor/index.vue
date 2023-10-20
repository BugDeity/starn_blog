<template>
    <div class="sponsor-main">
        <el-card class="sponsor-warpper">
            <h2 class="title">
                赞助墙
            </h2>
            <div class="sponsor-tips">
                <div class="item">当前赞助用途</div>
                <div class="item">1.维护网站：域名</div>
                <div class="item"> 2.为以后升级博客筹钱</div>
                <div class="item"> 3.捐款</div>
                <div class="item">4.满足…UP的小小愿望</div>
            </div>
            <div class="tips">
                <div class="item">
                    请注意:
                </div>
                <div class="item">
                    1.UP不会强迫任何人必须赞助！完全自愿。
                </div>
                <div class="item">
                    2.在支付完后请点击此处来发送你的支付截图
                </div>
            </div>
            <div class="sponsor">
                <div class="sponsorBtn">
                    <button ref="button" v-for="(item, index) in btnList" :key="index" typ="botton"
                        :class="{ 'active': index === activeIndex }" @click="handleClike(index)">{{ item }}</button>
                </div>
                <div class="sponsor-img">
                    <div class="img-tips">
                        请在支付前认真思考！！<br />
                        目前仅支持右侧的三项支付方式
                    </div>
                    <div class="imgBox">
                        <img v-if="!activeIndex"
                            src="https://www.z4a.net/images/2022/12/22/6a63f6246b600c3387448165dc1f460fd9f9d72a0b58.jpg"
                            alt="">
                        <img v-if="activeIndex == 1" :src="$store.state.webSiteInfo.weixinPay" alt="">
                        <img v-if="activeIndex == 2" :src="$store.state.webSiteInfo.aliPay" alt="">
                    </div>

                </div>
            </div>
        </el-card>
    </div>
</template>
<script>
export default {
    data() {
        return {
            btnList: ["确认", "微信", "支付宝"],
            activeIndex: 0,
        }
    },

    methods: {
        handleClike(index) {
            this.$refs.button[this.activeIndex].className = "";
            this.$refs.button[index].className = "active";
            this.activeIndex = index;
        },
    }
}
</script>
<style lang="scss" scoped>
.sponsor-main {
    display: flex;
    justify-content: center;

    /deep/ .sponsor-warpper {
        position: relative;
        margin-top: 80px;
        width: 65%;
        min-height: calc(100vh - 207px);
        padding: 30px 50px;
        background-color: var(--background-color);
        color: var(--text-color);

        .item {
            margin-bottom: 10px;
        }

        .sponsor-tips {
            margin-top: 15px;
            border: 1px solid var(--border-line);
            border-left: 5px solid var(--border-line);
            padding: 20px;
            width: auto;
            border-radius: 5px;


        }

        .tips {
            margin-top: 15px;
            background-color: var(--tips-backgroud-color);
            padding: 10px 20px;

        }

        .sponsor {
            margin-top: 15px;
            background-color: #f0f0f0;
            padding: 5px;
            border-radius: 5px;

            .sponsorBtn {
                button {
                    padding: 20px;
                    display: inline-block;
                    cursor: pointer;
                    border: none;

                    &:hover {
                        background-color: rgba(196, 193, 193, 0.7)
                    }
                }

                .active {
                    background-color: #fff;
                    border-bottom: 2px solid #799ee4;
                }
            }

            .sponsor-img {
                background-color: var(--background-color);

                .img-tips {
                    padding: 20px 20px;
                    color: #6bcf84;
                }

                .imgBox {
                    width: 500px;
                    margin: 0 auto;

                    img {
                        width: 100%;
                        text-align: center;

                    }
                }

            }
        }

    }
}
</style>