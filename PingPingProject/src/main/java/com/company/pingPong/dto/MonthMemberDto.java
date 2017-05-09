package com.company.pingPong.dto;

public class MonthMemberDto {
	private String month_code;
	private String fee_code;
	private String member_code;
	private String month_registerdate;
	private String fee_status;
	private String note;
	
	public String getMonth_code() {
		return month_code;
	}
	public void setMonth_code(String month_code) {
		this.month_code = month_code;
	}
	public String getFee_code() {
		return fee_code;
	}
	public void setFee_code(String fee_code) {
		this.fee_code = fee_code;
	}
	public String getMember_code() {
		return member_code;
	}
	public void setMember_code(String member_code) {
		this.member_code = member_code;
	}
	public String getMonth_registerdate() {
		return month_registerdate;
	}
	public void setMonth_registerdate(String month_registerdate) {
		this.month_registerdate = month_registerdate;
	}
	public String getFee_status() {
		return fee_status;
	}
	public void setFee_status(String fee_status) {
		this.fee_status = fee_status;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
}
