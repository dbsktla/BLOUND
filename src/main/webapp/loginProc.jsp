<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	MemberDAO mdao = MemberDAO.getInstance();  
	MemberBean member = mdao.getMemberInfo(id,password);
	String url = null;
	
	if(member != null){ //존재하는 회원(등록한 회원)
		String u_id = member.getId();
		int no = member.getNo(); //번호 갖고오기
		if(u_id.equals("admin")){ //관리자
			url = request.getContextPath()+"/admin/main.jsp";
		}else{ //일반 사용자
			url = request.getContextPath()+"/user/main.jsp";
		}
		//세션 이용해서 계속 넘겨주기
		session.setAttribute("sid", id);
		session.setAttribute("sno", no);
		String sid = (String)session.getAttribute("sid");
		System.out.println("세션값="+sid);
		
	}else{ //존재하지 않는 회원
		url = "login.jsp";
	%>
		<script type="text/javascript">
		alert("가입하지 않은 회원입니다.")
		location.href="<%=url%>";
		</script>
	<%
	}
	%>
<script type="text/javascript">
	location.href="<%=url%>";
</script>