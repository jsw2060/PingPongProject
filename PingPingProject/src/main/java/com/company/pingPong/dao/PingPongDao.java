package com.company.pingPong.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.company.pingPong.dto.AccountDto;
import com.company.pingPong.dto.BootrackDto;
import com.company.pingPong.dto.CoachDto;
import com.company.pingPong.dto.FeeDto;
import com.company.pingPong.dto.LockerDto;
import com.company.pingPong.dto.MemberDto;


public interface PingPongDao {
	/*public ArrayList<ContentDto> listDao();
	public void writeDao(String mWriter, String mContent);
	public ContentDto viewDao(String strID);
	public void deleteDao(String bId);*/
	
	// confirm Id when someone request login
	public int loginIdDao(String id);
	
	// confirm password when someone request password
	public int loginPwdDao(String pwd);
	
	// confirm login data when someone request login
	public MemberDto loginDao(Map<String, String> map);
	
	// inform a name who login successed
	public String loginNameDao(Map<String, String> map);
	
	// request join and create an account
	public void joinApplyAccountDao(MemberDto dto);
	
	// find members who joined as a monthmember or just a member
	public ArrayList<MemberDto> findMonthAndMemberDao(String memberName);
	
	// find members who registered a lesson or just a member
	public ArrayList<MemberDto> findLessonAndMemberDao(String coachName);
	
	// get list of member
	public ArrayList<MemberDto> getConfirmListDao();
	
	// get list of waiting confirm
	public ArrayList<MemberDto> getAccountListDao();
	
	// search accountList by member_code
	public ArrayList<MemberDto> searchAccountListDao(String selectedId);
	
	// get list of bootrack
	public ArrayList<BootrackDto> getBootrackList();
	
	// give an authorization to be a manager
	public void managerConfirmDao(Map<String, String> map);
	
	// give an authorization to be a coach
	public void coachConfirmDao(Map<String, String> map);
	
	// give an authorization to be a member
	public void memberConfirmDao(String memberCode);
	
	// update account
	public void accountUpdateDao(Map<String, String> map);
	
	// update bootrack
	public void bootrackUpdateDao(Map<String, String> map);
	
	// search accountList by member_name for bootrack
	public List<Map> searchAccountListByNameForBootrackDao(String memberName);
	
	// get lockerList
	public ArrayList<LockerDto> getLockerList();
	
	// search accountList by member_name for locker
	public List<Map> searchAccountListByNameForLockerDao(String memberName);
	
	// update locker
	public void lockerUpdateForMemberDao(Map<String, String> map);
	
	
	public ArrayList<FeeDto> getDateFeeList(String searchFeeDate);
	public ArrayList<FeeDto> getFeeList();
	public void insertGeneralFeeDao(Map<String, String> data);
	public void insertOneDayFeeDao(Map<String, String> data);
	public void insertMonthFeeDao(Map<String, String> data);
	public String getPrevFeeCode();
	public int checkMonthMemberDao(String memberCode);
	public void updateMonthMemberDao(Map<String, String> monthInfo);
	public void insertNewMonthMemberDao(Map<String, String> monthInfo);
	public ArrayList<CoachDto> findLessonAndCoachDao(String coachName);
	public ArrayList<MemberDto> defaultTotalMember();
	public ArrayList<MemberDto> defaultMonthMember();
	public ArrayList<MemberDto> defaultLessonMember();
	public void deleteAccount(String memberCode);
}