package Righthub;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class alertdbDao {
	private static String dburl = 
	private static String dbUser = 
	private static String dbpasswd = 
	
	private Connection conn = null;
	private PreparedStatement ps = null;
			
	// classDao 생성
		public alertdbDao() {
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
						.append("id int not null primary key auto_increment,")
						.append("content text,")
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
	//================ DB 내용 전부 가져오기 ===============//
	public ArrayList<alertdbDto> getalertdbAll(String name) {
		connect();
		ArrayList<alertdbDto> list = new ArrayList<alertdbDto>();
		String sql = "select * from "+ name;
		try {
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				alertdbDto dto = new alertdbDto();
				dto.setContent(rs.getString("content"));
				dto.setNum(rs.getInt("id"));
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
	//================== DB에 저장하기 =============== //
	public boolean insertalertDB(String name,String content) {
		boolean success = false;
		connect();
		String sql="INSERT INTO "+ name +" (content) VALUES (?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, content);
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
