import sqlite3

connect= sqlite3.connect("todo.db")

cursor = connect.cursor()

cursor.execute("PRAGMA foreign_keys = ON;")

cursor.execute(""" 
CREATE TABLE IF NOT EXISTS users(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    mail TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL
);
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS tasks  (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    date_ecrit TEXT NOT NULL DEFAULT (date('now')),
    status BOOLEAN NOT NULL DEFAULT 0,

    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)  ON DELETE CASCADE
);""")


connect.commit()
connect.close()