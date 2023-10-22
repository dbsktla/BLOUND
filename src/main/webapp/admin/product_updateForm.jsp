<%@page import="shop.ProductBean"%>
<%@page import="shop.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Blound_Product_input</title>
<link href="../style.css?after" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
	function fileName(){
		$("#file").change(function(){
			  var fileName = $("#file").val().split('/').pop().split('\\').pop();;
			  $(".filebox").val(fileName);
		});
	}
</script>
<style type="text/css">
	table{
		margin: auto;
	}
	.inputTypeText{
		width:60%;
	}
	.smInputTypeText{
		width:10%;
		margin-top: 20px;
	}
	textarea[name=pcontents]{
		width:95%;
		height:30%;
	}
	img{
		margin: 10px 15px;
	}
	input[name=pcategory_fk]{
		margin-left: 33px;
		width:56.8%;
	}
	input[name=point]{
		margin-bottom: 20px;
	}
	.register_size{
		height: 1500px;
	}
</style>
</head>
<body>
<%@ include file="b_top.jsp"%>
<%
	ProductDAO pdao = ProductDAO.getInstance();
	String pnum = request.getParameter("pnum");
	ProductBean pb =  pdao.getProductView(pnum);
%>
	<div class="register_size">
		<div class="pageTitle_kor">
			<font>제품 수정</font>
		</div>
			<form name="myform" action="product_updateProc.jsp" method="post" enctype="multipart/form-data">
				<table border="1" width="1000px">
					<tr>
						<th class="th">제품 번호</th>
						<td class="td">
							<input type="text" name="pnum" value="<%=pb.getPnum()%>" class="smInputTypeText" readonly>
						</td>
					</tr>
					<tr>
						<th class="th">카테고리</th>
						<td><!-- disabled 속성을 쓰면 값이 넘어가지 않음 -->
							<input type="text" name="pcategory_fk" value="<%=pb.getPcategory_fk()%>" class="inputTypeText" disabled >
						</td>
					</tr>
					<tr>
						<th class="th">제품 이름</th>
						<td class="td">
							<input type="text" name="pname" value="<%=pb.getPname()%>" class="inputTypeText">
						</td>
					</tr>
					<tr>
						<th class="th">제품 사진</th>
						<td class="td">
							<img src="<%=request.getContextPath()%>/product_img/<%=pb.getPimage() %>" width="300"><br>
							<input type="hidden" name="pimageold" value="<%=pb.getPimage()%>">
							<input type="text" class="filebox" placeholder="<%=pb.getPimage()%>" readonly>
						    <label for="file" class="fileButton">파일찾기</label> 
							<input type="file" id="file" name="pimage" class="delFileForm" onclick="fileName()">
						</td>
					</tr>
					<tr>
						<th class="th">제품 수량</th>
						<td class="td">
							<input type="text" name="pqty" class="inputTypeText" value="<%=pb.getPqty()%>">
						</td>
					</tr>
					<tr>
						<th class="th">제품 가격</th>
						<td class="td">
							<input type="text" name="price" class="inputTypeText" value="<%=pb.getPrice()%>">
						</td>
					</tr>
					<tr>
						<th class="th">제품 설명</th>
						<td class="td">
							<textarea rows="5" cols="30" style="resize:none" name="pcontents" class="inputTypeText"><%=pb.getPcontents()%></textarea>
						</td>
					</tr>
					<tr>
						<th class="th">제품 포인트</th>
						<td class="td">
							<input type="text" name="point" class="inputTypeText" value="<%=pb.getPoint()%>">
						</td>
					</tr>
				</table>
				<div class="center">
					<input type="submit" value="제품 수정" class="submit-style">
					<input type="reset" value="취소" class="submit-style" onclick="history.go(-1)"> 
				</div>
			</form>
	</div>
	<%@ include file="b_bottom.jsp"%>
</body>
</html>