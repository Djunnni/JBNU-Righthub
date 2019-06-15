<%@page import="Righthub.classDto"%>
<%@page import="Righthub.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Entering...</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8"); %>
<%
	//유저 정보 받기완료 
	LoginDto User = (LoginDto) session.getAttribute("dto");
	if(User==null ) response.sendRedirect("error.html"); else{

%>
<%
		String x = request.getParameter("class");
%>
	<jsp:useBean id="ClassDto" class="Righthub.classDto" scope="session"></jsp:useBean>
	<jsp:useBean id="classDao" class="Righthub.classDao" scope="session"></jsp:useBean>
	<%
		classDto dto = classDao.findClass(x);
		ClassDto.setAlertdbName(dto.getAlertdbName());
		ClassDto.setClassName(dto.getClassName());
		ClassDto.setName(dto.getName());
		ClassDto.setQuestiondbName(dto.getQuestiondbName());
		ClassDto.setS_num(dto.getS_num());
		ClassDto.setScoredbName(dto.getScoredbName());
		ClassDto.setType(dto.getType());
		ClassDto.setAccessCode(dto.getAccessCode());
		response.sendRedirect("class.jsp");
	%>
</body>
</html>
<%}%>