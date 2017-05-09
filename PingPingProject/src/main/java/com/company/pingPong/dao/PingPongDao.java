package com.company.pingPong.dao;

import java.util.ArrayList;
import java.util.Map;

import com.company.pingPong.dto.AccountDto;
import com.company.pingPong.dto.FeeDto;
import com.company.pingPong.dto.MemberDto;


public interface PingPongDao {
	/*public ArrayList<ContentDto> listDao();
	public void writeDao(String mWriter, String mContent);
	public ContentDto viewDao(String strID);
	public void deleteDao(String bId);*/
	
	public int loginIdDao(String id);
	public int loginPwdDao(String pwd);
	public MemberDto loginDao(Map<String, String> map);
	public String loginNameDao(Map<String, String> map);
	public void joinApplyAccountDao(MemberDto dto);
	public ArrayList<MemberDto> findMonthAndMemberDao(String memberName);
	public ArrayList<MemberDto> getAccountListDao();
	public ArrayList<AccountDto> getConfirmListDao();
	public void managerConfirmDao(Map<String, String> map);
	public void coachConfirmDao(Map<String, String> map);
	public ArrayList<FeeDto> getDateFeeList(String searchFeeDate);
	public ArrayList<FeeDto> getFeeList();
	public void insertGeneralFeeDao(Map<String, String> data);
	public void insertOneDayFeeDao(Map<String, String> data);
}