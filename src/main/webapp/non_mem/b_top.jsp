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
	<nav class="b_nav">
		<div>
			<a href="../main.jsp"><img src="../img/blound_logo.svg" width="300"></a>
		</div>
		<div>
			<a href="shop_main.jsp" class="b_nav-item">SHOP</a> 
			<a href="../story.jsp"class="b_nav-item">STORY</a> 
			<a href="../QnA/QnA_main.jsp" class="b_nav-item">QnA</a> 
			<a href="../login.jsp" class="b_nav-item">LOGIN</a>
			<a href="../register.jsp" class="b_nav-item">JOIN</a>
		</div>
	</nav>
</body>
</html>