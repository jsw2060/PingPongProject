package com.company.pingPong.dto;

import java.sql.Timestamp;

public class FeeDto {
	int fee_code;
	String fee_type;
	int fee_amount;
	Timestamp fee_date;
	String note;
	
	String member_code;
	String name;
	
	public String getMember_code() {
		return member_code;
	}
	public void setMember_code(String member_code) {
		this.member_code = member_code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public int getFee_code() {
		return fee_code;
	}
	public void setFee_code(int fee_code) {
		this.fee_code = fee_code;
	}
	public String getFee_type() {
		return fee_type;
	}
	public void setFee_type(String fee_type) {
		this.fee_type = fee_type;
	}
	public int getFee_amount() {
		return fee_amount;
	}
	public void setFee_amount(int fee_amount) {
		this.fee_amount = fee_amount;
	}
	public Timestamp getFee_date() {
		return fee_date;
	}
	public void setFee_date(Timestamp fee_date) {
		this.fee_date = fee_date;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
}
