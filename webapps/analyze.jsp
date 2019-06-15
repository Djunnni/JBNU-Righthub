<%@page import="java.util.Random"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Righthub.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  %>
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
	    	.ct-round .ct-label {
	    		color: white;
    			fill: white;
	    	}
	    	.ct-round .ct-label:nth-child(2) {
	    		display:none;
	    	}
	    	.ct-round .ct-series-a .ct-slice-pie {
	    		fill:#f47b7b;
	    	}
	    	.ct-round .ct-series-b .ct-slice-pie {
	    		fill:#eeeeee;
	    		
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
	
	 <%-- start --%>
	 <%-- start --%>
	 <%-- start --%>
	 				<!-- head -->
	 				<div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                            <div class="section-block" id="basicform">
                                <h3 class="section-title">성적 분석</h3>
                                <p>학생들의 성적을 손쉽게 분석하고 활용 하세요.</p>
                            </div>
                        </div>
                    </div>
                    <!-- tail -->
                    <div class="row">
                    <!-- 수강인원 -->
                    <%
                    	// =========================== Date ========================//
                    	Calendar cal_finish = Calendar.getInstance();
                    	Calendar cal_start = Calendar.getInstance();
                    	Calendar cal_now = Calendar.getInstance();
                    	// 달력에서 한달 빼야 됨 0=> 1월임 
                    	cal_start.set(2019,2,2);
                    	cal_finish.set(2019,5,19);
                    	long hakgiTime = (cal_finish.getTimeInMillis() - cal_now.getTimeInMillis())/1000;
                    	long doneTime = (cal_now.getTimeInMillis() - cal_start.getTimeInMillis())/1000;
                    	
                    	// =========================== DB 로직 ==========================//
                    	scoredbDao score_dao = new scoredbDao();
                    	// 과목 칼럼 종류 
                    	ArrayList<String> list_score_columns = score_dao.getColumn(classDto.getScoredbName());
                    	// 학생들 전체 리스트 
                    	ArrayList<scoredbDto> list_score_dto = score_dao.getStudentData(classDto.getScoredbName(), list_score_columns);
                  		int std_nums = list_score_dto.size();
                  		int col_nums = list_score_columns.size()-2;
                  	   	int[] datas = new int[col_nums];
                  	  	int[] datas2 = new int[col_nums];
                  	   	if(std_nums>0){
                  	   		Random random = new Random();
                  	   		//랜덤으로 2018년 test 케이스를 넣는다.
                  	   	for(scoredbDto x : list_score_dto){
                  	   		ArrayList<String> temp = x.getEl();
	                  	   		for(int i=0;i<temp.size()-2;i++){
	                  	   			String tmp = temp.get(i);
	                  	   			//System.out.println(tmp);
	                  	   			if(tmp!=""){
	                  	   			datas[i] += Integer.parseInt(tmp);
	                  	   			datas2[i]  += (Integer.parseInt(tmp)+(random.nextInt(20)-10));
	                  	   			}
	                  	   		}
                  	   	}
	                  	   	for(int i=0;i<col_nums;i++){
	                  	   		datas[i]=datas[i]/std_nums;
	                  	   		datas2[i]=datas2[i]/std_nums;
	                  	   	}
                  	   	}
                    %>
                       	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                       	 	<div class="card">
                    			<h5 class="card-header">수강 인원</h5>
                    			<h5 class="card-header"><%= std_nums %>명</h5>
                  			</div>
                  		</div>
                    </div>
                    <div class="row">
                    <!-- 수업진행 차트 -->
                       	<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12">
                       	 	<div class="card">
                       	 	<h5 class="card-header">수업진행 현황</h5>
                  			 <div class="ct-round" style="margin:5px 0;"></div>
                  			 </div>
                  		</div>
                  	<!-- 각 평가별 학생들의 평균 -->
                    	<div class="col-xl-9 col-lg-9 col-md-9 col-sm-12 col-12">
                    		<div class="card">
                    		<h5 class="card-header">평가종목 별 평균
                    			<div style="float:right;">
                    					<span style="padding: 0 5px;background:#5969ff ;color:#fff;">2019</span>
                    					<span style="padding: 0 5px;background:#f0346e ;color:#fff;">2018</span>
                    			</div>
                    		</h5>
                  			 <div class="ct-chart" style="margin:5px 0;"></div>
                  			 </div>
                  		</div>
                    </div>
                    <div class="row">
                    <!-- 학생 성적 등급 보이기 -->
                       	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                       	 	<div class="card">
                    		<h5 class="card-header">수강학생 학점</h5>
                  			<p class="card-header">아래의 등급은 지금까지의 점수를 평가한 점수입니다.</p>
                  			<%
                  				ArrayList<scoredbDto> rank_score_list = score_dao.getRankData(classDto.getScoredbName(),list_score_columns);
                  				int rank_size = rank_score_list.size();
                  				if(rank_size>1){
                  				int A = Integer.parseInt(String.valueOf(Math.round(rank_size*0.3)));
                  				int B = Integer.parseInt(String.valueOf(Math.round(rank_size*0.65)));
                  			%>
                  			<div class="card-body" style="overflow:auto; height:500px;">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                            	  <th scope="col">No.</th>
                                          		  <th scope="col">이름</th>
                  								  <th scope="col">학번</th>
                  									<% for(int i=0;i<col_nums;i++) {
                  											out.println("<th scope=\"col\">"+ list_score_columns.get(i) +"</th>");
                  										}
                  									%>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<%
                                        		for(int i=0;i<rank_size;i++){
                                        			if(i<=A)
                                        				out.println("<tr class=\"table-primary\">");
                                        			else if(i<=B)
                                        				out.println("<tr class=\"table-success\">");
                                        			else 
                                        				out.println("<tr class=\"table-secondary\">");
                                        			
                                        			out.println("<th scope=\"row\">"+(i+1)+"</th>");
                                        			out.println("<td>"+ rank_score_list.get(i).getName() +"</td>");
                                        			out.println("<td>"+ rank_score_list.get(i).getS_num() +"</td>");
                                        			
                                        			ArrayList<String> data =  rank_score_list.get(i).getEl();
                                        			int data_size = data.size();
                                        		for(int j=1;j<data_size-2;j++){
                                        			out.println("<td>"+ data.get(j) +"</td>");
                                        		}
                                        	}%>
                                        </tbody>
                                    </table>
                                </div>
                                <%} else {out.println("데이터가 없습니다.");} %>
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
    <script>
    // average bar //
    <% 
    StringBuilder col = new StringBuilder();
	for(int i=0;i<list_score_columns.size()-2;i++) {
			col.append("'"+list_score_columns.get(i)+"'");
		if(i!=list_score_columns.size()-3) col.append(",");
	}
	col.toString();
    %>
    var data = {
    		  labels: [<%=col%>],
    		  series: [
    		    <%= Arrays.toString(datas) %>,
    		    <%= Arrays.toString(datas2) %>,
    		  ]
    		};

    		var options = {
    		  seriesBarDistance: 10
    		};

    		var responsiveOptions = [
    		  ['screen and (max-width: 640px)', {
    		    seriesBarDistance: 5,
    		    axisX: {
    		      labelInterpolationFnc: function (value) {
    		        return value[0];
    		      }
    		    }
    		  }]
    		];

    		new Chartist.Bar('.ct-chart', data, options, responsiveOptions);

    		// Time //
    		var time_data = {
    				  series: [<%=doneTime%>,<%=hakgiTime %>]
    				};

    				var sum = function(a, b) { return a + b };

    				new Chartist.Pie('.ct-round', time_data, {
    				  labelInterpolationFnc: function(value) {
    				    return Math.round(value / time_data.series.reduce(sum) * 100) + '%';
    				  }
    		});
    </script>
</body>
</html>
<%}%>