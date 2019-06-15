package Righthub;

public class classDto {
	String className; // 과목
	String name;	//이름 
	String s_num;	//교수번호 
	String type;	//학수구분 
	String scoredbName; // 성적DB
	String alertdbName; // 알림DB
	String questiondbName; // 이의제기 DB
	String accessCode; // 접근 코드 
	
	public String getAccessCode() {
		return accessCode;
	}
	public void setAccessCode(String accessCode) {
		this.accessCode = accessCode;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getS_num() {
		return s_num;
	}
	public void setS_num(String s_num) {
		this.s_num = s_num;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getScoredbName() {
		return scoredbName;
	}
	public void setScoredbName(String scoredbName) {
		this.scoredbName = scoredbName;
	}
	public String getAlertdbName() {
		return alertdbName;
	}
	public void setAlertdbName(String alertdbName) {
		this.alertdbName = alertdbName;
	}
	public String getQuestiondbName() {
		return questiondbName;
	}
	public void setQuestiondbName(String questiondbName) {
		this.questiondbName = questiondbName;
	}
	
}
