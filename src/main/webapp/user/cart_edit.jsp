<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mallCart" class="shop.CartBean" scope="session"/>
<%
	String pnum = request.getParameter("pnum");
	String oqty = request.getParameter("oqty");
	
	mallCart.setEdit(pnum,oqty); //장바구니에서 주문수량 수정 메서드
	
%>
<script type="text/javascript">
	alert("수정 되었습니다.");
	location.href="cart_list.jsp";
</script>