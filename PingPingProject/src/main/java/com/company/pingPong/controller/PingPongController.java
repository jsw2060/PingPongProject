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
import com.company.pingPong.dto.CoachDto;
import com.company.pingPong.dto.FeeDto;
import com.company.pingPong.dto.MemberDto;

@Controller
public class PingPongController {

	private static final Logger logger = LoggerFactory.getLogger(PingPongController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * RequestMapping : index.do
	 * MethodName : loginHome
	 * Parameter : Locale
	 * Return : String
	 */
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
		
		// receive id and password from url
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		String name = "";
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		
		// Checking an exist of identification
		int idInfo = dao.loginIdDao(id);
		
		// Checking an exist of password
		int pwdInfo = dao.loginPwdDao(pwd);
		
		// When success to find id from database
		if(idInfo == 1){
			Map<String, String> map = new HashMap<String, String>();
			map.put("id", id);
			map.put("pwd", pwd);
			// Check exist status of member what it have same id and pwd.
			if(pwdInfo != 0){
				// And, getting some information from right tuple.
				MemberDto dto = dao.loginDao(map);
				
				// When the joiner is a member
				if(Integer.parseInt(dto.getApproval_status()) == 1){
					name = dao.loginNameDao(map);
				} else {	// When the joiner isn't a member
					name = "가입자";
				}
				
				HttpSession session = req.getSession();
			
				session.setAttribute("loginMemberCode", dto.getMember_code());
				session.setAttribute("loginId", dto.getId());
				session.setAttribute("loginPwd", dto.getPassword());
				session.setAttribute("loginName", name);
				session.setAttribute("loginApproval", dto.getApproval_status());
	
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
				System.out.println("해당 비밀번호가 없음");
				req.setAttribute("errorMsg", "계정이나 비밀번호가 올바르지 않습니다.");
				return "LoginHome";
			}
		} else {
			System.out.println("해당 아이디가 없음");
			req.setAttribute("errorMsg", "계정이나 비밀번호가 올바르지 않습니다.");
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
		//searchFeeDate = "\'" + searchFeeDate + "\'";
		
		// a list of fee what is searched by date
		logger.info(searchFeeDate);
		ArrayList<FeeDto> dateFeeList = dao.getDateFeeList(searchFeeDate);
		
		String tempFeeDate = "";
		for(int i =0; i<dateFeeList.size(); i++){
			if(dateFeeList.get(i).getFee_type().equals("일반")){			// When fee type is a normal pass
				dateFeeList.get(i).setName("일반");						// Name is normal
			} else if(dateFeeList.get(i).getFee_type().equals("일회원")) {	// When fee type is a day member pass
				dateFeeList.get(i).setName("일회원");						// Name is a day member
			}
			tempFeeDate = dateFeeList.get(i).getFee_date().substring(0, 11);
			dateFeeList.get(i).setFee_date(tempFeeDate);
			
			logger.info(dateFeeList.get(i).getMember_code());
			logger.info(dateFeeList.get(i).getName());
			logger.info(dateFeeList.get(i).getFee_type());
			System.out.println(dateFeeList.get(i).getFee_amount());
			System.out.println(dateFeeList.get(i).getFee_code());
			logger.info(dateFeeList.get(i).getFee_date().toString());
		}
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
		if(Integer.parseInt(status) == 0){	// general
			if(tempTime > 30){
				int tempHour = 0;
				int tempMin = 0;
				tempHour =(tempTime / 60);
				tempMin = (tempTime % 60);
				
				fee = (tempHour * 10000) + (tempMin * 6000);
				fee = fee * Integer.parseInt(req.getParameter("tableNum"));
			} 
			else {
				fee = (tempTime / 30) * 6000;
				fee = fee * Integer.parseInt(req.getParameter("tableNum"));
			}
		} else {			// student
			if(tempTime > 30){
				int tempHour = 0;
				int tempMin = 0;
				tempHour =(tempTime / 60);
				tempMin = (tempTime % 60);
				
				fee = (tempHour * 7000) + (tempMin * 4000);
				fee = fee * Integer.parseInt(req.getParameter("tableNum"));
			} 
			else {
				fee = (tempTime / 30) * 4000;
				fee = fee * Integer.parseInt(req.getParameter("tableNum"));
			}
		}
		String calFee = String.valueOf(fee);
		
		Map<String, String> data = new HashMap<String, String>();
		data.put("memberCode", memberCode);
		data.put("feeInputPage", "1");
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
	 * RequestMapping : OneDayFeeInput.do
	 * MethodName : oneDayMemberFee
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "OneDayFeeInput.do", method = RequestMethod.GET)
	public String oneDayMemberFee(Locale locale, HttpServletRequest req) {
		logger.info("PingPong oneDayMemberFee.do", locale);

		HttpSession session = req.getSession();
		
		String memberCode = session.getAttribute("loginMemberCode").toString();
		String calFee = "7000";
		
		Map<String, String> data = new HashMap<String, String>();
		data.put("memberCode", memberCode);
		data.put("feeInputPage", "2");
		data.put("calFee", calFee);
		
		req.setAttribute("specifyInput", data);
		req.setAttribute("view", "MainFeeInputFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "요금 입력");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : InserMonthFeeInput.do
	 * MethodName : insertmonthMemberFee
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "InsertMonthFeeInput.do", method = RequestMethod.GET)
	public String insertMonthMemberFee(Locale locale, HttpServletRequest req) {
		logger.info("PingPong InsertMonthMemberFee.do", locale);

		String memberCode = req.getParameter("memberCode");
		System.out.println("memberCode : " + memberCode);
		String calFee = "70000";
		
		Map<String, String> data = new HashMap<String, String>();
		data.put("memberCode", memberCode);
		data.put("feeInputPage", "3");
		data.put("calFee", calFee);
		
		req.setAttribute("specifyInput", data);
		req.setAttribute("view", "MainFeeInputFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "요금 입력");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : InsertLessonFeeInput.do
	 * MethodName : insertLessonFeeInput
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "InsertLessonFeeInput.do", method = RequestMethod.GET)
	public String insertLessonFeeInput(Locale locale, HttpServletRequest req) {
		logger.info("PingPong InsertLessonFeeInput.do", locale);

		// 요금계산 필요
		
		/*String memberCode = req.getParameter("memberCode");
		System.out.println("memberCode : " + memberCode);
		String calFee = "70000";
		
		Map<String, String> data = new HashMap<String, String>();
		data.put("memberCode", memberCode);
		data.put("feeInputPage", "3");
		data.put("calFee", calFee);
		
		req.setAttribute("specifyInput", data);*/
		
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
	 * RequestMapping : InsertGeneralFeeToDB.do
	 * MethodName : insertGeneralFeeToDB
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "InsertGeneralFeeToDB.do", method = RequestMethod.GET)
	public String insertGeneralFeeToDB(Locale locale, HttpServletRequest req) {
		logger.info("PingPong InsertGeneralFeeToDB.do", locale);
		
		String costInput = req.getParameter("costInput");
		String noteInput = req.getParameter("noteInput");
		
		logger.info(costInput);
		logger.info(noteInput);

		Map<String, String> data = new HashMap<String, String>();
		data.put("feeType", "일반");
		data.put("feeAmount", costInput);
		data.put("feeNote", noteInput);

		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		dao.insertGeneralFeeDao(data);
		
		req.setAttribute("view", "MainFeeInputFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "요금 입력");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : InsertOnedayFeeToDB.do
	 * MethodName : insertOnedayFeeToDB
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "InsertOnedayFeeToDB.do", method = RequestMethod.GET)
	public String insertOnedayFeeToDB(Locale locale, HttpServletRequest req) {
		logger.info("PingPong InsertOnedayFeeToDB.do", locale);
		
		String costInput = req.getParameter("costInput");
		String noteInput = req.getParameter("noteInput");
		
		logger.info(costInput);
		logger.info(noteInput);

		Map<String, String> data = new HashMap<String, String>();
		data.put("feeType", "일회원");
		data.put("feeAmount", costInput);
		data.put("feeNote", noteInput);

		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		dao.insertOneDayFeeDao(data);
		
		req.setAttribute("view", "MainFeeInputFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "요금 입력");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : InsertMonthFeeToDB.do
	 * MethodName : insertMonthFeeToDB
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "InsertMonthFeeToDB.do", method = RequestMethod.GET)
	public String insertMonthFeeToDB(Locale locale, HttpServletRequest req) {
		logger.info("PingPong InsertMonthFeeToDB.do", locale);
		
		String costInput = req.getParameter("costInput");
		String noteInput = req.getParameter("noteInput");
		String memberCode = req.getParameter("specifyMemberCode");
		
		logger.info(costInput);
		logger.info(noteInput);

		Map<String, String> data = new HashMap<String, String>();
		data.put("feeType", "월회원");
		data.put("feeAmount", costInput);
		data.put("feeNote", noteInput);

		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		dao.insertMonthFeeDao(data);
		
		String prevFeeCode = dao.getPrevFeeCode();
		int existMonthMember = dao.checkMonthMemberDao(memberCode);
		
		Map<String, String> monthInfo = new HashMap<String, String>();
		monthInfo.put("memberCode", memberCode);
		monthInfo.put("feeCode", prevFeeCode);
		
		if(existMonthMember != 0){
			dao.updateMonthMemberDao(monthInfo);
		} else {
			dao.insertNewMonthMemberDao(monthInfo);
		}
		
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
		ArrayList<MemberDto> confList = dao.getConfirmListDao();
		String tempDate = "";
		for(int i=0; i<confList.size(); i++){
			tempDate = confList.get(i).getRegisterday().substring(0, 11);
			confList.get(i).setRegisterday(tempDate);
		}
		// list of account
		ArrayList<MemberDto> dtos = dao.getAccountListDao();
		String tempMemberDate = "";
		for(int i=0; i<dtos.size(); i++){
			tempMemberDate = dtos.get(i).getRegisterday().substring(0, 11);
			dtos.get(i).setRegisterday(tempMemberDate);
		}
		
		req.setAttribute("confirmList", confList);
		req.setAttribute("memberList", dtos);
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
		
		String memberCode = req.getParameter("member_code");
		String managerStatus = req.getParameter("manager_status");
		String coachStatus = req.getParameter("coach_status");
		
		Map<String, String> data = new HashMap<String, String>();
		
		// confirm button selection
		logger.info(req.getParameter("agreeBtn"));
		if(Integer.parseInt(req.getParameter("agreeBtn")) == 1){	// agree
			if(managerStatus != null && Integer.parseInt(managerStatus) == 2){
				data.put("memberCode", memberCode);
				data.put("managerStatus", "1");
				dao.managerConfirmDao(data);
			}
			if(coachStatus != null && Integer.parseInt(coachStatus) == 2){
				data.put("memberCode", memberCode);
				data.put("coachStatus", "1");
				dao.coachConfirmDao(data);
			}
			if(Integer.parseInt(managerStatus) == 0 && Integer.parseInt(coachStatus) == 0){		// ordinary member
				dao.memberConfirmDao(memberCode);
			}
			// list of waiting confirm
			ArrayList<MemberDto> confList = dao.getConfirmListDao();
			String tempDate = "";
			for(int i=0; i<confList.size(); i++){
				tempDate = confList.get(i).getRegisterday().substring(0, 11);
				confList.get(i).setRegisterday(tempDate);
			}
			req.setAttribute("confirmList", confList);
		} else {													// reject
			if(managerStatus != null && Integer.parseInt(managerStatus) == 2){
				data.put("memberCode", memberCode);
				data.put("managerStatus", "0");
				dao.managerConfirmDao(data);
			}
			if(coachStatus != null && Integer.parseInt(coachStatus) == 2){
				data.put("memberCode", memberCode);
				data.put("coachStatus", "0");
				dao.coachConfirmDao(data);
			}
			// list of waiting confirm
			ArrayList<MemberDto> confList = dao.getConfirmListDao();
			String tempDate = "";
			for(int i=0; i<confList.size(); i++){
				tempDate = confList.get(i).getRegisterday().substring(0, 11);
				confList.get(i).setRegisterday(tempDate);
			}
			req.setAttribute("confirmList", confList);
		}
		// list of account
		ArrayList<MemberDto> dtos = dao.getAccountListDao();
		
		req.setAttribute("memberList", dtos);
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
		
		// id, pwd, manager, coach, name, age, sex, tel, email, addr, birthday, style, grade, note
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		String manager = req.getParameter("manager");
		String coach = req.getParameter("coach");
		String name = req.getParameter("userName");
		String age = req.getParameter("userAge");
		String sex = req.getParameter("userSex");
		String tel = req.getParameter("userTel");
		String email = req.getParameter("userEmail1") + req.getParameter("userEmail2");
		String addr = req.getParameter("userAddr");
		String birthday = req.getParameter("userBday");
		String grade = req.getParameter("userGrade");
		String style = req.getParameter("userStyle");
		String note = req.getParameter("userNote");
		
		// define memberDto instance
		MemberDto dto = new MemberDto();
		dto.setId(id);
		dto.setPassword(pwd);
		if(manager != null) {dto.setManager_status(manager);}
		else {dto.setManager_status("0");}
		if(coach != null) dto.setCoach_status(coach);
		else {dto.setCoach_status("0");}
		dto.setName(name);
		dto.setAge(age);
		dto.setSex(sex);
		dto.setTel(tel);
		dto.setEmail(email);
		dto.setAddr(addr);
		dto.setBirthday(birthday);
		dto.setGrade(grade);
		dto.setStyle(style);
		dto.setNote(note);
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		dao.joinApplyAccountDao(dto);
		
		return "LoginHome";
	}
	
	/*
	 * RequestMapping : FindMonthAndMember.do
	 * MethodName : findMonthAndMember
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "FindMonthAndMember.do", method = RequestMethod.GET)
	public String findMonthAndMember(Locale locale, HttpServletRequest req) throws Exception{
		logger.info("PingPong FindMonthAndMember.do", locale);
		
		req.setCharacterEncoding("UTF-8");
		String memberName = req.getParameter("memberName");
		logger.info(memberName);
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		ArrayList<MemberDto> memberDto = dao.findMonthAndMemberDao(memberName);

		for(int i=0; i<memberDto.size(); i++){
			logger.info(memberDto.get(i).getMember_code());
			logger.info(memberDto.get(i).getName());
			logger.info(memberDto.get(i).getSex());
			logger.info(memberDto.get(i).getFee_status());
		}
		req.setAttribute("memberResult", memberDto);
		req.setAttribute("view", "MonthFeeInput");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "월 회원 세부 정보");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : FindLessonAndMember.do
	 * MethodName : findLessonAndMember
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "FindLessonAndMember.do", method = RequestMethod.GET)
	public String findLessonAndMember(Locale locale, HttpServletRequest req) throws Exception{
		logger.info("PingPong FindLessonAndMember.do", locale);
		
		req.setCharacterEncoding("UTF-8");
		String memberName = req.getParameter("memberName");
		logger.info(memberName);
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		ArrayList<MemberDto> memberDto = dao.findLessonAndMemberDao(memberName);

		for(int i=0; i<memberDto.size(); i++){
			logger.info(memberDto.get(i).getMember_code());
			logger.info(memberDto.get(i).getName());
			logger.info(memberDto.get(i).getSex());
		}
		req.setAttribute("memberResult", memberDto);
		req.setAttribute("view", "LessonFeeInput");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "레슨 세부 정보");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : FindLessonAndCoach.do
	 * MethodName : findLessonAndCoach
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "FindLessonAndCoach.do", method = RequestMethod.GET)
	public String findLessonAndCoach(Locale locale, HttpServletRequest req) throws Exception{
		logger.info("PingPong FindLessonAndCoach.do", locale);
		
		req.setCharacterEncoding("UTF-8");
		String coachName = req.getParameter("coachName");
		logger.info(coachName);
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		ArrayList<CoachDto> coachDto = dao.findLessonAndCoachDao(coachName);

		for(int i=0; i<coachDto.size(); i++){
			logger.info(coachDto.get(i).getMember_code());
			logger.info(coachDto.get(i).getName());
			logger.info(coachDto.get(i).getSex());
		}
		req.setAttribute("coachResult", coachDto);
		req.setAttribute("view", "LessonFeeInput");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "레슨 세부 정보");
		return "MainHomeFrame";
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
