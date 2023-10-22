<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="../stylesheet" type="text/css" href="style.css">
<style>
	table{
		margin: auto;
	}
	input[type=password]{
		margin-left: 40px;
	}
</style>
<% 
String num = request.getParameter("num"); 
String pageNum = request.getParameter("pageNum"); 
%>

<%@ include file="b_top.jsp"%>
<div class="register_size">
	<div class="pageTitle_kor">
		<font>글삭제</font>
	</div>
<form name="deleteForm" action="deleteProc.jsp" method="post">
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<table border="1" width="700px" height="100px">
			<tr>
				<th class="th">비밀번호 확인</th>
				<td class="td"><input type="password" name="passwd" class="inputTypeText_full"></td>
			</tr>
		</table>
		<div class="center">
			<input type="submit" value="삭제" class="submit-style">
			<input type="button" onClick="javascript:history.go(-1)" value="취소" class="submit-style">
			<input type="button" onClick="location.href='QnA_main.jsp'" value="목록" class="submit-style">
		</div>			
	</form>
</div>
<%@ include file="b_bottom.jsp"%>