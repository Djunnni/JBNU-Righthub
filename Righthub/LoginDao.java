package Righthub;

import java.sql.*;
import Righthub.LoginDto;
import java.util.*;

public class LoginDao {
	private static String dburl = 
	private static String dbUser = 
	private static String dbpasswd = 
	
	private Connection conn = null;
	private PreparedStatement ps = null;
	
	// LoginDao 생성
	public LoginDao() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		}catch (Exception e) {
				e.printStackTrace();
		}
	}
	//LoginDao connect()
	public void connect() {
		try {
			conn = DriverManager.getConnection(dburl,dbUser,dbpasswd);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	//LoginDao disconnect() 
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
	//=========== 계정 추가 ===========//
	public boolean insertDB(LoginDto dto) {
		boolean success=false;
		connect();
		String sql="INSERT INTO loginDB (s_num,name,password,email,phone,major,type) VALUES (?,?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,dto.getS_num());
			ps.setString(2, dto.getName());
			ps.setString(3, dto.getPassword());
			ps.setString(4, dto.getEmail());
			ps.setString(5, dto.getPhone());
			ps.setString(6, dto.getMajor());
			ps.setString(7, dto.getType());
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
	//=========== 계정 삭제 ===========//
	public boolean deleteDB(LoginDto dto) {
		boolean success=false;
		connect();
		String sql="DELETE FROM loginDB WHERE s_num=? and name=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,dto.getS_num());
			ps.setString(2, dto.getName());
			
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
	//============= 교수님 계정 전부 출력 =========== //
	public ArrayList<LoginDto> getProfessorAll(){
		connect();
		ArrayList<LoginDto> list = new ArrayList<LoginDto>();
		String sql = "select * from loginDB where type=\'professor\'";
		try {
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				LoginDto dto = new LoginDto();
				dto.setConfirm(rs.getInt("confirm"));
				dto.setEmail(rs.getString("email"));
				dto.setMajor(rs.getString("major"));
				dto.setName(rs.getString("name"));
				dto.setPassword(rs.getString("password"));
				dto.setPhone(rs.getString("phone"));
				dto.setS_num(rs.getString("s_num"));
				dto.setType(rs.getString("type"));
				dto.setConfirm(rs.getInt("confirm"));
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
	//============= 계정 하나의 정보 ================ //
	public LoginDto getUser(String s_num) {
		connect();
		String sql = "select * from loginDB where s_num=?";
		LoginDto dto = new LoginDto();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, s_num);
			ResultSet rs = ps.executeQuery();
			rs.next();
			dto.setConfirm(rs.getInt("confirm"));
			dto.setEmail(rs.getString("email"));
			dto.setMajor(rs.getString("major"));
			dto.setName(rs.getString("name"));
			dto.setPassword(rs.getString("password"));
			dto.setPhone(rs.getString("phone"));
			dto.setS_num(rs.getString("s_num"));
			dto.setType(rs.getString("type"));
			dto.setConfirm(rs.getInt("confirm"));
			rs.close();
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return dto;
	}
	//============= 교수님용 계정 승인 ============= //
	public boolean checkedDB(LoginDto dto) {
		boolean success=false;
		connect();
		String sql="Update loginDB SET confirm = 1 WHERE s_num=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,dto.getS_num());
			
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
	//=========== 계정 로그 확인 =============//
	public boolean AccessDB(LoginDto dto) {
		boolean checked=false;
		connect();
		String sql="SELECT * from loginDB WHERE s_num=? and password=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,dto.getS_num());
			ps.setString(2,dto.getPassword());
			
			ResultSet rs = ps.executeQuery();
			String s_num ="";
			String password = "";
			String type ="";
			int confirm = 0;
			while(rs.next()) {
				s_num = rs.getString("s_num");
				password = rs.getString("password");
				type = rs.getString("type");
				confirm = rs.getInt("confirm");
			}
			rs.close();
		//	System.out.println("Login user accessing : "+s_num +" / "+ password+" / "+type+" / "+confirm);
			if(type.equals("professor")) {
				if(confirm==0) checked=false;
				else {
					if(s_num.equals(dto.getS_num()) && password.equals(dto.getPassword())) checked=true;
				}
			} else {
				if(s_num.equals(dto.getS_num()) && password.equals(dto.getPassword())) checked=true;
				
			}
		}catch(Exception e) {
			e.printStackTrace();
			return checked;
		} finally {
			disconnect();
		}
		return checked;
	}
	//=========== 계정 생성 중 기존번호 여부확인 =============//
		public boolean is_InDB(LoginDto dto) {
			boolean checked=false;
			connect();
			String sql="SELECT * from loginDB WHERE s_num=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1,dto.getS_num());
				
				ResultSet rs = ps.executeQuery();
				String s_num ="";
				while(rs.next()) {
					s_num = rs.getString("s_num");
				}
				rs.close();
				if(s_num.equals(dto.getS_num())) checked=true;
			
			}catch(Exception e) {
				e.printStackTrace();
				return checked;
			} finally {
				disconnect();
			}
			return checked;
		}
}
