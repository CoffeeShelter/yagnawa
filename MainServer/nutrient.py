import pymysql
import pandas as pd


class Nutrient:
    cursor = None
    nutrient_db = None

    def __init__(self, user='root', password='1234', host='localhost', db='nutrient', charset='utf-8'):
        # 데이터베이스 연결 설정 값
        self.user = user
        self.password = password
        self.host = host
        self.db = db
        self.charset = charset

        # 데이터베이스와 상호작용을 위한 객체

    def connectDatabase(self):
        if Nutrient.nutrient_db is None:
            Nutrient.nutrient_db = pymysql.connect(
                user=self.user,
                passwd=self.password,
                host=self.host,
                db=self.db,
                # charset=self.charset
            )

    def createCursor(self, cursor=pymysql.cursors.DictCursor):
        if Nutrient.cursor is None:
            Nutrient.cursor = Nutrient.nutrient_db.cursor(cursor)

    def getProductsInfo(self, product_name):
        sql = f"SELECT * FROM sor WHERE PRDLST_NM like '%{product_name}%'"

        if(Nutrient.cursor != None):
            print(f'[sql]: {sql}')
            Nutrient.cursor.execute(sql)
        else:
            print('cursor를 생성하십시오.')
            return None

        result = Nutrient.cursor.fetchall()
        return result

    def getProductInfo(self, product_id):
        sql = f"SELECT * FROM sor WHERE PRDLST_REPORT_NO = '{product_id}'"

        if(Nutrient.cursor != None):
            print(f'[sql]: {sql}')
            Nutrient.cursor.execute(sql)
        else:
            print('cursor를 생성하십시오.')
            return None

        result = Nutrient.cursor.fetchone()
        return result

    def getRecoProducts(self, content):
        sql = f"SELECT * FROM SOR WHERE STDR_STND LIKE '%{content}%';"

        if(Nutrient.cursor != None):
            print(f'[sql]: {sql}')
            Nutrient.cursor.execute(sql)
        else:
            print('cursor를 생성하십시오.')
            return None

        result = Nutrient.cursor.fetchone()
        return result
