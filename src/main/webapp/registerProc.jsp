<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
registerProc.jsp<br>
<%
	request.setCharacterEncoding("UTF-8");
	MemberDAO mdao = MemberDAO.getInstance();
%>
	<jsp:useBean id="md" class="member.MemberBean"/>
	<jsp:setProperty property="*" name="md"/>
<%
	int cnt = mdao.insertMember(md); 
	  
	String msg = "", url = "";
	if(cnt > 0){
		msg = "가입 성공했습니다.";
		url = "login.jsp";
	}else{
		msg = "가입 실패했습니다.";
		url = "register.jsp";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url %>";
</script>