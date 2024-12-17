import {createRouter, createWebHistory} from 'vue-router';
import Home from './components/Home/Home.vue';
import Login from './components/Login/Login.vue';
import Register from './components/Register/Register.vue';
import Conditions from './components/Register/Conditions.vue';
import Profil from './components/Profil/Profil.vue';
import ListPlayers from './components/Profil/ListPlayers.vue';
import Custom from './components/Games/Custom.vue';
import Pong from './components/Games/Pong.vue';
import TicTacToe from './components/Games/TicTacToe.vue';
import Custom_Tournaments from './components/Home/Custom_Tournaments.vue';
import Tournaments from './components/Home/Tournaments.vue';

const routes = [
	{
		path: '/',
		name: 'Home',
		component: Home,
	},
	{
		path: '/login',
		component: Login,
	},
	{
		path: '/register',
		component: Register,
	},
	{
		path: '/conditions',
		component: Conditions,
	},
	{
		path: '/profil',
		component: Profil,
	},
	{
		path: '/list_players',
		component: ListPlayers,
	},
	{
		path: '/custom',
		component: Custom,
	},
	{
		path: '/pong',
		component: Pong,
	},
	{
		path: '/tictactoe',
		component: TicTacToe,
	},
	{
		path: '/custom_tournaments',
		component: Custom_Tournaments,
	},
	{
		path: '/tournaments',
		component: Tournaments,
	},
];

const router = createRouter({
	history: createWebHistory(), // Utilisation de l'historique HTML5
	routes,
});

export default router;
