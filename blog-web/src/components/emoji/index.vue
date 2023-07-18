<template>
    <div class='emoji-container'>
        <span class="emoji-item" v-for="(item, index) of emojiList" :key="index" @click="chooseEmoji(item)">
            <span class="emoji">{{ item.emoji }}
            </span>
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
        chooseEmoji(obj) {
            this.$emit('chooseEmoji', obj.emoji);
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

    .emoji-item {
        cursor: pointer;
        display: inline-block;
        margin: 2px 0;

        .emoji {
            font-size: 20px;
            padding: 3px;
            border-radius: 10px;

            &:hover {
                background-color: rgb(221, 221, 221)
            }
        }
    }
}
</style>