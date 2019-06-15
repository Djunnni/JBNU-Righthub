<%@page import="java.util.*"%>
<%@page import="Righthub.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	LoginDto User = (LoginDto) session.getAttribute("dto");
	classDto classDto = (classDto) session.getAttribute("ClassDto");
		
		
		Enumeration params = request.getParameterNames();
		ArrayList<String> columns = new ArrayList<String>();
		ArrayList<String> datas = new ArrayList<String>();
		String snum="";
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    if(name.equals("s_num")) {
		    	snum = request.getParameter("s_num");
		    }
		    else if(name.equals("oper")) break;
		    else {
		    	columns.add(name);
		    	datas.add(request.getParameter(name));
		    }
		    
		}
		
		
		scoredbDao scoredbdao = new scoredbDao();
		scoredbdao.updateStudentData(classDto.getScoredbName(), columns, datas, snum);
%>