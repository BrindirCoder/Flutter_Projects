from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector

app = Flask(__name__)
CORS(app)

def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",          # بەکارهێنەری MySQL (دیفۆڵت: root)
        password="",          # پاسۆردی MySQL (ئەگەر پاسۆردت نییە بە بەتاڵی جێی بهێڵە)
        database="flutter_db"
    )

# 1. دروستکردنی ئەکاونت (Register)
@app.route('/register', methods=['POST'])
def register():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    if not username or not password:
        return jsonify({"message": "تکایە هەموو خانەکان پڕبکەرەوە"}), 400

    try:
        db = get_db_connection()
        cursor = db.cursor()
        cursor.execute("INSERT INTO users (username, password) VALUES (%s, %s)", (username, password))
        db.commit()
        cursor.close()
        db.close()
        return jsonify({"message": "ئەکاونت بە سەرکەوتوویی دروستکرا"}), 201
    except mysql.connector.Error:
        return jsonify({"message": "ئەم ناوی بەکارهێنەرە پێشتر تۆمارکراوە"}), 400

# 2. چوونەژوورەوە (Login)
@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users WHERE username = %s AND password = %s", (username, password))
    user = cursor.fetchone()
    cursor.close()
    db.close()

    if user:
        return jsonify({"message": "چوونەژوورەوە سەرکەوتوو بوو", "user": {"id": user['id'], "username": user['username']}}), 200
    return jsonify({"message": "ناوی بەکارهێنەر یان پاسۆرد هەڵەیە"}), 401

# 3. هێنانی داتاکان (Read)
@app.route('/items', methods=['GET'])
def get_items():
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM items ORDER BY id DESC")
    items = cursor.fetchall()
    cursor.close()
    db.close()
    return jsonify(items)

# 4. زیادکردنی داتای نوێ (Create)
@app.route('/items', methods=['POST'])
def add_item():
    data = request.json
    title = data.get('title')
    if not title:
        return jsonify({"message": "تێکست بەتاڵە"}), 400

    db = get_db_connection()
    cursor = db.cursor()
    cursor.execute("INSERT INTO items (title) VALUES (%s)", (title,))
    db.commit()
    cursor.close()
    db.close()
    return jsonify({"message": "داتاکە زیادکرا"}), 201

# 5. دەستکاریکردنی داتا (Update)
@app.route('/items/<int:item_id>', methods=['PUT'])
def update_item(item_id):
    data = request.json
    title = data.get('title')

    db = get_db_connection()
    cursor = db.cursor()
    cursor.execute("UPDATE items SET title = %s WHERE id = %s", (title, item_id))
    db.commit()
    cursor.close()
    db.close()
    return jsonify({"message": "داتاکە نوێکرایەوە"})

# 6. سڕینەوەی داتا (Delete)
@app.route('/items/<int:item_id>', methods=['DELETE'])
def delete_item(item_id):
    db = get_db_connection()
    cursor = db.cursor()
    cursor.execute("DELETE FROM items WHERE id = %s", (item_id,))
    db.commit()
    cursor.close()
    db.close()
    return jsonify({"message": "سڕدرایەوە"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)