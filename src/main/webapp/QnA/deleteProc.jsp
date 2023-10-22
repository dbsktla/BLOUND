<%@page import="QnA.QnADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
deleteForm.jsp(입력한 passwd,글번호,돌아갈 페이지번호)=>deleteProc.jsp

<%
	String num = request.getParameter("num");
	String passwd=request.getParameter("passwd");
	int pageNum=Integer.parseInt(request.getParameter("pageNum"));
	
	QnADAO qdao = QnADAO.getInstance();
	int cnt = qdao.deleteArticle(num, passwd); 
	if(cnt==1){ // 삭제 성공했을 때
		int pageSize = 5;
		int count = qdao.getArticleCount(); // 16-1=>15=>3페이지
		int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1);
		
		if(pageNum > pageCount){ // 4 > 3
			response.sendRedirect("QnA_main.jsp?pageNum="+(pageNum-1));
		}
		else{
		  	response.sendRedirect("QnA_main.jsp?pageNum="+pageNum);
		}
	}else{
		 %>
	<script>
		alert("비밀번호가 일치하지 않습니다.");
		history.go(-1);
	 </script>
<%
	}
%>

