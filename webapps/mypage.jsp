<%@page import="Righthub.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.html"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
	//유저 정보 받기완료 
	LoginDto User = (LoginDto) session.getAttribute("dto");
	if(User==null) response.sendRedirect("error.html"); else{

  		String type="";
  		if(User.getType().equals("std")) type="학생";
  		else if(User.getType().equals("pre_std")) type="대학원생";
  		else type="교수";
  	
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
	    	.dashboard-wrapper {
	    		margin:0;
	    	}
	    
	    </style> 
</head>
<body>
 <div class="dashboard-main-wrapper">
	<jsp:include page="topbar.jsp"></jsp:include>
	    <div class="dashboard-wrapper">
            <div class="dashboard-ecommerce">
                <div class="container-fluid dashboard-content ">
	 <%-- start --%>
	 <%-- start --%>
	 <%-- start --%>
	 
	 <%-- header --%>
	 				<div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                            <div class="section-block" id="basicform">
                                <h3 class="section-title">계정 설정</h3>
                                <p>개인 정보를 확인할 수 있습니다.</p>
                            </div>
                        </div>
                    </div>
      <%-- content --%>
                       <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" style="padding:0;">
                     		<div class="card">
                       		  <div class="card-body">
                          		   <div class="table-responsive">
                          		    계정의 정보를 출력합니다.
                          		    <table style="width:100%; margin-top:10px;">
                          		    	<tr>
                          		    		<% if(type.equals("교수")){ %>
                          		    		<td>교수번호</td>
                          		    		<% } else { %>
                          		    		<td>학번</td>
                          		    		<% } %>
                          		    		<td><%= User.getS_num() %></td>
                          		    	</tr>
                          		    	<tr>
                          		    		<td>이름</td>
                          		    		<td><%= User.getName() %></td>
                          		    	</tr>
                          		    	<tr>
                          		    		<td>이메일</td>
                          		    		<td><%= User.getEmail() %></td>
                          		    	</tr>
                          		    	<tr>
                          		    		<td>전공</td>
                          		    		<td><%= User.getMajor()  %></td>
                          		    	</tr>
                          		    	<tr>
                          		    		<td>직업</td>
                          		    		<td><%= type %></td>
                          		    	</tr>
                          		    	<!-- <tr>
                          		    		<td>현재 비밀번호</td>
                          		    		<td></td>	
                          		    	</tr>
                          		    	<tr>
                          		    		<td>비밀번호 변경</td>
                          		    		<td></td>
                          		    	</tr>
                          		    	<tr>
                          		    		<td>비밀번호 재확인</td>
                          		    		<td></td>
                          		    	</tr> -->
                          		    </table>
                          		    
                          		   </div>
	                   		  </div>
                  			</div>
              			</div>
                    
     <%-- end --%>
     <%-- end --%>
     <%-- end --%>
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