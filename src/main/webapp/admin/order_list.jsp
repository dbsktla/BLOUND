<%@page import="shop.OrdersDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="shop.OrdersBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLOUND</title>
<link href="../style.css?after" rel="stylesheet" type="text/css"/>
<style type="text/css">
	table{
		margin: auto;
		text-align: center;
	}
	#none{
		border: 1px solid #f3f1e8;
		text-align: right;
		padding-bottom: 20px;
	}
</style>
</head>
<body>
<%
	//처음엔 눌러서 들어오면 들어오는 게 없음. 그러다 이름 입력 후 내역 조회를 누르면 form에서 다시
	//같은 페이지로 memid를 가지고 같은 페이지로 넘어오게 됨
	String memid = request.getParameter("memid");
	Vector<OrdersBean> lists = null;
	DecimalFormat df = new DecimalFormat("###,###");
	
	OrdersDAO odao = OrdersDAO.getInstance();
	if(memid != null){//memid에 뭘 써놨다면
		lists = odao.getOrderList(memid);		
	}
%>

<%@ include file="b_top.jsp"%>
	<div class="page_size">
		<div class="pageTitle_kor-o">
			<font>주문 내역</font>
		</div>
		<table border="1" width="1000px">
			<tr>
				<td colspan="5" align="center" id="none"><br>
					<form action="order_list.jsp" method="post">
						조회할 아이디 입력 : 
						<input type="text" name="memid" size="10" class="smInputTypeText-o">
						<input type="submit" value="조회" class="smButton-o"><br>
					</form>
				</td>
			</tr>
			<tr height="75px">
				<th class="c_th">아이디</th>
				<th class="c_th">고객 이름</th>
				<th class="c_th">제품 이름</th>
				<th class="c_th">제품 수량</th>
				<th class="c_th">금액</th>
			</tr>
<%
		int total = 0;
		//처음엔 lists가 null이기 때문에 아닌걸 가정하고 코드를 써야 함
		if(lists == null){ //등록한 것 x
			out.println("<tr height='300px' class='tr_underline'><td colspan=5 align='center'>주문 내역이 없습니다.</td></tr>");
		}else{
			for(OrdersBean ob : lists){
%>
			<tr height="60px" class="tr_underline">
				<td width="20%"><%=ob.getMid() %></td>
				<td width="20%"><%=ob.getMname() %></td>
				<td width="20%"><%=ob.getPname() %></td>
				<td width="20%"><%=ob.getQty() %></td>
				<td width="20%"><%=df.format(ob.getAmount()) %></td>
			</tr>
<%			
			total += ob.getAmount();
}%>
			<tr height="75px" class="tr_underline">
				<th colspan="4" align="center" class="c_th">총 합</th>
				<th align="right" class="c_th">&#8361; <%=df.format(total)%></th>
			</tr>
			<% }%>
		</table>
	</div>
<%@ include file="b_bottom.jsp"%>
</body>
</html>