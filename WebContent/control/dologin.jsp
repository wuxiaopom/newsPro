<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.yc.dao.DBHelper" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录处理页面</title>
</head>
<body>
<%--小脚本--%>

<%      
        if(session.getAttribute("loginUser") == null){
			request.setCharacterEncoding("utf-8");
			String username = request.getParameter("uname");
			String password = request.getParameter("upwd");
			DBHelper db = new DBHelper();
			String sql = "SELECT 1 FROM ADMIN a WHERE a.aname = '"+username +"' AND a.pwd = '"+password+"'";
			if(db.findSingleObject(sql, null)!=null  && db.findSingleObject(sql, null).size()>0){
				session.setAttribute("loginUser", username);
				response.sendRedirect("../admin.jsp");
			}else{
				response.sendRedirect("../index.jsp");
			}
        }else{
        	session.removeAttribute("loginUser");
        	response.sendRedirect("../index.jsp");
        }
		
%>


</body>
</html>