package com.company.pingPong.dto;

import java.sql.Timestamp;

public class LessonDto {
	int lesson_code;
	int fee_code;
	int coach_code;
	int member_code;
	String irregular_status;
	String outer_status;
	Timestamp lesson_date;
	String lesson_weekday;
	String fee_status;
	String mon_time;
	String tue_time;
	String wed_time;
	String thu_time;
	String fri_time;
	String sat_time;
	String sun_time;
	int lesson_minute;
	String note;
	String lesson_type;
	
	public int getLesson_code() {
		return lesson_code;
	}
	public void setLesson_code(int lesson_code) {
		this.lesson_code = lesson_code;
	}
	public int getFee_code() {
		return fee_code;
	}
	public void setFee_code(int fee_code) {
		this.fee_code = fee_code;
	}
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
	public String getIrregular_status() {
		return irregular_status;
	}
	public void setIrregular_status(String irregular_status) {
		this.irregular_status = irregular_status;
	}
	public String getOuter_status() {
		return outer_status;
	}
	public void setOuter_status(String outer_status) {
		this.outer_status = outer_status;
	}
	public Timestamp getLesson_date() {
		return lesson_date;
	}
	public void setLesson_date(Timestamp lesson_date) {
		this.lesson_date = lesson_date;
	}
	public String getLesson_weekday() {
		return lesson_weekday;
	}
	public void setLesson_weekday(String lesson_weekday) {
		this.lesson_weekday = lesson_weekday;
	}
	public String getFee_status() {
		return fee_status;
	}
	public void setFee_status(String fee_status) {
		this.fee_status = fee_status;
	}
	public String getMon_time() {
		return mon_time;
	}
	public void setMon_time(String mon_time) {
		this.mon_time = mon_time;
	}
	public String getTue_time() {
		return tue_time;
	}
	public void setTue_time(String tue_time) {
		this.tue_time = tue_time;
	}
	public String getWed_time() {
		return wed_time;
	}
	public void setWed_time(String wed_time) {
		this.wed_time = wed_time;
	}
	public String getThu_time() {
		return thu_time;
	}
	public void setThu_time(String thu_time) {
		this.thu_time = thu_time;
	}
	public String getFri_time() {
		return fri_time;
	}
	public void setFri_time(String fri_time) {
		this.fri_time = fri_time;
	}
	public String getSat_time() {
		return sat_time;
	}
	public void setSat_time(String sat_time) {
		this.sat_time = sat_time;
	}
	public String getSun_time() {
		return sun_time;
	}
	public void setSun_time(String sun_time) {
		this.sun_time = sun_time;
	}
	public int getLesson_minute() {
		return lesson_minute;
	}
	public void setLesson_minute(int lesson_minute) {
		this.lesson_minute = lesson_minute;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getLesson_type() {
		return lesson_type;
	}
	public void setLesson_type(String lesson_type) {
		this.lesson_type = lesson_type;
	}
}
