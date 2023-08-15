<template>
    <div class='navigation-main'>
        <div class="navigation-container">
            <div class="site-container" v-for="(item, index) in navigationList" :key="index">
                <div class="title">
                    {{ item.siteClassName }}
                </div>
                <ul>
                    <li v-for="(item, index) in item.navigations" :key="index" @click="open(item.url)">
                        <div class="item">
                            <el-avatar class="logo" :src="item.logo"></el-avatar>
                            <span class="name">{{ item.name }}</span>
                        </div>
                        <div class="info">
                            {{ item.info }}
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>
   
<script>
import { getNavigations } from '@/api/navigation'
export default {
    name: '',
    data() {
        return {
            categoryList: [],
            navigationList: [],
            siteId: null,
        }
    },
    created() {
        this.getNavigations()
    },
    methods: {

        open(url) {
            window.open(url, "_blank")
        },
        getNavigations() {
            getNavigations().then(res => {
                this.navigationList = res.data
            })
        },
    },
}
</script>
   
<style lang='scss' scoped>
.navigation-main {
    display: flex;
    justify-content: center;
    position: relative;

    .navigation-container {
        margin-top: 100px;
        width: 70%;
        height: 100%;

        .site-container {
            width: 100%;
            color: var(--text-color);
            background-color: var(--background-color);
            border-radius: 5px;
            margin-bottom: 25px;

            &:hover {
                box-shadow: 5px 4px 8px 6px rgba(7, 17, 27, .06);
                transition: all .3s;
            }

            .title {
                background-color: #f56c6cdb;
                line-height: 40px;
                height: 40px;
                color: #000;
                font-weight: 700;
                text-align: center;
                border-top-right-radius: 5px;
                border-top-left-radius: 5px;
            }

            ul {
                grid-template-columns: repeat(5, 1fr);
                display: grid;
                padding: 10px;
                list-style: none;
            }

            li {
                margin-bottom: 10px;
                padding: 10px;
                cursor: pointer;
                font-size: 15px;


                &:hover {
                    background-color: #3a8ee62e;
                    border-radius: 10px;

                    .name {
                        color: #d93131;
                    }
                }

                .item {
                    margin-bottom: 5px;

                    .logo {
                        vertical-align: middle;
                        margin-right: 10px;
                    }

                    .name {
                        font-weight: 700;
                    }
                }

                .info {
                    color: #c3c3c3;
                    width: 90%;
                }
            }
        }
    }
}
</style>