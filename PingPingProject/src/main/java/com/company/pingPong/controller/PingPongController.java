/*
 * 작성일 : 2017.04.17
 * 작성자 : 정성원
 * 파일명 : PingPingController.java
 * 인코딩 : UTF-8 server.xml에 URIEncoding("UTF-8") 설정 필요
 */
package com.company.pingPong.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.lang.model.element.Element;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.company.pingPong.dao.PingPongDao;
import com.company.pingPong.dto.AccountDto;
import com.company.pingPong.dto.FeeDto;
import com.company.pingPong.dto.MemberDto;

@Controller
public class PingPongController {

	private static final Logger logger = LoggerFactory.getLogger(PingPongController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "index.do")
	public String loginHome(Locale locale) {
		logger.info("PingPong LoginHome.jsp", locale);
		
		return "LoginHome";
	}
	
	/*
	 * RequestMapping : Login.do
	 * MethodName : login
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "Login.do")
	public String login(Locale locale, HttpServletRequest req) {
		logger.info("PingPong Login.jsp", locale);
		
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		String name = "";
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		
		// Checking an exist of identification
		int idInfo = dao.loginIdDao(id);
		if(idInfo == 1){
			Map<String, String> map = new HashMap<String, String>();
			map.put("id", id);
			map.put("pwd", pwd);
			// Checking exist of account what it have same id and pwd.
			// And, getting some information from right tuple.
			AccountDto dto = dao.loginPwdDao(map);
			
			// When the joiner is a member
			if(dto.getMember_code() != 0){
				name = dao.loginNameDao(map);
			} else {	// When the joiner isn't a member
				name = "가입자";
			}
			
			HttpSession session = req.getSession();
		
			session.setAttribute("loginMemberCode", dto.getMember_code());
			session.setAttribute("loginId", dto.getId());
			session.setAttribute("loginPwd", dto.getPassword());
			session.setAttribute("loginName", name);

			// Checking authorization of manager or coach
			if(Integer.parseInt(dto.getManager_status()) == 1) {
				session.setAttribute("loginAuthor", "admin");
				session.setAttribute("accountMsg", "관리자계정");
				if(Integer.parseInt(dto.getCoach_status()) == 1) {
					session.setAttribute("loginAuthor", "master");
					session.setAttribute("accountMsg", "마스터계정");
				}
			}
			else {
				if(Integer.parseInt(dto.getCoach_status()) == 1) {
					session.setAttribute("loginAuthor", "coach");
					session.setAttribute("accountMsg", "코치 계정");
				} else {
					session.setAttribute("loginAuthor", "");
					session.setAttribute("accountMsg", "일반 계정");
				}
			}
			
			req.setAttribute("view", "MainHome");
			req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
			req.setAttribute("mainHomeTitle", "황남숙 탁구교실 통합관리 프로그램");
			return "MainHomeFrame";
		} else {
			req.setAttribute("errorMsg", "해당 ID가 존재하지 않습니다.");
			return "LoginHome";
		}
	}
	
	/*
	 * RequestMapping : Logout.do
	 * MethodName : logout
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "Logout.do")
	public String logout(Locale locale, HttpServletRequest req) {
		logger.info("PingPong Logout.do", locale);
		
		HttpSession session=req.getSession();
		session.invalidate();

		return "LoginHome";
	}
	
	/*
	 * RequestMapping : MainHomeFrame.do
	 * MethodName : mainHomeFrame
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "MainHomeFrame.do", method = RequestMethod.GET)
	public String mainHomeFrame(Locale locale, HttpServletRequest req) {
		logger.info("PingPong MainHomeFrame.jsp", locale);
		
		req.setAttribute("view", "MainHome");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("MainHomeTitle", "황남숙 탁구교실 관리 프로그램");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : MainHomeButtonsPane.do
	 * MethodName : mainHomeButtonsPane
	 * Parameter : Locale, Model
	 * Return : String
	 */
	@RequestMapping(value = "MainHomeButtonsPane.do", method = RequestMethod.POST)
	public String mainHomeButtonsPane(Locale locale, Model model) {
		logger.info("PingPong MainHomeButtonsPane.jsp", locale);
		model.addAttribute("MainHomeTitle", "황남숙 탁구교실 관리 프로그램");
		return "MainHomeButtonsPane";
	}
	
	/*
	 * RequestMapping : MainFeeInputFrame.do
	 * MethodName : mainFeeInputFrame
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "MainFeeInputFrame.do", method = RequestMethod.GET)
	public String mainFeeInputFrame(Locale locale, HttpServletRequest req) {
		logger.info("PingPong MainFeeInputFrame.jsp", locale);
		
		req.setAttribute("view", "MainFeeInputFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "요금 입력");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : FindFeeList.do
	 * MethodName : findFeeList
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "FindFeeList.do", method = RequestMethod.GET)
	public String findFeeList(Locale locale, HttpServletRequest req) {
		logger.info("PingPong FindFeeList.do", locale);

		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		String searchFeeDate = req.getParameter("feeDate"); 	// YYYY-MM-DD
		String[] tempDate = searchFeeDate.split("-");			// YYYY   MM   DD
		searchFeeDate = "";									// initial storage area
		for(int i=0; i< tempDate.length; i++){
			searchFeeDate = searchFeeDate + tempDate[i];			// YYYYMMDD
		}
		searchFeeDate = "\'" + searchFeeDate + "\'";
		
		// a list of fee what is searched by date
		ArrayList<FeeDto> dateFeeList = dao.getDateFeeList(searchFeeDate);
		
		req.setAttribute("dateFeeList", dateFeeList);
		req.setAttribute("view", "MainFeeInputFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "요금 입력");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : GeneralFeeInput.do
	 * MethodName : generalFeeInput
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "GeneralFeeInput.do", method = RequestMethod.GET)
	public String generalFeeInput(Locale locale, HttpServletRequest req) {
		logger.info("PingPong GeneralFeeInput.jsp", locale);

		req.setAttribute("view", "GeneralFeeInput");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "일반 요금");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : MonthFeeInput.do
	 * MethodName : monthFeeInput
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "MonthFeeInput.do", method = RequestMethod.GET)
	public String monthFeeInput(Locale locale, HttpServletRequest req) {
		logger.info("PingPong MonthFeeInput.jsp", locale);
		
		req.setAttribute("view", "MonthFeeInput");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "월 회원 세부 정보");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : LessonFeeInput.do
	 * MethodName : lessonFeeInput
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "LessonFeeInput.do", method = RequestMethod.GET)
	public String lessonFeeInput(Locale locale, HttpServletRequest req) {
		logger.info("PingPong lessonFeeInput.jsp", locale);
		
		req.setAttribute("view", "LessonFeeInput");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "레슨 세부 정보");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : InsertGeneralFee.do
	 * MethodName : generalFeeInput
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "InsertGeneralFee.do", method = RequestMethod.GET)
	public String insertGeneralFee(Locale locale, HttpServletRequest req) {
		logger.info("PingPong InsertGeneralFee.do", locale);

		HttpSession session = req.getSession();
		String memberCode = session.getAttribute("loginMemberCode").toString();
		String playTime = req.getParameter("playTime");
		int tempTime =  Integer.parseInt(req.getParameter("playTime"));
		String tableNum = req.getParameter("tableNum");
		String status = req.getParameter("status");
		
		logger.info(session.getAttribute("loginMemberCode").toString());
		logger.info(req.getParameter("playTime"));
		logger.info(req.getParameter("tableNum"));
		logger.info(req.getParameter("status"));
		
		int fee = 0;
		// Calculate General fee
		if(status == "0"){	// general
			if(tempTime > 30){
				int tempHour = 0;
				int tempMin = 0;
				tempHour =(tempTime / 60);
				tempMin = (tempTime % 60);
				
				fee = (tempHour * 10000) + (tempMin * 6000);
			} 
			else {
				fee = (tempTime / 30) * 6000;
			}
		} else {			// student
			if(tempTime > 30){
				int tempHour = 0;
				int tempMin = 0;
				tempHour =(tempTime / 60);
				tempMin = (tempTime % 60);
				
				fee = (tempHour * 7000) + (tempMin * 4000);
			} 
			else {
				fee = (tempTime / 30) * 4000;
			}
		}
		String calFee = String.valueOf(fee);
		
		Map<String, String> data = new HashMap<String, String>();
		data.put("memberCode", memberCode);
		data.put("playTime", playTime);
		data.put("tableNum", tableNum);
		data.put("status", status);
		data.put("calFee", calFee);
		
		req.setAttribute("specifyInput", data);
		req.setAttribute("view", "MainFeeInputFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "요금 입력");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : MainFeeManagerFrame.do
	 * MethodName : mainFeeManagerFrame
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "MainFeeManagerFrame.do", method = RequestMethod.GET)
	public String mainFeeManagerFrame(Locale locale, HttpServletRequest req) {
		logger.info("PingPong MainFeeManagerFrame.jsp", locale);
		
		req.setAttribute("view", "MainFeeManagerFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "요금정보 관리");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : InsertFee.do
	 * MethodName : insertFee
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "InsertFee.do", method = RequestMethod.GET)
	public String insertFee(Locale locale, HttpServletRequest req) {
		logger.info("PingPong InsertFee.do", locale);
		
		String memberCode = req.getParameter("specifyMemberCode");
		String playTime = req.getParameter("specifyPlayTime");
		String tableNum = req.getParameter("specifyTableNum");
		String status = req.getParameter("specifyStatus");
		String costInput = req.getParameter("costInput");
		String noteInput = req.getParameter("noteInput");
		
		logger.info(memberCode);
		logger.info(playTime);
		logger.info(tableNum);
		logger.info(status);
		logger.info(costInput);
		logger.info(noteInput);
		
		req.setAttribute("view", "MainFeeInputFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "요금 입력");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : FeeManagerChart.do
	 * MethodName : feeManagerChart
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "FeeManagerChart.do", method = RequestMethod.GET)
	public String feeManagerChart(Locale locale) {
		logger.info("PingPong FeeManagerChart.jsp", locale);
		
		return "FeeManagerChart";
	}
	
	/*
	 * RequestMapping : MainMemberManagerFrame.do
	 * MethodName : mainMemberManagerFrame
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "MainMemberManagerFrame.do", method = RequestMethod.GET)
	public String mainMemberManagerFrame(Locale locale, HttpServletRequest req) {
		logger.info("PingPong MainMemberManagerFrame.jsp", locale);
		
		req.setAttribute("view", "MainMemberManagerFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "회원정보 관리");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : MainLessonManagerFrame.do
	 * MethodName : mainLessonManagerFrame
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "MainLessonManagerFrame.do", method = RequestMethod.GET)
	public String mainLessonManagerFrame(Locale locale, HttpServletRequest req) {
		logger.info("PingPong MainLessonManagerFrame.jsp", locale);
		req.setAttribute("view", "MainLessonManagerFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "레슨정보 관리");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : LessonEditDialog.do
	 * MethodName : mainLessonManagerFrame
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "LessonEditDialog.do", method = RequestMethod.GET)
	public String lessonEditDialog(Locale locale, Model model) {
		logger.info("PingPong LessonEditDialog.jsp", locale);
		return "LessonEditDialog";
	}
	
	/*
	 * RequestMapping : AccountManagerFrame.do
	 * MethodName : accountManagerFrame
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "AccountManagerFrame.do", method = RequestMethod.GET)
	public String accountManagerFrame(Locale locale, HttpServletRequest req) {
		logger.info("PingPong AccountManagerFrame.jsp", locale);
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		
		// list of waiting confirm
		ArrayList<AccountDto> confList = dao.getConfirmListDao();
		// list of account
		ArrayList<MemberDto> dtos = dao.getAccountListDao();
		
		req.setAttribute("confirmList", confList);
		req.setAttribute("accountList", dtos);
		req.setAttribute("view", "AccountManagerFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "계정 관리");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : AuthorizationConfirm.do
	 * MethodName : authorizationConfirm
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "AuthorizationConfirm.do", method = RequestMethod.GET)
	public String athorizationConfirm(Locale locale, HttpServletRequest req) {
		logger.info("PingPong AuthorizationConfirm.do", locale);
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		
		String accountCode = req.getParameter("account_code");
		String managerStatus = req.getParameter("manager_status");
		String coachStatus = req.getParameter("coach_status");
		
		Map<String, String> data = new HashMap<String, String>();
		
		// confirm button selection
		logger.info(req.getParameter("agreeBtn"));
		if(Integer.parseInt(req.getParameter("agreeBtn")) == 1){	// agree
			if(managerStatus != null && Integer.parseInt(managerStatus) == 2){
				data.put("accountCode", accountCode);
				data.put("managerStatus", "1");
				dao.managerConfirmDao(data);
			}
			if(coachStatus != null && Integer.parseInt(coachStatus) == 2){
				data.put("accountCode", accountCode);
				data.put("coachStatus", "1");
				dao.coachConfirmDao(data);
			}
			// list of waiting confirm
			ArrayList<AccountDto> confList = dao.getConfirmListDao();
			req.setAttribute("confirmList", confList);
		} else {													// reject
			if(managerStatus != null && Integer.parseInt(managerStatus) == 2){
				data.put("accountCode", accountCode);
				data.put("managerStatus", "0");
				dao.managerConfirmDao(data);
			}
			if(coachStatus != null && Integer.parseInt(coachStatus) == 2){
				data.put("accountCode", accountCode);
				data.put("coachStatus", "0");
				dao.coachConfirmDao(data);
			}
			// list of waiting confirm
			ArrayList<AccountDto> confList = dao.getConfirmListDao();
			req.setAttribute("confirmList", confList);
		}
		// list of account
		ArrayList<MemberDto> dtos = dao.getAccountListDao();
		
		req.setAttribute("accountList", dtos);
		req.setAttribute("view", "AccountManagerFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "계정 관리");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : AccountCreateDialog.do
	 * MethodName : accountCreateDialog
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "AccountCreateDialog.do", method = RequestMethod.GET)
	public String accountCreateDialog(Locale locale) {
		logger.info("PingPong AccountCreateDialog.jsp", locale);
		return "AccountCreateDialog";
	}
	
	/*
	 * RequestMapping : AccountCreate.do
	 * MethodName : accountCreate
	 * Parameter : Locale, HttpServeltRequest
	 * Return : String
	 */
	@RequestMapping(value = "AccountCreate.do", method = RequestMethod.GET)
	public String accountCreate(Locale locale, HttpServletRequest req) {
		logger.info("PingPong AccountCreateMethod", locale);
		
		String id = req.getParameter("id");
		id = "\'" + id + "\'";
		String pwd = req.getParameter("pwd");
		pwd = "\'" + pwd + "\'";
		String managerStatusTemp = req.getParameter("manager");
		String coachStatusTemp = req.getParameter("coach");
		String memberCodeTemp = req.getParameter("memberCode");
		logger.info(id);
		logger.info(pwd);
		logger.info(managerStatusTemp);
		logger.info(coachStatusTemp);
		logger.info(memberCodeTemp);

		AccountDto dto = new AccountDto();
		dto.setId(id);
		dto.setPassword(pwd);
		
		// managerStatus and CoachStatus are confirmed by these sentences
		if(managerStatusTemp != null){
			dto.setManager_status(managerStatusTemp);
		} else {
			dto.setManager_status("0");
		}
		if(coachStatusTemp != null){
			dto.setCoach_status(coachStatusTemp);
		} else {
			dto.setCoach_status("0");
		}
		if(memberCodeTemp != null){
			int memberCode = Integer.parseInt(req.getParameter("memberCode"));
			dto.setMember_code(memberCode);
			PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
			dao.joinApplyAccountDao(dto);
		} else {
			PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
			dao.joinApplyDao(dto);
		}
		
		return "LoginHome";
	}
	
	/*
	 * RequestMapping : FindMember.do
	 * MethodName : findMember
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "FindMember.do", method = RequestMethod.GET)
	public String findMember(Locale locale, HttpServletRequest req) throws Exception{
		logger.info("PingPong FindMember.do", locale);
		
		req.setCharacterEncoding("UTF-8");
		String memberName = req.getParameter("memberName");
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		ArrayList<MemberDto> memberDto = dao.findMemberDao(memberName);
		for(int i=0; i<memberDto.size(); i++){
			System.out.println("managerStatus" + memberDto.get(i).getManager_status());
			System.out.println(memberDto.get(i).getRegisterday());
		}
		req.setAttribute("memberResult", memberDto);
		return "AccountCreateDialog";
	}
	
	/*
	 * RequestMapping : AccountEditDialog.do
	 * MethodName : accountManagerFrame
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "AccountEditDialog.do", method = RequestMethod.GET)
	public String accountEditDialog(Locale locale, Model model) {
		logger.info("PingPong AccountEditDialog.jsp", locale);
		return "AccountEditDialog";
	}
	
	/*
	 * RequestMapping : MainBootrackManagerFrame.do
	 * MethodName : mainBootrackManagerFrame
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "MainBootrackManagerFrame.do", method = RequestMethod.GET)
	public String mainBootrackManagerFrame(Locale locale, HttpServletRequest req) {
		logger.info("PingPong MainBootrackManagerFrame.do", locale);
		
		req.setAttribute("view", "MainBootrackManagerFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "신발장 관리");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : MainLockerManagerFrame.do
	 * MethodName : mainBootrackManagerFrame
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "MainLockerManagerFrame.do", method = RequestMethod.GET)
	public String mainLockerManagerFrame(Locale locale, HttpServletRequest req) {
		logger.info("PingPong MainLockerManagerFrame.do", locale);
		
		req.setAttribute("view", "MainLockerManagerFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "사물함 관리");
		return "MainHomeFrame";
	}
	
}
