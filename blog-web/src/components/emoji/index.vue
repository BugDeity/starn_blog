<template>
    <div class='emoji-container'>
        <span class="emoji-item" v-for="(item, index) of 105" :key="index" @click="chooseEmoji(index)">
            <img :src="`https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/${index}.gif`" class="emoji" />
        </span>
    </div>
</template>
   
<script>

export default {
    name: '',
    data() {
        return {
            emojiList: null,
        }
    },
    created() {
        this.emojiList = require('@/assets/emoji.json');
    },
    methods: {
        chooseEmoji(index) {
            this.$emit('chooseEmoji', `https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/${index}.gif`);
        },
    },
}
</script>
   
<style lang='scss' scoped>
.emoji-container {
    max-height: 150px;
    max-width: 400px;
    overflow-y: auto;
    background-color: var(--background-color);
    border: 1px solid var(--border-line);
    padding: 5px;
    border-radius: 5px;

    .emoji-item {
        cursor: url(https://img.shiyit.com/link.cur), pointer;
        display: inline-block;

        .emoji {
            padding: 3px;
            border-radius: 5px;

            &:hover {
                background-color: rgb(221, 221, 221)
            }
        }
    }
}
</style>