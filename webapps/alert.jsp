<%@page import="Righthub.classDto"%>
<%@page import="Righthub.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   errorPage="error.html"%>
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
       #submit {
          border-radius: 5px;
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
  <%-- 여기서부터 --%>
  <%-- 여기서부터 --%>
  <%-- 여기서부터 --%>
                    <div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                            <div class="section-block" id="basicform">
                                <h3 class="section-title">공지 알림</h3>
                                <p>내용을 작성하시면 과목 메인페이지에 공지 알림에 올라가게 됩니다. 학생들에게 공지하실 내용을 적어주세요.</p>
                            </div>
                            <div class="card">
                                <h5 class="card-header">공지알림</h5>
                                <div class="card-body">
                                    <form action="insert_alert.jsp" method="post">
                                       <!--  <div class="custom-file mb-3">
                                            <input type="file" class="custom-file-input" id="File">
                                            <label class="custom-file-label" for="File">파일 업로드 [ 클릭해주세요 ] </label>
                                        </div> -->
                                        <div class="form-group">
                                            <label for="content">공지하실 내용을 기입해주세요.</label>
                                            <textarea class="form-control" name="content" id="content" rows="5" required></textarea>
                                        </div>
                                        <input type="submit" id="submit" value="올리기">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
    <%-- END --%>
    <%-- END --%>
    <%-- END --%>
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