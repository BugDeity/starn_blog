<template>
    <el-card class="main">
        <div>
            <div style="padding: 5px;">
                {{ item.name }}
            </div>
            <el-checkbox-group v-model="checkedCities" v-if="item.type != 3">
                <el-checkbox v-for="huida in item.hd" :label="huida.id" :key="huida.id">
                    {{ huida.id + '、' + huida.name }}
                </el-checkbox>
            </el-checkbox-group>
            <div v-else>
                <input style="height: 30px;display: block;margin-bottom: 5px;width: 80%;" type="text"
                    v-for="num in item.number" placeholder="请输入内容" />
            </div>
            <div style="margin-top: 10px;margin-bottom: 10px;">
                <el-button style="float: left;" :disabled="!index" @click="last" type="primary" size=mini>上一题</el-button>
                <el-button style="margin-left: 100px;" @click="display = !display" type="success" size=mini>对比答案</el-button>
                <el-button style="float: right;" @click="next" type="primary" size=mini>下一题</el-button>
            </div>

            <div style="margin-top: 10px;margin-bottom: 10px;" v-show="display">
                正确答案:
                <div v-for="daan  in item.daan" :key="daan">
                    {{ daan }}
                </div>
            </div>
        </div>

    </el-card>
</template>
<script>
export default {
    data() {
        return {
            checkedCities: [],
            display: false,
            wenti: null,
            item: null,
            index: 0
        };
    },
    created() {

        this.wenti = require('@/view/test/wenti.json');
        this.item = this.wenti[0]
        console.log(this.wenti)
    },
    methods: {
        next() {
            this.index++
            this.display = false
            this.checkedCities = []
            this.item = this.wenti[this.index]
        },
        last() {
            this.index--
            this.checkedCities = []
            this.display = false
            this.item = this.wenti[this.index]
        }
    }
};
</script>
<style lang="scss" scoped>
/deep/ .el-checkbox {
    display: block;
    padding: 5px;
}

/deep/ .el-checkbox__label {
    display: inline
}

.main {
    margin-top: 70px;
    width: 100%;
}
</style>