import {createRouter, createWebHistory} from 'vue-router';
import Home from './components/Home/Home.vue';
import Login from './components/Login/Login.vue';
import Register from './components/Register/Register.vue';
import Custom from './components/Games/Custom.vue';
import Pong from './components/Games/Pong.vue';
import TicTacToe from './components/Games/TicTacToe.vue';

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
];

const router = createRouter({
	history: createWebHistory(), // Utilisation de l'historique HTML5
	routes,
});

export default router;
