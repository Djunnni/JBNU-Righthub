<%@page import="Righthub.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  errorPage="error.html"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
	//유저 정보 받기완료 
	session.removeAttribute("ClassDto");
	LoginDto User = (LoginDto) session.getAttribute("dto");
	if(User==null ) response.sendRedirect("error.html"); else{

	String type= User.getType();
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
	    	.card {
	    	margin-bottom:0;
	    	}
	    </style>
</head>
<body>
 <div class="dashboard-main-wrapper">
	<jsp:include page="topbar.jsp"></jsp:include>
	
      <div class="dashboard-wrapper">
            <div class="dashboard-ecommerce">
                <div class="container-fluid dashboard-content ">
                <%-- 내용넣기 --%>
<% if(type.equals("professor")) { %>
					<!-- add button row -->
 					<div class="row">
 						<div class="col-xl-4 col-lg-6 col-md-6 col-sm-12 col-12">
 							<div class="card-body">
                                <div class="card bg-primary text-white text-center p-3">
                                       <a href="addclass.jsp" style="color:white;"><blockquote class="blockquote mb-0">
                                            <p> + 과목생성</p>
                                            <footer class="blockquote-footer text-white">
                                                <small><cite title="Source Title">버튼을 클릭해 주세요 </cite></small>
                                            </footer>
                                        </blockquote></a>
                                 </div>
                         	</div>
                     	</div>
                     </div>
                     <!-- add button row end -->
                     <%
                     	classDao class_dao = new classDao();
                     	ArrayList<classDto> list = class_dao.getClassAll(User.getS_num());
                     	int i=0;
                  		String[] colors = {"bg-brand","bg-success","bg-dark","bg-secondary-light","bg-brand-light"};
                     %>
                     <hr>
                     
                     <div class="row">
                     <% for(classDto dto : list) { %>
                     <!-- row start -->
                      <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12 col-12">
 							<div class="card-body">
 								
                                <div class="card <%=colors[i++%7] %> text-white text-center p-3">
                                       <a href='enterclass.jsp?class=<%=dto.getScoredbName() %>' style="color:white;"><blockquote class="blockquote mb-0">
                                            <p style="font-weight:bold;"><%=dto.getClassName() %></p>
                                            <footer class="text-white">
                                                <p style="font-size:16px;">이동하기</p>
                                            </footer>
                                        </blockquote></a>
                                 </div>
                         	</div>
                     	</div>
                     	<% } %>
                     </div>
                    <!-- row end -->  
                    </div>
                     
<% } else { %>
	<%-- 학생용 사이트 --%> 
	<!-- add button row -->
 					<div class="row">
 						<div class="col-xl-4 col-lg-6 col-md-6 col-sm-12 col-12">
 							<div class="card-body">
                                <div class="card bg-secondary text-white text-center p-3">
                                       <div style="color:white;"><blockquote class="blockquote mb-0">
                                            <p style="margin:0 0 5px 0;" >과목 가입하기</p>
                                            <form action="signclass.jsp" action="post">
                                            	<input style="font-size: 12px; border-radius:5px; width:50%;" type="text" maxlength=10 name="code">
                                            	<input style="font-size: 12px; border-radius:5px; cursor:pointer;" type="submit" value="가입하기">
                                            </form>
                                            <footer class="blockquote-footer text-white">
                                                <small>'가입하기' 버튼을 클릭해 주세요</small>
                                            </footer>
                                        </blockquote></div>
                                 </div>
                         	</div>
                     	</div>
                     </div>
                     <!-- add button row end -->
                     <hr style="margin:0;">
                     <%
	                  	int i=0;
	               		String[] colors = {"bg-brand","bg-success","bg-dark","bg-secondary-light","bg-brand-light"};
	               		classDao class_dao = new classDao();
	               		scoredbDao score_dao = new scoredbDao();
	        			
	                  	ArrayList<classDto> list = class_dao.getClassAll_std();
	                  	ArrayList<classDto> resize = new ArrayList<classDto>();
	                  
	                  	for(classDto dto : list) {
	                  		if(score_dao.checkinDB(dto.getScoredbName(),User.getS_num()))
	                  			resize.add(dto);
	                  	}
                     %>
                      <div class="row">
                     <% for(classDto dto : resize) { %>
                     <!-- row start -->
                      <div class="col-xl-4 col-lg-6 col-md-6 col-sm-12 col-12">
 							<div class="card-body">
 								
                                <div class="card <%=colors[i++%7] %> text-white text-center p-3">
                                       <a href='enterclass.jsp?class=<%=dto.getScoredbName() %>' style="color:white;"><blockquote class="blockquote mb-0">
                                            <p style="font-weight:bold;"><%=dto.getClassName() %></p>
                                            <footer class="text-white">
                                                <p style="font-size:16px;">이동하기</p>
                                            </footer>
                                        </blockquote></a>
                                 </div>
                         	</div>
                     	</div>
                     	<% } %>
<% } %>
			<%-- 내용  --%>
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