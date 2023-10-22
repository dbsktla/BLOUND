<%@page import="QnA.QnADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
updateForm.jsp(5(입력)+1(num)+1(pageNum)) => updateProc.jsp
<br>

<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="qb" class="QnA.QnABean" />
<jsp:setProperty property="*" name="qb" />
<%
	String pageNum = request.getParameter("pageNum");

	QnADAO qdao = QnADAO.getInstance();
	int cnt = qdao.updateArticle(qb); 
	if (cnt == 1) {
		response.sendRedirect("QnA_main.jsp?pageNum="+pageNum);
	} else {
%>
	<script>
		alert("비밀번호가 일치하지 않습니다");
		history.go(-1);
	</script>
<%	
}
%>



