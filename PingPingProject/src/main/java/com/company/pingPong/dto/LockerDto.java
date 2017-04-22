package com.company.pingPong.dto;

public class LockerDto {
	String locker_code;
	int member_code;
	String locker_purpose;
	String locker_article;
	
	public String getLocker_code() {
		return locker_code;
	}
	public void setLocker_code(String locker_code) {
		this.locker_code = locker_code;
	}
	public int getMember_code() {
		return member_code;
	}
	public void setMember_code(int member_code) {
		this.member_code = member_code;
	}
	public String getLocker_purpose() {
		return locker_purpose;
	}
	public void setLocker_purpose(String locker_purpose) {
		this.locker_purpose = locker_purpose;
	}
	public String getLocker_article() {
		return locker_article;
	}
	public void setLocker_article(String locker_article) {
		this.locker_article = locker_article;
	}
}
