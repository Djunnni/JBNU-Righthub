package Righthub;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class scoredbDao {
	private static String dburl = 
	private static String dbUser =
	private static String dbpasswd = 
	
	private Connection conn = null;
	private PreparedStatement ps = null;
	
// classDao 생성
	public scoredbDao() {
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
public boolean createDB(scoredbDto dto,String name,int index) {
	boolean success=false;
	connect();
	Statement stmt=null;
	StringBuilder data = new StringBuilder();
	for(int i=0;i<index;i++) {
		data.append(dto.getEl().get(i)).append(" varchar(20) default '0',");
	}
	String d = data.toString();
	try {
		stmt = conn.createStatement();
		StringBuilder sb = new StringBuilder();
		String sql = sb.append("create table ")
					.append(name)
					.append("(")
					.append(d)
					.append("name varchar(20),")
					.append("s_num varchar(20));")
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
//============== 과목 가입하기 ================//
public boolean signClass(String x,LoginDto user) {
	boolean success=false;
	connect();
	String sql = "insert into "+x+" (name,s_num) values ('"+user.getName()+"','"+user.getS_num()+"')";
	try {
		ps = conn.prepareStatement(sql);
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
//=============== DB 데이터 초기화 ================//
public boolean truncateDB(String name) {
	boolean success=false;
	connect();
	String sql="truncate table "+name+";" ;
	try {
		ps = conn.prepareStatement(sql);
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
//============ Column 가져오기 ================ //
public ArrayList<String> getColumn(String name){
	connect();
	ArrayList<String> list = new ArrayList<String>();
	String sql =  "SHOW COLUMNS FROM "+name;
	try {
		ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			list.add(rs.getString("Field"));
		}
		rs.close();
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		disconnect();
	}
	return list;
}

//=============== 학생들 데이터 가져오기 ==================//
public ArrayList<scoredbDto> getStudentData(String name,ArrayList<String> column){
	connect();
	ArrayList<scoredbDto> list = new ArrayList<scoredbDto>();
	String sql = "select * from "+name;
	try {
		ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			scoredbDto dto = new scoredbDto();
			ArrayList<String> score = new ArrayList<String>();
			dto.setName(rs.getString("name"));
			dto.setS_num(rs.getString("s_num"));
			for(String x : column) {
				score.add(rs.getString(x));
			//	System.out.println(x);
			}
			dto.setEl(score);
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
//================ getRank and data ====================//
public ArrayList<scoredbDto> getRankData(String name,ArrayList<String> column){
	connect();
	ArrayList<scoredbDto> list = new ArrayList<scoredbDto>();
	StringBuilder col = new StringBuilder();
	for(int i=0;i<column.size()-2;i++) {
			col.append(column.get(i));
		if(i!=column.size()-3) col.append("+");
		else col.append(" as sum");
	}
	col.toString();
	String sql = "select *,"+col+" from "+name+" order by sum desc;";
	//System.out.println(sql);
	try {
		ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			scoredbDto dto = new scoredbDto();
			ArrayList<String> score = new ArrayList<String>();
			dto.setName(rs.getString("name"));
			dto.setS_num(rs.getString("s_num"));
			score.add(rs.getString("sum"));
			for(String x : column) {
				score.add(rs.getString(x));
			//	System.out.println(x);
			}
			dto.setEl(score);
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
//================ check ==================//
public boolean checkinDB(String dbname,String s_num) {
	boolean check =false;
	connect();
	String sql = "select s_num from "+ dbname + " where s_num='"+s_num+"'";
	String tmp="";
	try {
		ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			tmp=rs.getString("s_num");
		}
		if(s_num.equals(tmp)) {
			check=true;
		}
		rs.close();
	} catch(Exception e) {
		e.printStackTrace();
		return check;
	} finally {
		disconnect();
	}
		return check;
}
//================ 학생 1명 데이터  ==================//
public scoredbDto getDataDB(String dbname,String s_num,ArrayList<String> column) {
	scoredbDto dto = new scoredbDto();
	ArrayList<scoredbDto> list = new ArrayList<scoredbDto>();
	connect();
	String sql = "select * from "+ dbname + " where s_num='"+s_num+"'";
	
	try {
		ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			ArrayList<String> score = new ArrayList<String>();
			dto.setName(rs.getString("name"));
			dto.setS_num(rs.getString("s_num"));
			for(String x : column) {
				score.add(rs.getString(x));
			//	System.out.println(x);
			}
			dto.setEl(score);
			list.add(dto);
		}
		
		rs.close();
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		disconnect();
	}
		return dto;
}
//================ 학생 데이터 수정하기 ================//
public boolean updateStudentData(String name,ArrayList<String> column,ArrayList<String> data,String snum) {
	boolean success = false;
	connect();
	StringBuilder col = new StringBuilder();
	for(int i=0;i<column.size();i++) {
			col.append(column.get(i)+"='"+data.get(i)+"' ");
		if(i!=column.size()-1) col.append(",");
	}
	col.toString();
	String sql = "update "+ name +" set " +col +" where s_num='"+snum+"'";
	//System.out.println(sql);
	try {
		Statement stmt = conn.createStatement();
		int rs = stmt.executeUpdate(sql); 
		if(rs!=0) success=true;
	}catch(Exception e) {
		e.printStackTrace();
		return success;
	} finally {
		disconnect();
	}
	return success;
}
//================ 학생 데이터 저장하기 =============== //
public boolean setStudentData(String name,ArrayList<String> column,scoredbDto db) {
	boolean success = false;
	StringBuilder data = new StringBuilder();
	StringBuilder col = new StringBuilder();
	col.append("(");
	for(int i=0;i<column.size();i++) {
		col.append(column.get(i));
		data.append("?");
		if(i!=column.size()-1) {data.append(","); col.append(",");}
	}
	data.toString();
	col.append(")");  
	String c = col.toString();
	connect();
	String sql="insert into "+ name +" "+c+" values ("+data+");";
	//System.out.println(sql);
	try {
		ps = conn.prepareStatement(sql);
		ps.setString(1,db.getName());
		ps.setString(2,db.getS_num());
		
		for(int i=0;i<db.getEl().size();i++) {
			String x = db.getEl().get(i);
			ps.setString(3+i, x);
		}
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
}
