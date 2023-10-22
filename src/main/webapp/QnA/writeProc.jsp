<%@page import="QnA.QnADAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
writeForm.jsp 요청 => writeProc.jsp<br>

<%
	request.setCharacterEncoding("UTF-8");

	QnADAO qdao = QnADAO.getInstance(); 
%>
<jsp:useBean id="qb" class="QnA.QnABean"/>
<jsp:setProperty property="*" name="qb"/>
<%
	qb.setReg_date(new Timestamp(System.currentTimeMillis()));
	qb.setIp(request.getRemoteAddr());
	
	int cnt = qdao.insertArticle(qb);
 
	String msg = "등록 완료되었습니다.";
	
	if(cnt > 1){
		msg = "등록 실패했습니다.";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="QnA_main.jsp";
</script>