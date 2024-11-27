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
			<div class="h-full w-full flex flex-col md:flex-row items-center justify-center lg:space-x-52 md:space-x-16 space-y-8 md:space-y-0">
				<Card type="pong"/>
				<Card type="tictactoe"/>
			</div>
			<Footer/>
		</main>
	</div>
</template>
