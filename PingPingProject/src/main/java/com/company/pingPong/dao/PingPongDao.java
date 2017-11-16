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
import com.company.pingPong.dto.MonthMemberDto;


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
	
	// update memberInfo
	public void memberUpdateDao(Map<String, String> map);
	
	// search accountList by member_name for bootrack
	public List<Map> searchAccountListByNameForBootrackDao(String memberName);
	
	// search accountList by member_name for coach
	public List<Map> searchAccountListByNameForCoachDao(String memberName);
	
	// get lockerList
	public ArrayList<LockerDto> getLockerList();
	
	// search accountList by member_name for locker
	public List<Map> searchAccountListByNameForLockerDao(String memberName);
	
	// update locker
	public void lockerUpdateForMemberDao(Map<String, String> map);
	
	// update Coach
	public void insertCoachDao(Map<String, String> map);
	
	// set Coach status
	public void checkCoachStatusDao();
	
	// getting Coach Info
	public ArrayList<CoachDto> searchCoachByMemberIdDao(String memberCode);
	
	// edit Coach
	public void editCoachDao(Map<String, String> map);
	
	// getting monthMemberFeeData
	public ArrayList<FeeDto> monthMemberFeeDataDao(String sendedId);
	
	// update edited monthFee
	public void monthMemberFeeUpdateDao(Map<String, String> map);
	
	// search monthMember with some conditions
	public ArrayList<MemberDto> singleSearchMonthMemberDao(Map<String, String> map);
	
	// search member with some conditions
	public ArrayList<MemberDto> singleSearchTotalMemberDao(Map<String, String> map);
	
	// search coach with some conditions
	public ArrayList<CoachDto> singleSearchCoachMemberDao(Map<String, String> map);
	
	// getting fee list
	public ArrayList<FeeDto> FeeListDao();
	
	// getting monthmemberName
	public String getMonthMemberNameDao(String memberCode);
	
	// search fee with some conditions
	public ArrayList<FeeDto> singleSearchFeeListDao(Map<String, String> map);
	
	// update edited feeInfo
	public void feeUpdateDao(Map<String, String> map);
	
	// delete coach
	public void deleteCoach(String memberCode);
	
	// change coachStat
	public void changeCoachStat(String memberCode);
	
	// delete monthMember
	public void deleteMonthMember(String memberCode);
	
	// delete member
	public void deleteAccount(String memberCode);
	
	// get FeeList at a certain day 
	public ArrayList<FeeDto> getDateFeeList(String searchFeeDate);
	
	// getting FeeList
	public ArrayList<FeeDto> getFeeList();
	
	// inserting FeeInfo for general customer
	public void insertGeneralFeeDao(Map<String, String> data);
	
	// inserting FeeInfo for oneDay
	public void insertOneDayFeeDao(Map<String, String> data);
	
	// inserting FeeInfo for monthly member
	public void insertMonthFeeDao(Map<String, String> data);
	
	public String getPrevFeeCode();
	public int checkMonthMemberDao(String memberCode);
	public void updateMonthMemberDao(Map<String, String> monthInfo);
	public void insertNewMonthMemberDao(Map<String, String> monthInfo);
	public ArrayList<CoachDto> findLessonAndCoachDao(String coachName);
	public ArrayList<MemberDto> defaultTotalMember();
	public ArrayList<MemberDto> defaultMonthMember();
	public ArrayList<CoachDto> defaultTotalCoach();
	//public ArrayList<MemberDto> defaultLessonMember();
}