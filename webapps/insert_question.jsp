<%@page import="Righthub.*"%>
<%@page import="java.util.ArrayList, java.util.*, java.text.*"%>
<%@page import="com.mysql.jdbc.PreparedStatement.ParseInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Questioning...</title>
</head>
<body>
<%
	LoginDto User = (LoginDto) session.getAttribute("dto");
	classDto classDto = (classDto) session.getAttribute("ClassDto");
	if(User==null)  response.sendRedirect("error.html"); else{
		
	request.setCharacterEncoding("utf-8"); 
	
	String name = request.getParameter("name");
	String s_num = request.getParameter("snum");
	String email = request.getParameter("email");
	String question = request.getParameter("question");
	
	questiondbDto question_dto = new questiondbDto();
	question_dto.setS_num(s_num);
	question_dto.setName(name);
	question_dto.setEmail(email);
	question_dto.setText(question); 
	
%>
<%-- alertdbDao 생성!! --%>
<jsp:useBean id="question_dao" class="Righthub.questiondbDao" scope="page"></jsp:useBean>
<%
	if(question_dao.inputQuestion(classDto.getQuestiondbName(),question_dto)){
		//success !!
		response.sendRedirect("class.jsp");
	} else {
		out.println("failed");
		out.println("<script>alert(\"이의제기가 신청되지 않았습니다.\n 다시 한 번 시도해 주세요\"); history.go(-1)</script>");
	}
%>
</body>
</html>
<%}%>