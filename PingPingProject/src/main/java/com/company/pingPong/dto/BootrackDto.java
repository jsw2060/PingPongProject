package com.company.pingPong.dto;

public class BootrackDto {
	String bootrack_code;
	String member_code;
	String bootrack_status;
	
	String name;

	public String getBootrack_code() {
		return bootrack_code;
	}

	public void setBootrack_code(String bootrack_code) {
		this.bootrack_code = bootrack_code;
	}

	public String getMember_code() {
		return member_code;
	}

	public void setMember_code(String member_code) {
		this.member_code = member_code;
	}

	public String getBootrack_status() {
		return bootrack_status;
	}

	public void setBootrack_status(String bootrack_status) {
		this.bootrack_status = bootrack_status;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
