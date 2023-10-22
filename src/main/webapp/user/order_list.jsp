<%@page import="java.text.DecimalFormat"%>
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
	request.setCharacterEncoding("UTF-8");
	
	//제품 상세 페이지에서 application으로 flag = true라고 설정했던거 가져오기
	boolean flag = (Boolean)application.getAttribute("flag"); //다운캐스팅
	
	//바로 주문 눌렀을 경우에 처리하기 위해 번호랑 수량 받아오기
	String pnum = request.getParameter("pnum");
	String oqty = request.getParameter("oqty");
	
	//장바구니에서 넘어와서 00이 들어있을 경우엔 장바구니에 안 담기게 처리해야함 그래서
	//즉시 구매하기 눌렀을때, 즉 값이 00이 아닐때 장바구니에 담기게 처리
	if(!pnum.equals("00") && !oqty.equals("00")){
		if(flag == true){
		mallCart.addProduct(pnum, oqty); //여기에 장바구니 비었을경우/있을경우 나눠서 했기 때문에 문제 없음
		}	
	}

	Vector<ProductBean> cv = mallCart.getAllProducts();
	DecimalFormat df = new DecimalFormat("###,###");
%>
<%@ include file="b_top.jsp"%>
	<div class="shop-main-size">
		<div class="cart-width">
			<div class="pageTitle">
			<!-- 타이틀 텍스트 -->
				<font>ORDER</font>
			</div>
<%
			int price = 0;
			int point = 0;
			int count = 0;
			if(cv.size() == 0){
				out.println("<div class='cart-none'>장바구니에 담은 상품이 없습니다.</div></div></div>");
			}else{
			for(int i=0;i<cv.size();i++){
				count++;
				String imgPath = request.getContextPath()+"/product_img/"+cv.get(i).getPimage();
%>
			<!-- 장바구니 -->
			<div class="cart-box">
				<div class="cartImg-box">
					<img src="<%=imgPath%>" width="100%" height="100%">		
				</div>
				<div class="cartText-box">
					<div class="top">
						<span class="top-text bold"><%=cv.get(i).getPname()%></span>
						<a href="cart_delete.jsp?pnum=<%=cv.get(i).getPnum()%>"><span class="top-text right t-a">X</span></a>
						<span class="top-text bold right"><%=df.format(cv.get(i).getPrice()*cv.get(i).getPqty())%> &#8361;</span> 
					</div>
					<div class="middle">
						<span class="md-text"><%=df.format(cv.get(i).getPrice())%> &#8361;</span><br>
						<span class="md-text"><%=df.format(cv.get(i).getPoint())%> point</span>
					</div>
					<div class="bottom">
						<div>
							<form name="f" method="post" action="cart_edit.jsp">
								<input type="hidden" name="pnum" value="<%=cv.get(i).getPnum()%>">
								<input type="text" name="oqty" value="<%=cv.get(i).getPqty()%>" size="2" class="inputBox">
								<input type="submit" value="수정" class="inputBox">
							</form>
						</div>
					</div>
				</div>
				
			<%
				if(count % 1 == 0){
					out.println("</div>");
				}
				price += (cv.get(i).getPrice())*(cv.get(i).getPqty());
				point += (cv.get(i).getPoint())*(cv.get(i).getPqty());
				}//for%>
			<!-- 총 포인트,금액란 -->
			<div class="cart-bottom">
				<div class="cart-bottomBox1">
					<span>적립 예정 포인트</span>
					<span class="cart-right"><%=df.format(point)%> point</span>
				</div>
				<div class="cart-bottomBox2">
					<span class="cart-font">총 결제 예정 금액</span>
					<span class="cart-font cart-right"><%=df.format(price)%> &#8361;</span>
				</div>
			</div>
			<!-- 주문하기/계속 쇼핑 버튼란 -->
			<div class="cart-button-box">
				<a href="order_calculate.jsp?pnum=00&oqty=00"><button class="cart-button">주문하기</button></a> 
				<a href="javascript:history.go(-1)"><button class="cart-button">취소</button></a>
			</div>
			<%}//else%>
		</div>
	</div>
</div>	
<%
	application.setAttribute("flag", false);
%>	
</body>
<%@ include file="b_bottom.jsp"%>		
</html>