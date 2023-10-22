<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//전체 세션 해제하기 
	session.invalidate();
%>
<script type="text/javascript">
	location.href="<%=request.getContextPath()%>/main.jsp";
</script>

