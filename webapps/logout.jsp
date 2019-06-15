<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="index.html"%>
<%
//session에 저장된 User 정보 삭제
session.invalidate();
response.sendRedirect("./");
%>