<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.yc.dao.*,com.yc.bean.NewsBean" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新闻首页</title>
<link href="CSS/main.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%
	NewsDao nd = new NewsDao();
%>
<div id="header">
  <div id="top_login">
    <form action="control/dologin.jsp" method="post">
	    <label> 登录名 </label>
	    <input type="text" id="uname" name="uname" value="" class="login_input" />
	    <label> 密&#160;&#160;码 </label>
	    <input type="password" id="upwd" name="upwd" value="" class="login_input" />
	    <input type="submit" class="login_sub" value="登录" />
	    <label id="error"> </label>
    </form>
    <img src="Images/friend_logo.gif" alt="Google" id="friend_logo" /> 
  </div>
   
  <div id="nav">
    <div id="logo"> <img src="Images/logo.jpg" alt="新闻中国" /> </div>
    <div id="a_b01"> <img src="Images/a_b01.gif" alt="" /> </div>
    <!--mainnav end-->
  </div>
</div>
<div id="container">
  <div class="sidebar">
    <h1> <img src="Images/title_1.gif" alt="国内新闻" /> </h1>
    <div class="side_list">
       <ul>	
    	<% 
    	  List<Map<String , Object>> clist = nd.findNewsByType("10001");
    	   if(clist != null && clist.size()>0 ){
    		   for(int i = 0;i <= 5;i++){%>
    			  <li>&nbsp;&nbsp;&nbsp;<a href=''><%=clist.get(i).get("NTITLE") %>  </a></li>
    		 <%  }
    	 }%>
       </ul>
    </div>
    <h1> <img src="Images/title_2.gif" alt="国际新闻" /> </h1>
    <div class="side_list">
     
    </div>
    <h1> <img src="Images/title_3.gif" alt="娱乐新闻" /> </h1>
    <div class="side_list">
      
    </div>
  </div>
  <div class="main">
    <div class="class_type"> <img src="Images/class_type.gif" alt="新闻中心" /> </div>
    <div class="content">
      <ul class="class_date">
        <li id='class_month'>
        <%
           DBHelper db = new DBHelper();
           String sql = "select * from topic";
           List<Map<String , Object>> list =new ArrayList<Map<String ,Object>>();
           list =  db.findMultiObject(sql, null);
           for(int i = 0; i<list.size();i++){%>
        	 <a href='#'><b><%=list.get(i).get("TNAME") %> </b> </a> 
        <% }
        %>
      </ul>
      <ul class="classlist">
        <%
          String pageNum = request.getParameter("pageNum"); 
	      List<Map<String , Object>> nList = nd.findAllNews(0, 0);
	      int totalPage = 0 ;    //总页数
	      int pageSize = 5;     //一页多少条
	      if(nList != null  && nList.size()>0){
	      	int len = nList.size();    //总长度
	        if(len%pageSize == 0){
	         	 totalPage =  len/pageSize;
	           }else{
	         	  totalPage = len/pageSize+1;
	           }
	      }
          if(pageNum ==null || pageNum.equals("")){
        	  pageNum = "1";
          }
          int number = Integer.parseInt(pageNum);
          if(number == 0 ){
        	  number++;
          }
          if(number >= totalPage){
        	  number = totalPage;
          }
          List<Map<String , Object>> newsList = nd.findAllNews(number, pageSize);
          
          for(int i=0;i<newsList.size();i++){%>
        	 <li><a href='newspages/news_add.html'><%=newsList.get(i).get("NCONTENT") %>  </a><span><%=newsList.get(i).get("NCREATEDATE")%></span></li>
          <%   if((i+1)%5==0){  %>
	          		<li class='space'></li>
	          <%}
             }
        %>
      </ul>
       <p align="right"> 当前页数:[<%=number %>/<%=totalPage%>]&nbsp;  <a href="index.jsp?pageNum=1">首页</a> 
        <a href="index.jsp?pageNum=<%=number-1 %>">上一页</a> 
        <a href="index.jsp?pageNum=<%=number+1 %>">下一页</a> 
        <a href="index.jsp?pageNum=<%=totalPage%>">末页</a> 
        </p>
    </div>
    <div class="picnews">
      <ul>
        <li> <a href="#"><img src="Images/Picture1.jpg" width="249" alt="" /> </a><a href="#">幻想中穿越时空</a> </li>
        <li> <a href="#"><img src="Images/Picture2.jpg" width="249" alt="" /> </a><a href="#">国庆多变的发型</a> </li>
        <li> <a href="#"><img src="Images/Picture3.jpg" width="249" alt="" /> </a><a href="#">新技术照亮都市</a> </li>
        <li> <a href="#"><img src="Images/Picture4.jpg" width="249" alt="" /> </a><a href="#">群星闪耀红地毯</a> </li>
      </ul>
    </div>
  </div>
</div>
<div id="friend">
  <h1 class="friend_t"> <img src="Images/friend_ico.gif" alt="合作伙伴" /> </h1>
  <div class="friend_list">
    <ul>
      <li> <a href="#">中国政府网</a> </li>
      <li> <a href="#">中国政府网</a> </li>
      <li> <a href="#">中国政府网</a> </li>
      <li> <a href="#">中国政府网</a> </li>
      <li> <a href="#">中国政府网</a> </li>
      <li> <a href="#">中国政府网</a> </li>
      <li> <a href="#">中国政府网</a> </li>
    </ul>
  </div>
</div>
<div id="footer">
  <p class=""> 24小时客户服务热线：010-68988888 &#160;&#160;&#160;&#160; <a href="#">常见问题解答</a> &#160;&#160;&#160;&#160; 新闻热线：010-627488888 <br />
    文明办网文明上网举报电话：010-627488888 &#160;&#160;&#160;&#160; 举报邮箱： <a href="#">jubao@jb-aptech.com.cn</a> </p>
  <p class="copyright"> Copyright &copy; 1999-2009 News China gov, All Right Reserver <br />
    新闻中国 版权所有 </p>
</div>
</body>
</html>