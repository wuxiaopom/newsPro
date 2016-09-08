package com.yc.dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 * @ClassName:     DBHelper.java
 * @Description:   
 * @author          POM
 * @version         V1.0  
 * @Date           2016年9月7日 上午9:25:21 
 */
public class DBHelper {
	private static DataSource dataSource;

	static{
		try {
			Context context = new  InitialContext();
			// 获取与逻辑名相关联的数据源对象
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/jspJNDI");  //java:comp/env/为前缀
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	/**
	 *获取数据连接 
	 */
	public static Connection getConn(){
		Connection con = null;
		if (dataSource != null){
			try {
				con = dataSource.getConnection();   
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		}
		return con;
	}

	/**
	 *关闭连接 
	 */
	public static void closeAll(ResultSet rs,Statement stmt,Connection conn ){
		if(null!=rs){
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(null!=stmt){
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(null!=conn){
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
   
	
	public static int doUpdate(String sql,List<Object> params) {
		Connection conn =null;
		PreparedStatement pstmt =null;
		int result =-1;
		
		try {
			conn=getConn();
			pstmt=conn.prepareStatement(sql);
			setParams(pstmt, params);
			result =pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeAll(null, pstmt, conn);
		}
		return result;
	}

	public static int updateImg(String sql,int id ,File file) throws FileNotFoundException{
		FileInputStream in = new FileInputStream(file);
		Connection conn = null;
		PreparedStatement pstmt =null;
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setBinaryStream(1, in,(int)file.length());
			pstmt.setInt(2, id);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			
		} finally {
			closeAll(null, pstmt, conn);
		}
		
		return result;
	}
	
	
	public static List<Map<String , Object>> findMultiObject(String sql,List<Object> params) throws SQLException{
		List<Map<String , Object>> list =new ArrayList<Map<String ,Object>>();
		Connection conn =null;
		PreparedStatement pstmt =null;
		ResultSet rs =null;
		Map<String, Object> map =null;
		try {
			conn =getConn();
			pstmt =conn.prepareStatement(sql);
			setParams(pstmt, params);
			rs =pstmt.executeQuery();
			List<String > columnNames =getAllColumnNames(rs);
			while(rs.next()){
				map = new HashMap<String,Object>();
				for(String cn:columnNames){
					map.put(cn, rs.getObject(cn));
				}
				list.add(map);
			}
		} finally {
			closeAll(rs, pstmt, conn);
		}
		
		return list;
	}
	
	public static Map<String,Object> findSingleObject(String sql,List<Object> params) throws SQLException{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Map<String,Object> map = null;
		try {
			conn = getConn();
			pstmt = conn.prepareStatement(sql);
			setParams(pstmt, params);
			rs = pstmt.executeQuery();
			List<String> columnNames = getAllColumnNames(rs); 
			while(rs.next()){
				map = new HashMap<String,Object>();
				for(String cn: columnNames){	
					map.put(cn, rs.getObject(cn));
				}
			}
		}finally{
			closeAll(rs, pstmt, conn);
		}
		return map;
	}
	
	private static List<String> getAllColumnNames(ResultSet rs ) throws SQLException{
		List<String> columnNames =new ArrayList<String>();
		if(null !=rs){
			for(int i=0 ;i<rs.getMetaData().getColumnCount();i++){
				columnNames.add(rs.getMetaData().getColumnName(i+1));
			}
		}
		return columnNames;
	}
	
	/**
	 * @param pstmt
	 * @param params
	 * @throws SQLException 
	 */
	private static void setParams(PreparedStatement pstmt, List<Object> params) throws SQLException {
		if(null!=params&&params.size()>0){
			for(int i=0;i<params.size();i++){
				pstmt.setString(i+1, params.get(i).toString());//params瀛樺偍鍊肩殑椤哄簭涓�?鐨勯『搴忎竴鏍�
			}
		}
	}

}
