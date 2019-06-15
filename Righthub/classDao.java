package Righthub;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class classDao {
	private static String dburl = 
	private static String dbUser =
	private static String dbpasswd = 
	
	private Connection conn = null;
	private PreparedStatement ps = null;
	
	// classDao 생성
		public classDao() {
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
	public boolean insertDB(classDto dto) {
		boolean success=false;
		connect();
		String sql="INSERT INTO classDB (className,name,s_num,type,score_db,alert_db,question_db,accessCode) VALUES (?,?,?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,dto.getClassName());
			ps.setString(2, dto.getName());
			ps.setString(3, dto.getS_num());
			ps.setString(4, dto.getType());
			ps.setString(5, dto.getScoredbName());
			ps.setString(6, dto.getAlertdbName());
			ps.setString(7, dto.getQuestiondbName());
			ps.setString(8, dto.getAccessCode());
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
	//================ 학생 가입 시 ======================== //
	public String findCode(String x) {
		String className ="";
		connect();
		String sql = "select score_db from classDB where accesscode='"+x+"'";
		try {
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
			className = rs.getString("score_db");
			}
			rs.close();
		} catch(Exception e) {
			e.printStackTrace();
			return className;
		} finally {
			disconnect();
		}
		return className;
	}
	//==============학생용 강의 전체보기=======================//
	public ArrayList<classDto> getClassAll_std(){
		connect();
		ArrayList<classDto> list = new ArrayList<classDto>();
		String sql = "select * from classDB;";
		try {
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				classDto dto = new classDto();
				dto.setName(rs.getString("name"));
				dto.setClassName(rs.getString("className"));
				dto.setS_num(rs.getString("s_num"));
				dto.setType(rs.getString("type"));
				dto.setScoredbName(rs.getString("score_db"));
				dto.setAlertdbName(rs.getString("alert_db"));
				dto.setQuestiondbName(rs.getString("question_db"));
				dto.setAccessCode(rs.getString("accessCode"));
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
	//===================================================//
	public ArrayList<classDto> getClassAll(String s_num){
		connect();
		ArrayList<classDto> list = new ArrayList<classDto>();
		String sql = "select * from classDB where s_num=\'"+s_num +"\';";
		try {
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				classDto dto = new classDto();
				dto.setName(rs.getString("name"));
				dto.setClassName(rs.getString("className"));
				dto.setS_num(rs.getString("s_num"));
				dto.setType(rs.getString("type"));
				dto.setScoredbName(rs.getString("score_db"));
				dto.setAlertdbName(rs.getString("alert_db"));
				dto.setQuestiondbName(rs.getString("question_db"));
				dto.setAccessCode(rs.getString("accessCode"));
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
	public classDto findClass(String score_name) {
		connect();
		classDto dto = new classDto();
		String sql = "select * from classDB where score_db=\'"+score_name+"\';";
		try {
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				dto.setName(rs.getString("name"));
				dto.setClassName(rs.getString("className"));
				dto.setS_num(rs.getString("s_num"));
				dto.setType(rs.getString("type"));
				dto.setScoredbName(rs.getString("score_db"));
				dto.setAlertdbName(rs.getString("alert_db"));
				dto.setQuestiondbName(rs.getString("question_db"));
				dto.setAccessCode(rs.getString("accessCode"));
			}
			rs.close();
		} catch(Exception e ) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return dto;
	}
}
