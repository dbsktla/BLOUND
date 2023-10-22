<%@page import="shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLOUND</title>
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
	input[type=text]{
		width:60%;
	}
	textarea[name=pcontents]{
		width:95%;
		height:30%;
	}
</style>
</head>
<body>
<%@ include file="b_top.jsp"%>
<%
	CategoryDAO cdao = CategoryDAO.getInstance();
	ArrayList<CategoryBean> lists = cdao.getAllCategory();  
%>
	<div class="register_size">
		<div class="pageTitle_kor">
			<font>제품 등록</font>
		</div>
			<form name="myform" action="product_inputProc.jsp" method="post" enctype="multipart/form-data">
				<table border="1" width="1000px">
					<tr>
						<th class="th">카테고리</th>
						<td class="td">
							<select name="pcategory_fk" class="inputTypeText">
							<%
							if(lists.size() == 0){
							%>
								<option value="">카테고리 없음</option>
							<%	
							}else{
								for(int i=0;i<lists.size();i++){
							%>
								<option value="<%=lists.get(i).getCode()%>"><%=lists.get(i).getCname() %> [ <%=lists.get(i).getCode()%> ]</option>
							<%}}%>
							</select>
						</td>
					</tr>
					<tr>
						<th class="th">제품 코드</th>
						<td class="td">
							<input type="text" name="pcode" class="inputTypeText">
						</td>
					</tr>
					<tr>
						<th class="th">제품 이름</th>
						<td class="td">
							<input type="text" name="pname" class="inputTypeText">
						</td>
					</tr>
					<tr>
						<th class="th">제품 사진</th>
						<td class="td">
							<input class="filebox" placeholder="첨부파일">
						    <label for="file" class="fileButton">파일찾기</label> 
							<input type="file" id="file" name="pimage" class="delFileForm" onclick="fileName()">
						</td>
					</tr>
					<tr>
						<th class="th">제품 수량</th>
						<td class="td">
							<input type="text" name="pqty" class="inputTypeText">
						</td>
					</tr>
					<tr>
						<th class="th">제품 가격</th>
						<td class="td">
							<input type="text" name="price" class="inputTypeText">
						</td>
					</tr>
					<tr>
						<th class="th">제품 설명</th>
						<td class="td">
							<textarea rows="5" cols="30" style="resize:none" name="pcontents" class="inputTypeText" placeholder="설명"></textarea>
						</td>
					</tr>
					<tr>
						<th class="th">제품 포인트</th>
						<td class="td">
							<input type="text" name="point" class="inputTypeText">
						</td>
					</tr>
				</table>
				<div class="center">
					<input type="submit" value="제품 등록" class="submit-style"> 
				</div>
			</form>
	</div>
	<%@ include file="b_bottom.jsp"%>
</body>
</html>