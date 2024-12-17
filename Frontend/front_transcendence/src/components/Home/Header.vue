<template>
	<header class="bg-gray-900 text-gray-300 py-6 mt-auto max-w-6xl mx-auto px-36 rounded-b-xl relative">
		<!-- Tournois -->
		<div v-if="$i18n.locale === 'en'">
			<router-link to="/" @click="OpenTournament()" class="flex items-center absolute left-2.5 top-4 space-x-0">
				<h2 class="text-white text-sm">{{$t('Tournaments')}}</h2>
				<img
					class="relative h-5 w-5"
					src="../../assets/img/cup_yellow.png"
					alt="Image de la coupe du tournoi"
				/>
			</router-link>
		</div>
		<div v-else>
			<router-link to="/" @click="OpenTournament()" class="flex items-center absolute left-5 top-3.5 space-x-1">
				<h2 class="text-white">{{$t('Tournaments')}}</h2>
				<img
					class="relative h-5 w-5"
					src="../../assets/img/cup_yellow.png"
					alt="Image de la coupe du tournoi"
				/>
			</router-link>
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
								'flex items-center justify-center w-full px-4 py-2 text-white hover:text-red-600 cursor-pointer': true,
								'bg-gray-700': lang_index === locale,
							}"
							type="button"
							role="menuitem"
							>{{getLanguageName(locale)}}
						</button>
					</li>
				</ul>
			</div>
		</div>
	</header>
	<!-- Profil -->
	<div class="relative flex justify-center">
		<img v-if="!GetConnectState" class="h-14 w-14 rounded-xl border-2 border-red-600 absolute -top-10" src="../../assets/img/default_avatar.png" alt="Avatar par défaut"/>
		<img v-if="GetConnectState && !img" @click="ToggleSubMenu()" @keydown.enter="ToggleSubMenu()" @keydown.space="ToggleSubMenu()" tabindex="0" class="h-14 w-14 rounded-xl border-2 border-red-600 absolute -top-10 cursor-pointer" src="../../assets/img/default_avatar.png" alt="Avatar par défaut"/>
		<img v-if="GetConnectState && img" :src="img" @click="ToggleSubMenu()" @keydown.enter="ToggleSubMenu()" @keydown.space="ToggleSubMenu()" tabindex="0" class="h-14 w-14 rounded-xl border-2 border-red-600 absolute -top-10 cursor-pointer" alt="Notre Avatar"/>

		<div v-if="!GetConnectState" class="bg-gray-900 border border-gray-600 rounded-md w-26 absolute top-6" role="menu">
			<ul>
				<li v-for="(name, index) in [$t('Login'), $t('Register')]" :key="index">
					<router-link
						:to="index === 0 ? '/login' : '/register'"
						@focus="connect_index = index"
						@blur="connect_index = -1"
						:class="{
						'flex items-center justify-center px-4 py-2 text-white hover:text-red-600 cursor-pointer': true,
						'bg-gray-700': connect_index === index,}"
						role="menuitem"
					>{{name}}</router-link>
				</li>
			</ul>
		</div>
		<div v-if="connectedmenu_state" class="bg-gray-900 border border-gray-600 rounded-md absolute top-6 z-50" role="menu">
			<ul>
				<li v-for="(item, index) in menuItems" :key="index">
				<button
					@click="HandleSubMenu(index)"
					@focus="connected_index = index"
					@blur="connected_index = -1"
					:class="[
						'flex items-center justify-start w-full px-4 py-2 hover:text-red-600 cursor-pointer',
						connected_index === index ? 'bg-gray-700' : '',
						item.colorClass,
						item.text === $t('Delete_Account') ? 'mt-4' : ''
					]"
					role="menuitem"
				><i :class="[item.icon, 'mr-2']"></i>{{item.text}}</button>
			  </li>
			</ul>
		</div>
	</div>

</template>

<script>
	import {mapGetters, mapActions} from 'vuex';
	import apiClient from '@/axios';
	export default {
		name: "Header",
		data() {
			return {
				lang_state: false,
				lang_index: -1,
				connect_index: -1,
				connectedmenu_state: false,
				connected_index: -1,
				img: null,
			};
		},
		computed: {
			...mapGetters(['GetConnectState']),
			...mapGetters(['GetUserState']),
			...mapGetters(['GetLanguageState']),
			...mapGetters(['GetTournament']),
			menuItems() {
				return [
					{text: this.$t('Profil'), icon: 'fas fa-user', colorClass: 'text-sky-500 hover:text-yellow-400'},
					{text: this.$t('Player_Profile'), icon: 'fas fa-bars', colorClass: 'text-lime-500 hover:text-yellow-400'},
					{text: this.$t('Disconnect'), icon: 'fas fa-sign-out-alt', colorClass: 'text-orange-500 hover:text-yellow-400'},
					{text: this.$t('Delete_Account'), icon: 'fas fa-trash-alt', colorClass: 'text-red-500 hover:text-yellow-400'},
				];
			}
		},
		methods: {
			...mapActions(['Logout']),
			...mapActions(['ChangeLanguage']),
			getLanguageName(locale) {
				const languageNames = {
					fr: 'Français',
					en: 'English',
					es: 'Español'
				};
				return languageNames[locale] || locale;
			},
			changeLocale(locale) {
				this.$i18n.locale = locale;
				this.ChangeLanguage(locale);
				this.lang_state = false;
			},
			OpenTournament() {
				if (this.GetTournament) {
					this.$router.push('/tournaments');
				}
				else {
					this.$router.push('/custom_tournaments');
				}
			},
			ToggleSubMenu() {
				if (this.connectedmenu_state == false) {
					this.connectedmenu_state = true;
				}
				else {
					this.connectedmenu_state = false;
				}
			},
			async HandleSubMenu(index) {
				if (index == 0) {
					this.$router.push('/profil');
				}
				if (index == 1) {
					this.$router.push('/list_players');
				}
				if (index == 2) {
					const result = await this.deconnect_api();
					if (result == 1)
					{
						this.Logout();
						this.$router.push('/');
						window.location.reload();
					}
					else {
						console.error("error disconect");
					}
				}
				if (index == 3) {
					const result = await this.delete_api();
					if (result == 1)
					{
						this.Logout();
						this.$router.push('/');
    					window.location.reload();
					}
					else {
						console.error("error delete account");
					}
				}
			},
			async deconnect_api() {
				try {
					const response = await apiClient.post('logout/', this.GetUserState);
					return (1);
				} catch (error) {
					console.error('Erreur lors de l\'envoi des données :', error.response ? error.response.data : error.message);
					return (0);
				}
			},
			async delete_api() {
				try {
					const response = await apiClient.post('delete/', this.GetUserState);
					return (1);
				} catch (error) {
					console.error('Erreur lors de l\'envoi des données :', error.response ? error.response.data : error.message);
					return (0);
				}
			},
			async header_get_profil() {
				try {
					const response = await apiClient.get('profil/');
					this.img = `https://localhost:8443/api/media/player_picture/${response.data.data.id}.png`;
				} catch (error) {
					console.error('Erreur lors de la récupération des données :', error);
					this.img = null; 
				}
			},
		},
		mounted() {
			this.$i18n.locale = this.GetLanguageState;
			if (this.GetConnectState) {
				this.header_get_profil();
			}
		},
	};
</script>

<style scoped>
	@import url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css");
	@import url("https://cdn.jsdelivr.net/gh/lipis/flag-icons@6.6.6/css/flag-icons.min.css");
</style>
