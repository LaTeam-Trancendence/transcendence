<script setup>
	import LoopVideo from '../LoopVideo.vue'
</script>

<template>
    <div class="w-screen h-screen flex flex-col items-center hidden-scrollbar">
        <LoopVideo/>
        <router-link
            to="/"
            class="absolute top-0 md:left-0 text-white drop-shadow-[0_1.2px_1.2px_rgba(0,0,0,0.8)] bg-gradient-to-br from-sky-800 to-sky-500 hover:bg-gradient-to-bl text-xl text-center px-5 py-3 rounded-b-lg md:rounded-none md:rounded-br-lg shadow-lg"
        ><i class="fa-solid fa-left-long mr-3"></i> {{$t('Back')}}</router-link>
        <!-- Player info -->
        <div class="flex flex-col items-center md:items-start w-full space-y-6 mt-20 md:mt-16 md:ml-12">
            <!-- Section Informations joueur -->
            <div class="w-4/5 md:w-2/3 bg-gray-900 border border-gray-600 hover:border-red-600 hover:outline outline-2 outline-red-600 rounded-lg shadow-lg p-6">
                <div class="flex flex-col md:flex-row items-center md:items-start">
                    <!-- Image de profil -->
                    <div v-if="!img">
                        <img class="w-44 h-44 md:w-52 md:h-52 xl:w-96 xl:h-96 rounded-xl object-cover mr-4 mb-0" src="../../assets/img/default_avatar.png" alt="Image de profil"/>
                    </div>
                    <div v-else>
                        <img :src="img" class="w-44 h-44 md:w-52 md:h-52 xl:w-96 xl:h-96 rounded-xl object-cover mr-4 mb-0" alt="Image de profil"/>
                    </div>
                    <!-- <button 
                        @click="replaceImage"
                        class="bg-gray-700 hover:bg-gray-600 text-white text-sm font-medium px-4 py-2 rounded-lg shadow-lg"
                    ><i class="fa-solid fa-pen-to-square mr-2"></i>Modifier l'image</button> -->
        
                    <!-- Détails du joueur -->
                    <div class="flex-1">
                        <h5 class="mb-4 text-2xl font-bold tracking-tight text-white">{{$t('Title_Info')}}</h5>
                        <!-- pseudo -->
                        <p class="text-gray-300 mb-2">{{$t('Profil_Pseudo')}}{{pseudo}}</p>
                        <label class="inline-flex items-center bg-gray-700 hover:bg-gray-600 mb-4 text-white text-sm font-medium px-4 py-2 rounded-lg shadow-lg cursor-pointer">
                        <input type="checkbox" v-model="state_newPseudo" class="hidden"/>
                        <i class="fa-solid fa-pen-to-square mr-2"></i>{{$t('Edit_Pseudo')}}</label>
                        <div v-if="state_newPseudo">
                            <input
                                type="text"
                                v-model="newPseudo"
                                :placeholder="$t('Exemple_Edit_Pseudo')"
                                class="w-5/5 p-1 bg-gray-700 border border-gray-600 text-gray-300 rounded-lg shadow-lg mr-2"
                            />
                            <button
                                @click="updatePseudo"
                                class="w-10 mb-4 bg-red-600 hover:bg-red-700 text-yellow-400 py-1 rounded-lg shadow-lg"
                            ><i class="fa-solid fa-plus"></i></button>
                        </div>
                        <!-- mdp -->
                        <p class="text-gray-300 mb-2">{{$t('Profil_Mdp')}}{{mdp}}</p>
                        <label class="inline-flex items-center bg-gray-700 hover:bg-gray-600 mb-4 text-white text-sm font-medium px-4 py-2 rounded-lg shadow-lg cursor-pointer">
                            <input type="checkbox" v-model="state_newMdp" class="hidden"/>
                        <i class="fa-solid fa-pen-to-square mr-2"></i>{{$t('Edit_Mdp')}}</label>
                        <div v-if="state_newMdp">
                            <input
                                type="text"
                                v-model="newMdp"
                                :placeholder="$t('Exemple_Edit_Mdp')"
                                class="w-5/5 p-1 bg-gray-700 border border-gray-600 text-gray-300 rounded-lg shadow-lg mr-2"
                            />
                            <button
                                @click="updateMdp"
                                class="w-10 mb-4 bg-red-600 hover:bg-red-700 text-yellow-400 py-1 rounded-lg shadow-lg"
                            ><i class="fa-solid fa-plus"></i></button>
                        </div>
                        <!-- status -->
                        <p class="text-gray-300 mb-2">{{$t('Profil_Statut')}}</p>
                        <div class="flex space-x-4 mb-4">
                            <div v-for="option in statusOptions" :key="option.value" class="flex items-center">
                                <input 
                                    type="checkbox" 
                                    :id="option.value" 
                                    :checked="status === option.value" 
                                    @change="selectStatus(option.value)"
                                    class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2"
                                />
                                <label :for="option.value" class="ml-2 text-sm text-gray-300">{{option.label}}</label>
                            </div>
                        </div>
                        <div class="flex items-center space-x-2">
                            <div 
                                :class="{
                                    'w-6 h-6 rounded-full': true,
                                    'bg-green-600': status === 'online',
                                    'bg-yellow-500': status === 'inactive',
                                    'bg-red-600': status === 'offline'
                                }"
                            ></div>
                            <span class="text-white right-4">{{statusLabel}}</span>
                        </div>
                    </div>
                </div>
            </div>
        
            <!-- Section Statistiques -->
            <div class="w-4/5 md:w-2/3 bg-gray-900 border border-gray-600 hover:border-red-600 hover:outline outline-2 outline-red-600 rounded-lg shadow-lg p-6">
                <div class="flex flex-col md:flex-row justify-between items-center md:items-start">
                    <div class="flex flex-col items-center sm:items-start mb-4 sm:mb-0">
                        <img class="w-48 h-48 mb-10" src="../../assets/img/pong_trans.png" alt="Image du Pong"/>
                        <p class="text-white text-xl mb-8 ml-4"><strong>{{$t('Win_Pong')}}</strong>{{win_pong}}</p>
                        <p class="text-white text-xl ml-4"><strong>{{$t('Lose_Pong')}}</strong>{{lose_pong}}</p>
                    </div>
                    <div class="flex flex-col items-center sm:items-end space-4">
                        <img class="w-48 h-48 mb-10" src="../../assets/img/morpion_trans.png" alt="Image du Morpion"/>
                        <p class="text-white text-xl mb-8 mr-4"><strong>{{$t('Win_TicTacToe')}}</strong>{{win_tictactoe}}</p>
                        <p class="text-white text-xl mr-4"><strong>{{$t('Lose_TicTacToe')}}</strong>{{lose_tictactoe}}</p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Amis -->
		<div class="relative md:fixed top-4 right-0 w-4/5 md:w-1/4 h-screen md:mr-6 mt-16 md:mt-0 flex flex-col">
			<!-- Ajout d'amis -->
            <div class="relative w-full mb-6 bg-gray-900 border border-gray-600 hover:border-red-600 hover:outline outline-2 outline-red-600 rounded-lg shadow-lg">
				<div class="relative p-5">
					<h5 class="mb-6 text-2xl font-bold tracking-tight text-white">{{$t('Add_Friend')}}</h5>
					<input
						type="text"
						v-model="searchUsername"
						:placeholder="$t('Exemple_Add_Friend')"
						class="w-3/4 p-2 bg-gray-700 border border-gray-600 text-gray-300 rounded-lg shadow-lg mr-2"
					/>
					<button
						@click="addFriend"
						class="w-1/6 bg-red-600 hover:bg-red-700 text-yellow-400 font-semibold py-2 rounded-lg shadow-lg"
					><i class="fa-solid fa-user-plus"></i></button>
				</div>
			</div>
            <!-- Listes d'amis -->
            <div 
                class="relative flex-grow w-full bg-gray-900 border border-gray-600 hover:border-red-600 hover:outline outline-2 outline-red-600 rounded-lg shadow-lg" 
                style="max-height: calc(100vh - 150px); margin-bottom: 36px; height: 500px;"
            >
                <div class="relative p-5 h-full flex flex-col">
                    <h5 class="mb-6 text-2xl font-bold tracking-tight text-white">{{$t('My_Friends')}}</h5>
                    <ul class="flex-grow overflow-y-auto pr-2" style="max-height: calc(100% - 50px);">
                        <li
                            v-for="(friend, index) in friends"
                            :key="index"
                            class="p-2 text-white bg-gray-800 mb-3 rounded-lg shadow-lg flex justify-between items-center"
                        >
                            <div class="flex items-center space-x-3">
                                <img 
                                    class="w-8 h-8"
                                    :src="'https://localhost:8443/api/media/player_picture/' + friend.id + '.png'" 
                                    alt="Image de votre ami"
                                />
                                <span>{{friend.username}}</span>
                            </div>
                            <div 
                                :class="{
                                    'w-4 h-4 rounded-full': true,
                                    'bg-green-600': friend.status === 'online',
                                    'bg-yellow-500': friend.status === 'inactive',
                                    'bg-red-600': friend.status === 'offline'
                                }"
                            ></div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import apiClient from '@/axios';

	export default {
		name: 'Profil',
        data() {
			return {
                item: null,
				pseudo: null,
                mdp: null,
                img: null,
                status: "online",
                friends: {},
				// friends: [
				// 	{username: "test1", status: "online"},
				// 	{username: "test2", status: "offline"},
				// 	{username: "test3", status: "inactive"},
                //     {username: "test4", status: "online"},
				// 	{username: "test5", status: "offline"},
				// 	{username: "test6", status: "inactive"},
                //     {username: "test7", status: "online"},
				// 	{username: "test8", status: "offline"},
				// 	{username: "test9", status: "inactive"},
                //     {username: "test10", status: "online"},
				// 	{username: "test11", status: "offline"},
				// 	{username: "test12", status: "inactive"},
                //     {username: "test13", status: "online"},
				// 	{username: "test14", status: "offline"},
				// 	{username: "test15", status: "inactive"},
				// ],
                win_pong: null,
                lose_pong: null,
                win_tictactoe: null,
                lose_tictactoe: null,
                searchUsername: '',
                statusOptions: [
                    {value: "online", label: this.$t('Statut1')},
                    {value: "inactive", label: this.$t('Statut2')},
                    {value: "offline", label: this.$t('Statut3')},
                ],
                state_newPseudo: false,
                state_newMdp: false,
                newPseudo: null,
                newMdp: null,
			};
		},
        computed: {
            statusLabel() {
                switch (this.status) {
                    case 'online':
                    return this.$t('Statut1');
                    case 'offline':
                    return this.$t('Statut3');
                    case 'inactive':
                    return this.$t('Statut2');
                    default:
                    return 'Aucun statut';
                }
            },
        },
        methods: {
            selectStatus(value) {
                if (this.status === value) {
                    return;
                }
                this.status = value;
                this.updateStatus();
            },

            async get_profil_api() {
				try {
					const response = await apiClient.get('profil/');
					this.items = response.data.data;
					// console.log(this.items);

                    this.pseudo = response.data.data.username;
                    // console.log(this.pseudo);

                    this.mdp = response.data.data.password;
                    this.mdp = "*".repeat(12);
                    // console.log(this.mdp);

                    this.img = `https://localhost:8443/api/media/player_picture/${response.data.data.id}.png`;
                    // console.log(this.img);

                    this.status = response.data.data.status;
                    // console.log(this.status);

                    this.friends = response.data.data.friends;
                    // console.log(this.friends);

                    this.win_pong = response.data.data.win_pong;
                    // console.log(this.win_pong);
                    this.lose_pong = response.data.data.lose_pong;
                    // console.log(this.lose_pong);

                    this.win_tictactoe = response.data.data.win_tictactoe;
                    // console.log(this.win_tictactoe);
                    this.lose_tictactoe = response.data.data.lose_tictactoe;
                    // console.log(this.lose_tictactoe);
				} catch (error) {
					console.error('Erreur lors de la récupération des données :', error);
				}
			},
            async addFriend() {
                try {
                    const response = await apiClient.post('AddFriends/', {friend_username: this.searchUsername});
                    this.get_profil_api(); // Rafraîchit la liste des amis
                } catch (error) {
                    console.error('Erreur lors de l\'ajout d\'un ami :', error.response?.data || error.message);
                }
			},
            async updateStatus() {
                try {
                    const response = await apiClient.put('profil/', {status: this.status});
                } catch (error) {
                    console.error('Erreur lors de la mise à jour du statut :', error.response?.data || error.message);
                }
            },
            async updatePseudo() {
                try {
                    const response = await apiClient.put('profil/', {username: this.newPseudo});
                    this.pseudo = this.newPseudo;
                } catch (error) {
                    console.error('Erreur lors de la mise à jour du pseudo :', error.response?.data || error.message);
                }
            },
            async updateMdp() {
                try {
                    const response = await apiClient.put('profil/', {password: this.newMdp});
                    this.mdp = "*".repeat(12);
                } catch (error) {
                    console.error('Erreur lors de la mise à jour du mdp :', error.response?.data || error.message);
                }
            },
            // async replaceImage() {
			// 	try {
			// 		const newImage = prompt("Entrez votre nouvelle image :");
			// 		if (newImage) {
			// 			const response = await apiClient.put('profil/', { image: newImage });
			// 			this.img = newImage;
			// 			// this.get_profil_api();
			// 		}
			// 	} catch (error) {
			// 		console.error('Erreur lors de la mise à jour du image :', error.response?.data || error.message);
			// 	}
			// },	
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