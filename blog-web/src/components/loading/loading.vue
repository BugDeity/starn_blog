<template>
    <div class="loading-overlay" v-if="isLoading">
        <div class="loading-spinner"></div>
    </div>
</template>
<script>
export default {
    data() {
        return {
            isLoading: false
        };
    },
    created() {
        this.$bus.$on('showLoading', () => {
            this.isLoading = true;
        });
        this.$bus.$on('hideLoading', () => {
            this.isLoading = false;
        });
    },
    beforeDestroy() {
        this.$bus.$off('showLoading');
        this.$bus.$off('hideLoading');
    }
};
</script>
<style scoped>
.loading-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9999;
}

.loading-spinner {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    border: 4px solid #ffffff;
    border-top: 4px solid #3498db;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    0% {
        transform: rotate(0deg);
    }

    100% {
        transform: rotate(360deg);
    }
}
</style>
