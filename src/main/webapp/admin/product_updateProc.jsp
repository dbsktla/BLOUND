<%@page import="shop.ProductDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int maxSize = 1920 * 1920 * 10;
	MultipartRequest mr = null;
	String msg = "", url = "";
	
	String configFolder = config.getServletContext().getRealPath("/product_img/");
	mr = new MultipartRequest(request,configFolder,maxSize,"UTF-8",new DefaultFileRenamePolicy());
	
	//텍스트가 넘어와서 mr.getFilesystemName - 이미지 받는거가 아닌 getParameter로 받음
	String pimageold = mr.getParameter("pimageold");//기존 이미지.jpg라는 글자가 넘어옴
	String pimage = mr.getFilesystemName("pimage");//새 이미지. 파일이 넘어옴
	System.out.println(pimageold);
	System.out.println(pimage);
	
	String img = null;
	if(pimageold == null){
		if(pimage != null){ //기존 이미지 x, 새 이미지o
			img = pimage; //새 이미지 넣기
		}
	}else if(pimageold != null){
		if(pimage == null){ //기존 이미지 o, 새 이미지x
			img = pimageold; //기존 이미지 넣기
		}else{ //기존 이미지 o, 새 이미지o
			img = pimage; //새 이미지 넣기
			File delFile = new File(configFolder,pimageold); //문자열->폴더화
			delFile.delete(); //기존 이미지 지우기
		}
	}
	ProductDAO pdao = ProductDAO.getInstance();
	int cnt = pdao.updateProduct(mr,img);  
	 
	if(cnt > 0){
		msg = "상품 수정 성공했습니다.";
		url = "product_list.jsp";
	}else{
		msg = "상품 수정 실패했습니다.";
		url = "product_input.jsp";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url %>";
</script>