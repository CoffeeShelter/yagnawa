import pymysql
import pandas as pd

class DBHelper:
    def __init__(self):
        self.host = "localhost"
        self.user = "root"
        self.password = "1234"
        self.db = "nutrient"
        self.charset = 'utf-8'

    def __connect__(self):
        self.con = pymysql.connect(host=self.host, user=self.user, password=self.password, db=self.db, cursorclass=pymysql.cursors.
                                   DictCursor)
        self.cur = self.con.cursor()

    def __disconnect__(self):
        self.con.close()

    def fetchAll(self, sql):
        self.__connect__()
        self.cur.execute(sql)
        result = self.cur.fetchall()
        self.__disconnect__()
        return result

    def fetchOne(self, sql):
        self.__connect__()
        self.cur.execute(sql)
        result = self.cur.fetchone()
        self.__disconnect__()
        return result

    def execute(self, sql):
        self.__connect__()
        self.cur.execute(sql)
        self.__disconnect__()

class Nutrient(DBHelper):
    def __init__(self):
        super().__init__()

    def getProductsInfo(self, product_name):
        sql = f"SELECT * FROM sor WHERE PRDLST_NM like '%{product_name}%'"

        return self.fetchAll(sql)

    def getProductInfo(self, product_id):
        sql = f"SELECT * FROM sor WHERE PRDLST_REPORT_NO = '{product_id}'"

        return self.fetchOne(sql)

    def getRecoProducts(self, content):
        sql = f"SELECT * FROM SOR WHERE STDR_STND LIKE '%{content}%' LIMIT 5;"

        return self.fetchAll(sql)
