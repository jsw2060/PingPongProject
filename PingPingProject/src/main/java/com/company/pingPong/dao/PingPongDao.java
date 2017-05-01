package com.company.pingPong.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.company.pingPong.dto.AccountDto;
import com.company.pingPong.dto.MemberDto;


public interface PingPongDao {
	/*public ArrayList<ContentDto> listDao();
	public void writeDao(String mWriter, String mContent);
	public ContentDto viewDao(String strID);
	public void deleteDao(String bId);*/
	
	public int loginIdDao(String id);
	public AccountDto loginPwdDao(Map<String, String> map);
	public String loginNameDao(Map<String, String> map);
	public void joinApplyDao(AccountDto dto);
	public void joinApplyAccountDao(AccountDto dto);
	public ArrayList<MemberDto> findMemberDao(String memberName);
}