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
				<h5 class="mb-6 text-2xl font-bold tracking-tight text-white">{{$t('Tournaments')}}</h5>
				<!-- affichage info du tournois, jeu et nb joueur -->
				<h2 class="text-lg text-white">{{$t('Choice_Games')}}{{tournament.game_choice ? $t('TicTacToe') : 'Pong'}}</h2>
				<div v-if="tournament.players && tournament.players.length" class="mt-2">
					<h3 class="text-lg text-white inline-block">{{$t('List_Players_Tournaments')}}</h3>
					<span class="text-white ml-2">
						{{tournament.players.map(player => player.name || `${this.$t('Player')} ${player.id}`).join(', ')}}
					</span>
				</div>

				<!-- Arbre des tournois -->
				<div>
					<ul>
						<li v-for="(round, roundIndex) in tournament.rounds" :key="'round-' + roundIndex" class="mb-8">
						<h4 class="text-lg text-yellow-400 mt-6">Tour {{ roundIndex + 1 }}</h4>
							<ul>
								<li
									v-for="(match, matchIndex) in round"
									:key="'match-' + roundIndex + '-' + matchIndex"
									class="text-white"
								>{{$t('Game')}} {{matchIndex + 1}} : 
									<span class="font-bold">
										{{match.players[0]?.name || `Joueur ${match.players[0]?.id}`}}
									</span>
									<span> - </span>
									<span class="font-bold">
										{{match.players[1]?.name || `Joueur ${match.players[1]?.id}`}}
									</span>
									<span v-if="match.winner">
										{{$t('Winner')}} {{match.winner?.name || `Joueur ${match.winner?.id}`}}
									</span>
								</li>
							</ul>
						</li>
					</ul>
				</div>
				<!-- delete or play match -->
                <div class="flex justify-between items-center flex-col md:flex-row space-y-4 md:space-y-0">
                    <router-link
                        to="/custom_tournaments"
						@click="delete_tournament()"
                        class="text-white bg-gradient-to-br from-red-800 to-red-500 hover:bg-gradient-to-bl font-medium rounded-lg text-sm px-3 py-2 text-center"
                    ><i class="fa-solid fa-xmark mr-2"></i>{{$t('Delete_Tournaments')}}</router-link>
                    <router-link
                        to="/tournaments"
                        @click="play_next_match()"
                        class="text-white bg-gradient-to-br from-green-800 to-green-500 hover:bg-gradient-to-bl font-medium rounded-lg text-sm px-3 py-2 text-center"
                    ><i class="fa-solid fa-arrow-right mr-2"></i>{{$t('Play_Game_Tournaments')}}</router-link>
                </div>
			</div>
		</div>
	</div>
</template>

<script>
	import {mapActions, mapGetters} from 'vuex';

	export default {
		name: 'Tournaments',
		data() {
			return {
				tournament: {
					game_choice: false,
					actualround: null,
					rounds: [],
					byePlayer: null,
					playing: false,
				},
			}
		},
		computed: {
            ...mapGetters(['GetTournament']),
		},
		methods: {
			...mapActions(['CreateTournament']),
			...mapActions(['DeleteTournament']),

			delete_tournament() {
				this.DeleteTournament();
			},
			
			play_next_match() {
				this.tournament.playing = true;

				// definir quelle match est jouer
				// check tout les matchs du round si il on un vainqueur, si oui augmenter le round sinon jouer le match sans gagnant
				// si round = null alors prendre vainqueur dernier match = vainqueur du tournois

				let nb_rounds = 0;
				let nb_match = 0;
				while (nb_rounds < this.tournament.rounds.length) {
					const currentRound = this.tournament.rounds[nb_rounds];
					while (nb_match < currentRound.length) {
						const match = currentRound[nb_match];
						if (match && match.winner === null) {
							this.tournament.actualround = match;
							this.CreateTournament(this.tournament);
							if (this.tournament.game_choice == true) {
								this.$router.push('/tictactoe');
							}
							else {
								this.$router.push('/pong');
							}
							return;
						}
						nb_match = nb_match + 1;
					}
					nb_rounds = nb_rounds + 1;
					nb_match = 0;
				}
			},

			// Mélange aléatoire des joueurs
			shuffleArray(array) {
				for (let i = array.length - 1; i > 0; i--) {
					const j = Math.floor(Math.random() * (i + 1));
					[array[i], array[j]] = [array[j], array[i]]; // Échange
				}
			},

			// Génération de l'arbre du tournoi
			generateTournament() {
				let currentRound = [...this.tournament.players]; // Copie de la liste des joueurs
				this.shuffleArray(currentRound); // Mélange initial des joueurs
				this.tournament.rounds = []; // Réinitialise l'arbre des tours
				this.tournament.byePlayer = null; // Réinitialise le joueur "bye"

				while (currentRound.length > 1 || this.tournament.byePlayer) {
					const matches = [];

					// Gérer le joueur "bye" uniquement au premier tour
					if (currentRound.length % 2 === 1 && !this.tournament.byePlayer) {
						const randomIndex = Math.floor(Math.random() * currentRound.length);
						this.tournament.byePlayer = currentRound.splice(randomIndex, 1)[0]; // Retire un joueur au hasard
					}

					// Crée les matchs pour le tour
					for (let i = 0; i < currentRound.length; i += 2) {
						// const match = [currentRound[i], currentRound[i + 1]].filter(Boolean);
						// const match = [currentRound[i], currentRound[i + 1]].filter(Boolean);
						// match.winner = null;
						const match = {
							players: [currentRound[i], currentRound[i + 1]].filter(Boolean),
							winner: null, // Champ winner initialisé à null
						};
						matches.push(match);
					}
					this.tournament.rounds.push(matches); // Ajoute les matchs du tour actuel

					// Prépare les gagnants pour le prochain tour
					const nextRound = matches.map((match, index) => {
						return {
							id: null,
							name: `${this.$t('Winner_Of_Game')} ${index + 1}`
						};
					});

					// Ajouter le joueur "bye" au deuxième tour
					if (this.tournament.byePlayer) {
						nextRound.push(this.tournament.byePlayer);
						this.tournament.byePlayer = null; // Réinitialise le joueur "bye"
					}

					currentRound = nextRound; // Met à jour la liste des joueurs pour le prochain tour
				}
			},
		},
		mounted() {
			this.tournament = this.GetTournament;

			if (!this.tournament.rounds || this.tournament.rounds.length === 0) {
				// Initialisation
				this.generateTournament();
				this.CreateTournament(this.tournament);
			}
		},
	};
</script>

<style scoped>
	@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css');
</style>
