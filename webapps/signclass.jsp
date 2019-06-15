<%@page import="Righthub.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  errorPage="error.html"%>
      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign class...</title>
</head>
<body>
<% 
	LoginDto User = (LoginDto) session.getAttribute("dto");
	request.setCharacterEncoding("utf-8"); 
	if(User==null)  response.sendRedirect("error.html"); else{
	String code = request.getParameter("code");
	classDao class_dao = new classDao();
	String score_class = class_dao.findCode(code);
	if(score_class=="") {
		out.println("failed");
		out.println("<script>alert(\"코드를 잘못 입력하였습니다.\n 다시 한 번 시도해 주세요\"); history.go(-1)</script>");
	}
	else {
		scoredbDao scoredb_dao = new scoredbDao();
		boolean success = scoredb_dao.signClass(score_class,User);
		if (success==false){
			out.println("failed");
			out.println("<script>alert(\"코드를 잘못 입력하였습니다.\n 다시 한 번 시도해 주세요\"); history.go(-1)</script>");
		}
		else {
          	
			response.sendRedirect("main.jsp");
		}
	}
%>

</body>
</html>
<% } %>