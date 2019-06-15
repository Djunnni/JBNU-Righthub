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
	if(User==null || User.getConfirm()!=1)  response.sendRedirect("error.html"); else{
	request.setCharacterEncoding("utf-8"); 
	int index = Integer.parseInt(request.getParameter("index"));
	ArrayList<String> el = new ArrayList<String>();
	for(int i=0;i<index;i++){
		el.add(request.getParameter("el"+i));
	}
	SimpleDateFormat formatter = new SimpleDateFormat ( "MMddHHmmss", Locale.KOREA );
	Date currentTime = new Date ( );
	String dTime = formatter.format ( currentTime );
%>
<%-- classDB 생성!! --%>
<jsp:useBean id="class_dto" class="Righthub.classDto" scope="page"></jsp:useBean>
<jsp:setProperty property="s_num" name="class_dto"  />
<jsp:setProperty property="className" name="class_dto"/>
<jsp:setProperty property="name" name="class_dto"/>
<jsp:setProperty property="type" name="class_dto"/>
<% 
	class_dto.setScoredbName("score_"+class_dto.getS_num()+"_"+index+"_"+dTime);
	class_dto.setAlertdbName("alert_"+class_dto.getS_num()+"_"+index+"_"+dTime);
	class_dto.setQuestiondbName("question_"+class_dto.getS_num()+"_"+index+"_"+dTime);
	// Random code 생성하
	Random ran = new Random();
    String value = "";
    int i;

    for (i = 0; i < 10; i++) {     //  원하는 난수의 길이
      int num1 = (int) 48 + (int) (ran.nextDouble() * 43);
      if(num1>=58 && num1 <=64) {
   	   continue;
      }
      value = value + (char) num1;
    }
    class_dto.setAccessCode(value);
	   
%>
<jsp:useBean id="class_dao" class="Righthub.classDao"></jsp:useBean>
 <%
	// DB 삽입 완료 
	class_dao.insertDB(class_dto);

%> 
<%-- scoreDB 생성!! --%> 
<jsp:useBean id="score_dto" class="Righthub.scoredbDto"></jsp:useBean>
<jsp:useBean id="score_dao" class="Righthub.scoredbDao"></jsp:useBean>
<%
	score_dto.setEl(el);
	score_dao.createDB(score_dto, class_dto.getScoredbName(),index);
%>
<%-- alertDB 생성!! --%>
<jsp:useBean id="alert_dao" class="Righthub.alertdbDao"></jsp:useBean>
<%
	alert_dao.createDB(class_dto.getAlertdbName());
%>
<%-- Question DB 생성!! --%>
<jsp:useBean id="question_dao" class="Righthub.questiondbDao"></jsp:useBean>
<%
	question_dao.createDB(class_dto.getQuestiondbName());
%>
<%-- SUCCESS ALL! --%>
<%
	response.sendRedirect("main.jsp");
%>
</body>
</html>
<%}%>