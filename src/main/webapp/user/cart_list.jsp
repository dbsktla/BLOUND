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
	Vector<ProductBean> cv = mallCart.getAllProducts();
	DecimalFormat df = new DecimalFormat("###,###");
%>
<%@ include file="b_top.jsp"%>
	<div class="shop-main-size">
		<div class="cart-width">
			<div class="pageTitle">
			<!-- 타이틀 텍스트 -->
				<font>CART</font>
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
					<span class="cart-font">결제 예정 금액</span>
					<span class="cart-font cart-right"><%=df.format(price)%> &#8361;</span>
				</div>
			</div>
			<!-- 주문하기/계속 쇼핑 버튼란 -->
			<div class="cart-button-box">
				<a href="order_list.jsp?pnum=00&oqty=00"><button class="cart-button">주문하기</button></a> 
				<a href="javascript:history.go(-2)"><button class="cart-button">돌아가기</button></a>
			</div>
			<%}//else%>
		</div>
	</div>
</div>		
</body>
<%@ include file="b_bottom.jsp"%>		
</html>