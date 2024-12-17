import axios from 'axios';

// Récupérer le token CSRF depuis les cookies ou la page
const getCsrfToken = () => {
	const csrfCookie = document.cookie
		.split('; ')
		.find(row => row.startsWith('csrftoken='));
	return csrfCookie ? csrfCookie.split('=')[1] : null;
};

// Configurer Axios pour inclure le token CSRF
const apiClient = axios.create({
    baseURL: 'https://localhost:8443/api/api',
    headers: {
        'Content-Type': 'application/json',
    },
    withCredentials: true,
});

// Inclus le token CSRF dans le header de toutes les requetes api
apiClient.interceptors.request.use(config => {
    const csrfToken = getCsrfToken();
		if (csrfToken) {
			config.headers['X-CSRFToken'] = csrfToken;
		}
      return config;
});

export default apiClient;
