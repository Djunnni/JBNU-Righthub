<%@page import="java.util.ArrayList"%>
<%@page import="Righthub.scoredbDao"%>
<%@page import="Righthub.classDto"%>
<%@page import="Righthub.LoginDto"%>
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
	    <link rel="stylesheet" href="jqGrid_ui/jquery-ui.min.css" type="text/css" media="screen">
	  	<style>
	  	.tab-regular .nav.nav-tabs .nav-item {
	  		margin-bottom:-1px;
	  	}
        #lui_list,.ui-jqgrid-resize, .ui-jqgrid-resize-ltr {
            display:none;
        }
        .ui-jqgrid .ui-jqgrid-bdiv { overflow-y: scroll; }
        .ui-jqgrid-resize-mark {display:none;}
	  	</style>
	  	
		<!-- Optional JavaScript -->
	    <!-- jquery 3.3.1 -->
	    <script src="assets/vendor/jquery/jquery-3.3.1.min.js"></script>
	    <%-- jquery 오류 방지 --%>
	    <script>
			jQuery.browser = {};
			(function () {
			    jQuery.browser.msie = false;
			    jQuery.browser.version = 0;
			    if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
			        jQuery.browser.msie = true;
			        jQuery.browser.version = RegExp.$1;
			    }
			})();
		</script>
	    <!-- jqGrid -->
	    <script src="jqGrid/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
	    <script src="jqGrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
	    <script src="jqGrid_ui/jquery-ui.min.js" type="text/javascript"></script>
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
	    <%
        scoredbDao scoredbdao = new scoredbDao();
        ArrayList<String> column = scoredbdao.getColumn(classDto.getScoredbName());
        StringBuilder col = new StringBuilder();
        int count = column.size();
        for(int i=0;i<count-2;i++) {
			col.append("'"+column.get(i)+"'");
			if(i!=count-3) {col.append(",");}
			col.toString();
		}
        %>
		    $(function(){
                        jQuery("#list").jqGrid({
                    url: 'json_get.jsp',
                    datatype: 'json',
                    mtype: 'POST',
                    height : 300, 
                    colNames: ['Actions','이름','학번',<%=col %>],
                    colModel: [
                {name:'act',index:'act', width:110,sortable:false},
                { name: "name", index:'이름', width:90 },
                { name: "s_num", index:'학번', width:180 ,editable:true},
                <% for(int i=0;i<count-2;i++) { 
                	out.println("{name: \""+column.get(i)+"\",index:'"+column.get(i)+"',editable:true, align:\"left\"}");
                	if(i!=count-3) out.println(",");
                }%>
                ],
                    pager: jQuery('#pager'),
                    rowNum:100,
                    sortorder:"desc",
                    autowidth:true,
                    viewrecords: true,
                    caption: 'RightHub 성적관리 시스템',
                    jsonReader: { 
            			repeatitems : false
                    },
                    gridComplete: function(){
                		var ids = jQuery("#list").jqGrid('getDataIDs');
                		for(var i=0;i < ids.length;i++){
                			var cl = ids[i];
                			be = "<input style='border-radius:5px;height:22px;width:20px;' type='button' value='E' onclick=\"jQuery('#list').editRow('"+cl+"');\"  />"; 
                			se = "<input style='border-radius:5px;height:22px;width:20px;' type='button' value='S' onclick=\"jQuery('#list').saveRow('"+cl+"');\"  />"; 
                			ce = "<input style='border-radius:5px;height:22px;width:20px;' type='button' value='C' onclick=\"jQuery('#list').restoreRow('"+cl+"');\" />"; 
                			jQuery("#list").jqGrid('setRowData',ids[i],{act:be+se+ce});
                		}	
                	},
                    rownumbers : true,
                    sortable: false,
                    editurl: "json_push.jsp",
                    
                });
		    }).trigger("reloadGrid");
            $(window).on('resize.jqGrid', function () {
                jQuery("#list").jqGrid( 'setGridWidth', $("#content").width() );
            });
		    
		    
	    </script>
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
	 				<div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                            <div class="section-block" id="basicform">
                                <h3 class="section-title">성적 입력</h3>
                                <p>학생들의 성적을 기입해 주세요.성적은 직접입력, 파일 업로드를 통해서 저장하실 수 있습니다.</p>
                                
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 mb-12" style="margin-bottom:2%; padding:0;">
                    
                            <div class="tab-regular">
                                <ul class="nav nav-tabs " id="myTab" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active show" id="home-tab" data-toggle="tab" href="#home" style="padding-top:13px; padding-bottom:13px;" role="tab" aria-controls="home" aria-selected="true">수정하기</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" style="padding-top:13px; padding-bottom:13px;" role="tab" aria-controls="profile" aria-selected="false">파일 업로드</a>
                                    </li>
                                </ul>
                                <%-- 수정하기 --%>
                                <div class="tab-content" id="myTabContent">
                                    <div class="tab-pane fade active show" id="home" role="tabpanel" aria-labelledby="home-tab">
                                        <h3>성적 온라인 수정</h3>
                                        <p style="margin:0;">성적을 온라인으로 수정하실 수 있습니다.</p>
                                        <p style="margin:5px 0;color:red;">Action 칼럼의 E: 열 수정 , S: 열 저장 , C: 취소</p>
                               <!-- jqGrid 사용하기 -->    
                               <div class="jqGrid">     
                                    <table id="list"></table>
                                    <div id="pager"></div>
                               </div>         
                                        
                                        
                                        
                                        
                               <!-- jqGrid 끝 -->         
                                    </div>
                                <%-- 자동 올리기 --%>
                                    <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                        <h3>파일 업로드</h3>
                                        <p>성적 파일을 업로드 해주세요. 올려주신 성적을 자동으로 입력합니다.</p>
                                        <p style="color:red;">CSV 칼럼에 이름 : name, 학번 :s_num, 뒤에 평가 항목들을 넣어주시면 됩니다.</p>
                                        <form enctype="multipart/form-data" action="uploadfile.jsp" method="post" >
                                        	<input type="file" id="excel" name="excel" style="box-shadow: none;" accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel"><br><br>
                                        	<input type="submit" value="업로드"  style="border-radius:2px;cursor: pointer;">
                                        </form>
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
  
</body>
</html>
<%}%>