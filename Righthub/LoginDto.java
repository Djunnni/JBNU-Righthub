package Righthub;

public class LoginDto {
	private String s_num; // 학번 
	private String name; // 이름
	private String password; //비밀번호
	private String email; //이메일
	private String major; // 전공
	private String type; // 교수,학생, 대학원생
	private String phone;
	private int confirm; // 교수 타입 체크용
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getS_num() {
		return s_num;
	}
	public void setS_num(String s_num) {
		this.s_num = s_num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getConfirm() {
		return confirm;
	}
	public void setConfirm(int confirm) {
		this.confirm = confirm;
	}
	
}
