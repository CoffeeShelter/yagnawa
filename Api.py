
from tkinter import E
import requests
import json

import time

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
            row = jsonObj[self.serviceId]['row']
            return row

        except Exception as e:
            f = open(f"errorFiles/{self.startIdx}_{self.endIdx}_json_{self.index}.json", "w")
            json.dump(jsonObj, f, indent=4, ensure_ascii=False)
            f.close()

            name = e.__class__.__name__
            msg = f"[{name}] : {e}\n"

            log = open("log.txt", "a")
            log.write(msg)
            log.close()

            self.index += 1

            return None

    def excute(self, db, service_id, start=1, end=999, count=1):
        self.serviceId = service_id
        self.setUrl()

        start_ = start
        end_ = end
        l = end_ - start_ + 1

        if service_id == "C003":
            for i in range(count):
                self.startIdx = str(start_)
                self.endIdx = str(end_)
                self.setUrl()
                
                start_time = time.time()
                self.excute_I0030(db)

                self.excute_C003(db)
                
                end_time = time.time()
                result_time = end_time - start_time

                print(f"{start_} ~ {end_} 완료 [걸린시간:  {result_time}]")

                start_ = end_ + 1
                end_ = start_ + l

        elif service_id == "I0030":
            self.serviceId = service_id
            self.setUrl()

            for i in range(count):
                self.startIdx = str(start_)
                self.endIdx = str(end_)
                self.setUrl()

                start_time = time.time()
                self.excute_I0030(db)

                end_time = time.time()
                result_time = end_time - start_time

                print(f"{start_} ~ {end_} 완료 [걸린시간:  {result_time}]")

                start_ = end_ + 1
                end_ = start_ + l

        else:
            raise Exception("잘못된 api 서비스 아이디 입니다.")


    def excute_C003(self, db):
        rows = self.getJsonObject()
        if rows is None:
            return

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
            except Exception as e:
                f = open(f"sorr/{self.startIdx}_{self.endIdx}_{PRDLST_REPORT_NO}.json", "w")
                json.dump(row, f, indent=4, ensure_ascii=False)
                f.close()

                name = e.__class__.__name__
                msg = f"[{name}] : {e}\n"

                log = open("sorr_log.txt", "a")
                log.write(msg)
                log.close()

                print(msg)


    def excute_I0030(self, db):
        rows = self.getJsonObject()
        if rows is None:
            return

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
                # SHAP = row['SHAP'].replace("'", "''")
                STDR_STND = row['STDR_STND'].replace("'", "''")
                RAWMTRL_NM = row['RAWMTRL_NM'].replace("'", "''")
                # CRET_DTM = row['CRET_DTM'].replace("'", "''")
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
            except Exception as e:
                f = open(f"sor/{self.startIdx}_{self.endIdx}_{PRDLST_REPORT_NO}.json", "w")
                json.dump(row, f, indent=4, ensure_ascii=False)
                f.close()

                name = e.__class__.__name__
                msg = f"[{name}] : {e}\n"

                log = open("sor_log.txt", "a")
                log.write(msg)
                log.close()

                print(msg)