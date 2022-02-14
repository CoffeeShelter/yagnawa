package com.server.data.products;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

public class Test_Product {

	public static void main(String[] args) {

		ProductDAO productDAO = new ProductDAO();
		List<ProductVO> list = new ArrayList<ProductVO>();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prdlst_report_no", "200400200022578");
		
		list = productDAO.selectProduct(map);

		Vector<ProductVO> vector = new Vector<ProductVO>(list);

		for (ProductVO product : vector) {
			String stdr = product.getStdr_stnd();
			String[] sp = stdr.split("\n");

			for (String s : sp) {
				if(!check(s)) {
					System.out.println(s);
				}
			}

			break;
		}
	}

	private static boolean check(String s) {
		String[] checkWords = { "성상", "대장균군", "세균수" };
		
		for (String checkWord : checkWords) {
			if(s.contains(checkWord)) {
				return true;
			}
		}

		return false;
	}

}
