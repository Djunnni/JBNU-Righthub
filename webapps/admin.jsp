<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  errorPage="admin.html"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Righthub 관리자</title>
<style>
	input {
		background: blue;
		color:white;
	}
</style>
</head>
<body>
<%@ page import="java.util.*,Righthub.*" %>
<% 
	String name = request.getParameter("id");
	String password = request.getParameter("password");
	if(name.equals("root") && password.equals("web2019")){
		// ID : root, PASSWORD : web2019
%>
	<jsp:useBean id="dao" class="Righthub.LoginDao" scope="page"></jsp:useBean>	
<%
	ArrayList<LoginDto> list = dao.getProfessorAll();
	int count = list.size();
	int row = 0;
	
	if(count>0){ %>
		<h2>회원가입 교수용 -인증승인-</h2><hr>
		<table width=1000 border=1 cellpadding=1 cellspacing=3 >
			<tr>
				<th>교수번호</th>
				<th>이름</th>
				<th>비밀번호</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>학부</th>
				<th>타입</th>
				<th>승인</th>
			</tr>
			<%
				for(LoginDto dto : list) {
			%>
			<tr>
				<td align=center><%=dto.getS_num() %></td>
				<td align=center><%=dto.getName() %></td>
				<td align=left><%=dto.getPassword() %></td>
				<td align=left><%=dto.getEmail() %></td>
				<td align=left><%=dto.getPhone() %></td>
				<td align=left><%=dto.getMajor() %></td>
				<td align=center><%=dto.getType() %></td>
				<td align=center><% if(dto.getConfirm()==0){ %>
					<form action="admin_process.jsp" method="post">
						<input style="display:none;" name="s_num" value=<%=dto.getS_num() %> />
						<input type="submit" value="승인하기">
					</form>
					<% } else out.println("승인완료");  %>
					
					</td>
			</tr>
			<% } %>
		</table>
		<% }
} else {
		out.println("ADMIN LOGIN FAILED");
		response.sendRedirect("admin.html");
	}
%>



</body>
</html>