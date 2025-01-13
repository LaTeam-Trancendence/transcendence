# Transcendence - Projet 42

## 🚀 Brief du Projet
Transcendence est un projet full-stack visant à créer une application web complète, s'appuyant sur les concepts modernes de développement logiciel et de déploiement. Il intègre plusieurs services déployés sous forme de conteneurs Docker pour une architecture modulaire, scalable et facilement maintenable.

## 🔒 Configuration .env (Non Pushée pour des Raisons de Sécurité)
Pour garantir la sécurité des données sensibles, un fichier `.env` est requis pour configurer l'environnement du projet. Ce fichier n'est **pas pushé sur le repository**.

Lors de la correction, le fichier `.env` sera copié depuis le PC local grâce à la commande suivante :

```bash
make init
```

Cette commande exécute un script qui assure la création du fichier `.env` et initialise les volumes nécessaires pour les services Docker.

## 📋 Comment Utiliser le Projet
Voici les étapes pour exécuter l'application Transcendence :

&emsp;1. **Initialiser l'environnement** :
   ```bash
   make init
   ```
   Cette commande va :
   - Copier le fichier `.env` requis.
   - Créer les fichiers locaux pour les volumes Docker.

&emsp;2. **Lancer le projet** :
   ```bash
   make
   ```
   Cette commande déploie tous les services Docker nécessaires pour l'application.

3. **Accéder à l'application** :
   Rendez-vous sur https://localhost:8433 pour accéder à l'application.

## 📊 Accéder aux Dashboards de Monitoring
Pour assurer le suivi des différents services du projet, des dashboards de monitoring sont disponibles :

### 🔹 Grafana
- **URL** : https://localhost:8433/gafana/login
- **Fonctionnalités** : Monitoring des métriques des services via Prometheus.
- **Connexion** : Utilisez les logins par défaut lors de la première connexion, puis choisissez un mot de passe de votre choix pour sécuriser l'accès.


### 🔹 ELK Stack (Elasticsearch, Logstash, Kibana)
- **Kibana** : https://localhost:8433/kibana
- **Fonctionnalités** :
  - Visualisation des logs collectés des services Docker (Nginx, Frontend, API et PostgreSQL).
  - Accès à des dashboards préconfigurés pour faciliter l'analyse des logs.

#### 🚀 Importation du Dashboard Kibana
Pour importer le dashboard préconfiguré dans Kibana, suivez ces étapes :

   1. Cliquez sur les **3 traits** en haut à gauche.
   2. Descendez à la fin de la liste et cliquez sur **Stack Management**.
   3. Cliquez sur les **3 traits + fleche** dans le bandeau de gauche.
   4. Dans la catégorie **Kibana**, cliquez sur **Saved Objects**.
   5. En haut à gauche, cliquez sur **Import**.
   6. Importez le fichier `dashboard.ndjson` situé dans le dossier du projet :
      ```
      Kibana/provisioning/dashboard.ndjson
      ```
   7. Validez l'importation.
   8. Cliquez sur **"Transcendence"**, qui apparaît dans la liste des **Saved Objects**.
&nbsp;
---

**Remarque** : Assurez-vous que tous les services Docker sont correctement démarrés avant d'accéder aux dashboards.

---
&nbsp;

© Projet Transcendence - Lateam - École 42
