package com.server.data.products;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class ProductDAO {
	private static SqlSessionFactory sqlMapper = null;

	private static SqlSessionFactory getInstance() {
		if (sqlMapper == null) {
			try {
				String resource = "com/server/mybatis/SqlMapConfig.xml";
				Reader reader = Resources.getResourceAsReader(resource);
				sqlMapper = new SqlSessionFactoryBuilder().build(reader);
				reader.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return sqlMapper;
	}

	// 전체 상품 정보 조회
	public List<ProductVO> selectAllProductList() {
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		
		List<ProductVO> productList = null;
		productList = session.selectList("mapper.product.selectAllProduct");
		
		return productList;
	}
	
	public List<ProductVO> selectProduct(Map<String, Object> productMap){		
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();

		List<ProductVO> productList = null;
		productList = session.selectList("mapper.product.selectProduct", productMap);

		return productList;
	}
}
