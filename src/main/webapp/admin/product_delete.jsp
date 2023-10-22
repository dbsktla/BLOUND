<%@page import="java.io.File"%>
<%@page import="shop.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//이미지 이름은 복잡하게 알아내지 말고 걍 첨부터 이미지 이름까지 받아오기
	ProductDAO pdao = ProductDAO.getInstance();
	String pnum = request.getParameter("pnum");
	String pimage = request.getParameter("pimage");//이미지 이름, 즉 글자만 넘어옴

	//이미지까지 삭제하기 위해 경로 알아내기
	//삭제할 때도 config 객체 씀
	String configFolder = config.getServletContext().getRealPath("/");
	String delPath = configFolder+"/product_img/";
	// C:\JSP_ysy\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\18_Minimall\myshop/images/
	
	//파일 객체로 만들어서 글자가 아닌, 실제 접근 가능한 개념으로 만들어주기
	File delFile = null;
	File dir = new File(delPath);
	
	if(pimage != null){ //이미지가 존재 하면
		delFile = new File(dir,pimage); //경로랑 이미지 이름 변수에 담기
		if(delFile.exists()){ //존재하면 참이 됨
			if(delFile.delete()){ //삭제 성공하면 참이 됨
		  %><script type="text/javascript">
				alert("이미지 파일 삭제 성공");
			</script><%
			}
		}
	}//if
	
	int cnt = pdao.deleteProduct(pnum);      
			
	String msg = "";
	if(cnt > 0){
		msg = "상품 삭제 성공했습니다.";
	}else{
		msg = "상품 삭제 실패했습니다.";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="product_list.jsp";
</script>