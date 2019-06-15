<%-- 사이드 바를 나타낸다 --%>
<%@page import="Righthub.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	String url = request.getRequestURI();
%>
       <!-- left sidebar -->
        <!-- ============================================================== -->
    
        <div class="nav-left-sidebar sidebar-dark">
            <div class="menu-list">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <a class="d-xl-none d-lg-none" href="#">Dashboard</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav flex-column">
                            <li class="nav-divider">
                                Menu
                            </li>
                             <a class="nav-item">
					           <a class="nav-link <%if(url.contains("class.jsp")) out.println("active"); %>" href="class.jsp"><i class="fa fa-fw fa-user-circle"></i>홈</a>
					       </a>
                            
<%
	//유저 정보 받기완료 
	LoginDto User = (LoginDto) session.getAttribute("dto");
	String type = User.getType();
	
	if(type.equals("professor")){
%>
       <li class="nav-item">
           <a class="nav-link <%if(url.contains("analyze.jsp")) out.println("active"); %>" href="analyze.jsp"><i class="fa fa-fw fa-chart-pie"></i>성적 분석</a>
       </li>
       <li class="nav-item">
           <a class="nav-link <%if(url.contains("alert.jsp")) out.println("active"); %>" href="alert.jsp"><i class="fas fa-fw fa-rocket"></i>공지 알림</a>
       </li>
       <li class="nav-item ">
           <a class="nav-link <%if(url.contains("question.jsp")) out.println("active"); %>" href="question.jsp"><i class="fab fa-fw fa-wpforms"></i>이의 처리</a>
       </li>
       <li class="nav-item">
           <a class="nav-link <%if(url.contains("input.jsp")) out.println("active"); %>" href="input.jsp"><i class="fas fa-fw fa-table"></i>성적 입력</a>
       </li>
<% } else { %>              
 	   <li class="nav-item ">
           <a class="nav-link <%if(url.contains("question.jsp")) out.println("active"); %>" href="question.jsp"><i class="fab fa-fw fa-wpforms"></i>이의 제기</a>
       </li>
       <li class="nav-item">
           <a class="nav-link <%if(url.contains("view.jsp")) out.println("active"); %>" href="view.jsp"><i class="fas fa-fw fa-table"></i>성적 확인</a>
       </li>
<% } %>    
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- end left sidebar -->