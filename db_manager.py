import pymysql

class DB:
    def __init__(self):
        self.db = pymysql.connect(
            user= 'root',
            passwd= '1234',
            host= 'localhost',
            db= 'nutrient',
            charset= 'utf8'
        )
        self.cursor = self.db.cursor(pymysql.cursors.DictCursor)

    def execute(self, sql, commit=False):
        self.cursor.execute(sql)

        if commit == True:
            self.db.commit()
            return None

        else:
            result = self.cursor.fetchall()
            return result