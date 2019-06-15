<%@page import="java.util.ArrayList"%>
<%@page import="Righthub.questiondbDao"%>
<%@page import="Righthub.questiondbDto"%>
<%@page import="Righthub.classDto"%>
<%@page import="Righthub.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.html"%>
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
                
<% 
	String questionDB = classDto.getQuestiondbName();
	questiondbDao question_dao = new questiondbDao();

	if(User.getConfirm()==1){ 
 	ArrayList<questiondbDto> list = question_dao.getquestionAll(questionDB);
	int i=1;
	int size = list.size();
%>
		<!-- ============= head title ============= -->
					<div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                             <div class="section-block" id="basicform">
                                <h3 class="section-title">이의 처리</h3>
                                <p>학생들의 이의 사항을 확인하실 수 있습니다.</p>
                            </div>
                        </div>
                    </div>
        <!-- ============= head title ============= -->
        <div class="row">
                 <!-- ============================================================== -->
                 <!-- basic table  -->
                 <!-- ============================================================== -->
                 <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                     <div class="card">
                         <div class="card-body">
                             <div class="table-responsive">
                                 <table class="table table-striped table-bordered first">
                                     <thead>
                                         <tr>
                                             <th>No</th>
                                             <th>이름</th>
                                             <th>학번</th>
                                             <th>이메일</th>
                                             <th>내용</th>
                                             <th>전송날짜</th>
                                         </tr>
                                     </thead>
                                     <tbody>
                                     <% if(size>=1) { %>
                                     <% for(questiondbDto x : list) { %>
                                         <tr>
                                             <td><%= i++ %></td>
                                             <td><%=x.getName() %></td>
                                             <td><%=x.getS_num() %></td>
                                             <td><%=x.getEmail() %></td>
                                             <td><%= x.getText() %></td>
                                             <td><%= x.getRegdate() %></td>
                                         </tr>
                                      <% } } else {%>
                                       <tr><p>이의제기한 학생이 없습니다.</p></tr>
                                      <% } %>
                                 </table>
                             </div>
                         </div>
                     </div>
                 </div>
        </div>
		<%} else { %>
		<!-- ============= head title ============= -->
					<div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                             <div class="section-block" id="basicform">
                                <h3 class="section-title">이의 제기</h3>
                                <p>교수님께 이의제기할 사항을 적어주세요. 교수님께서 확인 후 메일을 보내주십니다.</p>
                            </div>
                        </div>
                    </div>
        <!-- ============= head title ============= -->
		<div class="row">
              <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                     <div class="card">
                                    <h5 class="card-header">[<%=classDto.getClassName() %>] 이의 제기</h5>
                                    <div class="card-body">
                                        <form method="post" action="insert_question.jsp">
                                            <div class="form-group">
                                                <label for="name" class="col-form-label">이름</label>
                                                <input id="name" name="name" type="text" value="<%= User.getName() %>" readonly class="form-control">
                                            </div>
                                            <div class="form-group">
                                                <label for="snum" class="col-form-label">학번</label>
                                                <input id="snum" name="snum" type="text" value="<%= User.getS_num() %>" readonly class="form-control">
                                            </div>
                                            <div class="form-group">
                                                <label for="email">이메일</label>
                                                <input id="email" type="email" name="email" value="<%= User.getEmail() %>" readonly class="form-control">
                                            </div>
                                            <div class="form-group">
                                                <label for="question" class="col-form-label">질문사항</label>
                                                 <textarea class="form-control" id="question" name="question" rows="5"></textarea>
                                            </div>
                                            <input type="submit" value="보내기" style="border-radius:5px;">
                                        </form>
                                    </div>
                                   
                                </div>
                            </div>
                        </div>
		
		<%} %>
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