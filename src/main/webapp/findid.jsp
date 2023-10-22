<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="style.css?after" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="b_top.jsp"%>
	<div class="login_size">
		<div class="pageTitle">
			<font>Find ID</font>
		</div>
		<div class="find_box">
				<div class="login_form">
					<form name="myform" action="findidProc.jsp" method="post">
					<table border="1" width="100%">
					<tr>
						<th class="th">이름</th>
							<td class="left td">
								<input type="text" name="name" placeholder="이름" class="inputTypeText">
							</td>
					</tr>
					<tr>
						<th class="th">주민등록번호</th>
							<td class="td">
								<input type="text" name="rrn1" size="6" maxlength="6" class="inputTypeText">
								- <input type="text" name="rrn2" size="7" maxlength="7" class="inputTypeText">
							</td>
					</tr>
					</table>
					<input type="submit" value="아이디 찾기" class="submit-style">
					<input type="button" value="취소" class="submit-style" onClick="javascript:history.go(-1)">
					</form>
				</div>
		</div>
	</div>
<%@ include file="b_bottom.jsp"%>
</body>
</html>  