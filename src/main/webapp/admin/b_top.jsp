<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="style.css" rel="stylesheet">
</head>
<body>
	<nav class="b_nav">
		<div>
			<a href="main.jsp"><img src="admin_img/blound_logo.svg" width="300"></a>
		</div>
		<div>
			<a href="category_input.jsp" class="b_nav-item">카테고리 등록</a> 
			<a href="category_list.jsp"class="b_nav-item">카테고리 목록</a> 
			<a href="product_input.jsp" class="b_nav-item">제품 등록</a> 
			<a href="product_list.jsp" class="b_nav-item">제품 목록</a>
			<a href="order_list.jsp" class="b_nav-item">주문 내역</a> 
			<a href="<%=request.getContextPath()%>/user/main.jsp" class="b_nav-item">사용자 페이지</a>
			<span class="admin_font">관리자</span>
		</div>
	</nav>
</body>
</html>