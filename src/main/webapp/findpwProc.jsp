<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	MemberDAO mdao = MemberDAO.getInstance();
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String rrn1 = request.getParameter("rrn1");
	String rrn2 = request.getParameter("rrn2");
	MemberBean member = mdao.findPw(name,id,rrn1,rrn2);   
	
	String msg = "", url = "";
	if(member == null){
		msg = "존재하지 않는 회원입니다.";
		url = "findpw.jsp";
	}else{
		msg = "비밀번호는 "+member.getPassword()+"입니다.";
		url = "main.jsp";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url %>";
</script>