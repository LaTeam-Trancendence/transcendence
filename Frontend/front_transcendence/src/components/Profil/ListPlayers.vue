<script setup>
	import LoopVideo from '../LoopVideo.vue'
</script>

<template>
    <div class="fixed inset-0 flex flex-col items-center justify-center">
        <LoopVideo/>
        <div class="relative w-full max-w-xs sm:max-w-md bg-gray-900 border border-gray-600 hover:border-red-600 hover:outline outline-2 outline-red-600 rounded-lg shadow-lg">
            <div class="p-5 relative">
                <router-link to="/" class="absolute top-3 right-3 text-yellow-400 px-1.5 py-0.5 rounded-md bg-red-600 hover:bg-red-700">✘</router-link>
                <h5 class="mb-6 text-2xl font-bold tracking-tight text-white">{{$t('List_Players')}}</h5>
                <ul class="max-h-96 overflow-y-auto pr-2">
                    <li v-for="(player, index) in players" :key="player.username" class="text-white mb-2">
                        <!-- Bouton principal pour chaque joueur -->
                        <button
                            @click="toggleMenu(index)"
                            class="w-full text-left bg-gray-800 hover:bg-gray-700 px-4 py-2 rounded-lg shadow-lg flex items-center space-x-2"
                        >
                            <img 
                                class="w-8 h-8" 
                                :src="'https://localhost:8443/api/media/player_picture/' + player.id + '.png'" 
                                alt="Image de votre ami"
                            />
                            <span>{{player.username}}</span>
                        </button>
                        <!-- Sous-menu affiché si actif -->
                        <div v-if="openMenus.includes(index)" class="mx-4 mt-2 bg-gray-700 p-3 text-sm rounded-lg shadow-lg">
                            <div class="flex flex-col sm:flex-row justify-between items-center sm:items-start">
                                <div class="flex flex-col items-center sm:items-start mb-4 sm:mb-0">
                                    <img class="w-12 h-12 mb-2" src="../../assets/img/pong_trans.png" alt="Image du Pong"/>
                                    <p><strong>{{$t('Win_Pong')}}</strong>{{player.win_pong}}</p>
                                    <p><strong>{{$t('Lose_Pong')}}</strong>{{player.lose_pong}}</p>
                                </div>
                                <div class="flex flex-col items-center sm:items-end">
                                    <img class="w-12 h-12 mb-2" src="../../assets/img/morpion_trans.png" alt="Image du Morpion"/>
                                    <p><strong>{{$t('Win_TicTacToe')}}</strong>{{player.win_tictactoe}}</p>
                                    <p><strong>{{$t('Lose_TicTacToe')}}</strong>{{player.lose_tictactoe}}</p>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>

<script>
    import apiClient from '@/axios';

    export default {
        name: 'ListPlayers',
        data() {
            return {
                players: [
                    // {username:"test1", win_pong: "6", lose_pong: "6", win_tictactoe: "6", lose_tictactoe: "6"},
                    // {username:"test2", win_pong: "2", lose_pong: "2", win_tictactoe: "2", lose_tictactoe: "2"},
                    // {username:"test3", win_pong: "42", lose_pong: "42", win_tictactoe: "42", lose_tictactoe: "42"},
                    // {username:"test4", win_pong: "6", lose_pong: "6", win_tictactoe: "6", lose_tictactoe: "6"},
                    // {username:"test5", win_pong: "2", lose_pong: "2", win_tictactoe: "2", lose_tictactoe: "2"},
                    // {username:"test6", win_pong: "42", lose_pong: "42", win_tictactoe: "42", lose_tictactoe: "42"},
                    // {username:"test7", win_pong: "6", lose_pong: "6", win_tictactoe: "6", lose_tictactoe: "6"},
                    // {username:"test8", win_pong: "2", lose_pong: "2", win_tictactoe: "2", lose_tictactoe: "2"},
                    // {username:"test9", win_pong: "42", lose_pong: "42", win_tictactoe: "42", lose_tictactoe: "42"},
                    // {username:"test10", win_pong: "6", lose_pong: "6", win_tictactoe: "6", lose_tictactoe: "6"},
                    // {username:"test11", win_pong: "2", lose_pong: "2", win_tictactoe: "2", lose_tictactoe: "2"},
                    // {username:"test12", win_pong: "42", lose_pong: "42", win_tictactoe: "42", lose_tictactoe: "42"}
                ],
                openMenus: [],
            };
        },
        methods: {
            toggleMenu(index) {
                if (this.openMenus.includes(index)) {
                    // Fermer le sous-menu si déjà ouvert
                    this.openMenus = this.openMenus.filter(i => i !== index);
                } else {
                    // Ouvrir le sous-menu
                    this.openMenus.push(index);
                }
            },
            async get_profil_api() {
                try {
                    const response = await apiClient.get('ListPlayers/');

                    if(response.data && response.data.status === 'success'){
                        this.players = response.data.data;
                    } else {
                        throw new Error("Format inattendu de la réponse de l'API");
                    }
                } catch (error) {
                    console.error('Erreur lors de la récupération des données :', error);
                }
            },
        },
        mounted() {
            this.get_profil_api();
        },
    };
</script>

<style scoped>
	@import url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css");

    /* Scrollbar personnalisé */
    ul::-webkit-scrollbar {
        width: 8px; /* Largeur de la scrollbar */
    }
    ul::-webkit-scrollbar-thumb {
        background-color: #4a5568; /* Couleur du curseur */
        border-radius: 4px; /* Coins arrondis */
    }
    ul::-webkit-scrollbar-thumb:hover {
        background-color: #5c6a81; /* Couleur au survol */
    }
    ul::-webkit-scrollbar-track {
        background-color: #2d3748; /* Couleur de la piste */
        border-radius: 4px;
    }
</style>
