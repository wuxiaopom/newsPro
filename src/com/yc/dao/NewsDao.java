package com.yc.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * @ClassName:     NewsDao.java
 * @author          POM
 * @version         V1.0  
 * @Date           2016年9月7日 上午11:05:35 
 */

public class NewsDao {

	public List<Map<String , Object>>  findAllNews(int pageNum,int pageSize){
		DBHelper  db = new DBHelper();
		String sql ="";
		if(pageNum == 0){
			sql = "SELECT * FROM news";
		}else{
			sql = "SELECT * FROM (SELECT ROWNUM RN, T.* FROM "
					+ " (SELECT * FROM NEWS) T "
					+ " WHERE ROWNUM <= "+pageNum*pageSize+") TT  WHERE TT.RN > "+(pageNum-1)*pageSize;
		}
		List<Map<String , Object>> list =new ArrayList<Map<String ,Object>>();
		try {
			list = db.findMultiObject(sql, null);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Map<String ,Object>> findNewsByType(String type) throws SQLException{
		List<Map<String , Object>> list =new ArrayList<Map<String ,Object>>();
		DBHelper  db = new DBHelper();
		String sql ="SELECT T.TNAME, N.* FROM NEWS N JOIN TOPIC T ON N.NTID = T.TID";
		if( type.equals("10001")){   //国内新闻
			sql = sql + " WHERE T.TID = 10001";
		}
		list  = db.findMultiObject(sql, null);
		return list;
	}
	
}
