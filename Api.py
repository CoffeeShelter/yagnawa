
from msilib.schema import CreateFolder
from sqlite3 import dbapi2
from tkinter import E
import requests
import json

import time

import os

class Api:
    def __init__(self, api_key):
        # self.api_key = api_key
        self.api_key = "97f136f5a8004dc382ca"
        self.serviceId = "C003"
        self.dataType = "json"
        self.startIdx = "1"
        self.endIdx = "999"
        self.api_url = ""

        self.index = 1

        self.running = False

        self.I0030 = None
        self.C003 = None

        self.setUrl()

    def setUrl(self):
        self.api_url = f"http://openapi.foodsafetykorea.go.kr/api/{self.api_key}/{self.serviceId}/{self.dataType}/{self.startIdx}/{self.endIdx}"

    def getData(self):
        # print(self.api_url)
        return requests.get(self.api_url).json()

    def toStringJson(self, data):
        return json.dumps(data, indent=4, ensure_ascii=False)

    def toJsonObject(self, stringJson):
        return json.loads(stringJson)

    def getJsonObject(self):
        sJson = self.toStringJson(self.getData())
        jsonObj = self.toJsonObject(sJson)

        try:
            result = jsonObj[self.serviceId]['RESULT']

            if result['CODE'] == "INFO-000":
                return jsonObj[self.serviceId]['row']
                
            else:
                self.running = False
                print(result['MSG'])
                return None

        except Exception as e:
            f = open(f"errorFiles/{self.startIdx}_{self.endIdx}_json_{self.index}.json", "w" ,encoding='utf-8')
            json.dump(jsonObj, f, indent=4, ensure_ascii=False)
            f.close()

            name = e.__class__.__name__
            msg = f"[{name}] : {e}\n"

            log = open("log.txt", "a" ,encoding='utf-8')
            log.write(msg)
            log.close()

            self.index += 1

            return None

    def excute(self, db, service_id, start=1, end=999, count=1):
        self.running = True
        self.serviceId = service_id
        self.setUrl()

        start_ = start
        end_ = end
        l = end_ - start_ + 1

        if service_id == "C003":
            if self.C003 is None:
                self.C003 = C003(self.api_key)

            for i in range(count):
                self.startIdx = str(start_)
                self.endIdx = str(end_)
                self.setUrl()
                
                self.C003.setUrl(startIdx=self.startIdx, endIdx=self.endIdx)

                print(f"[C003] {start_} ~ {end_} 시작")

                start_time = time.time()
                result = self.C003.execute(db=db)
                
                end_time = time.time()
                result_time = end_time - start_time

                print(f"{start_} ~ {end_} 완료 [걸린시간:  {result_time}]")

                start_ = end_ + 1
                end_ = start_ + l

                if result == False:
                    print("[데이터 수집 종료]")
                    break

        elif service_id == "I0030":
            if self.I0030 is None:
                self.I0030 = I0030(self.api_key)

            for i in range(count):
                self.startIdx = str(start_)
                self.endIdx = str(end_)
                
                self.I0030.setUrl(startIdx=self.startIdx, endIdx=self.endIdx)
                
                print(f"[I0030] {start_} ~ {end_} 시작")

                start_time = time.time()
                result = self.I0030.execute(db=db)

                end_time = time.time()
                result_time = end_time - start_time

                print(f"{start_} ~ {end_} 완료 [걸린시간:  {result_time}]")

                start_ = end_ + 1
                end_ = start_ + l

                if result == False:
                    print("[데이터 수집 종료]")
                    break

        else:
            raise Exception("잘못된 api 서비스 아이디 입니다.")

class ApiManager():
    def __init__(self):
        self.BASEURL_ = "http://openapi.foodsafetykorea.go.kr/api/"
        self.api_url = self.BASEURL_

    # api 요청 주소 세팅
    def setUrl(self):
        pass
    
    # api 결과 받아오기
    def getData(self):
       return requests.get(self.api_url).json()

    # api 결과 문자열 타입의 json으로 변환
    def toStringJson(self, data):
        return json.dumps(data, indent=4, ensure_ascii=False)
    
    # 문자열 타입의 json을 딕셔너리로 변환
    def toJsonObject(self, stringJson):
        return json.loads(stringJson)

    # api 결과 코드
    def getResultCode(self, jsonObj, serviceId):
        return jsonObj[serviceId]['RESULT']['CODE']
    
    # api 결과 메세지
    def getResultMsg(self, jsonObj, serviceId):
        return jsonObj[serviceId]['RESULT']['MSG']

    # api 결과 row(값) 들 반환
    def getResultRow(self, jsonObj, serviceId):
        return jsonObj[serviceId]['row']

    # api 결과 row(값) 개수
    def getResultTotalCount(self, jsonObj, serviceId):
        return jsonObj[serviceId]['total_count']

    def createFolder(self, path):
        try:
            if not os.path.exists(path):
                os.makedirs(path)
        except Exception as e:
            print (f"[{e.__class__.__name__}] : {e}")

class I0030(ApiManager):
    def __init__(self, api_key):
        super().__init__()
        self.ERRORFOLDER_ = os.getcwd()+f"\\sor"
        self.SERVICEID_ = "I0030"

        self.startIdx = 0
        self.endIdx = 0

        self.__api_key = api_key
        self.index = 1

        self.running = True

        self.createFolder(self.ERRORFOLDER_)

    def setUrl(self, dataType="json", startIdx=0, endIdx=0):
        self.startIdx = startIdx
        self.endIdx = endIdx
        self.api_url = self.BASEURL_ + f"{self.__api_key}/{self.SERVICEID_}/{dataType}/{startIdx}/{endIdx}"  

    def getJsonObject(self):
        sJson = self.toStringJson(self.getData())
        jsonObj = self.toJsonObject(sJson)

        try:
            if self.getResultCode(jsonObj, self.SERVICEID_) == "INFO-000":
                return self.getResultRow(jsonObj, self.SERVICEID_)
                
            else:
                self.running = False
                print(self.getResultMsg(jsonObj,self.SERVICEID_))
                return None

        except Exception as e:
            f = open(f"{self.ERRORFOLDER_}/{self.startIdx}_{self.endIdx}_json_{self.index}.json", "w" ,encoding='utf-8')
            json.dump(jsonObj, f, indent=4, ensure_ascii=False)
            f.close()

            name = e.__class__.__name__
            msg = f"{self.startIdx}~{self.endIdx}\n[{name}] : {e}\n\n"

            log = open("sor_log.txt", "a" ,encoding='utf-8')
            log.write(msg)
            log.close()

            self.index += 1

            return None

    
    def execute(self, db):
        rows = self.getJsonObject()
        if rows is None:
            return False

        count = 0
        for row in rows:
            try:
                LCNS_NO	= row['LCNS_NO'].replace("'", "''")
                BSSH_NM	= row['BSSH_NM'].replace("'", "''")
                PRDLST_REPORT_NO = row['PRDLST_REPORT_NO'].replace("'", "''")
                PRDLST_NM = row['PRDLST_NM'].replace("'", "''")
                PRMS_DT = row['PRMS_DT'].replace("'", "''")
                POG_DAYCNT = row['POG_DAYCNT'].replace("'", "''")
                DISPOS = row['DISPOS'].replace("'", "''")
                NTK_MTHD = row['NTK_MTHD'].replace("'", "''")
                PRIMARY_FNCLTY = row['PRIMARY_FNCLTY'].replace("'", "''")
                IFTKN_ATNT_MATR_CN = row['IFTKN_ATNT_MATR_CN'].replace("'", "''")
                CSTDY_MTHD = row['CSTDY_MTHD'].replace("'", "''")
                STDR_STND = row['STDR_STND'].replace("'", "''")
                RAWMTRL_NM = row['RAWMTRL_NM'].replace("'", "''")
                LAST_UPDT_DTM = row['LAST_UPDT_DTM'].replace("'", "''")
                PRDT_SHAP_CD_NM = row['PRDT_SHAP_CD_NM'].replace("'", "''")
                CHILD_CRTFC_YN = row['CHILD_CRTFC_YN'].replace("'", "''")
                ETC_RAWMTRL_NM = row['ETC_RAWMTRL_NM'].replace("'", "''")
                PRDLST_CDNM = row['PRDLST_CDNM'].replace("'", "''")
                INDUTY_CD_NM = row['INDUTY_CD_NM'].replace("'", "''")
                FRMLC_MTRQLT = row['FRMLC_MTRQLT'].replace("'", "''")
                INDIV_RAWMTRL_NM = row['INDIV_RAWMTRL_NM'].replace("'", "''")
                HIENG_LNTRT_DVS_NM = row['HIENG_LNTRT_DVS_NM'].replace("'", "''")
                PRODUCTION = row['PRODUCTION'].replace("'", "''")
                CAP_RAWMTRL_NM = row['CAP_RAWMTRL_NM'].replace("'", "''")


                sql = f"INSERT INTO sor (\
                            LCNS_NO,\
                            BSSH_NM,\
                            PRDLST_REPORT_NO,\
                            PRDLST_NM,\
                            PRMS_DT,\
                            POG_DAYCNT,\
                            DISPOS,\
                            NTK_MTHD,\
                            PRIMARY_FNCLTY,\
                            IFTKN_ATNT_MATR_CN,\
                            CSTDY_MTHD,\
                            STDR_STND,\
                            RAWMTRL_NM,\
                            LAST_UPDT_DTM,\
                            PRDT_SHAP_CD_NM,\
                            CHILD_CRTFC_YN,\
                            ETC_RAWMTRL_NM,\
                            PRDLST_CDNM,\
                            INDUTY_CD_NM,\
                            FRMLC_MTRQLT,\
                            INDIV_RAWMTRL_NM,\
                            HIENG_LNTRT_DVS_NM,\
                            PRODUCTION,\
                            CAP_RAWMTRL_NM\
                        ) SELECT\
                            '{LCNS_NO}',\
                            '{BSSH_NM}',\
                            '{PRDLST_REPORT_NO}',\
                            '{PRDLST_NM}',\
                            '{PRMS_DT}',\
                            '{POG_DAYCNT}',\
                            '{DISPOS}',\
                            '{NTK_MTHD}',\
                            '{PRIMARY_FNCLTY}',\
                            '{IFTKN_ATNT_MATR_CN}',\
                            '{CSTDY_MTHD}',\
                            '{STDR_STND}',\
                            '{RAWMTRL_NM}',\
                            '{LAST_UPDT_DTM}',\
                            '{PRDT_SHAP_CD_NM}',\
                            '{CHILD_CRTFC_YN}',\
                            '{ETC_RAWMTRL_NM}',\
                            '{PRDLST_CDNM}',\
                            '{INDUTY_CD_NM}',\
                            '{FRMLC_MTRQLT}',\
                            '{INDIV_RAWMTRL_NM}',\
                            '{HIENG_LNTRT_DVS_NM}',\
                            '{PRODUCTION}',\
                            '{CAP_RAWMTRL_NM}'\
                        FROM DUAL\
                        WHERE NOT EXISTS (\
                            SELECT *\
                            FROM sor\
                            WHERE PRDLST_REPORT_NO = '{PRDLST_REPORT_NO}'\
                        )"

                db.execute(sql, commit=True)
                count += 1

            except Exception as e:
                index = int(self.startIdx) + count
                f = open(f"{self.ERRORFOLDER_}/{str(index)}_{PRDLST_REPORT_NO}.json", "w" ,encoding='utf-8')
                json.dump(row, f, indent=4, ensure_ascii=False)
                f.close()

                name = e.__class__.__name__
                msg = f"[{name}] : {e}\n"

                log = open(os.getcwd() + "/sor_log.txt", "a" ,encoding='utf-8')
                log.write(msg)
                log.close()

                print(msg)

        return True

class C003(ApiManager):
    def __init__(self, api_key):
        super().__init__()
        self.ERRORFOLDER_ = os.getcwd()+f"\\sorr"
        self.SERVICEID_ = "C003"

        self.startIdx = 0
        self.endIdx = 0

        self.__api_key = api_key
        self.index = 1

        self.running = True

        self.createFolder(self.ERRORFOLDER_)

    def setUrl(self, dataType="json", startIdx=0, endIdx=0):
        self.startIdx = startIdx
        self.endIdx = endIdx
        self.api_url = self.BASEURL_ + f"{self.__api_key}/{self.SERVICEID_}/{dataType}/{startIdx}/{endIdx}"  

    def getJsonObject(self):
        sJson = self.toStringJson(self.getData())
        jsonObj = self.toJsonObject(sJson)

        try:
            if self.getResultCode(jsonObj, self.SERVICEID_) == "INFO-000":
                return self.getResultRow(jsonObj, self.SERVICEID_)
                
            else:
                self.running = False
                print(self.getResultMsg(jsonObj,self.SERVICEID_))
                return None

        except Exception as e:
            f = open(f"{self.ERRORFOLDER_}/{self.startIdx}_{self.endIdx}_json_{self.index}.json", "w" ,encoding='utf-8')
            json.dump(jsonObj, f, indent=4, ensure_ascii=False)
            f.close()

            name = e.__class__.__name__
            msg = f"{self.startIdx}~{self.endIdx}\n[{name}] : {e}\n\n"

            log = open(os.getcwd() + "/sorr_log.txt", "a", encoding='utf-8')
            log.write(msg)
            log.close()

            self.index += 1

            return None

    
    def execute(self, db):
        rows = self.getJsonObject()
        if rows is None:
            return False

        count = 0
        for row in rows:
            try:
                LCNS_NO	= row['LCNS_NO'].replace("'", "''")
                BSSH_NM	= row['BSSH_NM'].replace("'", "''")
                PRDLST_REPORT_NO = row['PRDLST_REPORT_NO'].replace("'", "''")
                PRDLST_NM = row['PRDLST_NM'].replace("'", "''")
                PRMS_DT = row['PRMS_DT'].replace("'", "''")
                POG_DAYCNT = row['POG_DAYCNT'].replace("'", "''")
                DISPOS = row['DISPOS'].replace("'", "''")
                NTK_MTHD = row['NTK_MTHD'].replace("'", "''")
                PRIMARY_FNCLTY = row['PRIMARY_FNCLTY'].replace("'", "''")
                IFTKN_ATNT_MATR_CN = row['IFTKN_ATNT_MATR_CN'].replace("'", "''")
                CSTDY_MTHD = row['CSTDY_MTHD'].replace("'", "''")
                SHAP = row['SHAP'].replace("'", "''")
                STDR_STND = row['STDR_STND'].replace("'", "''")
                RAWMTRL_NM = row['RAWMTRL_NM'].replace("'", "''")
                CRET_DTM = row['CRET_DTM'].replace("'", "''")
                LAST_UPDT_DTM = row['LAST_UPDT_DTM'].replace("'", "''")
                PRDT_SHAP_CD_NM = row['PRDT_SHAP_CD_NM'].replace("'", "''")
                sql = f"INSERT INTO sorr (\
                            LCNS_NO,\
                            BSSH_NM,\
                            PRDLST_REPORT_NO,\
                            PRDLST_NM,\
                            PRMS_DT,\
                            POG_DAYCNT,\
                            DISPOS,\
                            NTK_MTHD,\
                            PRIMARY_FNCLTY,\
                            IFTKN_ATNT_MATR_CN,\
                            CSTDY_MTHD,\
                            SHAP,\
                            STDR_STND,\
                            RAWMTRL_NM,\
                            CRET_DTM,\
                            LAST_UPDT_DTM,\
                            PRDT_SHAP_CD_NM\
                        ) SELECT\
                            '{LCNS_NO}',\
                            '{BSSH_NM}',\
                            '{PRDLST_REPORT_NO}',\
                            '{PRDLST_NM}',\
                            '{PRMS_DT}',\
                            '{POG_DAYCNT}',\
                            '{DISPOS}',\
                            '{NTK_MTHD}',\
                            '{PRIMARY_FNCLTY}',\
                            '{IFTKN_ATNT_MATR_CN}',\
                            '{CSTDY_MTHD}',\
                            '{SHAP}',\
                            '{STDR_STND}',\
                            '{RAWMTRL_NM}',\
                            '{CRET_DTM}',\
                            '{LAST_UPDT_DTM}',\
                            '{PRDT_SHAP_CD_NM}'\
                        FROM DUAL\
                        WHERE NOT EXISTS (\
                            SELECT *\
                            FROM sorr\
                            WHERE PRDLST_REPORT_NO = '{PRDLST_REPORT_NO}'\
                        )"

                db.execute(sql, commit=True)
                count += 1

            except Exception as e:
                index = int(self.startIdx) + count
                f = open(f"{self.ERRORFOLDER_}/{str(index)}_{PRDLST_REPORT_NO}.json", "w", encoding='utf-8')
                json.dump(row, f, indent=4, ensure_ascii=False)
                f.close()

                name = e.__class__.__name__
                msg = f"[{name}] : {e}\n"
                
                log = open(os.getcwd() + "/sorr_log.txt", "a", encoding='utf-8')
                log.write(msg)
                log.close()
                print(msg)

        return True