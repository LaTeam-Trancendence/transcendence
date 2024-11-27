<template>
	<div class="relative max-w-sm bg-gray-900 border border-gray-600 hover:border-red-600 hover:outline outline-2 outline-red-600 rounded-lg">
		<img class="rounded-t-lg relative z-20" src="../../assets/img/lantern_empty.png" alt="Lanterne qui contient TicTacToe"/>
		<img class="absolute -top-24 left-0 w-full h-full object-contain scale-40 z-10" src="../../assets/img/morpion_trans.png" alt="Image du Pong"/>
		<div class="p-5 relative z-20">
			<h5 class="mb-2 text-2xl font-bold tracking-tight text-white">{{$t('TicTacToe')}}</h5>
			<p class="mb-3 font-normal text-gray-400">{{$t('Descri_TicTacToe')}}</p>
			<div class="flex justify-between items-center">
				<router-link
					to="/tictactoe"
					class="text-white drop-shadow-[0_1.2px_1.2px_rgba(0,0,0,0.8)] bg-gradient-to-br from-red-600 to-yellow-400 hover:bg-gradient-to-bl font-medium rounded-lg text-sm px-3 py-2 text-center"
				><i class="fa-solid fa-gamepad"></i> {{$t('Play')}}
				</router-link>
				<router-link
					to="/custom_tictactoe"
					class="text-white bg-gradient-to-br from-gray-600 to-gray-400 hover:bg-gradient-to-bl font-medium rounded-lg text-sm px-2 py-1 text-center"
				><i class="fa-solid fa-sliders"></i> {{$t('Preferences')}}
				</router-link>
			</div>
		</div>
	</div>
</template>

<script>
export default {
	name: "TicTacToe",
};
</script>

<style scoped>
	@import url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css");
</style>
