package com.server.data.healthfoodfunc;

import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class HealthFoodFunc_BuildDB {
	private static final String BASE_URL = "http://openapi.foodsafetykorea.go.kr/api";
	private static final String KEY_ID = "97f136f5a8004dc382ca";
	private static final String SERVICE_ID = "I0960";
	private static final String DATA_TYPE = "json";

	public static void run() throws IOException, ParseException {
		// String api_url = BASE_URL + "/" + KEY_ID + "/" + SERVICE_ID + "/" + DATA_TYPE +"/1/999";
		String base_api_url = BASE_URL + "/" + KEY_ID + "/" + SERVICE_ID + "/" + DATA_TYPE;

		int startIdx = 1;
		int endIdx = 999;

		FileWriter fw = new FileWriter("errorLog.txt");

		for (int count = 0; count < 1000; count++) {
			String sIdx = Integer.toString(startIdx);
			String eIdx = Integer.toString(endIdx);

			String api_url = base_api_url + "/" + sIdx + "/" + eIdx;

			System.out.println("[요청중] : " + api_url);

			URL url = new URL(api_url);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			conn.setDoOutput(true);

			String jsonData = "";
			try {
				StringBuffer sb = new StringBuffer();
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
				while (br.ready()) {
					sb.append(br.readLine());
				}

				jsonData = sb.toString();
			} catch (Exception e) {
				e.printStackTrace();
			}

			System.out.println("데이터 수집 완료!");

			JSONObject objData = (JSONObject) new JSONParser().parse(jsonData);
			objData = (JSONObject) objData.get(SERVICE_ID);

			JSONObject resultData = (JSONObject) objData.get("RESULT");
			String resultCode = (String) resultData.get("CODE");
			if (resultCode.equals("INFO-000") == false) {
				String resultMessage = (String) resultData.get("MSG");
				System.out.println(resultMessage);
				break;
			}

			JSONArray arrData = (JSONArray) objData.get("row");
			int arrDataSize = arrData.size();
			System.out.println("별견된 데이터 : " + arrDataSize + "개");

			JSONObject tmp;
			HealthFoodFuncDAO hffDAO = new HealthFoodFuncDAO();

			System.out.println("DB구축 시작!");

			List<HealthFoodFuncVO> hffList = new ArrayList<HealthFoodFuncVO>();
			Map<String, Object> map = new HashMap<String, Object>();
			for (int i = 0; i < arrDataSize; i++) {
				HealthFoodFuncVO hff = new HealthFoodFuncVO();
				tmp = (JSONObject) arrData.get(i);
				
				hff.setPrdlst_cd((String) tmp.get("PRDLST_CD"));
				hff.setPc_kor_nm((String) tmp.get("PC_KOR_NM"));
				hff.setTestitm_cd((String) tmp.get("TESTITM_CD"));
				hff.setT_kor_nm((String) tmp.get("T_KOR_NM"));
				hff.setFnprt_itm_nm((String) tmp.get("FNPRT_ITM_NM"));
				hff.setSpec_val((String) tmp.get("SPEC_VAL"));
				hff.setSpec_val_sumup((String) tmp.get("SPEC_VAL_SUMUP"));
				hff.setVald_begn_dt((String) tmp.get("VALD_BEGN_DT"));
				hff.setVald_end_dt((String) tmp.get("VALD_END_DT"));
				hff.setSorc((String) tmp.get("SORC"));
				hff.setMxmm_val((String) tmp.get("MXMM_VAL"));
				hff.setNimm_val((String) tmp.get("NIMM_VAL"));
				hff.setInjry_yn((String) tmp.get("INJRY_YN"));
				hff.setUnit_nm((String) tmp.get("UNIT_NM"));
				
				hffList.add(hff);
			}
			
			map.put("list", hffList);
			
			try {
				hffDAO.insertHff(map);
				System.out.println(startIdx + " ~ " + endIdx + " 완료");
			} catch (Exception e) {
				String msg = e.getMessage() + "\r\n";
				System.out.println("[ " + startIdx + " ~ " + endIdx + "]\n" + msg);
				fw.write(msg);
			}

			startIdx = endIdx + 1;
			endIdx = endIdx + 1000;
		}

		if (fw != null) {
			fw.close();
		}

		System.out.println("끝!!!");

	}

	public static void main(String args[]){
		try {
			run();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	
}

/*
	map.put("PRDLST_CD", (String) tmp.get("PRDLST_CD"));
	map.put("PC_KOR_NM", (String) tmp.get("PC_KOR_NM"));
	map.put("TESTITM_CD", (String) tmp.get("TESTITM_CD"));
	map.put("T_KOR_NM", (String) tmp.get("T_KOR_NM"));
	map.put("FNPRT_ITM_NM", (String) tmp.get("FNPRT_ITM_NM"));
	map.put("SPEC_VAL", (String) tmp.get("SPEC_VAL"));
	map.put("SPEC_VAL_SUMUP", (String) tmp.get("SPEC_VAL_SUMUP"));
	map.put("VALD_BEGN_DT", (String) tmp.get("VALD_BEGN_DT"));
	map.put("VALD_END_DT", (String) tmp.get("VALD_END_DT"));
	map.put("SORC", (String) tmp.get("SORC"));
	map.put("MXMM_VAL", (String) tmp.get("MXMM_VAL"));
	map.put("NIMM_VAL", (String) tmp.get("NIMM_VAL"));
	map.put("INJRY_YN", (String) tmp.get("INJRY_YN"));
	map.put("UNIT_NM", (String) tmp.get("UNIT_NM")); 
*/
