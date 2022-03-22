
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


def log_user(email, password):
    # Defining variables before try-except block
    login_token = None
    success = False
    conn, cursor = connect_db()
    try:
        # SELECT query for gabbing data from user table and compare email and password values
        cursor.execute(
            "select id, f_name, l_name, email, phone from user where email = ? and password = ?", [email, password])
        # If this combo exists, using fetchone() to store the result in a variable
        user = cursor.fetchone()
        # In case the query is successful, we create a login_token and INSERT it into user_session table for storing this data. user_id is taken from user[0]
        if(user):
            login_token = create_login_token()
            cursor.execute("insert into user_session(login_token, user_id) values(?, ?)", [
                login_token, user[0]])
            # Saving changes
            conn.commit()
            success = True
    except db.OperationalError:
        print("Something is wrong with the DB, please try again in 5 minutes")
    except db.ProgrammingError:
        print("Error running DB query, please file bug report")
    except:
        print("Something went wrong!")
    disconnect_db(conn, cursor)
    return login_token, success, user


def logout_user(login_token):
    success = False
    conn, cursor = connect_db()
    try:
        # To log out, we need to delete login_token from user_session table and we return do data on successful delete
        cursor.execute(
            "delete from user_session where login_token = ?", [login_token])
        conn.commit()
        if(cursor.rowcount == 1):
            success = True
    except db.OperationalError:
        print("Something is wrong with the DB, please try again in 5 minutes")
    except db.ProgrammingError:
        print("Error running DB query, please file bug report")
    except:
        print("Something went wrong!")
    disconnect_db(conn, cursor)
    return success


def get_all_items():
    # Defining variables before try-except block
    items = []
    conn, cursor = connect_db()
    try:
        # Using SELECT statement to retrieve the users that follow the profile with that user_id
        cursor.execute(
            "select id, name, price, image_url from item")
        # Saving data using fetchall()
        items = cursor.fetchall()
    except db.OperationalError:
        print("Something is wrong with the DB, please try again in 5 minutes")
    except db.ProgrammingError:
        print("Error running DB query, please file bug report")
    except:
        print("Something went wrong!")
    disconnect_db(conn, cursor)
    return items


def get_cart_items(login_token):
    # Defining variables before try-except block
    user = None
    user_id = None
    cart_items = []
    conn, cursor = connect_db()
    try:
        # SELECT request to pull down login_token from the db
        cursor.execute(
            "select user_id from user_session where login_token = ?", [login_token])
        # Saving this row with fetchone()
        user = cursor.fetchone()
        # Assigning the correct position of user_id in the row 'user'
        user_id = user[0]
        cursor.execute(
            "select i.id, name, price, image_url, quantity from item i inner join cart_item ci on i.id = ci.item_id inner join cart c on c.id = ci.cart_id where c.user_id = ?", [user_id])
        cart_items = cursor.fetchall()
    except db.OperationalError:
        print("Something is wrong with the DB, please try again in 5 minutes")
    except db.ProgrammingError:
        print("Error running DB query, please file bug report")
    except:
        print("Something went wrong!")
    disconnect_db(conn, cursor)
    return cart_items


def place_order(login_token):  # Function and its arguments
    # We need to assign a new variable before try-except block if we're going to use it inside the block
    success = False
    user = None
    user_id = None
    item_id = None
    cart_items = []
    order = []
    conn, cursor = connect_db()
    try:
        # INSERT request with the inputs in []
        cursor.execute(
            "select user_id from user_session where login_token = ?", [login_token])
        # Saving this row with fetchone()
        user = cursor.fetchone()
        # Assigning the correct position of user_id in the row 'user'
        user_id = user[0]
        # The following condition checks if the insert happens
        # if(cursor.rowcount == 1):
        cursor.execute(
            "select i.id, name, price, image_url, quantity from item i inner join cart_item ci on i.id = ci.item_id inner join cart c on c.id = ci.cart_id where c.user_id = ?", [user_id])
        cart_items = cursor.fetchall()
        item_id = cart_items[0][0]
        # Another INSERT into user_session table
        cursor.execute("insert into purchase(item_id, user_id) values(?, ?)", [
            item_id, user_id])
        # Saving changes
        conn.commit()
        if(cursor.rowcount == 1):
            # In case sql queries are successful, new_user is set to True and returned to API
            success = True
            order = True
        # In case of various errors this will be returned
    except db.OperationalError:
        print("Something is wrong with the DB, please try again in 5 minutes")
    except db.ProgrammingError:
        print("Error running DB query, please file bug report")
    except:
        print("Something went wrong!")
    disconnect_db(conn, cursor)
    # Returning variables from the function
    return success, order


def get_all_bags():
    # Defining variables before try-except block
    bags = []
    conn, cursor = connect_db()
    try:
        # Using SELECT statement to retrieve the users that follow the profile with that user_id
        cursor.execute(
            "select id, name, price, image_url from item where category_id = 1")
        # Saving data using fetchall()
        bags = cursor.fetchall()
    except db.OperationalError:
        print("Something is wrong with the DB, please try again in 5 minutes")
    except db.ProgrammingError:
        print("Error running DB query, please file bug report")
    except:
        print("Something went wrong!")
    disconnect_db(conn, cursor)
    return bags
