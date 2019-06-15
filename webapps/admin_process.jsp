<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Processing..</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="dto" class="Righthub.LoginDto" scope="page"></jsp:useBean>
<jsp:setProperty property="s_num" name="dto"  />
<jsp:useBean id="dao" class="Righthub.LoginDao" scope="page"></jsp:useBean>
<% 
   	if(dao.checkedDB(dto)){
	out.println("<script>alert(\"승인이 완료되었습니다.\"); history.go(-1)</script>");} else {		
	out.println("<script>alert(\"승인이 불허되었습니다. 관리자에게 연락바랍니다.\"); history.go(-1)</script>");
	} %>
</body>
</html>