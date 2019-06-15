package Righthub;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

public class questiondbDao {
	private static String dburl = 
	private static String dbUser = 
	private static String dbpasswd =
	private Connection conn = null;
	private PreparedStatement ps = null;
			
	
// classDao 생성
public questiondbDao() {
	try {
		Class.forName("com.mysql.jdbc.Driver");
	}catch (Exception e) {
			e.printStackTrace();
	}
}
public void connect() {
try {
	conn = DriverManager.getConnection(dburl,dbUser,dbpasswd);
	
}catch (Exception e) {
	e.printStackTrace();
}
}
//classDao disconnect() 
public void disconnect() {
if(ps!=null){
	try {
		ps.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
}
if(conn!=null) {
	try {
		conn.close();
	}catch (Exception e) {
		e.printStackTrace();
	}
}
}
//========== 필요기능 함수 정의 ============//
public boolean createDB(String name) {
boolean success=false;
connect();
Statement stmt=null;
try {
	stmt = conn.createStatement();
	StringBuilder sb = new StringBuilder();
	String sql = sb.append("create table ")
				.append(name)
				.append("(")
				.append("name varchar(20),")
				.append("s_num varchar(20),")
				.append("email varchar(40),")
				.append("question text,")
				.append("regdate timestamp default current_timestamp);")
				.toString();
	//System.out.println(sql);
	stmt.execute(sql);
	success=true;
}catch(Exception e) {
	e.printStackTrace();
	return success;
} finally {
	disconnect();
}
return success;
}

//================ 데이터 삽입 ============== //
public boolean inputQuestion(String name,questiondbDto db) {
boolean success = false;
connect();
String sql="INSERT INTO "+ name +" (name,s_num,email,question) VALUES (?,?,?,?)";
try {
	ps = conn.prepareStatement(sql);
	ps.setString(1, db.getName());
	ps.setString(2, db.getS_num());
	ps.setString(3, db.getEmail());
	ps.setString(4, db.getText());
	ps.executeUpdate();
	success=true;
}catch(Exception e) {
	e.printStackTrace();
	return success;
} finally {
	disconnect();
}
return success;
}
// =============== 데이터 출력 ============== //
public ArrayList<questiondbDto> getquestionAll(String name){
connect();
ArrayList<questiondbDto> list = new ArrayList<questiondbDto>();
String sql = "select * from "+name;
try {
	ps = conn.prepareStatement(sql);
	ResultSet rs = ps.executeQuery();
	while(rs.next()) {
		questiondbDto dto = new questiondbDto();
		dto.setEmail(rs.getString("email"));
		dto.setName(rs.getString("name"));
		dto.setS_num(rs.getString("s_num"));
		dto.setText(rs.getString("question"));
		dto.setRegdate(rs.getTimestamp("regdate"));
		list.add(dto);
	}
	rs.close();
} catch(Exception e ) {
	e.printStackTrace();
} finally {
	disconnect();
}
return list;
}
}
