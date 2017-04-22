/*
 * 작성일 : 2017.04.17
 * 작성자 : 정성원
 * 파일명 : PingPingController.java
 */
package com.company.pingPong.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PingPongController {

	private static final Logger logger = LoggerFactory.getLogger(PingPongController.class);
	
	/*
	 * RequestMapping : /
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
	 * MethodName : loginHome
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "Login.do")
	public String login(Locale locale, HttpServletRequest req) {
		logger.info("PingPong Login.jsp", locale);
		String id = req.getParameter("id");
		System.out.println("id " + id);
		String pwd = req.getParameter("pwd");
		System.out.println("pwd " + pwd);
		
		return "LoginHome";
	}
	
	/*
	 * RequestMapping : /MainHomeFrame
	 * MethodName : mainHomeFrame
	 * Parameter : Locale, Model
	 * Return : String
	 */
	@RequestMapping(value = "MainHomeFrame.do", method = RequestMethod.GET)
	public String mainHomeFrame(Locale locale, Model model) {
		logger.info("PingPong MainHomeFrame.jsp", locale);
		model.addAttribute("view", "MainHome");
		model.addAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : /MainHomeButtonsPane
	 * MethodName : mainHomeButtonsPane
	 * Parameter : Locale, Model
	 * Return : String
	 */
	@RequestMapping(value = "MainHomeButtonsPane.do", method = RequestMethod.GET)
	public String mainHomeButtonsPane(Locale locale, Model model) {
		logger.info("PingPong MainHomeButtonsPane.jsp", locale);
		model.addAttribute("MainHomeTitle", "황남숙 탁구교실 관리 프로그램");
		return "MainHomeButtonsPane";
	}
	
	/*
	 * RequestMapping : /MainHomeMenuList
	 * MethodName : mainHomeMenuList
	 * Parameter : Locale, Model
	 * Return : String
	 */
	@RequestMapping(value = "MainHomeMenuList.do", method = RequestMethod.GET)
	public String mainHomeMenuList(Locale locale, Model model) {
		logger.info("PingPong MainHomeMenuList.jsp", locale);
		return "MainHomeMenuList";
	}
	
	/*
	 * RequestMapping : /MainFeeInputFrame
	 * MethodName : mainFeeManagerFrame
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "/MainFeeInputFrame", method = RequestMethod.GET)
	public String mainFeeInputFrame(Locale locale, Model model) {
		logger.info("PingPong MainFeeInputFrame.jsp", locale);
		return "MainFeeInputFrame";
	}
	
	/*
	 * RequestMapping : /GeneralFeeInput
	 * MethodName : generalFeeInput
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "/GeneralFeeInput", method = RequestMethod.GET)
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
	@RequestMapping(value = "/MonthFeeInput", method = RequestMethod.GET)
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
	@RequestMapping(value = "/LessonFeeInput", method = RequestMethod.GET)
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
	@RequestMapping(value = "/MainFeeManagerFrame", method = RequestMethod.GET)
	public String mainFeeManagerFrame(Locale locale, Model model) {
		logger.info("PingPong MainFeeManagerFrame.jsp", locale);
		return "MainFeeManagerFrame";
	}
	
	/*
	 * RequestMapping : /FeeManagerChart
	 * MethodName : feeManagerChart
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "/FeeManagerChart", method = RequestMethod.GET)
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
	@RequestMapping(value = "/MainMemberManagerFrame", method = RequestMethod.GET)
	public String mainMemberManagerFrame(Locale locale) {
		logger.info("PingPong MainMemberManagerFrame.jsp", locale);
		
		return "MainMemberManagerFrame";
	}
	
	/*
	 * RequestMapping : /MainLessonManagerFrame
	 * MethodName : mainLessonManagerFrame
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "/MainLessonManagerFrame", method = RequestMethod.GET)
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
	@RequestMapping(value = "/LessonEditDialog", method = RequestMethod.GET)
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
	@RequestMapping(value = "/AccountManagerFrame", method = RequestMethod.GET)
	public String accountManagerFrame(Locale locale, Model model) {
		logger.info("PingPong AccountManagerFrame.jsp", locale);
		return "AccountManagerFrame";
	}
	
	/*
	 * RequestMapping : /AccountCreateDialog
	 * MethodName : accountManagerFrame
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "AccountCreateDialog.do", method = RequestMethod.GET)
	public String accountCreateDialog(Locale locale) {
		logger.info("PingPong AccountCreateDialog.jsp", locale);
		return "AccountCreateDialog";
	}
	
	/*
	 * RequestMapping : /AccountEditDialog
	 * MethodName : accountManagerFrame
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "/AccountEditDialog", method = RequestMethod.GET)
	public String accountEditDialog(Locale locale, Model model) {
		logger.info("PingPong AccountEditDialog.jsp", locale);
		return "AccountEditDialog";
	}
}
