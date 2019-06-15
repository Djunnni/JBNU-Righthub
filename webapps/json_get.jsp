<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.*"%>
<%@page import="Righthub.*"%>
<%@ page language="java" contentType="application/json; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.*" %>
<%-- 역할 : jqGrid 에 엑셀로부터 데이터를 읽고 전달합니다. --%>
<% 

	LoginDto User = (LoginDto) session.getAttribute("dto");
	classDto classDto = (classDto) session.getAttribute("ClassDto");
	
	scoredbDao scoredbdao = new scoredbDao();
	scoredbDto scoredbdto = new scoredbDto();

	ArrayList<String> columns = scoredbdao.getColumn(classDto.getScoredbName());	
 	int col_num = columns.size();
	ArrayList<scoredbDto> list = scoredbdao.getStudentData(classDto.getScoredbName(), columns);
	
	JSONArray arr = new JSONArray();
	for(scoredbDto x : list){
		JSONObject obj = new JSONObject();
		for(int i=0;i<col_num-2;i++){
			obj.put(columns.get(i),x.getEl().get(i));
		}
		obj.put("name",x.getName());
		obj.put("s_num",x.getS_num());
		arr.add(obj);
	}
	JSONObject tem = new JSONObject();
	tem.put("rows",arr);
	PrintWriter pw = response.getWriter();
	pw.print(tem);
	pw.flush();
	pw.close();


 %>
