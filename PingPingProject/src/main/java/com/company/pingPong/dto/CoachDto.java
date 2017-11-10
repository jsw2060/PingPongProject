package com.company.pingPong.dto;

public class CoachDto {
	String coach_code;
	String member_code;
	String coach_status;
	String coach_registerdate;
	String work_weekday;
	String note;
	
	String name;
	String sex;
	String tel;
	String age;
	String style;
	String grade;
	
	
	public String getCoach_code() {
		return coach_code;
	}
	public void setCoach_code(String coach_code) {
		this.coach_code = coach_code;
	}
	public String getMember_code() {
		return member_code;
	}
	public void setMember_code(String member_code) {
		this.member_code = member_code;
	}
	public String getCoach_registerdate() {
		return coach_registerdate;
	}
	public void setCoach_registerdate(String coach_registerdate) {
		this.coach_registerdate = coach_registerdate;
	}
	public String getWork_weekday() {
		return work_weekday;
	}
	public void setWork_weekday(String work_weekday) {
		this.work_weekday = work_weekday;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getStyle() {
		return style;
	}
	public void setStyle(String style) {
		this.style = style;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getCoach_status() {
		return coach_status;
	}
	public void setCoach_status(String coach_status) {
		this.coach_status = coach_status;
	}
	
}
