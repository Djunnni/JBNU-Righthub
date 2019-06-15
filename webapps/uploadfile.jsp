<%@page import="Righthub.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="java.io.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.nio.charset.*" %>

<%
	LoginDto User = (LoginDto) session.getAttribute("dto");
	classDto classDto = (classDto) session.getAttribute("ClassDto");
	if(User==null || classDto ==null || User.getConfirm()!=1)  response.sendRedirect("error.html"); else{
    request.setCharacterEncoding("UTF-8");
    // 10Mbyte 제한
    int maxSize  = 1024*1024*10;       
    // 웹서버 컨테이너 경로  // 임시로 사용 변경할 것!!
    
    String root = "/data/home/201514740/webapps/Righthub/";
    // request.getSession().getServletContext().getRealPath("/");
    			
    // 파일 저장 경로(ex : /home/tour/web/ROOT/upload)
    String savePath = root + "upload/";
 
    // 업로드 파일명
    String uploadFile = "";
 
    // 실제 저장할 파일명
    String newFileName = "";
 
 
 
    int read = 0;
    byte[] buf = new byte[1024];
    FileInputStream fin = null;
    FileOutputStream fout = null;
  //  long currentTime = System.currentTimeMillis(); 
  // SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss"); 
 
    try{
 
        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
         
        // 전송받은 parameter의 한글깨짐 방지
       // String title = multi.getParameter("title");
       // title = new String(title.getBytes("8859_1"), "UTF-8");
 
        // 파일업로드
        uploadFile = multi.getFilesystemName("excel");
 
        // 실제 저장할 파일명(ex : 20140819151221.zip)
        newFileName = "excel_"+classDto.getScoredbName()+"."+ uploadFile.substring(uploadFile.lastIndexOf(".")+1);
     // simDf.format(new Date(currentTime)) +"."+ uploadFile.substring(uploadFile.lastIndexOf(".")+1);
 
         
        // 업로드된 파일 객체 생성
        File oldFile = new File(savePath + uploadFile);
 
         
        // 실제 저장될 파일 객체 생성
        File newFile = new File(savePath + newFileName);
         
 
        // 파일명 rename
        if(!oldFile.renameTo(newFile)){
 
            // rename이 되지 않을경우 강제로 파일을 복사하고 기존파일은 삭제
 
            buf = new byte[1024];
            fin = new FileInputStream(oldFile);
            fout = new FileOutputStream(newFile);
            read = 0;
            while((read=fin.read(buf,0,buf.length))!=-1){
                fout.write(buf, 0, read);
            }
             
            fin.close();
            fout.close();
            oldFile.delete();
        }  
     // =================== 파일 Query 작성 ================= //
       	scoredbDao scoredbdao = new scoredbDao();
    	//ArrayList<String> x = scoredbdao.getColumn(classDto.getScoredbName());
        BufferedReader br = null;
        try{
        scoredbdao.truncateDB(classDto.getScoredbName());
        br = Files.newBufferedReader(Paths.get(savePath+newFileName));
        Charset.forName("UTF-8");
        String line = "";
        line=br.readLine(); // 칼럼 읽기
        String column[] = line.split(","); // 칼럼 요소 받기
        	ArrayList<String> columns = new ArrayList<String>(); // 칼럼을 ArrayList에 저장
        for(String x : column){
        	if(!x.contains("\uFEFF"))
        	columns.add(x); 
        	else {
        		x=x.replace("\uFEFF", "")+"\n";
        		columns.add(x);
        	}
        }
        while((line = br.readLine()) != null){
        String array[] = line.split(",");
        //배열에서 리스트 반환
        //=========================================//
       	scoredbDto scoredto = new scoredbDto();
       	ArrayList<String> data = new ArrayList<String>();
       //	int count = x.size();
       	for(int i=0;i<columns.size()-2;i++){
     		data.add(array[2+i]);
     		
     	}
        scoredto.setName(array[0]);
     	scoredto.setS_num(array[1]);
     	     	
     	scoredto.setEl(data);
        //==========================================//
         //scoredbdao.setStudentData(classDto.getScoredbName(),scoredbdao.getColumn(classDto.getScoredbName()), scoredto);
        scoredbdao.setStudentData(classDto.getScoredbName(),columns, scoredto);
        System.out.println("삽입 완료!!");
        }
        
        }catch(FileNotFoundException e){
		      	out.println("<script language=\"javascript\">alert('업로드에 실패하였습니다. 관리자에게 문의 바랍니다.')</script>");
		       out.println("<script language=\"javascript\">window.location=\"input.jsp\"</script>");
        }catch(IOException e){
        	 out.println("<script language=\"javascript\">alert('업로드에 실패하였습니다. 관리자에게 문의 바랍니다.')</script>");
             out.println("<script language=\"javascript\">window.location=\"input.jsp\"</script>");
        }finally{
        try{
        if(br != null){
        br.close();
        }
        }catch(IOException e){
        	 out.println("<script language=\"javascript\">alert('업로드에 실패하였습니다. 관리자에게 문의 바랍니다.')</script>");
             out.println("<script language=\"javascript\">window.location=\"input.jsp\"</script>");
        
        }
        }
        
        
        out.println("<script language=\"javascript\">alert('성적파일이 정상적으로 업로드 되었습니다. ^^')</script>");
        out.println("<script language=\"javascript\">window.location=\"input.jsp\"</script>");
    }catch(Exception e){
        e.printStackTrace();
        out.println("<script language=\"javascript\">alert('업로드에 실패하였습니다. 관리자에게 문의 바랍니다.')</script>");
        out.println("<script language=\"javascript\">window.location=\"input.jsp\"</script>");
    }
 
}%>