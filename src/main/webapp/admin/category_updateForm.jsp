<%@page import="shop.CategoryBean"%>
<%@page import="shop.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../style.css?after" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="b_top.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cnum = request.getParameter("cnum");
	CategoryDAO cdao = CategoryDAO.getInstance();
	CategoryBean cb = cdao.getUpdateNum(cnum);  
%>
	<div class="login_size">
		<div class="pageTitle_kor">
			<font>카테고리 수정</font>
		</div>
		<div class="find_box">
				<div class="login_form">
					<form name="myform" action="category_updateProc.jsp?cnum=<%=cnum%>" method="post">
					<table border="1" width="100%">
					<tr>
						<th class="th">카테고리 코드</th>
							<td class="center td">
								<input type="text" name="code" class="inputTypeText_full" value="<%=cb.getCode()%>">
							</td>
					</tr>
					<tr>
						<th class="th">카테고리 이름</th>
							<td class="center td">
								<input type="text" name="cname" class="inputTypeText_full" value="<%=cb.getCname()%>">
							</td>
					</tr>
					</table>
					<input type="submit" value="수정" class="submit-style">
					<input type="button" value="취소" class="submit-style" onClick="location.href='category_list.jsp'">
					</form>
				</div>
		</div>
	</div>
<%@ include file="b_bottom.jsp"%>
</body>
</html>  