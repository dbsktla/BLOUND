<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../style.css?after" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="b_top.jsp"%>
	<div class="login_size">
		<div class="pageTitle_kor">
			<font>카테고리 등록</font>
		</div>
		<div class="find_box">
				<div class="login_form">
					<form name="myform" action="category_inputProc.jsp" method="post">
					<table border="1" width="100%">
					<tr>
						<th class="th">카테고리 코드</th>
							<td class="center td">
								<input type="text" name="code" class="inputTypeText_full">
							</td>
					</tr>
					<tr>
						<th class="th">카테고리 이름</th>
							<td class="center td">
								<input type="text" name="cname" class="inputTypeText_full">
							</td>
					</tr>
					</table>
					<input type="submit" value="등록" class="submit-style">
					</form>
				</div>
		</div>
	</div>
<%@ include file="b_bottom.jsp"%>
</body>
</html>  