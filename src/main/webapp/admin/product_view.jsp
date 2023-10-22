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
	String pnum = request.getParameter("pnum");
	ProductDAO pdao = ProductDAO.getInstance();
	ProductBean pb = pdao.getProductView(pnum); 
%>
	<div class="register_size">
		<div class="pageTitle_kor">
			<font>제품 상세보기</font>
		</div>
			<form name="myform" method="post" enctype="multipart/form-data">
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
							<input type="text" name="pcategory_fk" value="<%=pb.getPcategory_fk()%>" class="inputTypeText" readonly >
						</td>
					</tr>
					<tr>
						<th class="th">제품 이름</th>
						<td class="td">
							<input type="text" name="pname" value="<%=pb.getPname()%>" class="inputTypeText" readonly>
						</td>
					</tr>
					<tr>
						<th class="th">제품 사진</th>
						<td class="td">
							<img src="<%=request.getContextPath()%>/product_img/<%=pb.getPimage() %>" width="300"><br>
						</td>
					</tr>
					<tr>
						<th class="th">제품 수량</th>
						<td class="td">
							<input type="text" name="pqty" class="inputTypeText" value="<%=pb.getPqty()%>" readonly>
						</td>
					</tr>
					<tr>
						<th class="th">제품 가격</th>
						<td class="td">
							<input type="text" name="price" class="inputTypeText" value="<%=pb.getPrice()%>" readonly>
						</td>
					</tr>
					<tr>
						<th class="th">제품 설명</th>
						<td class="td">
							<textarea rows="5" cols="30" style="resize:none" name="pcontents" class="inputTypeText" readonly><%=pb.getPcontents()%></textarea>
						</td>
					</tr>
					<tr>
						<th class="th">제품 포인트</th>
						<td class="td">
							<input type="text" name="point" class="inputTypeText" value="<%=pb.getPoint()%>" readonly>
						</td>
					</tr>
				</table>
				<div class="center">
					<input type="button" value="수정" class="submit-style" onclick="location.href='product_updateForm.jsp?pnum=<%=pb.getPnum()%>'">
					<input type="button" value="삭제" class="submit-style" onclick="location.href='product_delete.jsp?pnum=<%=pb.getPnum()%>&pimage=<%=pb.getPimage()%>'">
					<input type="button" value="취소" class="submit-style" onclick="history.go(-1)"> 
				</div>
			</form>
	</div>
	<%@ include file="b_bottom.jsp"%>
</body>
</html>