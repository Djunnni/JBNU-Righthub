<%@page import="Righthub.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.html"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login...</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8"); %>
<!-- 기능 : 로그인을 확인하고 교수님일 경우 check가 되었는지 확인 그리고
학생의 경우에는 그냥 로그인 forward "main.jsp"
  -->
<%-- DTO 객체 불러오기 --%>
<jsp:useBean id="dto" class="Righthub.LoginDto" scope="session"></jsp:useBean>
<jsp:setProperty property="s_num" name="dto"  />
<jsp:setProperty property="password" name="dto"/>

<%-- DAO 객체불러오기 --%>
<jsp:useBean id="dao" class="Righthub.LoginDao" scope="session"></jsp:useBean>
<% 
	if(dao.AccessDB(dto)){
		//DB 정보 받아와서 업데이트하고 session에 저장
		LoginDto up_dt = dao.getUser(dto.getS_num());
		dto.setName(up_dt.getName());
		dto.setS_num(up_dt.getS_num());
		dto.setEmail(up_dt.getEmail());
		dto.setMajor(up_dt.getMajor());
		dto.setPassword(up_dt.getPassword());
		dto.setPhone(up_dt.getPhone());
		dto.setType(up_dt.getType());
		dto.setConfirm(up_dt.getConfirm());
		
		out.println("sucess");
		response.sendRedirect("main.jsp");
%>
		<%-- <jsp:forward page="main.jsp"></jsp:forward> --%>
<%
	} else {
		// FAILED 실패
		out.println("failed");
		out.println("<script>alert(\"학번과 비밀번호를  확인후 다시 입력바랍니다.\\n[교수님의 경우 회원가입 이후 관리자에게 권한을 받으셔야 로그인이 가능합니다.]\"); history.go(-1)</script>");
	}

%>
</body>
</html>