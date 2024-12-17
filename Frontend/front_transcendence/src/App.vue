<template>
	<div id="app">
		<router-view></router-view>
	</div>
</template>

<style>
	body {
		overflow-x: hidden;
	}
	.hidden-scrollbar {
		overflow: auto;
		scrollbar-width: none;
	}
	.hidden-scrollbar::-webkit-scrollbar {
		display: none;
	}
</style>
