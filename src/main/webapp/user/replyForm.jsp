<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="../stylesheet" type="text/css" href="style.css">
<style>
	table{
		margin: auto;
	}
	input[type=text]{
		width:60%;
	}
</style>
<%
	String ref = request.getParameter("ref");
	String re_step = request.getParameter("re_step");
	String re_level = request.getParameter("re_level");
	String pageNum = request.getParameter("pageNum");
	System.out.println(ref+","+re_step+","+re_level); //부모 정보
%>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="script.js"></script>
<%@ include file="b_top.jsp"%>
<div class="register_size">
	<div class="pageTitle_kor">
		<font>답글쓰기</font>
	</div>
<form method="post" name="writeForm" action="replyProc.jsp" onSubmit="return writeSave()">
	<input type="hidden" name="ref" value="<%=ref %>">
	<input type="hidden" name="re_step" value="<%=re_step %>">
	<input type="hidden" name="re_level" value="<%=re_level %>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
<table border="1" width="1200px">
	<tr>
		<th class="th">제목</th>
		<td class="td"><input type="text" name="subject" class="inputTypeText" value="[답변]"></td>
	</tr>
	<tr>
		<th class="th">이름</th>
		<td class="td"><input type="text" name="writer" class="smInputTypeText"></td>
	</tr>
	<tr>
		<th class="th">이메일</th>
		<td class="td"><input type="text" name="email" class="inputTypeText"></td>
	</tr>
	<tr>
		<th class="th">본문</th>
		<td class="td">
			<textarea rows="10" cols="93" style="resize:none" name="content" class="inputTypeTextarea" placeholder="설명"></textarea>
		</td>
	</tr>
	<tr>
		<th class="th">비밀번호</th>
		<td class="td"><input type="password" name="passwd" class="smInputTypeText"></td>
	</tr>
</table>	
	<div class="center">
		<input type="submit" value="답글등록" class="submit-style">
		<input type="button" onClick="javascript:history.go(-1)" value="취소" class="submit-style">
		<input type="button" onClick="location.href='QnA_main.jsp'" value="목록" class="submit-style">
	</div>
</form>
</div>
<%@ include file="b_bottom.jsp"%>