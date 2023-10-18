<template>
    <div id="toast">
        <span class="toast" :style="{ backgroundColor: color, top: styleTop }">
            <i :class="icon" style="margin-right:5px"></i>
            {{ message }}
        </span>
    </div>
</template>
 
<script>
export default {
    name: 'Toast',
    data() {
        return {
            message: '',
            icon: "",
            type: "normal",
            color: "#49b1f5",
            styleTop: "-100px",
            timer: null
        };
    },

    methods: {
        after(message) {
            clearInterval(this.timer);
            this.message = message;
            this.styleTop = "30px"
            this.timer = setTimeout(() => {
                this.styleTop = "-100px"
            }, 2000);
        },
        show(message, type) {
            switch (type) {
                case "error":
                    this.color = "#F56C6C";
                    this.icon = "iconfont icon-cuo";
                    break;
                case "success":
                    this.color = "#52C41A";
                    this.icon = "iconfont icon-duigouxiao";
                    break;
                case "warnning":
                    this.color = "#F57C00";
                    this.icon = "iconfont icon-jinggao";
                    break;
                default:
                    this.icon = null
                    this.color = "#49b1f5"
                    break;
            }
            this.after(message)
        },
        success(message) {
            this.color = "#52C41A";
            this.icon = "iconfont icon-duigouxiao";
            this.after(message)
        },
        error(message) {
            this.color = "#F56C6C";
            this.icon = "iconfont icon-cuo";
            this.after(message)
        },
        warnning(message) {
            this.color = "#F57C00";
            this.icon = "iconfont icon-jinggao";
            this.show = true;
            this.after(message)
        },
    },
};
</script>
 
<style scoped>
.toast {
    position: fixed;
    left: 0;
    right: 0;
    bottom: 0;
    margin: 0 auto;
    background-color: #333;
    color: #fff;
    padding: 10px;
    border-radius: 3px;
    z-index: 99999;
    width: fit-content;
    height: fit-content;
    transition: all 0.35s;

}
</style>