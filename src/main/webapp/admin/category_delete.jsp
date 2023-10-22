<%@page import="shop.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CategoryDAO cdao = CategoryDAO.getInstance();
	String cnum = request.getParameter("cnum");
	
	int cnt = cdao.deleteCategory(cnum);      
	  
	String msg = "";
	if(cnt > 0){
		msg = "카테고리 삭제 성공했습니다.";
	}else{
		msg = "카테고리 삭제 실패했습니다.";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="category_list.jsp";
</script>