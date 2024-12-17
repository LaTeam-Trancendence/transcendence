<script setup>
	import LoopVideo from '../LoopVideo.vue'
	import ImageUpload from './ImageUpload.vue'
</script>

<template>
	<div class="fixed inset-0 flex flex-col items-center justify-center">
		<LoopVideo/>
		<div class="relative bg-gray-900 border-gray-600 hover:border-red-600 hover:outline outline-2 outline-red-600 w-full max-w-xs sm:max-w-md p-8 rounded-md">
			<div class="absolute top-3 right-3">
				<router-link to="/" class="text-yellow-400 px-1.5 py-0.5 rounded-md bg-red-600 hover:bg-red-700">✘</router-link>
			</div>
			<form @submit.prevent="submitRegister">
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
				<div class="mb-4">
					<label for="password" class="block text-sm font-medium text-gray-300">{{$t('Password')}}</label>
					<input
					type="password"
					id="password"
					v-model="password"
					required
					class="w-full mt-1 p-2 rounded-md bg-gray-700 border border-gray-600 text-gray-300 focus:outline-none focus:ring-2 focus:ring-red-600"
					/>
				</div>
				<div class="mb-4">
					<label for="confirm_password" class="block text-sm font-medium text-gray-300">{{$t('Confirm_Password')}}</label>
					<input
					type="password"
					id="confirm_password"
					v-model="confirm_password"
					required
					class="w-full mt-1 p-2 rounded-md bg-gray-700 border border-gray-600 text-gray-300 focus:outline-none focus:ring-2 focus:ring-red-600"
					/>
				</div>
				<h2 v-if="error_return_api" class="mb-4 flex items-center justify-center text-red-700 font-bold">{{error_return_api}}</h2>
				<h2 v-if="password !== confirm_password" class="mb-4 flex items-center justify-center text-red-700 font-bold">{{$t('Error_Doublemdp')}}</h2>
				<div class="mb-6">
					<label for="confirm_password" class="block text-sm font-medium text-gray-300">{{$t('Profile_Image')}}</label>
					<ImageUpload @image-selected="handleImageSelected"/>
				</div>
				<div class="mb-6">
					<input type="checkbox" id="checkbox" v-model="check_conditions"/>
					<label class="text-sm font-medium text-gray-300 ml-2" for="checkbox">{{$t('Conditions1')}}<a href="/conditions" class="text-blue-500">{{$t('Conditions2')}}</a>{{$t('Conditions3')}}</label>
				</div>
				<h2 v-if="!check_conditions" class="mb-4 flex items-center justify-center text-red-700 font-bold">{{$t('Error_Conditions')}}</h2>
				<button
					v-if="password === confirm_password && check_conditions == true"
					type="submit"
					class="w-full bg-red-600 hover:bg-red-700 text-yellow-400 font-medium py-2 px-4 rounded-md"
				>{{$t('Register')}}</button>
			</form>
		</div>
	</div>
</template>
  
<script>
	import {mapGetters, mapActions, mapMutations} from 'vuex';
	import apiClient from '@/axios';

	export default {
		name: 'Register',
		data() {
			return {
				pseudo: '',
				password: '',
				confirm_password: '',
				image: null,
				image_link: null,
				check_conditions: false,
				error_return_api: null,
			};
		},
		methods: {
			...mapActions(['CloseConnect']),
			...mapActions(['Login']),
			async submitRegister() {
				this.error_return_api = null;
				// console.log(this.pseudo);
				// console.log(this.password);
				// console.log(this.confirm_password);
				// console.log(this.image);

				const formData = new FormData();
				formData.append('username', this.pseudo);
				formData.append('password', this.password);
				if (this.image) {
					formData.append('image', this.image);
				}

				const result = await this.postregister(formData);
				if (result == 1)
				{
					this.$router.push('/');
				}
				else {
					console.error("error post register");
				}
			},
			handleImageSelected(file) {
				this.image = file;
				this.image_link = URL.createObjectURL(file);
			},
			async postregister(formData) {
				try {
					const response = await apiClient.post('register/', formData, {
						headers: {
							'Content-Type': 'multipart/form-data',
						},
					});
					this.CloseConnect();
					return (1);
				} catch (error) {
					this.error_return_api = this.$t('Error_MdpApi');
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
