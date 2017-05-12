package com.company.pingPong.dto;

import java.sql.Timestamp;

public class CoachDto {
	String coach_code;
	String member_code;
	String coach_registerdate;
	String work_weekday;
	String note;
	
	String name;
	String sex;
	
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
}
