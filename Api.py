
import requests
import json

class Api:
    def __init__(self, api_key):
        # self.api_key = api_key
        self.api_key = "97f136f5a8004dc382ca"
        self.serviceId = "C003"
        self.dataType = "json"
        self.startIdx = "1"
        self.endIdx = "999"
        self.api_url = ""

        self.setUrl()

    def setUrl(self):
        self.api_url = f"http://openapi.foodsafetykorea.go.kr/api/{self.api_key}/{self.serviceId}/{self.dataType}/{self.startIdx}/{self.endIdx}"

    def getData(self):
        return requests.get(self.api_url).json()

    def toStringJson(self, data):
        return json.dumps(data, indent=4, ensure_ascii=False)

    def toJsonObject(self, stringJson):
        return json.loads(stringJson)

    def getJsonObject(self):
        sJson = self.toStringJson(self.getData())
        return self.toJsonObject(sJson)[self.serviceId]['row']

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

                self.excute_C003(db)
                print(f"{start_} ~ {end_} 완료")

                start_ = end_ + 1
                end_ = start_ + l

        elif service_id == "I0030":
            self.serviceId = service_id
            self.setUrl()

            for i in range(count):
                self.startIdx = str(start_)
                self.endIdx = str(end_)
                self.setUrl()

                self.excute_I0030(db)
                print(f"{start_} ~ {end_} 완료")

                start_ = end_ + 1
                end_ = start_ + l

        else:
            raise Exception("잘못된 api 서비스 아이디 입니다.")


    def excute_C003(self, db):
        rows = self.getJsonObject()
        for row in rows:
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


    def excute_I0030(self, db):
        rows = self.getJsonObject()
        for row in rows:
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