# 🎙️ Voice Notes App (Flutter & Python Flask Backend)

A full-stack mobile application built with **Flutter** for the mobile user interface and **Python (Flask + SQLite)** for the backend REST API and media storage.

---

## 🛠️ Prerequisites

Ensure you have the following installed on your development system:

* **Flutter SDK:** Version 3.0.0 or higher
* **Python:** Version 3.8 or higher
* **Android Studio:** With Android Virtual Device (AVD) Emulator configured

---

## 🚀 1. Backend Setup (Python Flask + SQLite)

1. Open your terminal and navigate to the `backend` folder:
   ```bash
   cd backend


1.Install the required Python libraries:


    pip install Flask flask-cors
    
2.Start the Flask backend server:

    python app.py

📌 Note: The backend runs on http://127.0.0.1:5000 (or http://10.0.2.2:5000 from Android Emulator). It automatically creates the SQLite database (voice_notes.db) and the uploads directory.

📱 2. Frontend Setup (Flutter)
Open a new terminal in the project root directory and install dependencies:

1.Bash:
    flutter pub get
(Ensure dependencies in pubspec.yaml include record, audioplayers, path_provider, and http).

2.Verify system permissions in android/app/src/main/AndroidManifest.xml:

    <manifest xmlns:android="[http://schemas.android.com/apk/res/android](http://schemas.android.com/apk/res/android)">
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.INTERNET" />
    ...
</manifest>


3.Launch the Flutter application:

Bash
flutter run


🎙️ 3. Android Emulator Microphone Configuration (Audio Fix)
If audio is recorded and uploaded successfully, but no sound plays back during audio reproduction:

On the Android Emulator side control bar, click the three dots (...) to open Extended Controls.

Select the Microphone tab from the left side menu.

Toggle "Enable Host Microphone Access" to ON.

Check the box for "Virtual microphone attached".

Use the Emulator's physical Volume Up button to ensure the Media Volume is turned up.

Delete any silent recordings previously created and record a new voice note.

⚙️ 4. API Endpoints ReferenceMethodEndpointDescriptionGET/notesFetch all recorded voice notes metadataPOST/uploadUpload audio file with title and durationGET/audio/<filename>Stream/download an audio fileDELETE/notes/<id>Delete a voice note entry and associated file💡 TroubleshootingConnection Error: Make sure baseUrl in Flutter is set to http://10.0.2.2:5000 when running inside the Android Emulator.Recording Permission Failed: Verify that microphone access is permitted in your Android device/emulator settings.


