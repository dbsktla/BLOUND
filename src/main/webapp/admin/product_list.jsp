<%@page import="shop.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../style.css?after" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
	function deleteCheck(pnum, pimage){
		//대화상자 confirm으로 뛰워서 확인/취소 선택할수 있게 함
		//확인 : true / 취소 : false
		var isDel = confirm("제품을 삭제하시겠습니까?");
		if(isDel){ //확인 눌렀을 때
			location.href="product_delete.jsp?pnum="+pnum+"&pimage="+pimage; //위에 받아왔으니까
		}
	}//deleteCheck
</script>
<style type="text/css">
	table{
		margin: auto;
		text-align: center;
	}
</style>
</head>
<body class="background-color">
<%
	request.setCharacterEncoding("UTF-8");
	ProductDAO pdao = ProductDAO.getInstance();
	ArrayList<ProductBean> lists = pdao.getAllProduct();   
%>
<%@ include file="b_top.jsp"%>
	<div class="productList_size">
		<div class="pageTitle_kor">
			<font>제품 목록</font>
		</div>
		<table border="1" width="1100px">
			<tr height="75px">
				<th class="c_th">번호</th>
				<th class="c_th">제품 사진</th>
				<th class="c_th">제품 코드</th>
				<th class="c_th">제품 이름</th>
				<th class="c_th">가격</th>
				<th class="c_th">수량</th>
				<th class="c_th">수정</th>
				<th class="c_th">삭제</th>
			</tr>
<%
		if(lists.size() == 0){ //등록한 것 x
			out.println("<tr><td colspan=8 align='center'>등록된 상품이 없습니다.</td></tr>");
		}else{
			for(int i=0;i<lists.size();i++){
	%>
				<tr height="60px" class="tr_underline">
					<td width="8%"><%= lists.get(i).getPnum() %></td>
					<td width="20%">
						<a href="product_view.jsp?pnum=<%=lists.get(i).getPnum()%>">
						<img src="<%=request.getContextPath()%>/product_img/<%= lists.get(i).getPimage() %>" width="100%">
						</a>
					</td>
					<td width="26%"><%= lists.get(i).getPcategory_fk() %></td>
					<td width="10%"><%= lists.get(i).getPname() %></td>
					<td width="10%"><%= lists.get(i).getPrice() %></td>
					<td width="10%"><%= lists.get(i).getPqty() %></td>
					<td width="8%">
						<a class="underline" href="product_updateForm.jsp?pnum=<%=lists.get(i).getPnum()%>">수정</a>
					</td>
					<td width="8%">
						<a class="underline" href="javascript:deleteCheck('<%=lists.get(i).getPnum()%>','<%=lists.get(i).getPimage()%>')">삭제</a>
					</td>
				</tr>
	<%}}%>
		</table>
	</div>
<%@ include file="b_bottom.jsp"%>
</body>
</html>  