<template>
	<header class="bg-gray-900 text-gray-300 py-6 mt-auto max-w-6xl mx-auto px-36 rounded-b-xl relative">
		<div v-if="$i18n.locale === 'en'">
			<div class="flex items-center absolute left-2.5 top-4 space-x-0">
					<h2 class="text-white text-sm">{{$t('Tournaments')}}</h2>
					<img
						class="relative h-5 w-5"
						src="../../assets/img/cup_yellow.png"
						alt="Image de la coupe du tournoi"
					/>
			</div>
		</div>
		<div v-else>
			<div class="flex items-center absolute left-5 top-3.5 space-x-1">
				<h2 class="text-white">{{$t('Tournaments')}}</h2>
				<img
					class="relative h-5 w-5"
					src="../../assets/img/cup_yellow.png"
					alt="Image de la coupe du tournoi"
				/>
			</div>
		</div>

		<!-- Traduction -->
		<div class="absolute justify-center space-x-1 mx-10 top-3">
			<button
				@click="lang_state = !lang_state"
				class="flex items-center bg-transparent text-white px-1 py-0.5"
			>
				<div v-if="$i18n.locale === 'fr'">
					<i class="fi fi-fr text-1xl mr-2"></i>
				</div>
				<div v-else-if="$i18n.locale === 'en'">
					<i class="fi fi-gb text-1xl mr-2"></i>
				</div>
				<div v-else-if="$i18n.locale === 'es'">
					<i class="fi fi-es text-1xl mr-2"></i>
				</div>
				<span>{{$t('Language', $i18n.locale)}}</span>
			</button>
			<div
				v-if="lang_state"
				class="bg-gray-900 border border-gray-600 rounded-md absolute mt-4 w-full z-10"
				role="menu"
			>
				<ul>
					<li v-for="locale in $i18n.availableLocales" :key="`locale-${locale}`">
						<button
						@click="changeLocale(locale)"
						@focus="lang_index = locale"
						@blur="lang_index = null"
						:class="{
							'flex items-center justify-center px-4 py-2 text-white hover:text-red-600 cursor-pointer': true,
							'bg-gray-700': lang_index === locale,
						}"
						type="button"
						role="menuitem"
						>
						{{$t('Language', locale)}}
						</button>
					</li>
				</ul>
			</div>
		</div>
	</header>
	<!-- Profil -->
	<div class="relative flex justify-center">
		<img
			class="h-14 w-14 rounded-xl border-2 border-red-600 absolute -top-10"
			src="../../assets/img/default_avatar.png"
			alt="Avatar par défaut"
		/>
		<div
			v-if="!GetConnectState"
			class="bg-gray-900 border border-gray-600 rounded-md w-26 absolute top-6"
			role="menu"
		>
			<ul>
				<li v-for="(name, index) in [$t('Login'), $t('Register')]" :key="index">
					<!-- <button
						@click="handle(index)"
						@focus="connect_index = index"
						@blur="connect_index = -1"
						:class="{
						'flex items-center justify-center px-4 py-2 text-white hover:text-red-600 cursor-pointer': true,
						'bg-gray-700': connect_index === index,
						}"
						type="button"
						role="menuitem"
					>{{name}}
					</button> -->
					<router-link
						:to="index === 0 ? '/login' : '/register'"
						@click="connect_change()"
						@focus="connect_index = index"
						@blur="connect_index = -1"
						:class="{
						'flex items-center justify-center px-4 py-2 text-white hover:text-red-600 cursor-pointer': true,
						'bg-gray-700': connect_index === index,
						}"
						role="menuitem"
					>{{name}}
					</router-link>
				</li>
			</ul>
		</div>
		<button @click="getapi()" class="flex items-center justify-center px-4 py-2 absolute top-80 text-white hover:text-red-600 cursor-pointer bg-gray-700">Test Get Api</button>
		<button @click="postapi()" class="flex items-center justify-center px-4 py-2 absolute top-96 text-white hover:text-red-600 cursor-pointer bg-gray-700">Test Post Api</button>
	</div>

</template>

<script>
	import {mapGetters, mapActions} from 'vuex';
	import apiClient from '@/axios'; // Adapter le chemin selon ton organisation
	export default {
		name: "Header",
		data() {
			return {
				lang_state: false,
				lang_index: -1,
				connect_index: -1,
				items: [],
				tabletestapi: {
					test1: "yes yes",
					test2: "haha",
				},
			};
		},
		computed: {
			...mapGetters(['GetConnectState']),
		},
		methods: {
			...mapActions(['OpenConnect']),
			changeLocale(locale) {
				this.$i18n.locale = locale;
				this.lang_state = false;
			},
			connect_change() {
				this.OpenConnect();
			},
			// ...mapActions(['OpenLogin']),
			// ...mapActions(['OpenRegister']),
			// handle(index) {
			// 	if (index === 0) {
			// 		this.OpenLogin();
			// 	} else if (index === 1) {
			// 		this.OpenRegister();
			// 	}
			// },
			async getapi() {
				console.log("get api");
				try {
					const response = await apiClient.get('register/'); // Remplace 'endpoint/' par ton URL
					this.items = response.data; // Met à jour les données
					console.log(JSON.parse(this.items));
				} catch (error) {
					console.error('Erreur lors de la récupération des données :', error);
				}
			},
			async postapi() {
				console.log("post api");
				try {
					const response = await apiClient.post('register/', this.tabletestapi); // Remplace 'endpoint/' par ton URL
					console.log('Données envoyées avec succès :', response.data);
				} catch (error) {;
					console.error('Erreur lors de l\'envoi des données :', error.response ? error.response.data : error.message);
				}
			},
		},
	};
</script>

<style scoped>
	@import url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css");
	@import url("https://cdn.jsdelivr.net/gh/lipis/flag-icons@6.6.6/css/flag-icons.min.css");
</style>
