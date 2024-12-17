<script setup>
	import LoopVideo from '../LoopVideo.vue'
	import Header from './Header.vue'
	import Card from './Card.vue'
	import Footer from './Footer.vue'
</script>

<template>
	<div class="w-screen h-screen flex flex-col hidden-scrollbar">
		<LoopVideo/>
		<Header/>

		<main class="flex-1 w-full">
			<div class="h-full w-full flex flex-col md:flex-row items-center justify-center mt-8 md:mt-0 2xl:space-x-96 xl:space-x-72 lg:space-x-60 space md:space-x-24 space-y-32 md:space-y-0">
				<Card type="pong"/>
				<Card type="tictactoe"/>
			</div>
			<Footer/>
		</main>
	</div>
</template>
