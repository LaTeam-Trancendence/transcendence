<script setup>
	import LoopVideo from '../LoopVideo.vue'
</script>

<template>
	<!-- <div v-if="GetLoginState" class="fixed inset-0 flex flex-col items-center justify-center"> -->
	<div class="fixed inset-0 flex flex-col items-center justify-center"> 
		<LoopVideo/>
		<div class="relative bg-gray-900 border-gray-600 hover:border-red-600 hover:outline outline-2 outline-red-600 w-full max-w-xs sm:max-w-md p-8 rounded-md">
			<div class="absolute top-3 right-3">
				<router-link to="/" class="text-yellow-400 px-1.5 py-0.5 rounded-md bg-red-600 hover:bg-red-700">✘</router-link>
			</div>
			<form @submit.prevent="submitLogin">
				<div class="mb-4">
					<label for="pseudo" class="block text-sm font-medium text-gray-300">{{$t('Pseudo')}}</label>
					<input
					type="pseudo"
					id="pseudo"
					v-model="pseudo"
					required
					class="w-full mt-1 p-2 rounded-md bg-gray-700 border border-gray-600 text-gray-300 focus:outline-none focus:ring-2 focus:ring-red-600"
					/>
				</div>
				<div class="mb-6">
					<label for="password" class="block text-sm font-medium text-gray-300">{{$t('Password')}}</label>
					<input
					type="password"
					id="password"
					v-model="password"
					required
					class="w-full mt-1 p-2 rounded-md bg-gray-700 border border-gray-600 text-gray-300 focus:outline-none focus:ring-2 focus:ring-red-600"
					/>
				</div>
				<div v-if="errorMessage" class="mb-6 flex items-center justify-center text-red-700 font-bold">{{errorMessage}}</div>
				<button
					type="submit"
					class="w-full bg-red-600 hover:bg-red-700 text-yellow-400 font-medium py-2 px-4 rounded-md"
				>{{$t('Login')}}
				</button>
			</form>
		</div>
	</div>
</template>
  
<script>
	import {mapGetters, mapActions, mapMutations} from 'vuex';
	import apiClient from '@/axios';

	export default {
		name: 'Login',
		data() {
			return {
				pseudo: '',
				password: '',
				table_login: {
					username: "NULL",
					password: "NULL",
				},
				errorMessage: '',
			};
		},
		methods: {
			...mapActions(['OpenConnect']),
			...mapActions(['Login']),
			async submitLogin() {
				this.table_login.username = this.pseudo;
				this.table_login.password = this.password;
				const result = await this.postlogin();
				if (result == 1) {
					this.OpenConnect();
					this.$router.push('/');
				}
				else {
					console.error("error login");
				}
			},
			async postlogin() {
				try {
					const response = await apiClient.post('login/', this.table_login);
					this.Login(response.data);
					this.errorMessage = '';
					return (1);
				} catch (error) {
					this.errorMessage = this.$t('Error_LoginApi');
					console.error('Erreur lors de l\'envoi des données :', error.response ? error.response.data : error.message);
					return (0);
				}
			},
		},
	};
</script>

<style>
	body.no-scroll {
		overflow: hidden;
	}
</style>
