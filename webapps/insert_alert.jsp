<%@page import="Righthub.classDto"%>
<%@page import="Righthub.LoginDto"%>
<%@page import="java.util.ArrayList, java.util.*, java.text.*"%>
<%@page import="com.mysql.jdbc.PreparedStatement.ParseInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Inserting...</title>
</head>
<body>
<%
	LoginDto User = (LoginDto) session.getAttribute("dto");
	classDto classDto = (classDto) session.getAttribute("ClassDto");
	if(User==null || User.getConfirm()!=1)  response.sendRedirect("error.html"); else{
		
	request.setCharacterEncoding("utf-8"); 
	String text = request.getParameter("content");
%>
<%-- alertdbDao 생성!! --%>
<jsp:useBean id="alert_dao" class="Righthub.alertdbDao" scope="page"></jsp:useBean>
<%
	if(alert_dao.insertalertDB(classDto.getAlertdbName(), text)){
		//success !!
		response.sendRedirect("class.jsp");
	} else {
		out.println("failed");
		out.println("<script>alert(\"공지알림이 업로드 되지 않았습니다.<br> 다시 한 번 시도해 주세요\"); history.go(-1)</script>");
	}
%>
</body>
</html>
<%}%>