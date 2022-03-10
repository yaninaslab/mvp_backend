
import mariadb as db
import dbcreds
import secrets

# Adding salt(extra characters to the password in db)


def create_salt():
    return secrets.token_urlsafe(10)

# Creating login_token for every user session


def create_login_token():
    return secrets.token_urlsafe(50)

# Connecting to db


def connect_db():
    conn = None
    cursor = None
    try:
        conn = db.connect(user=dbcreds.user, password=dbcreds.password,
                          host=dbcreds.host, port=dbcreds.port, database=dbcreds.database)
        cursor = conn.cursor()
    except db.OperationalError:
        print("Something is wrong with the DB, please try again in 5 minutes")
    except:
        print("Something went wrong!")
    return conn, cursor

# Disconnecting from db


def disconnect_db(conn, cursor):
    try:
        cursor.close()
    except:
        print("The issue with cursor")
    try:
        conn.close()
    except:
        print("The issue with connection")


def signup_user(
        f_name, l_name, email, password, phone):  # Function and its arguments
    # We need to assign a new variable before try-except block if we're going to use it inside the block
    new_user = None
    conn, cursor = connect_db()
    try:
        # Creating salt and adding it to the column in the db
        salt = create_salt()
        # INSERT request with the inputs in []
        cursor.execute(
            "insert into user(f_name, l_name, email, password, phone, salt) values(?, ?, ?, ?, ?, ?)", [f_name, l_name, email, password, phone, salt])
        conn.commit()
        # The following condition checks if the insert happens
        if(cursor.rowcount == 1):
            # In case the query goes well, login_token is created
            login_token = create_login_token()
            # Assigning value to user_id with lastrowid attribute after the insert took place
            user_id = cursor.lastrowid
            # Another INSERT into user_session table
            cursor.execute("insert into user_session(login_token, user_id) values(?, ?)", [
                           login_token, user_id])
            # Saving changes
            conn.commit()
            # In case sql queries are successful, new_user is set to True and returned to API
            new_user = True
            # In case of various errors this will be returned
    except db.OperationalError:
        print("Something is wrong with the DB, please try again in 5 minutes")
    except db.ProgrammingError:
        print("Error running DB query, please file bug report")
    except:
        print("Something went wrong!")
    disconnect_db(conn, cursor)
    # Returning variables from the function
    return new_user, login_token, user_id


def update_user(login_token,
                f_name, l_name, email, password, phone):  # Function and its arguments
    # Defining variables before try-except block
    success = None
    user = None
    user_id = None
    conn, cursor = connect_db()
    try:
        # SELECT request to pull down login_token from the db
        cursor.execute(
            "select user_id from user_session where login_token = ?", [login_token])
        # Saving this row with fetchone()
        user = cursor.fetchone()
        # Assigning the correct position of user_id in the row 'user'
        user_id = user[0]
        # UPDATE request that's going to edit values
        cursor.execute(
            "update user set f_name = ?, l_name = ?, email = ?, password = ?, phone = ? where id = ?", [f_name, l_name, email, password, phone, user_id])
        # Saving changes
        conn.commit()
        # The following condition checks if the query happens
        if(cursor.rowcount == 1):
            # SELECT query selects the necessary values and returns them as response from db
            cursor.execute(
                "select id, f_name, l_name, email, phone from user where id = ?", [user_id])
            # Collecting this data with fetchone()
            user = cursor.fetchone()
            # If the previous line was successful, success is turned to True
            success = True
    except db.OperationalError:
        print("Something is wrong with the DB, please try again in 5 minutes")
    except db.ProgrammingError:
        print("Error running DB query, please file bug report")
    except:
        print("Something went wrong!")
    disconnect_db(conn, cursor)
    # Returning variables from the function
    return success, user, user_id


def delete_user(user_id):
    # Assigning a variable to return in the end
    success = None
    conn, cursor = connect_db()
    try:
        # DELETE query based on user_id
        cursor.execute(
            "delete from user where id = ?", [user_id])
        # Saving changes
        conn.commit()
        # The following condition checks if the query happens
        if(cursor.rowcount == 1):
            # In case it does, success is changed to True
            success = True
    except db.OperationalError:
        print("Something is wrong with the DB, please try again in 5 minutes")
    except db.ProgrammingError:
        print("Error running DB query, please file bug report")
    except:
        print("Something went wrong!")
    disconnect_db(conn, cursor)
    return success
