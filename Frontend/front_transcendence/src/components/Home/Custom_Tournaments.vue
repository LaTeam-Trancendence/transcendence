<script setup>
	import LoopVideo from '../LoopVideo.vue';
</script>

<template>
	<div class="w-screen h-screen flex flex-col items-center justify-start md:justify-center hidden-scrollbar">
		<LoopVideo/>
		<div class="relative w-4/5 md:w-3/5 mt-8 mb-8 bg-gray-900 border border-gray-600 hover:border-red-600 hover:outline outline-2 outline-red-600 rounded-lg">
			<div class="absolute top-3 right-3 z-50">
				<router-link to="/" class="text-yellow-400 px-1.5 py-0.5 rounded-md bg-red-600 hover:bg-red-700">✘</router-link>
			</div>
			<div class="p-5 relative z-20">
				<h5 class="mb-6 text-2xl font-bold tracking-tight text-white">{{$t('Creation_Tournaments')}}</h5>
				<!-- game choice -->
				<label class="mb-3 inline-flex items-center cursor-pointer">
					<span class="text-white">Pong</span>
					<input type="checkbox" v-model="game_choice" class="sr-only peer">
					<div class="relative w-11 h-6 -mt-0 -right-3 bg-gray-600 rounded-full peer peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-yellow-400"></div>
					<span class="text-white ml-6">{{$t('TicTacToe')}}</span>
				</label>

				<!-- Nombre de joueurs -->
				<h2 class="text-white relative sm:absolute my-4">{{$t('Number_Players')}}</h2>
                <div class="relative mb-12 top-4 sm:left-38">
                    <label for="price-range-input" class="sr-only"></label>
                    <input id="price-range-input" type="range" v-model="nb_player" min="3" max="8" class="w-3/5 h-2 bg-gray-700 rounded-lg appearance-none cursor-pointer">
                    <span class="text-sm text-gray-400 absolute start-0 -bottom-6">x3</span>
                    <span class="text-sm text-gray-400 absolute w-2/5 end-6 -bottom-6">x8</span>
                    <div class="relative mt-2">
                        <span id="range-indicator" class="text-sm text-gray-400 absolute x-1/2 -top-14 left-0 bg-gray-800 px-2 py-1 rounded-md">
                            x3
                        </span>
                    </div>
                </div>

				<!-- Pseudos des joueurs -->
				<div class="mb-6">
					<div v-for="(player, index) in players" :key="player.id" class="mb-1">
						<label :for="'player-' + player.id" class="block text-sm font-medium text-gray-300">
						{{$t('Player')}} {{index + 1}}</label>
						<input
							:id="'player-' + player.id"
							v-model="player.name"
							type="text"
							:placeholder="$t('Enter_Pseudo')"
							class="w-full mt-1 px-3 py-2 bg-gray-800 text-white border border-gray-600 rounded-lg focus:outline-none focus:ring focus:ring-red-600"
						/>
					</div>
				</div>
				<!-- Creer le tournois -->
				<div class="bottom-8 w-full flex justify-center">
					<router-link
						to="/tournaments"
						@click="save_tournament()"
						class="text-white bg-gradient-to-br from-green-800 to-green-500 hover:bg-gradient-to-bl font-medium rounded-lg text-sm px-3 py-2 text-center"
					><i class="fa-solid fa-plus mr-2"></i>{{$t('Create_Tournaments')}}
					</router-link>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
	import {mapActions} from 'vuex';

	export default {
		name: 'Custom_Tournaments',
		data() {
			return {
				game_choice: false, // Toggle pour le choix du jeu
				nb_player: 3, // Nombre initial de joueurs
				players: [], // Liste des joueurs
			};
		},
		methods: {
			...mapActions(['CreateTournament']),
			save_tournament() {
				let i = 0;
				while (this.players[i] != null) {
					if (this.players[i].name == null || this.players[i].name == '') {
						this.players[i].name = this.$t('Player') + " " + (this.players[i].id);
					}
					i = i + 1;
				}
				let tournament = {game_choice: this.game_choice, nb_player: this.nb_player, players: this.players};
				this.CreateTournament(tournament);
			},

			// Mise à jour de la liste des joueurs
			updatePlayers(nb) {
				this.players = Array.from({length: nb}, (_, i) => ({
					id: i + 1,
					name: '',
				}));
			},
		},
		watch: {
			nb_player(newNb) {
				this.updatePlayers(newNb);
			},
		},
		mounted() {
			// Initialisation
			this.updatePlayers(this.nb_player);

			// input
			const rangeInput = document.getElementById('price-range-input');
            const rangeIndicator = document.getElementById('range-indicator');

            rangeInput.addEventListener('input', (event) => {
                const value = event.target.value;

                // Récupérer la largeur totale de la barre de progression
                const rangeWidth = rangeInput.offsetWidth;

                // Calculer le pourcentage de la progression (entre 0 et 100)
                const percent = (value - rangeInput.min) / (rangeInput.max - rangeInput.min);

                // Calculer la position en pixels en fonction du pourcentage
                const indicatorPosition = percent * rangeWidth;

                // Ajuster la position de l'indicateur pour le centrer
                const offset = rangeIndicator.offsetWidth / 2;
                rangeIndicator.style.left = `calc(${indicatorPosition}px - ${offset}px)`;

                // Mettre à jour le texte de l'indicateur
                rangeIndicator.textContent = `x${value}`;
            });
		},
	};
</script>

<style scoped>
	@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css');
</style>
