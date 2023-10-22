<%@page import="shop.ProductDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String pname = request.getParameter("pname");
	int maxSize = 1920 * 1920 * 10;
	MultipartRequest mr = null;
	
	//올릴때 config
	String configFolder = config.getServletContext().getRealPath("/product_img/"); //한줄로 한번에 쓰기
	//갖고올때 request
	String requestFolder = request.getContextPath()+"/product_img/";
	
	String msg = "", url = "";
	try{
		mr = new MultipartRequest(request,configFolder,maxSize,"UTF-8",new DefaultFileRenamePolicy());
		//파일명 가져오기
		System.out.println(mr.getParameter("pname"));
		System.out.println(mr.getParameter("pimage")); //업로드는 되는데 null 나옴
		System.out.println(mr.getFilesystemName("pimage")); //제대로 이름 나옴(중복 넘버링)
		System.out.println(mr.getOriginalFileName("pimage")); //오리지널 이름 나옴
		
		ProductDAO pdao = ProductDAO.getInstance();
		int cnt = pdao.insertProduct(mr); //mr은 폼에서 넘어온 모든걸 관리함  
		
		if(cnt > 0){
			msg = "제품 등록 성공했습니다.";
			url = "product_list.jsp";
		}else{
			msg = "제품 등록 실패했습니다.";
			url = "product_input.jsp";
		}
	}catch(Exception e){ //숫자창 문자로 입력했을때
		msg = "가격, 수량, 포인트는 숫자로 입력하세요.";
		url = "product_input.jsp";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url %>";
</script>