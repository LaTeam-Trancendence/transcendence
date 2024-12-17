<script setup>
	import LoopVideo from '../LoopVideo.vue'
</script>

<template>
    <div class="fixed inset-0 flex flex-col items-center justify-center">
        <LoopVideo/>
        <div class="relative w-3/5 bg-gray-900 border border-gray-600 outline-red-600 rounded-lg">
            <div class="p-5 relative">
                <router-link to="/" class="absolute top-3 right-3 text-yellow-400 px-1.5 py-0.5 rounded-md bg-red-600 hover:bg-red-700">✘</router-link>
                <h5 class="mb-6 text-2xl font-bold tracking-tight text-white">{{$t('Terms_Use')}}</h5>
                <h2 class="text-white">{{$t('Terms_Use_Text')}}</h2>
            </div>
        </div>
    </div>
</template>

<script>
	export default {
		name: 'Conditions',
	};
</script>

<style scoped>
	@import url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css");
</style>
