<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="Righthub.LoginDao,Righthub.LoginDto"  errorPage="index.html"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Signing up....</title>
</head>
<body>
<!-- 기능 : 회원가입을 처리하고 index.html로 리다이렉트  -->
<%-- DTO 객체에 내용저장 --%> 
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="dto" class="Righthub.LoginDto" scope="page"></jsp:useBean>
<jsp:setProperty property="s_num" name="dto"  />
<jsp:setProperty property="name" name="dto" />
<jsp:setProperty property="password" name="dto"/>
<jsp:setProperty property="email" name="dto"/>
<jsp:setProperty property="phone" name="dto"/>
<jsp:setProperty property="major" name="dto"/>
<jsp:setProperty property="type" name="dto" />

<%-- DAO 객체불러오기 --%>
<jsp:useBean id="dao" class="Righthub.LoginDao" scope="page"></jsp:useBean>
<%
	if(dto.getS_num()!=null && dto.getPassword()!=null){
		if(!dao.is_InDB(dto)){
			boolean success = dao.insertDB(dto);
			if(success==true){
%>
<jsp:forward page="index.html"></jsp:forward>
<%		} else { 
			out.println("<script>alert(\"회원가입을 실패하였습니다. 확인후 다시 입력바랍니다.\"); history.go(-1)</script>");
			}
		}
		out.println("<script>alert(\"이미 해당 학번의 계정이 있습니다. 확인후 다시 입력바랍니다.\"); history.go(-1)</script>");
	}	else { 
	response.sendRedirect("signup.html");
}%>

</body>
</html>