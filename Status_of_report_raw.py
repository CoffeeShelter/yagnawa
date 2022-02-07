from db_manager import DB

import requests
import json

class Api:
    def __inif__(self, api_key):
        # self.api_key = api_key
        self.api_key = "97f136f5a8004dc382ca"
        self.serviceID = "C003"
        self.dataType = "json"
        self.startIdx = "1"
        self.endIdx = "999"
        self.api_url = ""

        self.setUrl()

    def setUrl(self):
        self.api_url = f"http://openapi.foodsafetykorea.go.kr/api/{self.api_key}/{self.serviceId}/{self.dataType}/{self.startIdx}/{self.endIdx}"

    def getData(self):
        return requests.get(self.api_url)

    def toStringJson(self, data):
        return json.dumps(data, indent=4, ensure_ascii=False)

    def toJsonObject(self, stringJson):
        return json.loads(stringJson)

    def getJsonObject(self):
        sJson = self.toJsonObject(self.getData())
        return self.toJsonObject(sJson)[self.serviceID]['row']

    """
    1 999
    1000 1999
    2000 2999


    1 3
    4 7
    8 11
    """

    def excute(self, db, service_id, start=1, end=999, count=1):
        start_ = start
        end_ = end
        l = end_ - start_ + 1

        if service_id == "C003":
            for i in range(count):
                self.startIdx = str(start_)
                self.endIdx = str(end_)
                self.setUrl()

                # self.excute_C003(db)

                start_ = end_ + 1
                end_ = start_ + l

                print(f"{start_} ~ {end_}")


        elif service_id == "I0030":
            self.excute_I0030()

    def excute_C003(self, db):
        rows = self.getJsonObject()
        for row in rows:
            LCNS_NO	= row['LCNS_NO']
            BSSH_NM	= row['BSSH_NM']
            PRDLST_REPORT_NO = row['PRDLST_REPORT_NO']
            PRDLST_NM = row['PRDLST_NM']
            PRMS_DT = row['PRMS_DT']
            POG_DAYCNT = row['POG_DAYCNT']
            DISPOS = row['DISPOS']
            NTK_MTHD = row['NTK_MTHD']
            PRIMARY_FNCLTY = row['PRIMARY_FNCLTY']
            IFTKN_ATNT_MATR_CN = row['IFTKN_ATNT_MATR_CN']
            CSTDY_MTHD = row['CSTDY_MTHD']
            SHAP = row['SHAP']
            STDR_STND = row['STDR_STND']
            RAWMTRL_NM = row['RAWMTRL_NM']
            CRET_DTM = row['CRET_DTM']
            LAST_UPDT_DTM = row['LAST_UPDT_DTM']
            PRDT_SHAP_CD_NM = row['PRDT_SHAP_CD_NM']

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



    def excute_I0030(self):
        pass