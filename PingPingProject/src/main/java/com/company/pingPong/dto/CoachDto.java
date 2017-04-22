package com.company.pingPong.dto;

import java.sql.Timestamp;

public class CoachDto {
	int coach_code;
	int member_code;
	Timestamp coach_registerdate;
	String work_weekday;
	String note;
	
	public int getCoach_code() {
		return coach_code;
	}
	public void setCoach_code(int coach_code) {
		this.coach_code = coach_code;
	}
	public int getMember_code() {
		return member_code;
	}
	public void setMember_code(int member_code) {
		this.member_code = member_code;
	}
	public Timestamp getCoach_registerdate() {
		return coach_registerdate;
	}
	public void setCoach_registerdate(Timestamp coach_registerdate) {
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
}
