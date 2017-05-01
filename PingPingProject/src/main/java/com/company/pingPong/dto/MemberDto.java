package com.company.pingPong.dto;

import java.sql.Timestamp;

public class MemberDto {
	int member_code;
	String name;
	int age;
	String sex;
	String tel;
	String email;
	String addr;
	Timestamp birthday;
	String style;
	String grade;
	String registerday;
	String note;
	int manager_status;
	int coach_status;
	
	public int getManager_status() {
		return manager_status;
	}
	public void setManager_status(int manager_status) {
		this.manager_status = manager_status;
	}
	public int getCoach_status() {
		return coach_status;
	}
	public void setCoach_status(int coach_status) {
		this.coach_status = coach_status;
	}
	public int getMember_code() {
		return member_code;
	}
	public void setMember_code(int member_code) {
		this.member_code = member_code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Timestamp getBirthday() {
		return birthday;
	}
	public void setBirthday(Timestamp birthday) {
		this.birthday = birthday;
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
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getRegisterday() {
		return registerday;
	}
	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}
}
