<template>
	<div class="w-full h-screen relative flex justify-center items-center bg-gray-900">
		<canvas ref="pongCanvas" class="relative w-11/12 h-11/12 border-4 border-white rounded-lg shadow-lg"></canvas>
		<router-link
			to="/"
			class="absolute top-4 left-4 text-white drop-shadow-[0_1.2px_1.2px_rgba(0,0,0,0.8)] bg-gradient-to-br from-sky-800 to-sky-500 hover:bg-gradient-to-bl font-medium text-lg text-center px-4 py-2 rounded-lg shadow-lg"
		><i class="fa-solid fa-left-long mr-4"></i> {{$t('Play')}}
		</router-link>
	</div>
</template>

<script>
export default {
	name: "Pong",
};
</script>

<style scoped>
	@import url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css");
</style>
