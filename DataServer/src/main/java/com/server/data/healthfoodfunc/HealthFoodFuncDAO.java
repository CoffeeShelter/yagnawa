package com.server.data.healthfoodfunc;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class HealthFoodFuncDAO {
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
	public List<HealthFoodFuncVO> selectAllHff() {
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		
		List<HealthFoodFuncVO> hffList = null;
		hffList = session.selectList("mapper.hff.selectAllHff");
		
		return hffList;
	}
	
	public List<HealthFoodFuncVO> selectHff(Map<String, Object> hffMap){		
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();

		List<HealthFoodFuncVO> hffList = null;
		hffList = session.selectList("mapper.hff.selectHff", hffMap);

		return hffList;
	}
	
	public int insertHff(Map<String, Object> hffMap){		
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();

		int result = session.insert("mapper.hff.insertHff", hffMap);
		session.commit();

		return result;
	}
}
