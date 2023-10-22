<%@page import="QnA.QnABean"%>
<%@page import="QnA.QnADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="../stylesheet" type="text/css" href="style.css">
<style>
	table{
		margin: auto;
	}
	input[type=text]{
		width:60%;
	}
</style> 
<%
	QnADAO qdao = QnADAO.getInstance();
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	
	QnABean article = qdao.getContentByNum(num); 
%>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="script.js"></script>
<%@ include file="b_top.jsp"%>
<div class="register_size">
	<div class="pageTitle_kor">
		<font>글 수정</font>
	</div>
<form method="post" name="writeForm" action="updateProc.jsp" onSubmit="return writeSave()">
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
<table border="1" width="1200px">
	<tr>
		<th class="th">제목</th>
		<td class="td"><input type="text" name="subject" class="inputTypeText" value="<%=article.getSubject()%>"></td>
	</tr>
	<tr>
		<th class="th">이 름</th>
		<td class="td"><input type="text" name="writer" class="inputTypeText" value="<%=article.getWriter()%>"></td>
	</tr>
	<tr>
		<th class="th">이메일</th>
		<td class="td"><input type="text" name="email" class="inputTypeText" value="<%=article.getEmail()%>"></td>
	</tr>
	<tr>
		<th class="th">본문</th>
		<td class="td">
			<textarea rows="10" cols="93" style="resize:none" name="content" class="inputTypeTextarea"><%=article.getContent()%></textarea>
		</td>
	</tr>
	<tr>
		<th class="th">비밀번호</th>
		<td class="td"><input type="password" name="passwd" class="smInputTypeText"></td>
	</tr>
</table>
	<div class="center">
		<input type="submit" value="수정" class="submit-style">
		<input type="button" onClick="javascript:history.go(-1)" value="취소" class="submit-style">
		<input type="button" onClick="location.href='QnA_main.jsp'" value="목록" class="submit-style">
	</div>
</form>	
</div>
<%@ include file="b_bottom.jsp"%>