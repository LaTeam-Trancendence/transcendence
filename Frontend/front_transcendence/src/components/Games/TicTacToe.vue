<script setup>
	import LoopVideo from '../LoopVideo.vue'

	import {useI18n} from 'vue-i18n';
	import {useStore} from 'vuex';
	import {ref, computed} from 'vue';
	import apiClient from '@/axios';
	import {useRouter} from 'vue-router';

	const {t} = useI18n()
	const store = useStore();
	const router = useRouter();
	const board = ref(Array(9).fill(null));
	const currentPlayer = ref('X');
	const winner = ref(null);
	const cancel_move = ref(false);

	// Message de statut
	const statusMessage = computed(() => {
		if (cancel_move.value == true) {
			return `<i class="fa-solid fa-ban mr-6"></i>${t('Hit_Cancel')}<i class="fa-solid fa-ban ml-6"></i>`;
		}
		if (winner.value) {
			if (currentPlayer.value === "X") {
				if (store.getters["GetTournament"]?.playing) {
					return `<i class="fa-solid fa-trophy mr-6"></i>${store.getters["GetTournament"].actualround.players[0].name} ${t('Player1_TicTacToe_Tournaments')}<i class="fa-solid fa-trophy ml-6"></i>`;
				}
				return `<i class="fa-solid fa-trophy mr-6"></i>${t('Player1_TicTacToe')}<i class="fa-solid fa-trophy ml-6"></i>`;
			}
			else {
				if (store.getters["GetTournament"]?.playing) {
					return `<i class="fa-solid fa-trophy mr-6"></i>${store.getters["GetTournament"].actualround.players[1].name} ${t('Player2_TicTacToe_Tournaments')}<i class="fa-solid fa-trophy ml-6"></i>`;
				}
				return `<i class="fa-solid fa-trophy mr-6"></i>${t('Player2_TicTacToe')}<i class="fa-solid fa-trophy ml-6"></i>`;
			}
		}
		if (board.value.every(cell => cell)) {
			return `<i class="fa-solid fa-handshake-angle mr-6"></i>${t('Equality')}`;
		}
		if (currentPlayer.value === "X") {
			if (store.getters["GetTournament"]?.playing) {
				return `<i class="fa-solid fa-play mr-6"></i>${store.getters["GetTournament"].actualround.players[0].name} ${t('Player1_TicTacToe_Tournaments')}`;
			}
			return `<i class="fa-solid fa-play mr-6"></i>${t('Player1_TicTacToe')}`;
		}
		else {
			if (store.getters["GetTournament"]?.playing) {
				return `<i class="fa-solid fa-play mr-6"></i>${store.getters["GetTournament"].actualround.players[1].name} ${t('Player2_TicTacToe_Tournaments')}`;
			}
			return `<i class="fa-solid fa-play mr-6"></i>${t('Player2_TicTacToe')}`;
		}
	});

	// Combinaisons gagnantes
	const winningCombinations = [
		[0, 1, 2], [3, 4, 5], [6, 7, 8], // Lignes
		[0, 3, 6], [1, 4, 7], [2, 5, 8], // Colonnes
		[0, 4, 8], [2, 4, 6],            // Diagonales
	];

	// Fonction pour vérifier un gagnant
	const checkWinner = () => {
		for (const [a, b, c] of winningCombinations) {
			if (board.value[a] && board.value[a] === board.value[b] && board.value[a] === board.value[c]) {
				winner.value = board.value[a];
				return true;
			}
		}
		return false;
	};

	// Fonction pour effectuer un mouvement
	const makeMove = async (index) => {
		if (board.value[index] || winner.value) return; // Empêche de jouer sur une case occupée ou après la fin
		if (!store.getters["GetTournament"]?.playing) {
			if (store.getters["GetRemoveHitState"]) {
				if (Math.random() < 1 / 9) {
					cancel_move.value = true;
					setTimeout(() => {
						cancel_move.value = false;
					}, 2000);
					currentPlayer.value = currentPlayer.value === 'X' ? 'O' : 'X'; // Change de joueur
					return;
				}
			}
		}
		board.value[index] = currentPlayer.value;
		if (checkWinner()) {
			if (!store.getters["GetTournament"]?.playing) {
				// Gérer l'appel API après avoir trouvé un gagnant
				try {
					await post_tictactoe(currentPlayer.value);
				} catch (error) {
					console.error('Erreur lors de l\'envoi du résultat :', error);
				}
			}
		} else if (board.value.every(cell => cell)) {
			// Égalité
			// console.log('Match nul');
		} else {
			// Changer de joueur
			currentPlayer.value = currentPlayer.value === 'X' ? 'O' : 'X'; // Change de joueur
		}
	};

	// Fonction pour réinitialiser la partie
	const resetGame = () => {
		board.value = Array(9).fill(null);
		currentPlayer.value = 'X';
		winner.value = null;
	};

	const IsEgual = computed(() => {
		return (board.value && board.value.every(cell => cell != null));
	});

	const IsFinish = computed(() => {
		return winner.value != null;
	});

	const SetWinnerOfGame = async () => {
		// console.log(winner.value);
		// return;
		const tournament = store.getters['GetTournament'];
		tournament.playing = false;
		const currentWinner = winner.value === 'X' ? tournament.actualround.players[0] : tournament.actualround.players[1];
		let i = 0;
		while (i < tournament.rounds.length) {
			const round = tournament.rounds[i];

			const matchIndex = round.findIndex((match) => match === tournament.actualround);
			if (matchIndex !== -1) {
				tournament.rounds[i][matchIndex].winner = currentWinner;
				break;
			}
			i++;
		}
		if (tournament.rounds[i + 1] != null) {
			let i_match = 0;
			while (tournament.rounds[i + 1][i_match] != null) {
				if (tournament.rounds[i + 1][i_match].players[0].id == null) {
					tournament.rounds[i + 1][i_match].players[0] = currentWinner;
					break;
				}
				if (tournament.rounds[i + 1][i_match].players[1].id == null) {
					tournament.rounds[i + 1][i_match].players[1] = currentWinner;
					break;
				}
				i_match = i_match + 1;
			}
		}
		tournament.actualround = null;
		await store.dispatch("CreateTournament", tournament);
		router.push('/tournaments');
	};

	const isGameOver = computed(() => {
		return winner.value != null || (board.value && board.value.every(cell => cell != null));
	});

	const post_tictactoe = async (winner) => {
		try {
			const userState = store.getters.GetUserState;
			let state;
			if (winner == "X") {
				state = "win_tictactoe";
			}
			else {
				state = "lose_tictactoe";
			}
			const response = await apiClient.post('player/', {user: userState, stat_type: state});
		} catch (error) {;
			console.error('Erreur lors de l\'envoi des données :', error.response ? error.response.data : error.message);
		}
	};
</script>

<template>
	<div class="fixed inset-0 flex flex-col items-center justify-center">
		<LoopVideo/>
		<router-link
			v-if="!GetTournament?.playing"
			to="/"
			class="absolute top-0 sm:left-0 justify-center text-white drop-shadow-[0_1.2px_1.2px_rgba(0,0,0,0.8)] bg-gradient-to-br from-sky-800 to-sky-500 hover:bg-gradient-to-bl text-xl text-center px-5 py-3 rounded-b-lg md:rounded-none md:rounded-br-lg shadow-lg"
		><i class="fa-solid fa-left-long mr-3"></i> {{$t('Back')}}</router-link>

		<!-- a quelle joueur de jouer -->
		<div class="absolute top-36 sm:top-30 md:top-26 lg:top-18 xl:top-16 drop-shadow-[0_1.2px_1.2px_rgba(0,0,0,0.8)] bg-gradient-to-br from-gray-800 to-purple-600 hover:bg-gradient-to-bl mb-8 rounded-lg shadow-lg">
			<p class="relative items-center justify-center text-white text-3xl sm:text-4xl lg:text-5xl mx-4 my-4" v-html="statusMessage"></p>
		</div>
		
		<!-- Grille du Tic-Tac-Toe -->
		<div class="relative w-80 h-80 sm:w-96 sm:h-96 lg:w-104 lg:h-104 xl:w-112 xl:h-112 bg-black border border-gray-800 rounded-lg shadow-lg">
			<!-- Barre verticale -->
			<div class="absolute left-1/3 top-4 w-1 h-72 sm:h-88 lg:h-96 xl:h-104 bg-slate-600 rounded-lg"></div>
			<div class="absolute left-2/3 top-4 w-1 h-72 sm:h-88 lg:h-96 xl:h-104 bg-slate-600 rounded-lg"></div>
			<!-- Barre horizontale -->
			<div class="absolute top-1/3 left-4 w-72 sm:w-88 lg:w-96 xl:w-104 h-1 bg-slate-600 rounded-lg"></div>
			<div class="absolute top-2/3 left-4 w-72 sm:w-88 lg:w-96 xl:w-104 h-1 bg-slate-600 rounded-lg"></div>
			
			<div class="grid grid-cols-3 w-80 h-80 sm:w-96 sm:h-96 lg:w-104 lg:h-104 xl:w-112 xl:h-112 shadow-lg">
				<div
					v-for="(cell, index) in board"
					:key="index"
					class="flex items-center justify-center w-full h-full text-8xl font-bold cursor-pointer hover:bg-slate-400"
					:style="{color: cell === 'X' ? GetColor1State : cell === 'O' ? GetColor2State : 'inherit'}"
					@click="makeMove(index)"
				><span class="flex items-center justify-center w-full h-0">{{cell}}</span>
				</div>
			</div>
		</div>
	
		<!-- Bouton de réinitialisation -->
		<button
			v-if="isGameOver && !GetTournament?.playing"
			@click="resetGame"
			class="absolute bottom-40 px-4 py-2 drop-shadow-[0_1.2px_1.2px_rgba(0,0,0,0.8)] bg-gradient-to-br from-sky-800 to-sky-500 hover:bg-gradient-to-bl text-white rounded-lg shadow-lg"
		><i class="fa-solid fa-rotate-right mr-3"></i>{{$t('Reset')}}</button>
		<button
			v-if="IsEgual && GetTournament?.playing"
			@click="resetGame"
			class="absolute bottom-40 px-4 py-2 drop-shadow-[0_1.2px_1.2px_rgba(0,0,0,0.8)] bg-gradient-to-br from-sky-800 to-sky-500 hover:bg-gradient-to-bl text-white rounded-lg shadow-lg"
		><i class="fa-solid fa-rotate-right mr-3"></i>{{$t('Reset')}}</button>
		<router-link
			v-if="IsFinish && GetTournament?.playing"
			to="/tournaments"
			@click="SetWinnerOfGame"
			class="absolute bottom-40 px-4 py-2 drop-shadow-[0_1.2px_1.2px_rgba(0,0,0,0.8)] bg-gradient-to-br from-sky-800 to-sky-500 hover:bg-gradient-to-bl text-white rounded-lg shadow-lg"
		><i class="fa-solid fa-rotate-right mr-3"></i>{{$t('Return_Tournaments')}}</router-link>
	</div>
</template>

<script>
	import {mapGetters} from 'vuex';

	export default {
		name: 'TicTacToe',
		computed: {
			...mapGetters(['GetColor1State']),
			...mapGetters(['GetColor2State']),
			...mapGetters(['GetRemoveHitState']),
			...mapGetters(['GetUserState']),
			...mapGetters(['GetTournament']),
		},
	};
</script>

<style scoped>
	@import url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css");
</style>
