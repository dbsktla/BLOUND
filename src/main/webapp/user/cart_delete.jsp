<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mallCart" class="shop.CartBean" scope="session"/>
<%
	String pnum = request.getParameter("pnum");
	mallCart.removeProduct(pnum);
	response.sendRedirect("cart_list.jsp");
%>