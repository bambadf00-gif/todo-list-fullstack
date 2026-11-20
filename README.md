# 📝 Todo List — Application mobile

Une application mobile de gestion de tâches développée avec **Flutter**, **Python**, **FastAPI** et **SQLite**.

Ce projet personnel a été réalisé dans le cadre de mon apprentissage du développement Full Stack. Il me permet de découvrir la création d'une API REST, la gestion d'une base de données et la communication entre une application mobile et un backend.

## 🚀 Technologies utilisées

### Backend
- Python
- FastAPI
- SQLite
- SQL

### Frontend
- Flutter
- Dart
- HTTP
- GoRouter

## ✨ Fonctionnalités

### Backend
- [x] Inscription des utilisateurs
- [x] Connexion des utilisateurs
- [x] Suppression d'un compte
- [x] Création de tâches
- [x] Récupération des tâches d'un utilisateur
- [x] Modification des tâches
- [x] Suppression des tâches

### Frontend
- [x] Création des pages d'inscription et de connexion
- [x] Navigation avec GoRouter
- [x] Connexion à l'API FastAPI
- [x] Création de tâches depuis Flutter
- [x] Affichage des tâches
- [x] Interface simple avec Flutter

## 📂 Structure du projet

```text
todo-list/
│
├── backend/
│   ├── __pycache__/
│   ├── venv/
│   ├── .gitignore
│   ├── crud.py
│   ├── database.py
│   ├── main.py
│   ├── model.py
│   └── todo.db
│
├── frontend/
│   ├── android/
│   ├── ios/
│   ├── lib/
│   │   ├── app/
│   │   │   ├── main/
│   │   │   │   └── main_layout.dart
│   │   │   └── router/
│   │   │       ├── app_router.dart
│   │   │       └── app_routes.dart
│   │   ├── screens/
│   │   ├── services/
│   │   └── main.dart
│   └── pubspec.yaml
│
└── README.md
```

## ⚙️ Installation

### 1. Cloner le projet

```bash
git clone https://github.com/bambadf00-gif/todo-list-fullstack
cd todo-list
```

### 2. Installer le backend

Accéder au dossier backend :

```bash
cd backend
```

Créer un environnement virtuel :

```bash
python -m venv venv
```

Activer l'environnement virtuel sous Windows :

```bash
venv\Scripts\activate
```

Installer FastAPI :

```bash
pip install "fastapi[standard]"
```

Lancer le serveur :

```bash
fastapi dev main.py
```

Documentation de l'API :

http://127.0.0.1:8000/docs

### 3. Installer le frontend

Dans un autre terminal :

```bash
cd frontend
```

Installer les dépendances :

```bash
flutter pub get
```

Lancer l'application :

```bash
flutter run
```

## 🌐 Configuration de l'API

Pour utiliser l'application sur un émulateur Android, l'adresse du backend est :

```dart
static const String baseUrl = "http://10.0.2.2:8000";
```

Pour un appareil physique, il faudra utiliser l'adresse IP locale de l'ordinateur sur le même réseau.

## 🗺️ Roadmap

Les prochaines améliorations prévues :


- [ ] Marquer une tâche comme terminée
- [ ] Améliorer la gestion des erreurs
- [ ] Ajouter le hachage sécurisé des mots de passe
- [ ] Mettre en place une authentification JWT
- [ ] Renforcer la protection des données des utilisateurs
- [ ] Ajouter des tests automatisés
- [ ] Améliorer l'interface utilisateur

## 🎯 Objectif du projet

Apprendre à développer une application complète en comprenant :

- Le fonctionnement d'un backend Python.
- La création et l'utilisation d'une API REST.
- La gestion d'une base de données SQLite.
- La communication entre Flutter et FastAPI.
- Les bases de l'architecture d'une application Full Stack.

## 👨‍💻 Auteur

Projet personnel réalisé dans le cadre de mon apprentissage de Python, FastAPI et Flutter.

**Ce projet est avant tout un projet d'apprentissage et sera amélioré progressivement.**