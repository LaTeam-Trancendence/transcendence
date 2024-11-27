<script setup>
	import LoopVideo from '../LoopVideo.vue'
</script>

<template>
	<!-- <div v-if="GetLoginState" class="fixed inset-0 flex flex-col items-center justify-center"> -->
	<div class="fixed inset-0 flex flex-col items-center justify-center"> 
		<LoopVideo/>
		<div class="relative bg-gray-900 w-full max-w-md p-8 rounded-md">
			<div class="absolute top-3 right-3">
				<router-link to="/" @click="return_home" class="text-yellow-400 px-1.5 py-0.5 rounded-md bg-red-600 hover:bg-red-700">✘</router-link>
				<!-- <button @click="CloseLogin" class="text-yellow-400 px-1.5 py-0 rounded-md bg-red-600 hover:bg-red-700">✘</button> -->
			</div>
			<!-- <h2 class="flex items-center justify-center text-white">{{$t('Login')}}</h2> -->
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
	import {mapGetters, mapActions} from 'vuex';

	export default {
		name: 'Login',
		data() {
			return {
				pseudo: '',
				password: '',
			};
		},
		computed: {
			// ...mapGetters(['GetLoginState']),
		},
		methods: {
			// ...mapActions(['CloseLogin']),
			...mapActions(['CloseConnect']),
			// api rest envoie de pseudo et password
			submitLogin() {
				console.log(this.pseudo);
				console.log(this.password);
				// this.CloseLogin();
				this.$router.push('/');
			},
			return_home() {
				this.CloseConnect();
			},
		},
	};
</script>

<style>
	body.no-scroll {
		overflow: hidden;
	}
</style>
