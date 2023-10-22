<%@page import="shop.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	CategoryDAO cdao = CategoryDAO.getInstance();
%>
	<jsp:useBean id="cb" class="shop.CategoryBean"/>
	<jsp:setProperty property="*" name="cb"/>
<%
	int cnt = cdao.updateCategory(cb);     
	  
	String msg = "", url = "";
	if(cnt > 0){
		msg = "카테고리 수정 성공했습니다.";
		url = "category_list.jsp";
	}else{
		msg = "카테고리 수정 실패했습니다.";
		url = "category_updateForm.jsp";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url %>";
</script>