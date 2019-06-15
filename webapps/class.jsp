<%@page import="Righthub.alertdbDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Righthub.classDto"%>
<%@page import="Righthub.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@page import="java.net.URLDecoder" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
	//유저 정보 받기완료 
	LoginDto User = (LoginDto) session.getAttribute("dto");
	classDto classDto = (classDto) session.getAttribute("ClassDto");
	if(User==null || classDto ==null ) response.sendRedirect("error.html"); else{
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Righthub Main</title>

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.min.css">
	    <link href="assets/vendor/fonts/circular-std/style.css" rel="stylesheet">
	    <link rel="stylesheet" href="assets/libs/css/style.css">
	    <link rel="stylesheet" href="assets/vendor/fonts/fontawesome/css/fontawesome-all.css">
	    <link rel="stylesheet" href="assets/vendor/charts/chartist-bundle/chartist.css">
	    <link rel="stylesheet" href="assets/vendor/charts/morris-bundle/morris.css">
	    <link rel="stylesheet" href="assets/vendor/fonts/material-design-iconic-font/css/materialdesignicons.min.css">
	    <link rel="stylesheet" href="assets/vendor/charts/c3charts/c3.css">
	    <link rel="stylesheet" href="assets/vendor/fonts/flag-icon-css/flag-icon.min.css">
	    <style>
        .card-text {
          color:black;
        }
	     #alert > .card:nth-child(2){
        background: cadetblue;
       }
       #alert > .card:nth-child(3){
        background: coral;
        }
        #alert > .card:nth-child(2) .card-text{
        color:#fff;
       }
       #alert > .card:nth-child(3) .card-text{
        color:#fff;
        }
	    </style>
</head>
<body>
 <div class="dashboard-main-wrapper">
	<jsp:include page="topbar.jsp"></jsp:include>
	<jsp:include page="sidebar.jsp"></jsp:include>
	<!-- class 내용 받기  -->
      <div class="dashboard-wrapper">
            <div class="dashboard-ecommerce">
                <div class="container-fluid dashboard-content ">
                
                <div class="row" >
                	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" style="color:white">
                		<div class="card text-white p-3" 
                				style="    
                					 margin-bottom:15px;
									 background: transparent;
									 border: none;
									 box-shadow: none;">
                  			<h2 style="margin:0;"><%=classDto.getClassName() %></h2>
                  		</div>
                  </div>
                </div>
	<%-- 작업공간 --%>
	<%-- 작업공간 --%>
	<%-- 작업공간 --%>
		
		<div class="row">
	      <div class="col-xl-9 col-lg-9 col-md-12 col-sm-12 col-12">
          	<div class="card-body" style="padding:0;">
                <div id="alert" class="card text-white p-3">
                    <h3> 공지 사항 </h3>
					<jsp:useBean id="alert_dao" class="Righthub.alertdbDao" scope="page"></jsp:useBean>
<%
					ArrayList<alertdbDto> list = alert_dao.getalertdbAll(classDto.getAlertdbName());
					int count = list.size();
					if(count>0){
						
					for(int i=count-1;i>=0;i--) {
%>
                    <div class="card">
                        <div class="card-body">
                            <p  style="float:right;"class="card-text"><small class="text-muted"><%=list.get(i).getRegdate() %></small></p>
                            <h3 class="card-title"><%=list.get(i).getNum() %></h3>
                            <p class="card-text" style="font-size:1.2em;"><%= list.get(i).getContent() %></p>
                            
                        </div>
                    </div>
<%
					} } else {
%>
					<p style="color:black">수업 공지가 아직 올라오지 않았습니다. ^^</p>
<%
					}
%>
                </div>
          	</div>
		  </div>
    </div>
	<% if(User.getConfirm()==1){  %>	
		<div class="row">
	      <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
          	<div class="card-body" style="padding:0;">
                <div id="alert" class="card text-white p-3">
                    <h5>과목코드는 "<%=classDto.getAccessCode() %>" 입니다.</h5>
                    <p style="color:black">학생들에게 공지해주세요</p>
                </div>
             </div>
           </div>
         </div>
    <% } %>
	<%-- 작업공간 --%>
	<%-- 작업공간 --%>
	<%-- 작업공간 --%>
	<jsp:include page="footer.jsp"></jsp:include>
			</div>
		</div>
	</div>
	
 </div>
  <!-- ============================================================== -->
    <!-- end main wrapper  -->
    <!-- ============================================================== -->
    <!-- Optional JavaScript -->
    <!-- jquery 3.3.1 -->
    <script src="assets/vendor/jquery/jquery-3.3.1.min.js"></script>
    <!-- bootstap bundle js -->
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.js"></script>
    <!-- slimscroll js -->
    <script src="assets/vendor/slimscroll/jquery.slimscroll.js"></script>
    <!-- main js -->
    <script src="assets/libs/js/main-js.js"></script>
    <!-- chart chartist js -->
    <script src="assets/vendor/charts/chartist-bundle/chartist.min.js"></script>
    <!-- sparkline js -->
    <script src="assets/vendor/charts/sparkline/jquery.sparkline.js"></script>
</body>
</html>
<%}%>