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
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="script.js"></script>
<%@ include file="b_top.jsp"%>
<div class="register_size">
	<div class="pageTitle">
		<font>글쓰기</font>
	</div>
	
	<form method="post" name="writeForm" action="writeProc.jsp" onSubmit="return writeSave()">
	<table border="1" width="1200px">
		<tr>
			<th class="th">제목</th>
			<td class="td"><input type="text" name="subject" class="inputTypeText"></td>
		</tr>
		<tr>
			<th class="th">이름</th>
			<td class="td"><input type="text" name="writer" class="smInputTypeText"></td>
		</tr>
		
		<tr>
			<th class="th">아이디</th>
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
			<input type="submit" value="등록" class="submit-style">
			<input type="button" onClick="javascript:history.go(-1)" value="취소" class="submit-style">
			<input type="button" onClick="location.href='QnA_main.jsp'" value="목록" class="submit-style">
		</div>
</form>
</div>
<%@ include file="b_bottom.jsp"%>