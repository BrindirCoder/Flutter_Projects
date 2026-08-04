# Fullstack Flutter App with Flask & MySQL

A full-stack mobile application built with **Flutter** (Frontend), **Python Flask** (Backend REST API), and **MySQL** (Database). Features include User Authentication (Login/Register), Full CRUD Operations, Dark/Light Mode Theme support, and Settings screen.

---

## 🚀 Features

- 🔐 **User Authentication:** Account Registration & Login system.
- 📝 **CRUD Operations:** Create, Read, Update, and Delete notes/items stored in MySQL.
- 🌙 **Dark & Light Mode:** Seamless dynamic theme switching using Flutter State Management.
- ⚡ **RESTful API Backend:** Fast and scalable Python Flask server.

---

## 🛠️ Prerequisites

Make sure you have the following installed on your machine:
1. [Flutter SDK](https://docs.flutter.dev/get-started/install)
2. [Python 3.x](https://www.python.org/downloads/)
3. [XAMPP](https://www.apachefriends.org/index.html) (for MySQL Server)

---

## 💻 Step-by-Step Installation & Setup

### 1. Database Setup (MySQL)
1. Launch **XAMPP Control Panel** and start **MySQL Module**.
2. Open **phpMyAdmin** in your browser (`http://localhost/phpmyadmin`).
3. Click on the **SQL** tab and run the following script:

```sql
CREATE DATABASE IF NOT EXISTS flutter_db;
USE flutter_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);



2. Backend Setup (Flask Server)
Open your terminal and navigate to the backend folder:

Bash
cd backend
Install the required Python packages:

Bash
python -m pip install -r requirements.txt
Run the Flask API server:

Bash
python app.py
The server will run on http://0.0.0.0:5000.

3. Frontend Setup (Flutter)
Open a new terminal window at the project root folder.

Fetch dependencies:

Bash
flutter pub get
Run the Flutter application:

Bash
flutter run
Note for Android Emulator: The base URL is configured as http://10.0.2.2:5000 to connect to localhost. If running on Windows desktop or Web, update baseUrl in lib/main.dart to http://127.0.0.1:5000.