package com.server.data.products;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import com.server.data.util.StringProcessing;

public class Test_Product {

	public static void main(String[] args) {
		ProductDAO productDAO = new ProductDAO();
		List<ProductVO> list = new ArrayList<ProductVO>();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prdlst_report_no", "200400200022578");

		// list = productDAO.selectProduct(map);
		list = productDAO.selectAllProductList();

		Vector<ProductVO> vector = new Vector<ProductVO>(list);

		StringProcessing processing = new StringProcessing();
		// (\d*)(\.|,*)(\d+)(\s*)(mg|ug)
		
		int count = 0;
		int temp = 2;
		for(ProductVO v : vector) {
			if (count == temp) {
			
				System.out.println("[제품명]");
				System.out.println(v.getPrdlst_nm() + "\n");
				
				System.out.println("[업소명]");
				System.out.println(v.getBssh_nm() + "\n");
			
				System.out.println("[기능성]");
				System.out.println(v.getPrimary_fnclty() + "\n");
				
				System.out.println("[기능성 원재료]");
				System.out.println(v.getIndiv_rawmtrl_nm() + "\n");
				
				System.out.println("[함량정보]");
				String stnd = v.getStdr_stnd();
				System.out.println(stnd);

				/*
				Pattern pattern = Pattern.compile("(\\d*)(\\.|,*)(\\d+)(\\s*)(mg|ug)");
				Matcher matcher = pattern.matcher(stnd);

				while(matcher.find()){
				  System.out.println(matcher.group());
				}
				*/
				processing.setTargetString(stnd);
				processing.getContent();
				
			
			}
			if (count > temp) {
				break;
			}
		
			count += 1;
		}
	}
	// 성상, 실리
}
