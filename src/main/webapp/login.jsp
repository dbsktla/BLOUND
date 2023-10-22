<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Blound_Login</title>
<link href="style.css?after" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="b_top.jsp"%>
	<div class="login_size">
		<div class="pageTitle">
			<font>LOGIN</font>
		</div>
		<div class="login_box">
				<div class="login_form">
					<form name="myform" action="loginProc.jsp" method="post">
						<input type="text" name="id" placeholder="아이디" class="inputbox"><br>
						<input type="password" name="password" placeholder="비밀번호" class="inputbox">
				<div class="login_smfont">
					<font>
						<a href="register.jsp" class="login_smfont">회원가입</a>   |   
						<a href="findid.jsp" class="login_smfont">아이디 찾기</a>   |   
						<a href="findpw.jsp" class="login_smfont">비밀번호 찾기</a>
					</font>
				</div>
					<input type="submit" value="Login" class="submit-style">
					</form>
				</div>
		</div>
	</div>
<%@ include file="b_bottom.jsp"%>
</body>
</html>
			<!-- <div class="id_pw_box">
				<div class="form_space">
				<form name="myform" action="loginProc.jsp" method="post">
					<input class="inputbox" type="text" name="id" placeholder="아이디" size="30"><br>
					<input class="inputbox" type="password" name="password" placeholder="비밀번호" size="30">
				</form>
				</div>
				<div class="sm_font">
						<font>회원가입 아이디 찾기 비밀번호 찾기</font>
				</div>
			</div> -->