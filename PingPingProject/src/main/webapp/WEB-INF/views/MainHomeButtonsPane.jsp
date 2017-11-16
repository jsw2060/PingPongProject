<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/MainHomeButtonsPane.css" rel="stylesheet" type="text/css">
<link href="resources/css/MainHomeMenuList.css" rel="stylesheet" type="text/css">
<link href="resources/css/Modal.css" rel="stylesheet" type="text/css">
<script	src="https://code.jquery.com/jquery-3.0.0.min.js" integrity="sha256-JmvOoLtYsmqlsWxa7mDSLMwa6dZ9rrIdtrrVYRnDRH0=" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".sidebarmenu").show();
		$("#homeBtn").click(function(){
			/* $("#homeBtn").toggle(); */
			$(".sidebarmenu").animate({width:'toggle', float:'left'});

			if($(".mainHomeView").attr("style") == 'width: 608px; float: left;') {
				$(".mainHomeView").animate({width:'768px', float:'left'});
			} else {
				$(".mainHomeView").animate({width:'608px', float:'left'});
			}
		});
		
		$("#modal-launcher, #modal-background, #modal-close").click(function () {
			$("#modal-content,#modal-background").toggleClass("active");
		});
	});
</script>
</head>
<body>
	<div>
		<ul class="menuList">
			<li class="menuLi"><a href="#" id="homeBtn"><img class="layout_img" alt="menu" src="resources/light/appbar.lines.horizontal.4.png"></a></li>
			<li class="menuLi"><a href="MainHomeFrame.do"><img class="layout_img" alt="menu" src="resources/light/appbar.home.png"></a></li>
			<li class="menuLi"><a href="Logout.do"><img class="layout_img" alt="menu" src="resources/light/appbar.lock.png"></a></li>
			<li class="menuLi"><a><img class="layout_img" alt="menu" src="resources/light/appbar.layout.collapse.right.variant.png"></a></li>
			<li class="menuLi">
				<div class="mainHomeInfo">
				<a onclick="return false;">${ loginAuthor }(${ loginName })님
				<br/>환영합니다.[${ accountMsg }]</a>
				</div>
			</li>
			<li class="menuLi">
				<div class="mainHomeTitle">
				<a onclick="return false;">${ mainHomeTitle }</a>
				</div>
			</li>
			<li class="menuLi">
				<a id="modal-launcher">
					<img class="layout_img" alt="menu" src="resources/light/appbar.information.circle.png">
				</a>		
			</li>
		</ul>
	</div>
	<div class="sidebarmenu" style="width: 160px; float: left;">
		<ul id="mainHomeMenu">
			<c:choose>
				<c:when test="${ loginName eq '가입자'}">
					<li><a href="MainLockerManagerFrame.do">사물함 관리</a></li>
					<li><a href="MainBootrackManagerFrame.do">신발장 관리</a></li>
					<li><a href="http://cafe.daum.net/hnspp">홈페이지</a></li>
				</c:when>
				<c:when test="${ accountMsg eq '관리자계정' || accountMsg eq '마스터계정' }">
					<li><a href="MainFeeInputFrame.do">요금 입력</a></li>
					<li><a href="MainFeeManagerFrame.do">요금정보 관리</a></li>
					<li><a href="MainMemberManagerFrame.do">회원정보 관리</a></li>
					<li><a href="MainLockerManagerFrame.do">사물함 관리</a></li>
					<li><a href="MainBootrackManagerFrame.do">신발장 관리</a></li>
					<!-- <li><a href="MainLessonManagerFrame.do">레슨정보 관리</a></li> -->
					<li><a href="AccountManagerFrame.do">계정 관리</a></li>
					<li><a href="http://cafe.daum.net/hnspp">홈페이지</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="MainFeeInputFrame.do">요금 입력</a></li>
					<li><a href="MainLockerManagerFrame.do">사물함 관리</a></li>
					<li><a href="MainBootrackManagerFrame.do">신발장 관리</a></li>
					<li><a href="http://cafe.daum.net/hnspp">홈페이지</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
	<div class="mainHomeView" style="width: 608px; float: left;">
		<jsp:include page="${ view }.jsp" flush="false"/>
	</div>
	<div id="modal-background"></div>
	<div id="modal-content">
		<h4>프로그램정보</h4>
		<p>Made by SungWeon Jung<br/>
			E-MAIL : jsw2060@gmail.com
		</p>
		<button id="modal-close" style="float: right;">OK</button>
	</div>
</body>
</html>