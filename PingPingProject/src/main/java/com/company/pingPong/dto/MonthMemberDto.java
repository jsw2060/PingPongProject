package com.company.pingPong.dto;

import java.sql.Timestamp;

public class MonthMemberDto {
	int month_code;
	int fee_code;
	Timestamp month_registerdate;
	String fee_status;
	String note;
	
	public int getMonth_code() {
		return month_code;
	}
	public void setMonth_code(int month_code) {
		this.month_code = month_code;
	}
	public int getFee_code() {
		return fee_code;
	}
	public void setFee_code(int fee_code) {
		this.fee_code = fee_code;
	}
	public Timestamp getMonth_registerdate() {
		return month_registerdate;
	}
	public void setMonth_registerdate(Timestamp month_registerdate) {
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
