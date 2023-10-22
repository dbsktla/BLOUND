<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Blound_Register</title>
<link href="style.css?after" rel="stylesheet" type="text/css" />
<style type="text/css">
	table{
		margin: auto;
	}
</style>
</head>
<body>
	<%@ include file="b_top.jsp"%>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>
	<script>
		/** 우편번호 찾기 */
		function execDaumPostcode() {
		    daum.postcode.load(function(){
		        new daum.Postcode({
		            oncomplete: function(data) {
		              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분
		              $("#postcode").val(data.zonecode);
		              $("#address").val(data.roadAddress);
		            }
		        }).open();
		    });
		}
</script>
	<div class="register_size">
		<div class="pageTitle">
			<font>JOIN</font>
		</div>
			<form name="myform" action="registerProc.jsp" method="post" onSubmit="return writeSave()">
				<table border="1" width="1000px">
					<tr>
						<th class="th">아이디</th>
						<td class="td"><input type="text" name="id" onkeydown="keyd()" class="inputTypeText">
							<input type="button" value="중복체크" onClick="duplicate()" class="smButton">
							<span id="idmessage"></span></td>
					</tr>
					<tr>
						<th class="th">비밀번호</th>
						<td class="td"><input type="text" name="password" class="inputTypeText"
							onBlur="return pwcheck()"> <span class="exFont">영문 소문자/숫자 조합 3~8자</span></td>
					</tr>
					<tr>
						<th class="th">비밀번호 확인</th>
						<td class="td"><input type="text" name="password2" class="inputTypeText"
							onKeyup="return pw2check()"> <span id="pwmessage"></span></td>
					</tr>
					<tr>
						<th class="th">이름</th>
						<td class="td"><input type="text" name="name" class="inputTypeText"> 
						<span class="exFont">성과 이름을 붙여주세요 (ex)홍길동</span></td>
					</tr>
					<tr>
						<th class="th">주소</th>
						<td class="td">
							<input type="text" class="inputTypeText" name="postcode" id="postcode" placeholder="우편번호" readonly />
							  <button type="button" class="smButton" onclick="execDaumPostcode()">우편번호 찾기</button><br>
							  <input
							      type="text"
							      class="inputTypeText"
							      name="address"
							      id="address"
							      placeholder="도로명 주소"
							      readonly
							    /><br>
							     <input
							      type="text"
							      class="inputTypeText"
							      name="detailAddress"
							      placeholder="상세 주소"
							    />
						</td>
					</tr>
					
					<tr>
						<th class="th">이메일</th>
						<td class="td"><input type="email" name="email" class="inputTypeText"></td>
					</tr>
					<tr>
						<th class="th">주민등록번호</th>
						<td class="td"><input type="text" name="rrn1" size="6" maxlength="6" class="inputTypeText">
							- <input type="text" name="rrn2" size="7" maxlength="7" class="inputTypeText">
						</td>
					</tr>
					<tr>
						<th class="th">휴대 전화 번호</th>
						<td class="td"><select name="hp1" class="smInputTypeText">
								<option>010</option>
								<option>011</option>
								<option>012</option>
						</select> - <input type="text" name="hp2" size="4" maxlength="4" class="smInputTypeText"> -
							<input type="text" name="hp3" size="4" maxlength="4" class="smInputTypeText">
						</td>
					</tr>
					<tr>
						<th class="th">가입 일자</th>
						<td class="td"><input type="text" name="joindate" class="inputTypeText"> <span class="exFont">ex)2000/05/22</span></td>
					</tr>
				</table>
				<div class="center">
					<input type="submit" value="회원 가입" class="submit-style"> 
					<input type="button" value="취소" onClick="location.href='<%=request.getContextPath()%>/main.jsp'" class="submit-style">
				</div>
			</form>
	</div>
	<%@ include file="b_bottom.jsp"%>
</body>
</html>