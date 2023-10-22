<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../style.css?after" rel="stylesheet" type="text/css" />
</head>
<body>
<% 
	String sid = (String)session.getAttribute("sid"); 
%>
	<nav>
		<div>
			<a href="main.jsp"><img src="../img/blound_logo.svg" width="300"></a>
		</div>
		<div>
			<a href="shop_main.jsp" class="nav-item">SHOP</a> 
			<a href="story.jsp" class="nav-item">STORY</a> 
			<a href="QnA_main.jsp" class="nav-item">QnA</a> 
			<a href="cart_list.jsp" class="nav-item">CART</a>
			<%
				if(sid.equals("admin")){
			%>
				<a href="<%=request.getContextPath()%>/admin/main.jsp" class="nav-item">관리자 페이지</a>
			<%}%>
			<a href="logout.jsp" class="nav-item">LOGOUT</a>
			<span class="user_font"><%=sid%> 님</span>
		</div>
	</nav>
</body>
</html>