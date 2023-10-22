<%@page import="shop.CategoryBean"%>
<%@page import="shop.CategoryDAO"%>
<%@page import="shop.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.ProductDAO"%>
<%@page import="java.text.DecimalFormat"%>
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
<%	
	request.setCharacterEncoding("UTF-8");
	String code = request.getParameter("code");
	String cname = request.getParameter("cname");
	DecimalFormat df = new DecimalFormat("###,###");
	System.out.println(code);
	System.out.println(cname);
	
	ProductDAO pdao = ProductDAO.getInstance();
	ArrayList<ProductBean> plists = pdao.getBycategory(code);
	
	CategoryDAO cdao = CategoryDAO.getInstance();
	ArrayList<CategoryBean> clists = cdao.getAllCategory();
%>
<%@ include file="b_top.jsp"%>
	<div class="shop-main-size">
		<div class="shop-width">
			<div class="pageTitle">
			<!-- 타이틀 텍스트 -->
				<font><%=cname %></font>
			</div>
			<!-- 바로가기 버튼 -->
			<div class="button-area">  
			<%
				for(int i=0;i<clists.size();i++){
				if(cname.equals(clists.get(i).getCname())){
			%>
				<input type="button" value="<%=clists.get(i).getCname()%>" class="select-button-style" onClick="location.href='shop_category.jsp?code=<%=clists.get(i).getCode()%>&cname=<%=clists.get(i).getCname()%>'">
			<%		
				}else{
			%>
				<input type="button" value="<%=clists.get(i).getCname()%>" class="gray-button-style" onClick="location.href='shop_category.jsp?code=<%=clists.get(i).getCode()%>&cname=<%=clists.get(i).getCname()%>'">
							
			<%}} %>
			</div>
			<div class="underline"></div>
			<!-- 상품-귀마개 -->
			<%
				
			if(plists.size() == 0){
				out.println("<b>등록된 상품이 없습니다.</b>");
			}else{
			%>
			<div class="product-container">
			<%
				int count = 0;
				for(ProductBean pb : plists){
					count++;
					String imgPath = request.getContextPath()+"/product_img/"+pb.getPimage();
			%>
				<div class="product-box">
					<a href="product-view.jsp?pnum=<%=pb.getPnum()%>">
					<img src="<%=imgPath %>" width="100%">
					<span class="img-titleText"><%=pb.getPname() %></span>
					<span class="img-subText">SHOW MORE ></span></a>
				</div>
			<%
					if(count % 4 == 0){
						out.println("</div>");
					}
				}//for
			}
			%>
		</div>
	</div>	
<%@ include file="b_bottom.jsp"%>
</body>
</html>