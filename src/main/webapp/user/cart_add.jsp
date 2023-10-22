<%@page import="shop.ProductBean"%>
<%@page import="shop.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pnum = request.getParameter("pnum");
	String oqty = request.getParameter("oqty");
	
	//CartBean mallCart = new CartBean(); // 장바구니 객체 생성 / 생성자로 와야 생성됨 / 이렇게 하던가 jsp:useBean으로 하던가
	//이러면 여러개를 담을 경우에 계속 객체를 만들어서 하나만 담는 장바구니를 여러개 만들게 됨. session 설정 해야함
%>
<!-- 여러개 하면 객체 계속 만듦.기본값 : scope="page" / session으로 설정하면 한번 객체 만들고 계속 유지됨. 싱글톤과 비슷-->
<jsp:useBean id="mallCart" class="shop.CartBean" scope="session"/>
<%
	ProductDAO pdao = ProductDAO.getInstance();
	ProductBean pb = pdao.getProductView(pnum);
	mallCart.addProduct(pnum,oqty); 
%>	
	<script type="text/javascript">
		var resp = confirm("선택한 상품을 장바구니에 담았습니다. \n장바구니로 가시겠습니까?");
		if(resp){ //확인을 누르면 true가 됨
			location.href="cart_list.jsp";
		}else{
			location.href="shop_main.jsp";
		}
	</script>
