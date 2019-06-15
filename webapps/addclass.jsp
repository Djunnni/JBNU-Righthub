<%@page import="Righthub.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
	//유저 정보 받기완료 
	LoginDto User = (LoginDto) session.getAttribute("dto");
	if(User==null || User.getConfirm()!=1) response.sendRedirect("error.html"); else{
%>
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Righthub -강의 생성하기-</title>

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
	    	#add, #delete {
	    	    font-weight: bold;
			    margin: 0 2% 2% 0;
			    border: 1px solid;
			    padding: 5px;
			    border-radius: 5px;
	    		cursor:pointer;
	    		float:left;
	    	}
	    	#submit {
	    	    background-color: cadetblue;
			    color: white;
			    border-radius: 5px;
			    padding: 1%;
			    width: 80px;
			    border: none;
	    	}
	    </style> 
</head>
<body>
 <div class="dashboard-main-wrapper">
	<jsp:include page="topbar.jsp"></jsp:include>
	    <div class="dashboard-wrapper">
            <div class="dashboard-ecommerce">
                <div class="container-fluid dashboard-content ">
	
						<div class="row">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <div class="card">
                                    <h5 class="card-header">강의 생성하기</h5>
                                    <div class="card-body">
                                        <form method="post" action="insertclass.jsp">
                                            <div class="form-group">
                                                <label for="name" class="col-form-label">교수명</label>
                                                <input name="name" type="text" class="form-control" value="<%=User.getName() %>" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="s_num" class="col-form-label">교수번호</label>
                                                <input name="s_num" type="text" class="form-control" value="<%=User.getS_num() %>" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="className" class="col-form-label">과목명</label>
                                                <input name="className" type="text" class="form-control" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputSelect1">구분</label>
                                                <select class="form-control" name="type" required>
													<option value="교양">교양</option>
													<option value="일반선택">일반선택</option>
													<option value="전공선택">전공선택</option>
													<option value="전공필수">전공필수</option>
												</select>
                                                <p>위 버튼을 눌러 학수구분을 선택해주세요.</p>
                                            </div>
                                            <hr>
                                            <p style="color:red; margin-bottom:2%;">평가하실 목록을 추가해주세요.</p>
                                          
                                            <div class="class_btn">
                                            <div id="add" style=" color:blue; font-weight:bold;" onclick="add_item();">평가목록 추가</div>
                                            <div id="delete" style="color:red; font-weight:bold;" onclick="del_item()">평가목록 제거</div>
                            			    </div>
                            			    
                                            <input name="index" id="index" type="number" style="display:none;" value=1>
                                           
                                            <div id="my_contents" style="clear:both;">
                                             <hr style="border-bottom:0;">
	                                            <div class="form-group" id="gl0" >
	                                                <label for="el0" class="col-form-label">평가이름 1</label>
	                                                <input name="el0" id="el0" type="text" class="form-control" placeholder="평가하실 항목의 이름을 적어주세요 [ ex) 중간고사 ]" required>
	                                            	<hr>
	                                            </div>
	                                           
                                            </div>
                                           <input id="submit" type="submit" value="생성">
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
	
	
	
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
  
   
</body>
<script>
	var i=1;
	function add_item(){
		console.log("add item");
		id = i+1;
		$('#my_contents').append("<div class=\"form-group\" id=\"gl"+i+"\" ><label for=\"el"+i+"\" class=\"col-form-label\">평가이름 "+id+"</label><input name=\"el"+i+"\" id=\"el"+i+"\" type=\"text\" class=\"form-control\" placeholder=\"평가하실 항목의 이름을 적어주세요 [ ex) 중간고사 ]\"><hr></div></div>");
		i=i+1;
		document.querySelector("#index").value=i;
		console.log(document.querySelector("#index").value);
	}
	function del_item() {
		if(i==1) return;
		console.log("delete item");
		var parent = document.querySelector("#my_contents");
		parent.removeChild(parent.lastChild);
		i=i-1;
		document.querySelector("#index").value=i;
		console.log(document.querySelector("#index").value);
	}
</script>
</html>
<%}%>