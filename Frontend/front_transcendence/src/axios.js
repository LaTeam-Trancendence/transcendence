import axios from 'axios';

const apiClient = axios.create({
    baseURL: 'http://localhost:8000/api/', // URL de l'api django
    headers: {
        'Content-Type': 'application/json',
    },
    withCredentials: false, // l'authentification par cookies
});

export default apiClient;