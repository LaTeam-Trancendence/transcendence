import {createStore} from 'vuex';

export default createStore({
	state: {
		user: null,
		connect_state: false,
		play_ia: false,
		color1: "#ff0000",
		color2: "#ffd200",
		ball_speed_time: false,
		ball_speed_manual: 1,
		remove_hit: false,
		layout: false,
		language: "fr",
		tournament: null,
	},
	getters: {
		GetUserState(state) {
			return state.user;
		},
		GetConnectState(state) {
			return state.connect_state;
		},
		GetPlayIaState(state) {
			return state.play_ia;
		},
		GetColor1State(state) {
			return state.color1;
		},
		GetColor2State(state) {
			return state.color2;
		},
		GetBallSpeedTimeState(state) {
			return state.ball_speed_time;
		},
		GetBallSpeedManualState(state) {
			return state.ball_speed_manual;
		},
		GetRemoveHitState(state) {
			return state.remove_hit;
		},
		GetLayoutState(state) {
			return state.layout;
		},
		GetLanguageState(state) {
			return state.language;
		},
		GetTournament(state) {
			return state.tournament;
		},
	},
	mutations: {
		SetUser(state, user) {
			state.user = user;
			localStorage.setItem('user', JSON.stringify(user));
		},
		ClearUser(state) {
			state.user = null;
			localStorage.removeItem('user');
		},
		SetConnectState(state, value) {
			state.connect_state = value;
		},
		SetPlayIaState(state, value) {
			state.play_ia = value;
			localStorage.setItem('play_ia', JSON.stringify(value));
		},
		SetColor1State(state, value) {
			state.color1 = value;
			localStorage.setItem('color1', value);
		},
		SetColor2State(state, value) {
			state.color2 = value;
			localStorage.setItem('color2', value);
		},
		SetBallSpeedTimeState(state, value) {
			state.ball_speed_time = value;
			localStorage.setItem('ball_speed_time', JSON.stringify(value));
		},
		SetBallSpeedManualState(state, value) {
			state.ball_speed_manual = value;
			localStorage.setItem('ball_speed_manual', JSON.stringify(value));
		},
		SetRemoveHitState(state, value) {
			state.remove_hit = value;
			localStorage.setItem('remove_hit', JSON.stringify(value));
		},
		SetLayoutState(state, value) {
			state.layout = value;
			localStorage.setItem('layout', JSON.stringify(value));
		},
		SetLanguageState(state, value) {
			state.language = value;
			localStorage.setItem('language', JSON.stringify(value));
		},
		SetTournament(state, tournament) {
			state.tournament = tournament;
			localStorage.setItem('tournament', JSON.stringify(tournament));
		},
		ClearTournament(state) {
			state.tournament = null;
			localStorage.removeItem('tournament');
		},
	},
	actions: {
		Login({commit}, userData) {
			commit('SetUser', userData);
		},
		Logout({commit}) {
			commit('ClearUser');
		},
		InitializeStore({ commit }) {
			const user = localStorage.getItem('user');
			const play_ia = localStorage.getItem('play_ia');
			const color1 = localStorage.getItem('color1');
			const color2 = localStorage.getItem('color2');
			const ball_speed_time = localStorage.getItem('ball_speed_time');
			const ball_speed_manual = localStorage.getItem('ball_speed_manual');
			const remove_hit = localStorage.getItem('remove_hit');
			const layout = localStorage.getItem('layout');
			const language = localStorage.getItem('language');
			const tournament = localStorage.getItem('tournament');

			if (user) {
				commit('SetUser', JSON.parse(user));
				commit('SetConnectState', true);
			}
			commit('SetPlayIaState', JSON.parse(play_ia) || false);
			commit('SetColor1State', color1 || "#ff0000");
			commit('SetColor2State', color2 || "#ffd200");
			commit('SetBallSpeedTimeState', JSON.parse(ball_speed_time) || false);
			commit('SetBallSpeedManualState', JSON.parse(ball_speed_manual) || 1);
			commit('SetRemoveHitState', JSON.parse(remove_hit) || false);
			commit('SetLayoutState', JSON.parse(layout) || false);
			commit('SetLanguageState', JSON.parse(language) || "fr");
			commit('SetTournament', JSON.parse(tournament));
		},
		ChangeLanguage({commit}, language) {
			commit('SetLanguageState', language);
		},
		OpenConnect({commit}) {
			commit('SetConnectState', true);
		},
		CloseConnect({commit}) {
			commit('SetConnectState', false);
		},
		CreateTournament({commit}, tournament) {
			commit('SetTournament', tournament);
		},
		DeleteTournament({commit}) {
			commit('ClearTournament');
		},
	},
});
