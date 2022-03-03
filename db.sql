CREATE DATABASE IF NOT EXISTS NUTRIENT;

USE NUTRIENT;

DROP TABLE IF EXISTS SOR;
DROP TABLE IF EXISTS SORR;
DROP TABLE IF EXISTS HEALTHFOODFUNC;

# 건강기능식품 품목제조 신고사항 현황
CREATE TABLE IF NOT EXISTS SOR (
	PRDLST_REPORT_NO VARCHAR(50),	# 품목제조번호
	PRMS_DT VARCHAR(50),	# 허가 일자
	PRDT_SHAP_CD_NM VARCHAR(50),	# 품목제조번호
	LAST_UPDT_DTM VARCHAR(100),	# 최종수정일자
	LCNS_NO VARCHAR(50),	# 인허가번호
	PRDLST_NM VARCHAR(200),	# 품목 명
	IFTKN_ATNT_MATR_CN TEXT,	# 섭취시주의사항
	BSSH_NM VARCHAR(500),	# 업소 명
	CHILD_CRTFC_YN VARCHAR(500),	# 어린이기호식품품질인증여부
	ETC_RAWMTRL_NM TEXT,	# 기타 원재료
	STDR_STND TEXT,	# 기준규격
	PRDLST_CDNM VARCHAR(500),	# 유형
	INDUTY_CD_NM VARCHAR(500),	# 업종
	DISPOS VARCHAR(500),	# 성상
	PRIMARY_FNCLTY TEXT,	# 주된기능성
	FRMLC_MTRQLT TEXT,	# 포장재질
	POG_DAYCNT VARCHAR(200),	# 유통기한 일수
	CSTDY_MTHD VARCHAR(500),	# 보관방법
	INDIV_RAWMTRL_NM TEXT,	# 기능성 원재료
	NTK_MTHD VARCHAR(500),	# 섭취방법
	HIENG_LNTRT_DVS_NM VARCHAR(200),	# 고열량저영양여부
	RAWMTRL_NM TEXT,	# 품목유형(기능지표성분)
	PRODUCTION VARCHAR(200),	# 생산종료여부
	CAP_RAWMTRL_NM TEXT	# 캡슐 원재료
) CHARSET=utf8 COLLATE=utf8_general_ci;

# 건강기능식품 품목제조신고(원재료)
CREATE TABLE IF NOT EXISTS SORR (
	LCNS_NO	VARCHAR(50),	# 인허가번호
	BSSH_NM	VARCHAR(50),	# 업소명
	PRDLST_REPORT_NO VARCHAR(50),	# 픔목제조번호
	PRDLST_NM VARCHAR(500),	# 품목명
	PRMS_DT VARCHAR(500),	# 보고일자
	POG_DAYCNT VARCHAR(500),	# 유통기한
	DISPOS VARCHAR(500),	# 성상
	NTK_MTHD VARCHAR(500),	# 섭취방법
	PRIMARY_FNCLTY TEXT,	# 주된기능성
	IFTKN_ATNT_MATR_CN TEXT,	# 섭취시주의사항
	CSTDY_MTHD VARCHAR(500),	# 보관방법
	SHAP VARCHAR(500),	# 형태
	STDR_STND TEXT,		# 기준규격
	RAWMTRL_NM TEXT,	# 원재료
	CRET_DTM VARCHAR(500),	# 최초생성일시
	LAST_UPDT_DTM VARCHAR(500),	# 최종수정일시
	PRDT_SHAP_CD_NM VARCHAR(500)	# 제품형태
) CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

# 건강기능식품공전
CREATE TABLE IF NOT EXISTS HEALTHFOODFUNC (
	PRDLST_CD VARCHAR(20) NOT NULL, # 품목코드
    PC_KOR_NM VARCHAR(200) NOT NULL, # 품목한글명
    TESTITM_CD VARCHAR(20) NOT NULL, # 시험항목코드
    T_KOR_NM VARCHAR(200),	# 시험항목 한글명
    FNPRT_ITM_NM VARCHAR(20),	# 세부항목명
    SPEC_VAL VARCHAR(20),	# 기준규격 값
    SPEC_VAL_SUMUP VARCHAR(500),	# 기준규격값 요약
    VALD_BEGN_DT VARCHAR(20),	# 유효개시일자
    VALD_END_DT VARCHAR(20),	# 유효종료일자
    SORC VARCHAR(200),	# 출처
    MXMM_VAL VARCHAR(20),	# 최대값
    NIMM_VAL VARCHAR(20),	# 최소값
    INJRY_YN VARCHAR(20),	# 위해여부
    UNIT_NM VARCHAR(20)	# 단위명
    # PRIMARY KEY(PRDLST_CD, PC_KOR_NM, TESTITM_CD, T_KOR_NM, SPEC_VAL, SPEC_VAL_SUMUP)
) CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SHOW TABLES;
desc HEALTHFOODFUNC;

select * from healthFoodFunc;
select * from HEALTHFOODFUNC where not replace(pc_kor_nm, ' ', '') like concat('%', replace(t_kor_nm, ' ', ''), '%');
select * 
from HEALTHFOODFUNC 
where (
	select count(t_kor_nm)
    from HEALTHFOODFUNC
) > 2500;
select * from HEALTHFOODFUNC where PC_KOR_NM like '%프로바이오틱스%';

alter table HEALTHFOODFUNC modify SORC VARCHAR(200);

alter table sor convert to character set utf8 collate utf8_general_ci;

select rawmtrl_nm, stdr_stnd from sor;

select prdlst_report_no, stdr_stnd from sor where not STDR_STND like "%:%";
select stdr_stnd from sor where STDR_STND like "%비타민 C%";
select * from sor where PRDLST_NM like "%밀크씨슬 헬퍼%";
select count(*) from sorr;
select * from sorr where STDR_STND like "%0.45mg%";

desc sor;