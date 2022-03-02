package com.server.data.healthfoodfunc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

public class HealthFoodFuncTest {

	public static void main(String[] args) {
		HealthFoodFuncDAO hffDAO = new HealthFoodFuncDAO();
		List<HealthFoodFuncVO> list = new ArrayList<HealthFoodFuncVO>();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("PRDLST_CD", "1004");
		map.put("PC_KOR_NM", "비타민d");
		map.put("TESTITM_CD", "777");

		// list = productDAO.selectProduct(map);
		int reulst = hffDAO.insertHff(map);

		list = hffDAO.selectAllHff();
		Vector<HealthFoodFuncVO> vector = new Vector<HealthFoodFuncVO>(list);
		
		for (HealthFoodFuncVO v : vector) {
			System.out.println(v.toString());
		}
	}

}
