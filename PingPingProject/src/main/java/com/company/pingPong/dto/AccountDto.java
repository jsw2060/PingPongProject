package com.company.pingPong.dto;

import java.sql.Timestamp;

public class AccountDto {
	int account_code;
	int member_code;
	String id;
	String password;
	String approval_status;
	String join_status;
	Timestamp join_date;
	String manager_status;
	String coach_status;
	
	public int getAccount_code() {
		return account_code;
	}
	public void setAccount_code(int account_code) {
		this.account_code = account_code;
	}
	public int getMember_code() {
		return member_code;
	}
	public void setMember_code(int member_code) {
		this.member_code = member_code;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public Timestamp getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Timestamp join_date) {
		this.join_date = join_date;
	}
	public String getApproval_status() {
		return approval_status;
	}
	public void setApproval_status(String approval_status) {
		this.approval_status = approval_status;
	}
	public String getJoin_status() {
		return join_status;
	}
	public void setJoin_status(String join_status) {
		this.join_status = join_status;
	}
	public String getManager_status() {
		return manager_status;
	}
	public void setManager_status(String manager_status) {
		this.manager_status = manager_status;
	}
	public String getCoach_status() {
		return coach_status;
	}
	public void setCoach_status(String coach_status) {
		this.coach_status = coach_status;
	}
}
