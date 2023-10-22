<%@page import="shop.ProductDAO"%>
<%@page import="shop.OrdersDAO"%>
<%@page import="shop.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLOUND</title>
<link href="style.css?after" rel="stylesheet" type="text/css"/>
</head>
<body>
<jsp:useBean id="mallCart" class="shop.CartBean" scope="session"/>
<%
	Vector<ProductBean> clist = mallCart.getAllProducts();
	//loginProc에서 설정해놨던 세션 이용해서 구매자 정보 가져오기
	int sno = (Integer)session.getAttribute("sno"); //object 리턴하니까 integer로 바꿔서 넣어주기
	
	OrdersDAO odao = OrdersDAO.getInstance();
	ProductDAO pdao = ProductDAO.getInstance();
	int cnt = odao.insertOrder(sno,clist); //회원번호,장바구니
	
	String msg = "";
	if(cnt >= 0){ //누적이라 >=
		pdao.updatepqty(clist); 
		msg = "주문 완료했습니다.";
		mallCart.removeAllProduct(); //장바구니 전체 삭제
	}else{
		msg = "주문 실패했습니다.";
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="main.jsp";
</script>

</body>
</html>