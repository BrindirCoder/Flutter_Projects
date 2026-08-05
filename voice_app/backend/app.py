from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
import sqlite3
import os
from datetime import datetime

app = Flask(__name__)
CORS(app)

# فۆڵدەرێک بۆ خەزنکردنی فایلی دەنگەکان
UPLOAD_FOLDER = 'uploads'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# دروستکردن یان بەستنەوە بە داتابەیسی SQLite (پێویستی بە XAMPP نییە)
DB_NAME = 'voice_notes.db'

def init_db():
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS audio_notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            filename TEXT NOT NULL,
            duration TEXT NOT NULL,
            created_at TEXT NOT NULL
        )
    ''')
    conn.commit()
    conn.close()

# بانگهێشتکردنی دروستکردنی تەیبڵەکە لەگەڵ دەستپێکردنی بەکئێند
init_db()

def get_db_connection():
    conn = sqlite3.connect(DB_NAME)
    conn.row_factory = sqlite3.Row
    return conn

# --- 1. هێنانی هەموو دەنگەکان (Get All Audio Notes) ---
@app.route('/notes', methods=['GET'])
def get_notes():
    conn = get_db_connection()
    notes = conn.execute('SELECT * FROM audio_notes ORDER BY id DESC').fetchall()
    conn.close()
    return jsonify([dict(note) for note in notes])

# --- 2. ئاپڵۆدکردنی دەنگی نوێ (Upload Audio File & Save Info) ---
@app.route('/upload', methods=['POST'])
def upload_audio():
    if 'file' not in request.files:
        return jsonify({"message": "هیچ فایلێک نەنێردراوە"}), 400

    file = request.files['file']
    title = request.form.get('title', 'دەنگی بێ‌ناو')
    duration = request.form.get('duration', '00:00')

    if file.filename == '':
        return jsonify({"message": "ناوی فایلەکە بەتاڵە"}), 400

    # دروستکردنی ناوێکی ناوازە بۆ فایلی دەنگەکە
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"audio_{timestamp}.m4a"
    filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    file.save(filepath)

    created_at = datetime.now().strftime("%Y-%m-%d %H:%M")

    # خەزنکردن لە داتابەیسی SQLite
    conn = get_db_connection()
    conn.execute(
        'INSERT INTO audio_notes (title, filename, duration, created_at) VALUES (?, ?, ?, ?)',
        (title, filename, duration, created_at)
    )
    conn.commit()
    conn.close()

    return jsonify({"message": "دەنگەکە بە سەرکەوتوویی خەزنکرا"}), 201

# --- 3. ڕەوانەکردنی فایلی دەنگ بۆ لێدانەوە لە ئەپدا (Play Audio) ---
@app.route('/audio/<filename>', methods=['GET'])
def get_audio_file(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename)

# --- 4. سڕینەوەی دەنگ (Delete Audio Note) ---
@app.route('/notes/<int:note_id>', methods=['DELETE'])
def delete_note(note_id):
    conn = get_db_connection()
    note = conn.execute('SELECT filename FROM audio_notes WHERE id = ?', (note_id,)).fetchone()

    if note:
        # سڕینەوەی فایلەکە لە سەر کۆمپیوتەر
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], note['filename'])
        if os.path.exists(filepath):
            os.remove(filepath)

        # سڕینەوە لە داتابەیس
        conn.execute('DELETE FROM audio_notes WHERE id = ?', (note_id,))
        conn.commit()
        conn.close()
        return jsonify({"message": "دەنگەکە سڕدرایەوە"})
    
    conn.close()
    return jsonify({"message": "دەنگەکە نەدۆزرایەوە"}), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)