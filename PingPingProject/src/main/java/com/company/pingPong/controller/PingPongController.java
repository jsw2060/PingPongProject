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
		
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		String name = "";
		String errorMsg = "";
		
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
		
			session.setAttribute("loginId", dto.getId());
			session.setAttribute("loginPwd", dto.getPassword());
			session.setAttribute("loginName", name);
			
			// Checking authorization of manager or coach
			if(dto.getManager_status() == 1) {
				session.setAttribute("loginAuthor", "admin");
				session.setAttribute("accountMsg", "관리자계정");
			}
			else {
				if(dto.getCoach_status() == 1) {
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
	 * Parameter : Locale, HttpServletRequest, Model
	 * Return : String
	 */
	@RequestMapping(value = "MainHomeFrame.do", method = RequestMethod.POST)
	public String mainHomeFrame(Locale locale, HttpServletRequest req, Model model) {
		logger.info("PingPong MainHomeFrame.jsp", locale);
		
		model.addAttribute("view", "MainHome");
		model.addAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
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
	 * Parameter : Locale
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
	 * RequestMapping : /GeneralFeeInput
	 * MethodName : generalFeeInput
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "GeneralFeeInput.do", method = RequestMethod.GET)
	public String generalFeeInput(Locale locale, Model model) {
		logger.info("PingPong GeneralFeeInput.jsp", locale);
		return "GeneralFeeInput";
	}
	
	/*
	 * RequestMapping : /MonthFeeInput
	 * MethodName : monthFeeInput
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "MonthFeeInput.do", method = RequestMethod.GET)
	public String monthFeeInput(Locale locale, Model model) {
		logger.info("PingPong MonthFeeInput.jsp", locale);
		return "MonthFeeInput";
	}
	
	/*
	 * RequestMapping : /LessonFeeInput
	 * MethodName : lessonFeeInput
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "LessonFeeInput.do", method = RequestMethod.GET)
	public String lessonFeeInput(Locale locale, Model model) {
		logger.info("PingPong lessonFeeInput.jsp", locale);
		return "LessonFeeInput";
	}
	
	/*
	 * RequestMapping : /MainFeeManagerFrame
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
	 * RequestMapping : /FeeManagerChart
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
	 * RequestMapping : /MainMemberManagerFrame
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
	 * RequestMapping : /MainLessonManagerFrame
	 * MethodName : mainLessonManagerFrame
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "MainLessonManagerFrame.do", method = RequestMethod.GET)
	public String mainLessonManagerFrame(Locale locale, Model model) {
		logger.info("PingPong MainLessonManagerFrame.jsp", locale);
		return "MainLessonManagerFrame";
	}
	
	/*
	 * RequestMapping : /LessonEditDialog
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
	 * RequestMapping : /AccountManagerFrame
	 * MethodName : accountManagerFrame
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "AccountManagerFrame.do", method = RequestMethod.GET)
	public String accountManagerFrame(Locale locale, Model model) {
		logger.info("PingPong AccountManagerFrame.jsp", locale);
		
		return "AccountManagerFrame";
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
			int managerStatus = Integer.parseInt(req.getParameter("manager"));
			dto.setManager_status(managerStatus);
		} else {
			dto.setManager_status(0);
		}
		if(coachStatusTemp != null){
			int coachStatus = Integer.parseInt(req.getParameter("coach"));
			dto.setCoach_status(coachStatus);
		} else {
			dto.setCoach_status(0);
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
		/*
		if(req.getAttribute("memberCode") != null){
			dto.setMember_code(memberCode);
			
		}*/ /*else {
			dto.setMember_code(0);
		}*/
		
		return "LoginHome";
	}
	
	/*
	 * RequestMapping : FindMember
	 * MethodName : accountManagerFrame
	 * Parameter : Locale
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
	 * RequestMapping : /AccountEditDialog
	 * MethodName : accountManagerFrame
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "AccountEditDialog.do", method = RequestMethod.GET)
	public String accountEditDialog(Locale locale, Model model) {
		logger.info("PingPong AccountEditDialog.jsp", locale);
		return "AccountEditDialog";
	}
}
