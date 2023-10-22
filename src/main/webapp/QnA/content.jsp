<%@page import="QnA.QnABean"%>
<%@page import="QnA.QnADAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="../style.css?after" rel="stylesheet" type="text/css"/>
<%
	request.setCharacterEncoding("UTF-8");
	QnADAO qao = QnADAO.getInstance();
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	
	QnABean article = qao.getArticleByNum(num); 
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%@ include file="b_top.jsp"%>
<div class="page-size">
	<div class="page-width">
		<div class="pageTitle">
			<font>QnA</font>
		</div>
		<!-- 내용 시작 -->
	<form name="contentForm">
		<div class="border">
		<!-- 타이틀 -->
			<div class="top-box">
				<div class="text-box">
					<div class="top">
						<span class="top-text bold"><%=article.getSubject()%></span>
					</div>
					<div class="middle">
						<span class="md-text"><%=article.getWriter()%></span>
						<span class="md-text"><%=sdf.format(article.getReg_date())%></span>
						<span class="md-text">조회 <%=article.getReadcount()%></span>
					</div>
				</div>
			</div>
			<!-- 본문 -->
			<div class="bottom-box">
				<%=article.getContent()%>
			</div>
		</div>
		<div class="center">
			<input type="button" value="수정" onClick="location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'" class="submit-style">
			<input type="button" value="삭제"  onClick="location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'" class="submit-style">
			<input type="button" value="답글쓰기" onClick="location.href='replyForm.jsp?ref=<%=article.getRef()%>&re_step=<%=article.getRe_step()%>&re_level=<%=article.getRe_level()%>&pageNum=<%=pageNum%>'" class="submit-style">
			<input type="button" value="목록" onclick="location.href='QnA_main.jsp?pageNum=<%=pageNum%>'" class="submit-style">
		</div>
	</form>
</div>
</div>
<%@ include file="b_bottom.jsp"%>