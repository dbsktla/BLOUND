<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	request.setCharacterEncoding("UTF-8");
	MemberDAO mdao = MemberDAO.getInstance();
	String name = request.getParameter("name");
	String rrn1 = request.getParameter("rrn1");
	String rrn2 = request.getParameter("rrn2");
	MemberBean member = mdao.findId(name,rrn1,rrn2);  
	
	String msg = "", url = "";
	if(member == null){
		msg = "일치하는 아이디가 없습니다.";
		url = "findid.jsp";
	}else{
		msg = "아이디는 "+member.getId()+"입니다.";
		url = "main.jsp";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url %>";
</script>