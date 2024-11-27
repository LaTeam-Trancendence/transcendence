import {createStore} from 'vuex';

export default createStore({
	state: {
		connect_state: false,
		color1: "#ff0000",
		color2: "#ffd200",
		ball_speed_time: false,
		ball_speed_manual: 1,
		remove_hit: false,
	},
	getters: {
		GetConnectState(state) {
			return state.connect_state
		},
		GetColor1State(state) {
			return state.color1
		},
		GetColor2State(state) {
			return state.color2
		},
		GetBallSpeedTimeState(state) {
			return state.ball_speed_time
		},
		GetBallSpeedManualState(state) {
			return state.ball_speed_manual
		},
		GetRemoveHitState(state) {
			return state.remove_hit
		},
	},
	mutations: {
		SetConnectState(state, value) {
			state.connect_state = value;
		},
		SetColor1State(state, value) {
			state.color1 = value;
		},
		SetColor2State(state, value) {
			state.color2 = value;
		},
		SetBallSpeedTimeState(state, value) {
			state.ball_speed_time = value;
		},
		SetBallSpeedManualState(state, value) {
			state.ball_speed_manual = value;
		},
		SetRemoveHitState(state, value) {
			state.remove_hit = value;
		},
	},
	actions: {
		OpenConnect({commit}) {
			commit('SetConnectState', true);
		},
		CloseConnect({commit}) {
			commit('SetConnectState', false);
		},
	},
});
