<%@page import="shop.CategoryBean"%>
<%@page import="shop.CategoryDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="shop.ProductBean"%>
<%@page import="shop.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLOUND</title>
<link href="style.css?after" rel="stylesheet" type="text/css"/>
<script type="text/javascript">
	function goCart(pnum,o_pqty){
		id = document.f.id.value;
		oqty = document.f.oqty.value;
		if(id == "admin"){
			alert("관리자 계정으로는 구매가 불가능합니다.");
			return;
		}
		if(oqty < 1){
			alert("주문 수량은 1개 이상으로 선택해주세요.");
			return;
		}
		else if(oqty > o_pqty){
			alert("주문 수량이 재고 수량보다 많습니다.");
			return;
		}
		location.href="<%=request.getContextPath()%>/user/cart_add.jsp?pnum="+pnum+"&oqty="+oqty;
	}//goCart
	
	function goOder(pnum,o_pqty){
		id = document.f.id.value;
		oqty = document.f.oqty.value;
		if(id == "admin"){
			alert("관리자 계정으로는 구매가 불가능합니다.");
			return;
		}
		if(oqty < 1){
			alert("주문 수량은 1개 이상으로 선택해주세요.");
			return;
		}
		if(oqty > o_pqty){
			alert("주문 수량이 재고 수량보다 많습니다.");
			return;
		}
		//여기서 입력 받은 폼 액션 설정 / submit 누른 것 같은 효과를 주는 것.
		//submit 같은 효과니까 폼 안에 입력받은 값은 자동으로 다 넘어감. pnum은 따로 넘겨주기
		document.f.action="order_list.jsp?pnum="+pnum;  
		document.f.submit();
	}//goOder
</script>
</head>
<body>
<%
	//application 객체는 프로젝트당 하나만 만들어짐 / 프로젝트 전반에 걸쳐 사용할 변수는 이걸 이용
	//application 속성으로 변수를 만들면 프로젝트 내부 어디서든 사용 가능함
	application.setAttribute("flag", true); //(속성명, 값) flag라는 변수에 true를 넣은것과 비슷
	String id = (String)session.getAttribute("sid");
	
	String pnum = request.getParameter("pnum");
	ProductDAO pdao = ProductDAO.getInstance();
	
	ProductBean pb = pdao.getProductView(pnum);
	
	DecimalFormat df = new DecimalFormat("###,###");
	String imgPath = request.getContextPath()+"/product_img/"+pb.getPimage();
%>
<%@ include file="b_top.jsp"%>
	<div class="shop-view-size">
		<div class="shop-width">
			<div class="pageTitle-l">
			<!-- 타이틀 텍스트 -->
				<font><%=pb.getPname()%></font>
			</div>
			<!-- 상단 폼 -->
			<div class="view-container">
			<!-- 왼쪽 이미지 -->
				<div class="view-product-img">
					<img src="<%=imgPath%>" width="100%">
				</div>
			<!-- 오른쪽 설명 -->
				<div class="text-container">
					<div class="view-box">
						<div class="view-topBox">
							<div class="ex-top">
								<span class="ex-title-l bold"><%=pb.getPname()%></span>
								<span class="ex-title-r bold"><%=df.format(pb.getPrice())%> &#8361;</span>
							</div>
							<div class="ex-bottom">
								<span class="ex-font"><%=pb.getPcontents() %></span>
							</div>
						</div>
						<div class="view-bottomBox">
							<div class="width-m-b left">
								<span><%=df.format(pb.getPoint())%> point</span>
							</div>
							<div class="width">
								<span class="left"><%=df.format(pb.getPrice())%> &#8361;</span>
								<form name="f" method="post">
								<input type="hidden" name="id" value="<%=id %>">
								<span class="right"><input type="text" name="oqty" value="1" size="2" class="inputBox"> 개</span>
								</form>
							</div>
						</div>
					</div>
					<div class="view-button-container">
						<input type="button" value="CART" class="black-button" onClick="goCart(<%=pnum%>,<%=pb.getPqty()%>)">
						<input type="button" value="BUY NOW" class="black-button" onClick="goOder(<%=pnum%>,<%=pb.getPqty()%>)">
					</div>
				</div>
			</div>
			<!-- 하단 폼 -->
			<!-- information 박스 -->
				<div class="inf-box">
					<span class="inf-titme bold">INFORMATION</span>
				</div>
			<!-- 사진+설명 박스 -->	
				<div id="img-box" style="background-image: url('<%=imgPath%>'); background-size : cover; width:100%; height:820px; position: relative;">
					<span style="position: absolute; top: 30%; left: 50%; transform: translate(-50%, -50%); z-index: 1; color:#F4F2E9; font-weight:700px; font-size:70px;"><%=pb.getPname()%></span>
					<div class="sm-underline"></div>
					<div class="inf-text-box">
						<span class="inf-text"><%=pb.getPcontents() %></span>
					</div>
				</div>
		</div>
	</div>	
<%@ include file="b_bottom.jsp"%>
</body>
</html>