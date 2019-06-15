<%@page import="Righthub.*"%>
<%@page import="java.util.ArrayList, java.util.*, java.text.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  errorPage="error.html"%>
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
	    
</head>
<body>
 <div class="dashboard-main-wrapper">
	<jsp:include page="topbar.jsp"></jsp:include>
	<jsp:include page="sidebar.jsp"></jsp:include>
	<!-- class 내용 받기  -->
      <div class="dashboard-wrapper">
            <div class="dashboard-ecommerce">
                <div class="container-fluid dashboard-content ">
	<!-- ============= head title ============= -->
					<div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                             <div class="section-block" id="basicform">
                                <h3 class="section-title">성적 확인</h3>
                                <p>성적을 확인합니다. 잘못된 사항은 교수님께 '이의제기' 를 통해 해결하실 수 있습니다.</p>
                            </div>
                        </div>
                    </div>
    <!-- ============= head title ============= -->
    <!-- text -->
    <!-- text -->
    <!-- text -->
    <%
    	scoredbDao score_dao = new scoredbDao();
    	ArrayList<String> columns = score_dao.getColumn(classDto.getScoredbName());
     	int size = columns.size();

    	scoredbDto score_dto = score_dao.getDataDB(classDto.getScoredbName(),User.getS_num(),columns);
    	
    %>
    <div class="row">
              <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                     <div class="card">
                     	<div class="card-body">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                            <%
						 							for(int i=0;i<size-2;i++){
						 								out.println("<th scope=\"col\">"+columns.get(i)+"</th>");
						 							}
 												%>    
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                  <%
							                   			for(int i=0;i<size-2;i++ ){
							                   				if(score_dto.getEl().get(i)==null)
							                   					out.println("<td>"+0+"</td>");
							                   				else
								                   				out.println("<td>"+score_dto.getEl().get(i)+"</td>");
								                   			}
                      							 %>	 		
                       				       </tr>
                                        </tbody>
                                    </table>
                       </div>
                    
                    </div>
                </div>
            </div>


    
    <!-- text -->
    <!-- text -->
    <!-- text -->
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