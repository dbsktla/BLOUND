<%@page import="QnA.QnADAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	QnADAO bdao = QnADAO.getInstance(); 
%>
<jsp:useBean id="qb" class="QnA.QnABean"/>
<jsp:setProperty property="*" name="qb"/>

<%
	qb.setReg_date(new Timestamp(System.currentTimeMillis()));
	qb.setIp(request.getRemoteAddr());
	
	int cnt = bdao.replyArticle(qb);  // 8+2
 
	String msg = "등록 실패했습니다.";
	String url="replyForm.jsp?ref="+qb.getRef()+"&re_step="+qb.getRe_step()+"&re_level="+qb.getRe_level()+ "&pageNum=" + pageNum;
	
	if(cnt == 1){
		msg = "등록 성공했습니다.";
		url = "QnA_main.jsp?pageNum=" + pageNum;
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>