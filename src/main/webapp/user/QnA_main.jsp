<%@page import="QnA.QnADAO"%>
<%@page import="QnA.QnABean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLOUND</title>
<link href="../style.css?after" rel="stylesheet" type="text/css"/>
<style type="text/css">
	table{
		margin: auto;
		text-align: center;
	}
</style>
</head>
<body>
<%@ include file="b_top.jsp"%>
<%      
	int pageSize = 5;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	String pageNum = request.getParameter("pageNum"); //pageNum:내가 선택한 페이지번호
	System.out.println("pageNum : " + pageNum);
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1) * pageSize + 1;
	int endRow = currentPage * pageSize;	
	
	QnADAO qdao = QnADAO.getInstance();
	ArrayList<QnABean> lists = null; 
	int count = qdao.getArticleCount(); // 19
	if(count > 0) {
		lists = qdao.getArticles(startRow,endRow);  
	}
	int number = count-(currentPage-1) * pageSize;
	/* 
	1페이지 : 19-(1-1)*5; =>19
	2페이지 : 19-(2-1)*5; =>14 */ 
%> 
<div class="login_size">
		<div class="pageTitle">
			<font>QnA</font>
		</div>
		<div class="QnATable">
<%
	if(count == 0){
%>
		<table border="1" width="1200px">
			<tr height="75px">
				<td align="center">
					게시판에 저장된 글이 없습니다.
				</td>
			</tr>
		</table>
<%		
	}else{  
%>
		<table border="1" width="1200px">
			<tr height="75px">
				<th class="c_th" width="8%">번호</th>
				<th class="c_th" width="44%">제목</th>
				<th class="c_th" width="10%">작성자</th>
				<th class="c_th" width="30%">작성일</th>
				<th class="c_th" width="8%">조회</th>
			</tr>
			<%for(QnABean bb : lists){ %>
				<tr height="60px" class="tr_underline">
					<td><%=number-- %></td> 
					<td align="left" id="QnA-title">
						<%
							int wid = 20;
							if(bb.getRe_level() > 0){ // 답글, 답답,답답답
								wid = 20 * bb.getRe_level(); // 1:20, 2:40, 3:60
						%>
								<img src="" width="<%=wid %>" height="15">
								<img src="../img/re_icon.gif">
						<%
							}
						%>
						<a href="content.jsp?num=<%=bb.getNum() %>&pageNum=<%=pageNum%>"><%=bb.getSubject() %></a>
					<!-- content.jsp?num=20&pageNum=2 -->
					</td>
					<td><%=bb.getWriter() %></td>
					<td><%=sdf.format(bb.getReg_date()) %></td>
					<td><%=bb.getReadcount() %></td>
				</tr>
			<%}//for %>
		</table>
<% 
	}//else
%>
	</div>
	<div class="whiteArea">
		<button class="smButton" onClick="location.href='writeForm.jsp'">글쓰기</button>
	</div>
	
	<div class="pageNum">
<%
	// 페이지 설정
	if(count > 0){ // 23 / 5   => 4+1
		int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1);
	
		int pageBlock = 3;
		
		int startPage =  ((currentPage-1) / pageBlock * pageBlock)+1;
		int endPage = startPage + pageBlock - 1;
		if(pageCount < endPage){
			endPage = pageCount;
		}
		
		if(startPage > 3){
	%>
			<a href="QnA_main.jsp?pageNum=<%=startPage-3%>">이전</a>
	<%
		}//if
		for(int i=startPage;i<=endPage;i++){
		%>
			<a href="QnA_main.jsp?pageNum=<%=i %>"><%=i %></a>
			<!-- select.jsp?pageNum=2 -->
			<!-- [1][2][3] -->
		<%
		}//for
		
		if(endPage < pageCount){
		%>
			<a href="QnA_main.jsp?pageNum=<%=startPage + 3%>">다음</a>
		<%			
		}   
	}// if 
%>
</div>
</div>
<%@ include file="b_bottom.jsp"%>
</body>
</html>