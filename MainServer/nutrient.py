import pymysql
import pandas as pd

class Nutrient:
    def __init__(self, user='root', password='1234', host='localhost', db='nutrient', charset='utf-8'):
        self.nutrient_db = None

        # 데이터베이스 연결 설정 값
        self.user = user
        self.password = password
        self.host = host
        self.db = db
        self.charset = charset

        # 데이터베이스와 상호작용을 위한 객체
        self.cursor = None

    def connectDatabase(self):
        self.nutrient_db = pymysql.connect(
            user=self.user,
            passwd=self.password,
            host=self.host,
            db=self.db,
            # charset=self.charset
        )

    def createCursor(self, cursor=pymysql.cursors.DictCursor):
        self.cursor = self.nutrient_db.cursor(cursor)

    def getProductsInfo(self, product_name):
        sql = f"SELECT * FROM sor WHERE PRDLST_NM like '%{product_name}%'"

        if(self.cursor != None):
            print(f'[sql]: {sql}')
            self.cursor.execute(sql)
        else:
            print('cursor를 생성하십시오.')
            return None
        
        result = self.cursor.fetchall()
        return result

    def getProductInfo(self, product_id):
        sql = f"SELECT * FROM sor WHERE PRDLST_REPORT_NO = '{product_id}'"

        if(self.cursor != None):
            print(f'[sql]: {sql}')
            self.cursor.execute(sql)
        else:
            print('cursor를 생성하십시오.')
            return None
        
        result = self.cursor.fetchone()
        return result
