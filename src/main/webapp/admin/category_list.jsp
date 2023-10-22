<%@page import="shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLOUND</title>
<link href="../style.css?after" rel="stylesheet" type="text/css"/>
<style type="text/css">
	table{
		margin: auto;
		text-align: center;
	}
</style>
</head>
<body>
<%
	CategoryDAO cdao = CategoryDAO.getInstance();
	ArrayList<CategoryBean> lists = cdao.getAllCategory();
%>
<%@ include file="b_top.jsp"%>
	<div class="login_size">
		<div class="pageTitle_kor">
			<font>카테고리 목록</font>
		</div>
		<table border="1" width="1000px">
			<tr height="75px">
				<th class="c_th">번호</th>
				<th class="c_th">카테고리 코드</th>
				<th class="c_th">카테고리 이름</th>
				<th class="c_th">수정</th>
				<th class="c_th">삭제</th>
			</tr>
<%
		if(lists.size() == 0){ //등록한 것 x
			out.println("<tr><td colspan=5 align='center'>등록된 카테고리가 없습니다.</td></tr>");
		}
		for(int i=0;i<lists.size();i++){
%>
			<tr height="60px" class="tr_underline">
				<td width="10%"><%= lists.get(i).getCnum() %></td>
				<td width="35%"><%= lists.get(i).getCode() %></td>
				<td width="35%"><%= lists.get(i).getCname() %></td>
				<td width="10%"><a class="underline" href="category_updateForm.jsp?cnum=<%=lists.get(i).getCnum()%>">수정</a></td>
				<td width="10%"><a class="underline" href="category_delete.jsp?cnum=<%=lists.get(i).getCnum()%>">삭제</a></td>
			</tr>
<%}%>
		</table>
	</div>
<%@ include file="b_bottom.jsp"%>
</body>
</html>  