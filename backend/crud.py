import sqlite3

# Gestion des utilisateurs

def create_user(username,mail,password):
    connecti = sqlite3.connect("todo.db")
    cursor = connecti.cursor()

    cursor.execute("""
    INSERT INTO users (username,mail,password)
    VALUES (?,?,?)
    """,(username,mail,password))

    connecti.commit()
    connecti.close()


def get_user_by_mail(mail):
    connecti = sqlite3.connect("todo.db")
    cursor = connecti.cursor()

    cursor.execute("""
        SELECT *
        FROM users
        WHERE mail = ?
    """, (mail,))

    user = cursor.fetchone()

    connecti.close()

    return user


def delete_user(mail):
    connecti = sqlite3.connect("todo.db")
    cursor = connecti.cursor()

    cursor.execute(""" 
    DELETE FROM users 
    where mail = ?
    """ , (mail,))

    connecti.commit()
    connecti.close()

# Gestion des tâches

def create_task(user_id, title, description, status):
    connecti = sqlite3.connect("todo.db")
    cursor = connecti.cursor()

    cursor.execute("""
        INSERT INTO tasks (user_id, title, description, status)
        VALUES (?, ?, ?, ?)
    """, (user_id, title, description, status))

    connecti.commit()
    connecti.close()


def get_tasks(user_id):
    connecti = sqlite3.connect("todo.db")
    cursor = connecti.cursor()

    cursor.execute("""
        SELECT *
        FROM tasks
        WHERE user_id = ?
    """, (user_id,))

    tasks = cursor.fetchall()

    connecti.close()

    return tasks


def update_task(task_id, title, description, status):
    connecti = sqlite3.connect("todo.db")
    cursor = connecti.cursor()

    cursor.execute("""
        UPDATE tasks
        SET title = ?, description = ?, status = ?
        WHERE id = ?
    """, (title, description, status, task_id))

    connecti.commit()
    connecti.close()


def delete_task(task_id):
    connecti = sqlite3.connect("todo.db")
    cursor = connecti.cursor()


    cursor.execute("""
        DELETE FROM tasks
        WHERE id = ?
    """, (task_id,))

    connecti.commit()
    connecti.close()
