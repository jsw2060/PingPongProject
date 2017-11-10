/*
 * 작성일 : 2017.04.17
 * 작성자 : 정성원
 * 파일명 : PingPingController.java
 * 인코딩 : UTF-8 server.xml에 URIEncoding("UTF-8") 설정 필요
 */
package com.company.pingPong.controller;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.sql.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.company.pingPong.dao.PingPongDao;
import com.company.pingPong.dto.BootrackDto;
import com.company.pingPong.dto.CoachDto;
import com.company.pingPong.dto.FeeDto;
import com.company.pingPong.dto.LockerDto;
import com.company.pingPong.dto.MemberDto;

@Controller
public class PingPongController {

	private static final Logger logger = LoggerFactory.getLogger(PingPongController.class);
	private static String RSA_WEB_KEY = "_RSA_WEB_KEY_";	// 개인키 session key
	private static String RSA_INSTANCE = "RSA";				// rsa transformation
	
	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * MethodName : initRsa
	 * Parameter : HttpServletRequest
	 */
	public void initRsa(HttpServletRequest req) {
		HttpSession session = req.getSession();
		
		KeyPairGenerator generator;
		
		try {
			generator = KeyPairGenerator.getInstance(PingPongController.RSA_INSTANCE);
			generator.initialize(1024);
			
			KeyPair keyPair = generator.genKeyPair();
			KeyFactory keyFactory = KeyFactory.getInstance(PingPongController.RSA_INSTANCE);
			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();
			
			session.setAttribute(PingPongController.RSA_WEB_KEY, privateKey);	// Store RSA PrivateKey in a session
			
			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			String publicKeyModulus = publicSpec.getModulus().toString(16);
			String privateKeyExponent = publicSpec.getPublicExponent().toString(16);
			
			req.setAttribute("RSAModulus", publicKeyModulus);
			req.setAttribute("RSAExponent", privateKeyExponent);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * RequestMapping : index.do
	 * MethodName : loginHome
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "index.do")
	public String loginHome(Locale locale, HttpServletRequest req) {
		logger.info("PingPong LoginHome.jsp", locale);
		
		// Create RSA Key
		initRsa(req);
		
		return "LoginHome";
	}
	
	/*
	 * MethodName : hexToByteArray
	 * Parameter : String hex
	 * Return : byte[] bytes
	 */
	public static byte[] hexToByteArray(String hex) {
		if(hex == null || hex.length() % 2 != 0) {
			return new byte[] {};
		}
		
		byte[] bytes = new byte[hex.length() / 2];
		
		for(int i = 0; i < hex.length(); i += 2) {
			byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
			bytes[(int) Math.floor(i / 2)] = value;
		}
		
		return bytes;
	}
	
	/*
	 * MethodName : decryptRsa
	 * Parameter : securityValue
	 * Return : String
	 */
	private String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
		Cipher cipher = Cipher.getInstance(PingPongController.RSA_INSTANCE);
		byte[] encryptedBytes = hexToByteArray(securedValue);
		cipher.init(Cipher.DECRYPT_MODE, privateKey);
		byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
		String decryptedValue = new String(decryptedBytes, "UTF-8");
		
		return decryptedValue;
	}
	
	/*
	 * RequestMapping : Login.do
	 * MethodName : login
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "Login.do")
	public String login(Locale locale, HttpServletRequest req) throws Exception{
		logger.info("PingPong Login.jsp", locale);
		
		// receive id and password from url
		String id = (String)req.getParameter("USER_ID");
		String pwd = (String)req.getParameter("USER_PW");
		String name = "";
		
		HttpSession session = req.getSession();
		PrivateKey privateKey = (PrivateKey)session.getAttribute(PingPongController.RSA_WEB_KEY);
		
		// 복호화
		id = decryptRsa(privateKey, id);
		pwd = decryptRsa(privateKey, pwd);
		
		// 개인키 삭제
		session.removeAttribute(PingPongController.RSA_WEB_KEY);
		
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
				
				// Create RSA Key
				initRsa(req);
				
				System.out.println("해당 비밀번호가 없음");
				req.setAttribute("errorMsg", "계정이나 비밀번호가 올바르지 않습니다.");
				return "LoginHome";
			}
		} else {
			
			// Create RSA Key
			initRsa(req);
			
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
		
		return "redirect:/index.do";
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
	 * RequestMapping : InsertMonthFeeInput.do
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
		
		// 전체리스트 준비
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		ArrayList<MemberDto> defaultTMList = dao.defaultTotalMember();
		// join_status = 0 가입자, 1 일회원, 2 월회원
		
		String tempRegDate = "";
		for(int i=0; i<defaultTMList.size(); i++){
			
			if(defaultTMList.get(i).getRegisterday() != null) {
				tempRegDate = defaultTMList.get(i).getRegisterday().substring(0, 11);
			} else {
				tempRegDate = "";
			}
			
			defaultTMList.get(i).setRegisterday(tempRegDate);
		}
		
		String tempBdayDate = "";
		for(int i=0; i<defaultTMList.size(); i++){
			tempBdayDate = defaultTMList.get(i).getBirthday().substring(0, 11);
			defaultTMList.get(i).setBirthday(tempBdayDate);
		}
		
		// 월회원 리스트
		ArrayList<MemberDto> defaultMMList = dao.defaultMonthMember();
		
		String tempMMRegDate = "";
		for(int i=0; i<defaultMMList.size(); i++){
			tempMMRegDate = defaultMMList.get(i).getMonth_registerdate().substring(0, 11);
			defaultMMList.get(i).setMonth_registerdate(tempMMRegDate);
		}
		
		String tempMMBdayDate = "";
		for(int i=0; i<defaultMMList.size(); i++){
			tempMMBdayDate = defaultMMList.get(i).getBirthday().substring(0, 11);
			defaultMMList.get(i).setBirthday(tempMMBdayDate);
		}
		
		// 레슨회원 리스트
		//ArrayList<MemberDto> defaultLMList = dao.defaultLessonMember();
		
		
		// 코치리스트 준비
		ArrayList<CoachDto> defaultCoachList = dao.defaultTotalCoach();
		
		String tempCoachRegdate = "";
		for(int i=0; i<defaultCoachList.size(); i++) {
			tempCoachRegdate = defaultCoachList.get(i).getCoach_registerdate().substring(0, 11);
			defaultCoachList.get(i).setCoach_registerdate(tempCoachRegdate);			
		}
		
		req.setAttribute("defaultMMList", defaultMMList);
		req.setAttribute("defaultTMList", defaultTMList);
		req.setAttribute("defaultCoachList", defaultCoachList);
		req.setAttribute("view", "MainMemberManagerFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "회원정보 관리");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : MemberEditDialog.do
	 * MethodName : memberEditDialog
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "MemberEditDialog.do", method = RequestMethod.GET)
	public String memberEditDialog(Locale locale, HttpServletRequest req) {
		logger.info("PingPong MemberEditDialog.jsp", locale);
		
		String sendedId = req.getParameter("memberId");
		String sendedName = req.getParameter("memberName");
		String sendedSex = req.getParameter("memberSex");
		String sendedTel = req.getParameter("memberTel");
		String sendedAge = req.getParameter("memberAge");
		String sendedBday = req.getParameter("memberBday");
		String sendedAddr = req.getParameter("memberAddr");
		String sendedEmail = req.getParameter("memberEmail");
		String sendedStyle = req.getParameter("memberStyle");
		String sendedGrade = req.getParameter("memberGrade");
		String sendedRegDay = req.getParameter("memberRegDay");
		String sendedNote = req.getParameter("memberNote");
		
		sendedBday = sendedBday.trim();
		sendedRegDay = sendedRegDay.trim();
		
		System.out.println("sendedBday " + sendedBday);
		System.out.println("sendedStyle " + sendedStyle);
		System.out.println("sendedGrade " + sendedGrade);
		System.out.println("sendedSex " + sendedSex);
		
		req.setAttribute("memberId", sendedId);
		req.setAttribute("memberName", sendedName);
		req.setAttribute("memberSex", sendedSex);
		req.setAttribute("memberTel", sendedTel);
		req.setAttribute("memberAge", sendedAge);
		req.setAttribute("memberBday", sendedBday);
		req.setAttribute("memberAddr", sendedAddr);
		req.setAttribute("memberEmail", sendedEmail);
		req.setAttribute("memberStyle", sendedStyle);
		req.setAttribute("memberGrade", sendedGrade);
		req.setAttribute("memberRegDay", sendedRegDay);
		req.setAttribute("memberNote", sendedNote);
		
		req.setAttribute("view", "MemberEditDialog");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "회원 정보 수정");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : MemberUpdate.do
	 * MethodName : memberUpdate
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "MemberUpdate.do", method = RequestMethod.GET)
	public String memberUpdate(Locale locale, HttpServletRequest req) {
		logger.info("PingPong MemberUpdate.do", locale);
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		
		// 수정 정보 값을 req로 긁어옴
		String code = req.getParameter("userCode");
		String name = req.getParameter("updateName");
		String sex = req.getParameter("updateSex");
		String tel = req.getParameter("updateTel");
		String age = req.getParameter("updateAge");
		String bDay = req.getParameter("updateBday");
		String addr = req.getParameter("updateAddr");
		String email = req.getParameter("updateEmail");
		String style = req.getParameter("updateStyle");
		String grade = req.getParameter("updateGrade");
		String regDay = req.getParameter("updateRegDay");
		String note = req.getParameter("updateNote");
		
		logger.warn("code " + code);
		logger.warn("name " + name);
		logger.warn("sex " + sex);
		logger.warn("tel " + tel);
		logger.warn("age " + age);
		logger.warn("bDay " + bDay);
		logger.warn("addr " + addr);
		logger.warn("email " + email);
		logger.warn("style " + style);
		logger.warn("grade " + grade);
		logger.warn("regDay " + regDay);
		logger.warn("note " + note);
		
		// map에 모아서 전송 준비
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("code", code);
		map.put("name", name);
		map.put("sex", sex);
		map.put("tel", tel);
		map.put("age", age);
		map.put("bDay", bDay);
		map.put("addr", addr);
		map.put("email", email);
		map.put("style", style);
		map.put("grade", grade);
		map.put("regDay", regDay);
		map.put("note", note);
		
		// 수정 DAO
		dao.memberUpdateDao(map);
		
		return "redirect:/MainMemberManagerFrame.do";
	}
	
	/*
	 * RequestMapping : MonthMemberEditDialog.do
	 * MethodName : monthMemberEditDialog
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "MonthMemberEditDialog.do", method = RequestMethod.GET)
	public String monthMemberEditDialog(Locale locale, HttpServletRequest req) {
		logger.info("PingPong MonthMemberEditDialog.jsp", locale);
		
		String sendedId = req.getParameter("memberId");
		String sendedName = req.getParameter("memberName");
		String sendedSex = req.getParameter("memberSex");
		String sendedTel = req.getParameter("memberTel");
		String sendedAge = req.getParameter("memberAge");
		String sendedBday = req.getParameter("memberBday");
		String sendedAddr = req.getParameter("memberAddr");
		String sendedEmail = req.getParameter("memberEmail");
		String sendedStyle = req.getParameter("memberStyle");
		String sendedGrade = req.getParameter("memberGrade");
		String sendedRegDay = req.getParameter("memberRegDay");
		String sendedNote = req.getParameter("memberNote");
		
		sendedBday = sendedBday.trim();
		sendedRegDay = sendedRegDay.trim();
		
		req.setAttribute("memberRegDay", sendedRegDay);
		req.setAttribute("view", "MonthMemberEditDialog");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "월 회원 수정");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : CoachAddDialog.do
	 * MethodName : coachAddDialog
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "CoachAddDialog.do", method = RequestMethod.GET)
	public String coachAddDialog(Locale locale, HttpServletRequest req) {
		logger.info("PingPong CoachAddDialog.jsp", locale);
		
		req.setAttribute("view", "CoachAddDialog");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "코치 추가");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : CoachSearch.do
	 * MethodName : coachSearch
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "CoachSearch.do", method = RequestMethod.GET)
	@ResponseBody
	public List<Map> coachSearch(Locale locale, HttpServletRequest req) {
		logger.info("PingPong CoachSearch.do", locale);
		
		String searchName = req.getParameter("searchName");
		System.out.println("searchName " + searchName);
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		List<Map> findedMemberList = dao.searchAccountListByNameForCoachDao(searchName);

		return findedMemberList;
	}
	
	/*
	 * RequestMapping : AddCoach.do
	 * MethodName : addCoach
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "AddCoach.do", method = RequestMethod.GET)
	public String addCoach(Locale locale, HttpServletRequest req) {
		logger.info("PingPong AddCoach.do", locale);
		
		String coachName = req.getParameter("selectedMember");
		String coachDay = req.getParameter("coachDay");
		String coachRegDay = req.getParameter("coachRegDay");
		String coachNote = req.getParameter("coachNote");
		
		System.out.println("coachName " + coachName);
		System.out.println("coachDay " + coachDay);
		System.out.println("coachRegDay " + coachRegDay);
		System.out.println("coachNote " + coachNote);
		
		// map에 모아서 전송 준비
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("coachName", coachName);
		map.put("coachDay", coachDay);
		map.put("coachRegDay", coachRegDay);
		map.put("coachNote", coachNote);
		
		// 수정 DAO
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		dao.insertCoachDao(map);
		dao.checkCoachStatusDao();
		
		return "redirect:/MainMemberManagerFrame.do";
	}
	
	/*
	 * RequestMapping : CoachEditDialog.do
	 * MethodName : coachEditDialog
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "CoachEditDialog.do", method = RequestMethod.GET)
	public String coachEditDialog(Locale locale, HttpServletRequest req) {
		logger.info("PingPong CoachEditDialog.jsp", locale);

		String coachMemberCode = req.getParameter("memberId");		
		System.out.println("coachMemberCode " + coachMemberCode);
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		ArrayList<CoachDto> CoachInfoList = dao.searchCoachByMemberIdDao(coachMemberCode);
		
		for(int i=0; i<CoachInfoList.size(); i++) {
		
			logger.info("id ",CoachInfoList.get(i).getMember_code());
			logger.info("name ",CoachInfoList.get(i).getName());
			logger.info("sex ",CoachInfoList.get(i).getSex());
			logger.info("registerdate ",CoachInfoList.get(i).getCoach_registerdate());
			logger.info("workweekday ",CoachInfoList.get(i).getWork_weekday());
		}
		
		req.setAttribute("CoachInfoList", CoachInfoList);
		req.setAttribute("view", "CoachEditDialog");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "코치 수정");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : EditCoach.do
	 * MethodName : editCoach
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "EditCoach.do", method = RequestMethod.GET)
	public String editCoach(Locale locale, HttpServletRequest req) {
		logger.info("PingPong EditCoach.do", locale);
		
		// 변경된 값을 받아온다.
		String memberCode = req.getParameter("sendMemberCode");
		String coachRegDay = req.getParameter("sendRegDay");
		String coachWorkWeekday = req.getParameter("sendWorkWeekday");
		String coachNote = req.getParameter("sendNote");
		
		System.out.println("memberCode " + memberCode);
		System.out.println("coachRegDay " + coachRegDay);
		System.out.println("coachWorkWeekday " + coachWorkWeekday);
		System.out.println("coachNote " + coachNote);
		
		// 변경값이 없을 때는, 과거값을 그대로 가져옴
		if(coachRegDay.equals(null) || coachRegDay == "" || coachRegDay.equals("null")) {
			coachRegDay = req.getParameter("coachRegDay");
		}
		
		// 변경값이 없는 레슨요일
		if(coachWorkWeekday.equals(null) || coachWorkWeekday == "" || coachWorkWeekday.equals("null")) {
			coachWorkWeekday = req.getParameter("coachWorkDay");
		} else {
			String[] tempList;
			String[] storage = {"false", "false", "false", "false", "false", "false", "false"};
			// tempList에 각 요일 저장
			tempList = coachWorkWeekday.split("");
			
			for(int i=0; i< tempList.length; i++) {
				System.out.println("tempList[" + i + "] " +tempList[i]);
			}
			
			for(int i=0; i<tempList.length; i++) {
				if(tempList[i].equals("월")) {
					System.out.println("뭐야");
					storage[0] = tempList[i];
				} else if(tempList[i].equals("화")) {
					storage[1] = tempList[i];
				} else if(tempList[i].equals("수")) {
					storage[2] = tempList[i];
				} else if(tempList[i].equals("목")) {
					storage[3] = tempList[i];
				} else if(tempList[i].equals("금")) {
					storage[4] = tempList[i];
				} else if(tempList[i].equals("토")) {
					storage[5] = tempList[i];
				} else if(tempList[i].equals("일")) {
					storage[6] = tempList[i];
				}
			}
			
			coachWorkWeekday = "";
			for(int j=0; j<storage.length; j++) {
				System.out.println("수정근무일 " + storage[j]);
				coachWorkWeekday = coachWorkWeekday + storage[j] + ",";
			}
			coachWorkWeekday = coachWorkWeekday.substring(0, coachWorkWeekday.length()-1);
		}
		if(coachNote.equals(null) || coachNote == "" || coachNote.equals("null")) {
			coachNote = req.getParameter("coachNote");
		}
		
		System.out.println("memberCode " + memberCode);
		System.out.println("coachRegDay " + coachRegDay);
		System.out.println("coachWorkWeekday " + coachWorkWeekday);
		System.out.println("coachNote " + coachNote);
		
		// map에 모아서 전송 준비
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("memberCode", memberCode);
		map.put("coachRegDay", coachRegDay);
		map.put("coachWorkWeekday", coachWorkWeekday);
		map.put("coachNote", coachNote);
		
		// 수정 DAO
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		dao.editCoachDao(map);
		
		return "redirect:/MainMemberManagerFrame.do";
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
			tempDate = confList.get(i).getJoin_date().substring(0, 11);
			confList.get(i).setJoin_date(tempDate);
		}
		// list of account
		ArrayList<MemberDto> dtos = dao.getAccountListDao();
		String tempMemberDate = "";
		for(int i=0; i<dtos.size(); i++){
			tempMemberDate = dtos.get(i).getJoin_date().substring(0, 11);
			dtos.get(i).setJoin_date(tempMemberDate);
		}
		
		req.setAttribute("confirmList", confList);
		req.setAttribute("memberList", dtos);
		req.setAttribute("view", "AccountManagerFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "계정 관리");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : AccountEditDialog.do
	 * MethodName : accountEditDialog
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "AccountEditDialog.do", method = RequestMethod.GET)
	public String accountEditDialog(Locale locale, HttpServletRequest req) {
		logger.info("PingPong AccountEditDialog.jsp", locale);
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		
		String selecteId = req.getParameter("selectedId");
		System.out.println("선택된 id " + selecteId);
		
		ArrayList<MemberDto> selectedInfo = dao.searchAccountListDao(selecteId);
		
		System.out.println(selectedInfo.get(0).getId());
		
		req.setAttribute("selectedInfo", selectedInfo);
		req.setAttribute("view", "AccountEditDialog");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "계정 수정");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : AccountUpdate.do
	 * MethodName : accountUpdate
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "AccountUpdate.do", method = RequestMethod.GET)
	public String accountUpdate(Locale locale, HttpServletRequest req) {
		logger.info("PingPong AccountUpdate.do", locale);
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		
		// 수정 정보 값을 req로 긁어옴
		String code = req.getParameter("updateCode");
		String id = req.getParameter("updateId");
		String pwd = req.getParameter("updatePwd");
		String mng_status = req.getParameter("updateMng");
		String coach_status = req.getParameter("updateCoach");
		
		if(mng_status == null) {
			mng_status = "0";
		}
		if(coach_status == null) {
			coach_status = "0";
		}
		
		System.out.println("mng_status" + mng_status);
		System.out.println("coach_status" + coach_status);
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("code", code);
		map.put("id", id);
		map.put("pwd", pwd);
		map.put("mng_status", mng_status);
		map.put("coach_status", coach_status);
		
		// 수정 DAO
		dao.accountUpdateDao(map);
		
		return "redirect:/AccountManagerFrame.do";
	}
	
	/*
	 * RequestMapping : AccountDelete.do
	 * MethodName : mainLessonManagerFrame
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "AccountDelete.do", method = RequestMethod.GET)
	public String accountDelete(Locale locale, HttpServletRequest req) {
		logger.info("PingPong AccountDelete.do", locale);
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		
		String selecteId = req.getParameter("selectedId");
		System.out.println("선택된 id " + selecteId);
		
		dao.deleteAccount(selecteId);
		
		return "redirect:/AccountManagerFrame.do";
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
				tempDate = confList.get(i).getJoin_date().substring(0, 11);
				confList.get(i).setJoin_date(tempDate);
			}
			req.setAttribute("confirmList", confList);
		} else {													// reject
			/*if(managerStatus != null && Integer.parseInt(managerStatus) == 2){
				data.put("memberCode", memberCode);
				data.put("managerStatus", "0");
				dao.managerConfirmDao(data);
			}
			if(coachStatus != null && Integer.parseInt(coachStatus) == 2){
				data.put("memberCode", memberCode);
				data.put("coachStatus", "0");
				dao.coachConfirmDao(data);
			}*/
			
			// delete
			dao.deleteAccount(memberCode);
			
			// list of waiting confirm
			ArrayList<MemberDto> confList = dao.getConfirmListDao();
			String tempDate = "";
			for(int i=0; i<confList.size(); i++){
				tempDate = confList.get(i).getJoin_date().substring(0, 11);
				confList.get(i).setJoin_date(tempDate);
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
		/*String email = req.getParameter("userEmail1") + req.getParameter("userEmail2");*/
		String email = req.getParameter("userEmail");
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
		
		// Create RSA Key
			initRsa(req);
		
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
		String coachName = req.getParameter("searchCoachName");
		
		if(coachName != null){
			PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
			ArrayList<CoachDto> coachDto = dao.findLessonAndCoachDao(coachName);

			for(int i=0; i<coachDto.size(); i++){
				logger.info(coachDto.get(i).getMember_code());
				logger.info(coachDto.get(i).getName());
				logger.info(coachDto.get(i).getSex());
			}
			req.setAttribute("coachResult", coachDto);
		}
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		ArrayList<MemberDto> memberDto = dao.findLessonAndMemberDao(memberName);

		for(int i=0; i<memberDto.size(); i++){
			logger.info(memberDto.get(i).getMember_code());
			logger.info(memberDto.get(i).getName());
			logger.info(memberDto.get(i).getSex());
		}
		req.setAttribute("memberResult", memberDto);
		req.setAttribute("view", "LessonFeeInput");
		req.setAttribute("searchMemberName", memberName);
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
	public String findLessonAndCoach(Locale locale, HttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.info("PingPong FindLessonAndCoach.do", locale);
		
		req.setCharacterEncoding("UTF-8");
		
		String memberName = req.getParameter("searchMemberName");
		String coachName = req.getParameter("coachName");
		
		if(memberName != null){
			PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
			ArrayList<MemberDto> memberDto = dao.findLessonAndMemberDao(memberName);

			for(int i=0; i<memberDto.size(); i++){
				logger.info(memberDto.get(i).getMember_code());
				logger.info(memberDto.get(i).getName());
				logger.info(memberDto.get(i).getSex());
			}
			req.setAttribute("memberResult", memberDto);
		}
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		ArrayList<CoachDto> coachDto = dao.findLessonAndCoachDao(coachName);

		for(int i=0; i<coachDto.size(); i++){
			logger.info(coachDto.get(i).getMember_code());
			logger.info(coachDto.get(i).getName());
			logger.info(coachDto.get(i).getSex());
		}
		req.setAttribute("coachResult", coachDto);
		req.setAttribute("view", "LessonFeeInput");
		req.setAttribute("searchCoachName", coachName);
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "레슨 세부 정보");
		
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : FixedLessonAndCoach.do
	 * MethodName : fixedLessonAndCoach
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "FixedLessonAndCoach.do", method = RequestMethod.GET)
	public String fixedLessonAndCoach(Locale locale, HttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.info("PingPong FixedLessonAndCoach.do", locale);
		
		req.setCharacterEncoding("UTF-8");
		
		String memberCode = req.getParameter("memberCode");	
				
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		
		//ArrayList<CoachDto> coachDto = dao.findLessonAndCoachDao(coachName);

		/*req.setAttribute("coachResult", coachDto);
		req.setAttribute("view", "LessonFeeInput");
		req.setAttribute("searchCoachName", coachName);
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "레슨 세부 정보");*/
		
		return "MainHomeFrame";
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
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		ArrayList<BootrackDto> bootrackList = dao.getBootrackList();
		
		req.setAttribute("bootrackList", bootrackList);
		req.setAttribute("view", "MainBootrackManagerFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "신발장 관리");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : BootrackEditDialog.do
	 * MethodName : bootrackEditDialog
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "BootrackEditDialog.do", method = RequestMethod.GET)
	public String bootrackEditDialog(Locale locale, HttpServletRequest req) {
		logger.info("PingPong BootrackEditDialog.jsp", locale);
		
		String selectedCd = req.getParameter("selectedCd");
		int selectedIdx = Integer.parseInt(selectedCd);
		String bootrackSt = "";
		String bootrackName = "";
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		ArrayList<BootrackDto> bootrackList = dao.getBootrackList();
		
		bootrackSt = bootrackList.get(selectedIdx-1).getBootrack_status();
		bootrackName = bootrackList.get(selectedIdx-1).getName();
		
		System.out.println("bootrackCd " + selectedCd);
		System.out.println("bootrackSt " + bootrackSt);
		System.out.println("bootrackName " + bootrackName);
		
		if(bootrackSt == "0") {
			req.setAttribute("bootrackCd", selectedCd);
			req.setAttribute("bootrackSt", bootrackSt);
		} else {
			req.setAttribute("bootrackCd", selectedCd);
			req.setAttribute("bootrackSt", bootrackSt);
			req.setAttribute("bootrackName", bootrackName);
		}
		
		req.setAttribute("view", "BootrackEditDialog");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "신발장 정보 수정");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : BootrackSearch.do
	 * MethodName : bootrackSearch
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "BootrackSearch.do", method = RequestMethod.GET)
	@ResponseBody
	public List<Map> bootrackSearch(Locale locale, HttpServletRequest req) {
		logger.info("PingPong BootrackSearch.do", locale);
		
		String searchName = req.getParameter("searchName");
		System.out.println("searchName " + searchName);
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		List<Map> findedMemberList = dao.searchAccountListByNameForBootrackDao(searchName);
		
		for(int idx=0; idx<findedMemberList.size(); idx++) {
			if(findedMemberList.get(idx).get("BOOTRACK_CODE") == null) {
				findedMemberList.get(idx).put("BOOTRACK_CODE", "");
			}
			if(findedMemberList.get(idx).get("BOOTRACK_STATUS") == null) {
				findedMemberList.get(idx).put("BOOTRACK_STATUS", 0);
			}
		}

		return findedMemberList;
	}
	
	/*
	 * RequestMapping : BootrackUpdate.do
	 * MethodName : accountUpdate
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "BootrackUpdate.do", method = RequestMethod.GET)
	public String bootrackUpdate(Locale locale, HttpServletRequest req) {
		logger.info("PingPong BootrackUpdate.do", locale);
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		
		// 수정 정보 값을 req로 긁어옴
		String selectedMember = req.getParameter("selectedMember");
		String selectedBootrack = req.getParameter("selectedBootrack");
		String selectedStatus = "1";
		
		System.out.println("selectedMemb " + selectedMember);
		System.out.println("selectedBootrack " + selectedBootrack);
		System.out.println("selectedSt " + selectedStatus);
		
		if(selectedMember == null || selectedMember == "") {
			selectedStatus = "0";
			selectedMember = "";
		}
		
		System.out.println("selectedMemb" + selectedMember);
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("selMemb", selectedMember);
		map.put("selectedBootrack", selectedBootrack);
		map.put("selSt", selectedStatus);
		
		// 수정 DAO
		dao.bootrackUpdateDao(map);
		
		return "redirect:/MainBootrackManagerFrame.do";
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
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		
		ArrayList<LockerDto> lockerList = dao.getLockerList();
		
		req.setAttribute("lockerList", lockerList);
		req.setAttribute("view", "MainLockerManagerFrame");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "사물함 관리");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : LockerEditDialog.do
	 * MethodName : lockerEditDialog
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "LockerEditDialog.do", method = RequestMethod.GET)
	public String lockerEditDialog(Locale locale, HttpServletRequest req) {
		logger.info("PingPong LockerEditDialog.jsp", locale);
		
		String selectedCd = req.getParameter("selectedCd");
		int selectedIdx = Integer.parseInt(selectedCd);
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		ArrayList<LockerDto> lockerList = dao.getLockerList();
		
		String selectPurpose = lockerList.get(selectedIdx-1).getLocker_purpose();
		String selectName = lockerList.get(selectedIdx-1).getName();
		String selectStuff = lockerList.get(selectedIdx-1).getLocker_article();
		String selectMemberCode = String.valueOf(lockerList.get(selectedIdx-1).getMember_code());
		
		System.out.println("lockerCd " + selectedCd);
		System.out.println("lockerPurpose " + selectPurpose);
		System.out.println("lockerName " + selectName);
		System.out.println("lockerStuff " + selectStuff);
		System.out.println("lockerMemberCode " + selectMemberCode);
		
		if(Integer.parseInt(selectPurpose) == 0) {  		// for Members
			req.setAttribute("lockerCd", selectedCd);
			req.setAttribute("lockerPurpose", selectPurpose);
			req.setAttribute("lockerName", selectName);
			req.setAttribute("lockerMemberCode", selectMemberCode);
			
		} else if(Integer.parseInt(selectPurpose) == 1) {   // for stuffs
			req.setAttribute("lockerCd", selectedCd);
			req.setAttribute("lockerPurpose", selectPurpose);
			req.setAttribute("lockerStuff", selectStuff);
			
		} else {							// not used
			req.setAttribute("lockerCd", selectedCd);
			req.setAttribute("lockerPurpose", selectPurpose);
		}
		
		req.setAttribute("view", "LockerEditDialog");
		req.setAttribute("MainHomeButtonsPane", "MainHomeButtonsPane");
		req.setAttribute("mainHomeTitle", "사물함 정보 수정");
		return "MainHomeFrame";
	}
	
	/*
	 * RequestMapping : LockerSearch.do
	 * MethodName : lockerSearch
	 * Parameter : Locale, HttpServletRequest
	 * Return : String
	 */
	@RequestMapping(value = "LockerSearch.do", method = RequestMethod.GET)
	@ResponseBody
	public List<Map> lockerSearch(Locale locale, HttpServletRequest req) {
		logger.info("PingPong LockerSearch.do", locale);
		
		String searchName = req.getParameter("searchName");
		System.out.println("searchName " + searchName);
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		List<Map> findedMemberList = dao.searchAccountListByNameForLockerDao(searchName);
		
		for(int idx=0; idx<findedMemberList.size(); idx++) {
			if(findedMemberList.get(idx).get("LOCKER_CODE") == null) {
				findedMemberList.get(idx).put("LOCKER_CODE", "");
			}
			if(findedMemberList.get(idx).get("LOCKER_PURPOSE") == null) {
				findedMemberList.get(idx).put("LOCKER_PURPOSE", 2);
			}
		}

		return findedMemberList;
	}
	
	/*
	 * RequestMapping : LockerUpdate.do
	 * MethodName : accountUpdate
	 * Parameter : Locale
	 * Return : String
	 */
	@RequestMapping(value = "LockerUpdate.do", method = RequestMethod.GET)
	public String lockerUpdate(Locale locale, HttpServletRequest req) {
		logger.info("PingPong LockerUpdate.do", locale);
		
		PingPongDao dao = sqlSession.getMapper(PingPongDao.class);
		
		// 수정 정보 값을 req로 긁어옴
		String selectedMember = req.getParameter("selectedMember");
		String selectedLocker = req.getParameter("selectedLocker");
		String selectedPurpose = req.getParameter("selectedPurpose");
		String selectedArticle = req.getParameter("selectedArticle");
		
		System.out.println("selectedMemb " + selectedMember);
		System.out.println("selectedLocker " + selectedLocker);
		System.out.println("selectedPurpose " + selectedPurpose);
		System.out.println("selectedArticle " + selectedArticle);
		System.out.println("selectedMemb " + selectedMember);
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("selectedMemb", selectedMember);
		map.put("selectedLocker", selectedLocker);
		map.put("selectedPurpose", selectedPurpose);
		map.put("selectedArticle", selectedArticle);
		
		// 수정 DAO
		dao.lockerUpdateForMemberDao(map);
		
		return "redirect:/MainLockerManagerFrame.do";
	}
}
