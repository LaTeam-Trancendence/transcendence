import {createI18n} from 'vue-i18n'
import fr from './locales/fr.json'
import en from './locales/en.json'
import es from './locales/es.json'

import store from './store';

function loadLocaleMessages() {
	const messages = {
        fr: fr,
        en: en,
        es: es,
    };
    return messages;
}

export default createI18n({
    legacy: false,
    locale: store.getters.GetLanguageState,
    fallbackLocale: 'fr',
    messages: loadLocaleMessages()
})