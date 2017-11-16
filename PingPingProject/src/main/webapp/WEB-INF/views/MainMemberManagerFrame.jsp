<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/FrameLayout.css" rel="stylesheet" type="text/css">
<link href="resources/css/TabMenu.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
	$(function () {

	    $(".tab_content").hide();
	    $(".tab_content:first").show();

	    $("ul.tabs li").click(function () {
	        $("ul.tabs li").removeClass("active").css("color", "#333");
	        $(this).addClass("active").css({"color": "darkred","font-weight": "bolder"});
	        $(".tab_content").hide()
	        var activeTab = $(this).attr("rel");
	        $("#" + activeTab).fadeIn()
	    });
	});
	
	$(function () {
    	// divBodyScroll의 스크롤이 동작할때에 함수를 불러옵니다.
    	$('#divBodyScroll').scroll(function () {
	        // divBodyScroll의 x좌표가 움직인 거리를 가져옵니다.
	        var xPoint = $('#divBodyScroll').scrollLeft();
	
	        // 가져온 x좌표를 divHeadScroll에 적용시켜 같이 움직일수 있도록 합니다.
	        $('#divHeadScroll').scrollLeft(xPoint);
    	});
	});
	
	$(function () {
		// table selection
		$("#tblBody tr").click(function () {
			alert("클릭 ");
			var tdArr = new Array();
			
			// get each td from seleted row
			var selectedTr = $(this);
			var selectedTd = selectedTr.children();

			console.log("??  ", selectedTd);
			
			selectedTd.each(function(i) {
				tdArr.push(selectedTd.eq(i).text());
			});
			console.log("배열에 담긴 값 : "+tdArr);
			
			// store temporary info in each hidden input
			var code = selectedTd.eq(0).children().eq(0).val();
			var id = selectedTd.eq(0).text();
			var sex = selectedTd.eq(1).children().eq(0).val();
			var tel = selectedTd.eq(2).text();
			var age = selectedTd.eq(3).text();
			var style = selectedTd.eq(4).children().eq(0).val();
			var grade = selectedTd.eq(5).text();
			var addr = selectedTd.eq(6).text();
			var email = selectedTd.eq(7).text();
			var bday = selectedTd.eq(8).text();
			var regDay = selectedTd.eq(9).text();
			var note = selectedTd.eq(10).text();
			
			console.log("code ", code);
			console.log("id ", id);
			console.log("sex ", sex);
			console.log("tel ", tel);
			console.log("age ", age);
			console.log("style ", style);
			console.log("grade ", grade);
			console.log("addr ", addr);
			console.log("email ", email);
			console.log("bday ", bday);
			console.log("regDay ", regDay);
			console.log("note ", note);
			
			document.getElementById("memberId").value = code;
			document.getElementById("memberName").value = id;
			document.getElementById("memberSex").value = sex;
			document.getElementById("memberTel").value = tel;
			document.getElementById("memberAge").value = age;
			document.getElementById("memberStyle").value = style;
			document.getElementById("memberGrade").value = grade;
			document.getElementById("memberAddr").value = addr;
			document.getElementById("memberEmail").value = email;
			document.getElementById("memberBday").value = bday;
			document.getElementById("memberRegDay").value = regDay;
			document.getElementById("memberNote").value = note;
			
		});
	
		$("#memberEditBtn").click(function() {
			$("#MemberEditForm").submit();
		});
	
		$("#monthMemberEditBtn").click(function() {
			$("#MemberEditForm").attr("action", "MonthMemberEditDialog.do").submit();
		});

		$("#coachAddBtn").click(function() {
			$("#MemberEditForm").attr("action", "CoachAddDialog.do").submit();
		});
	
		$("#coachEditBtn").click(function() {
			$("#MemberEditForm").attr("action", "CoachEditDialog.do").submit();
		});
		
		$("#coachDelBtn").on("click", function() {
			$("#MemberEditForm").attr("action", "CoachDelete.do");
			$("#MemberEditForm").submit();	
		});
		
		$("#monthMemberDelBtn").on("click", function() {
			$("#MemberEditForm").attr("action", "MonthMemberDelete.do");
			$("#MemberEditForm").submit();
		})
	});
	
	$(function() {
		$("#searchName").on("change", function() {
			document.getElementById("searchingName").value = document.getElementById("searchName").value;
		});
		
		// sex selection
		$("#searchSex").on("change", function() {
			
			var that = $(this);
			console.log("that.val", that.val());

			switch(that.val()) {
			
			case '0':
				$("#notUse").removeAttr('selected');
				$("#female").removeAttr('selected');
				$("#male").attr('selected', true);
				
				document.getElementById("searchingSex").value = '0';
				break;
			case '1':
				$("#notUse").removeAttr('selected');
				$("#male").removeAttr('selected');
				$("#female").attr('selected', true);
				
				document.getElementById("searchingSex").value = '1';
				break;
			default: 
				alert("check logic!!");
				break;	
			}
		});
		
		// style selection
		$("#searchStyle").on("change", function() {

			var that = $(this);
			console.log("that.val", that.val());

			switch(that.val()) {
			
			case '0':	
			
				$("#penholder").removeAttr('selected');
				$("#shakehand").removeAttr('selected');
				$("#chinese").removeAttr('selected');
				$("#notUse").attr('selected', true);
				
				document.getElementById("searchingStyle").value = '0';
				break;
			case '1': 
				
				$("#shakehand").removeAttr('selected');
				$("#notUse").removeAttr('selected');
				$("#chinese").removeAttr('selected');
				$("#penholder").attr('selected', true);
				
				document.getElementById("searchingStyle").value = '1';
				break;
			case '2': 
				
				$("#penholder").removeAttr('selected');
				$("#notUse").removeAttr('selected');
				$("#chinese").removeAttr('selected');
				$("#shakehand").attr('selected', true);
				
				document.getElementById("searchingStyle").value = '2';
				break;
			case '3':
				$("#penholder").removeAttr('selected');
				$("#notUse").removeAttr('selected');
				$("#shakehand").removeAttr('selected');
				$("#chinese").attr('selected', true);
				
				document.getElementById("searchingStyle").value = '3';
				break;
			default: 
				alert("check logic!!");
				break;	
			}
		});
		
		// grade selection
		$("#searchGrade").on("change", function() {

			var that = $(this);
			console.log("that.val", that.val());

			switch(that.val()) {
			
			case '0':	
			
				$("#one").removeAttr('selected');
				$("#two").removeAttr('selected');
				$("#three").removeAttr('selected');
				$("#four").removeAttr('selected');
				$("#five").removeAttr('selected');
				$("#six").removeAttr('selected');
				$("#seven").removeAttr('selected');
				$("#eight").removeAttr('selected');
				$("#notUse").attr('selected', true);
				
				document.getElementById("searchingGrade").value = '0';
				break;
			case '1': 
				
				$("#notUse").removeAttr('selected');
				$("#two").removeAttr('selected');
				$("#three").removeAttr('selected');
				$("#four").removeAttr('selected');
				$("#five").removeAttr('selected');
				$("#six").removeAttr('selected');
				$("#seven").removeAttr('selected');
				$("#eight").removeAttr('selected');
				$("#one").attr('selected', true);
				
				document.getElementById("searchingGrade").value = '1';
				break;
			case '2': 
				
				$("#one").removeAttr('selected');
				$("#notUse").removeAttr('selected');
				$("#three").removeAttr('selected');
				$("#four").removeAttr('selected');
				$("#five").removeAttr('selected');
				$("#six").removeAttr('selected');
				$("#seven").removeAttr('selected');
				$("#eight").removeAttr('selected');
				$("#two").attr('selected', true);
				
				document.getElementById("searchingGrade").value = '2';
				break;
			case '3':
				$("#one").removeAttr('selected');
				$("#two").removeAttr('selected');
				$("#notUse").removeAttr('selected');
				$("#four").removeAttr('selected');
				$("#five").removeAttr('selected');
				$("#six").removeAttr('selected');
				$("#seven").removeAttr('selected');
				$("#eight").removeAttr('selected');
				$("#three").attr('selected', true);
				
				document.getElementById("searchingGrade").value = '3';
				break;
			case '4':
				$("#one").removeAttr('selected');
				$("#two").removeAttr('selected');
				$("#three").removeAttr('selected');
				$("#notUse").removeAttr('selected');
				$("#five").removeAttr('selected');
				$("#six").removeAttr('selected');
				$("#seven").removeAttr('selected');
				$("#eight").removeAttr('selected');
				$("#four").attr('selected', true);
				
				document.getElementById("searchingGrade").value = '4';
				break;
			case '5':
				$("#one").removeAttr('selected');
				$("#two").removeAttr('selected');
				$("#three").removeAttr('selected');
				$("#four").removeAttr('selected');
				$("#notUse").removeAttr('selected');
				$("#six").removeAttr('selected');
				$("#seven").removeAttr('selected');
				$("#eight").removeAttr('selected');
				$("#five").attr('selected', true);
				
				document.getElementById("searchingGrade").value = '5';
				break;
			case '6':
				$("#one").removeAttr('selected');
				$("#two").removeAttr('selected');
				$("#three").removeAttr('selected');
				$("#four").removeAttr('selected');
				$("#five").removeAttr('selected');
				$("#notUse").removeAttr('selected');
				$("#seven").removeAttr('selected');
				$("#eight").removeAttr('selected');
				$("#six").attr('selected', true);
				
				document.getElementById("searchingGrade").value = '6';
				break;
			case '7':
				$("#one").removeAttr('selected');
				$("#two").removeAttr('selected');
				$("#three").removeAttr('selected');
				$("#four").removeAttr('selected');
				$("#five").removeAttr('selected');
				$("#six").removeAttr('selected');
				$("#notUse").removeAttr('selected');
				$("#eight").removeAttr('selected');
				$("#seven").attr('selected', true);
				
				document.getElementById("searchingGrade").value = '7';
				break;
			case '8':
				$("#one").removeAttr('selected');
				$("#two").removeAttr('selected');
				$("#three").removeAttr('selected');
				$("#four").removeAttr('selected');
				$("#five").removeAttr('selected');
				$("#six").removeAttr('selected');
				$("#seven").removeAttr('selected');
				$("#notUse").removeAttr('selected');
				$("#eight").attr('selected', true);
				
				document.getElementById("searchingGrade").value = '8';
				break;
			default: 
				alert("check logic!!");
				break;		
			}
		
		});
		
		
		
		$("#startDate").on("change", function() {
			$("#searchingStart").attr('value', $(this).val());
		});
		
		$("#endDate").on("change", function() {
			$("#searchingEnd").attr('value', $(this).val());
		});
		
		$("#searchBtn").on("click", function() {
			$("#MemberEditForm").attr("action", "singleMemberSearch.do");
			$("#MemberEditForm").submit();	
		});
		
		$("#totalSearchBtn").on("click", function() {
			$("#MemberEditForm").attr("action", "totalMemberSearch.do");
			$("#MemberEditForm").submit();	
		});
	});
	
</script>
</head>
<body>
	<form id="MemberEditForm" action="MemberEditDialog.do">
		<div class="defaultPage" align="center">
			<div>
				<table class="outLineTable">
					<tr>
						<td>
							<label>이름:</label>
							<input type="text" id="searchName" style="width: 75px;">
						</td>
						<td>
							<label>성별:</label>
							<select id="searchSex">
								<option id="notUse" value="" selected="selected">-- 전체 --</option>
								<option id="male" value="0">남</option>
								<option id="female" value="1">여</option>
							</select>
						</td>
						<td>
							<label>전형:</label>
							<select id="searchStyle">
								<option id="notUse" value="0" selected="selected">-- 전체 --</option>
								<option id="penholder" value="1">펜홀더</option>
								<option id="shakehand" value="2">쉐이크핸드</option>
								<option id="chinese" value="3">중국식 펜홀더</option>
							</select>
						</td>
						<td>
							<label>부수:</label>
							<select id="searchGrade">
								<option id="notUse" value="0" selected="selected">-- 전체 --</option>
								<option id="one" value="1">0부</option>
								<option id="two" value="2">1부</option>
								<option id="three" value="3">2부</option>
								<option id="four" value="4">3부</option>
								<option id="five" value="5">4부</option>
								<option id="six" value="6">5부</option>
								<option id="seven" value="7">6부</option>
								<option id="eight" value="8">7부</option>
							</select>
						</td>
						<td>
							<button type="button" style="border-bottom-style: hidden;" id="searchBtn">
								<img style="width: 25px;" alt="검색버튼" src="resources/Collection/Single Browse.png">
							</button>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<label>기간:</label>
							<input type="date" id="startDate" style="width: 200px;">&nbsp; ~ &nbsp;<input type="date" id="endDate" style="width: 200px;">
						</td>
						<td>
							<button type="button" style="border-bottom-style: hidden;" id="totalSearchBtn">
								<img style="width: 25px;" alt="전체검색버튼" src="resources/Collection/Total Browse.png">
							</button>
						</td>
					</tr>
					<tr class="dataSheet" height="300">
						<td colspan="5" style="vertical-align: top;">
							<div id="container">
								<ul class="tabs">
									<li class="active" rel="tab1">전체 회원 정보</li>
									<li rel="tab2">월 회원 정보</li>
									<!-- <li rel="tab3">레슨 회원 정보</li> -->
									<li rel="tab4">코치 정보</li>
								</ul>
								<div class="tab_container">
									<div id="tab1" class="tab_content" style="overflow:scroll; width: 590px; height: 260px;">
							        	<div id="divHeadScroll" style="width: 740px;">
								            <table id="tblHead" border="0" style="text-align: center;">
												<colgroup>
													<col style="width:60px;"/>
							                        <col style="width:30px;"/>
							                        <col style="width:90px;"/>
							                        <col style="width:30px;"/>
							                        <col style="width:50px;"/>
							                        <col style="width:30px;"/>
							                        <col style="width:200px;"/>
							                        <col style="width:100px;"/>
							                        <col style="width:50px;"/>
							                        <col style="width:50px;"/>
							                        <col style="width:50px;"/>
												</colgroup>
												<tr>
													<td>이름</td>
													<td>성별</td>
													<td>연락처</td>
													<td>나이</td>
													<td>전형</td>
													<td>부수</td>
													<td>주소</td>
													<td>이메일</td>
													<td>생일</td>
													<td>등록일</td>
													<td>비고</td>
												</tr>
											</table>
										</div>
										<div id="divBodyScroll" style="width: 740px;">
											<table id="tblBody" border="1" style="text-align: center;">
												<colgroup>
							                        <col style="width:60px;" class="right_border" />
							                        <col style="width:30px;" class="right_border" />
							                        <col style="width:90px;" class="right_border" />
							                        <col style="width:30px;" class="right_border" />
							                        <col style="width:50px;" class="right_border" />
							                        <col style="width:30px;" class="right_border" />
							                        <col style="width:200px;" class="right_border" />
							                        <col style="width:100px;" class="right_border" />
							                        <col style="width:50px;" class="right_border" />
							                        <col style="width:50px;" class="right_border" />
							                        <col style="width:50px;" class="right_border" />
							                    </colgroup>
												<c:forEach var="TMList" items="${ defaultTMList }">
													<tr>
														<td>${ TMList.name }<input type="hidden" value="${ TMList.member_code }"></td>
														<c:choose>
															<c:when test="${ TMList.sex eq 0}">
																<td>남<input type="hidden" value="${TMList.sex }"></td>
															</c:when>
															<c:otherwise>
																<td>여<input type="hidden" value="${TMList.sex }"></td>
															</c:otherwise>
														</c:choose>
														<td>${ TMList.tel }</td>
														<c:choose>
															<c:when test="${ TMList.age eq 00 || TMList.age eq 0}">
																<td></td>
															</c:when>
															<c:otherwise>
																<td>${ TMList.age }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${ TMList.style eq 0}">
																<td><input type="hidden" value="${TMList.style }"></td>
															</c:when>
															<c:when test="${ TMList.style eq 1}">
																<td>펜홀더<input type="hidden" value="${TMList.style }"></td>
															</c:when>
															<c:when test="${ TMList.style eq 2}">
																<td>쉐이크핸드<input type="hidden" value="${TMList.style }"></td>
															</c:when>
															<c:otherwise>
																<td>중국식 펜홀더<input type="hidden" value="${TMList.style }"></td>
															</c:otherwise>
														</c:choose>
														<td>${ TMList.grade }</td>
														<td>${ TMList.addr }</td>
														<td>${ TMList.email }</td>
														<td>${ TMList.birthday }</td>
														<c:choose>
															<c:when test="${ TMList.join_date eq null || TMList.join_date eq ''}">
																<td></td>
															</c:when>
															<c:otherwise>
																<td>${ TMList.join_date }</td>
															</c:otherwise>
														</c:choose>
														<td>${ TMList.note }</td>
													</tr>
												</c:forEach>
											</table>
										</div>
									</div>
									<div id="tab2" class="tab_content" style="overflow:scroll; width: 590px; height: 260px;">
							        	<div id="divHeadScroll" style="width: 740px;">
								            <table id="tblHead" border="0" style="text-align: center;">
												<colgroup>
													<col style="width:60px;"/>
													<col style="width:30px;"/>
													<col style="width:90px;"/>
													<col style="width:30px;"/>
													<col style="width:50px;"/>
													<col style="width:30px;"/>
													<col style="width:200px;"/>
													<col style="width:100px;"/>
													<col style="width:50px;"/>
													<col style="width:50px;"/>
													<col style="width:50px;"/>
												</colgroup>
												<tr>
													<td>이름</td>
													<td>성별</td>
													<td>연락처</td>
													<td>나이</td>
													<td>전형</td>
													<td>부수</td>
													<td>주소</td>
													<td>이메일</td>
													<td>생일</td>
													<td>등록일</td>
													<td>비고</td>
												</tr>
											</table>
										</div>
										<div id="divBodyScroll" style="width: 740px;">
											<table id="tblBody" border="1" style="text-align: center;">
												<colgroup>
							                        <col style="width:60px;" class="right_border" />
							                        <col style="width:30px;" class="right_border" />
							                        <col style="width:90px;" class="right_border" />
							                        <col style="width:30px;" class="right_border" />
							                        <col style="width:50px;" class="right_border" />
							                        <col style="width:30px;" class="right_border" />
							                        <col style="width:200px;" class="right_border" />
							                        <col style="width:100px;" class="right_border" />
							                        <col style="width:50px;" class="right_border" />
							                        <col style="width:50px; "class="right_border" />
							                        <col style="width:50px;" class="right_border" />
							                    </colgroup>
												<c:forEach var="MMList" items="${ defaultMMList }">
													<tr>
														<td>${ MMList.name }<input type="hidden" value="${ MMList.member_code }"></td>
														<c:choose>
															<c:when test="${ MMList.sex eq 0}">
																<td>남<input type="hidden" value="${MMList.sex }"></td>
															</c:when>
															<c:otherwise>
																<td>여<input type="hidden" value="${MMList.sex }"></td>
															</c:otherwise>
														</c:choose>
														<td>${ MMList.tel }</td>
														<c:choose>
															<c:when test="${ MMList.age eq 00 || MMList.age eq 0}">
																<td></td>
															</c:when>
															<c:otherwise>
																<td>${ MMList.age }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${ MMList.style eq 0}">
																<td><input type="hidden" value="${MMList.style }"></td>
															</c:when>
															<c:when test="${ MMList.style eq 1}">
																<td>펜홀더<input type="hidden" value="${MMList.style }"></td>
															</c:when>
															<c:when test="${ MMList.style eq 2}">
																<td>쉐이크핸드<input type="hidden" value="${MMList.style }"></td>
															</c:when>
															<c:otherwise>
																<td>중국식 펜홀더<input type="hidden" value="${MMList.style }"></td>
															</c:otherwise>
														</c:choose>
														<td>${ MMList.grade }</td>
														<td>${ MMList.addr }</td>
														<td>${ MMList.email }</td>
														<td>${ MMList.birthday }</td>
														<td>${ MMList.month_registerdate }</td>
														<td>${ MMList.note }</td>
													</tr>
												</c:forEach>
											</table>
										</div>
									</div>
									<%-- <div id="tab3" class="tab_content">
										<div id="divHeadScroll">
								            <table id="tblHead" border="0" style="text-align: center;">
												<colgroup>
													<col style="width:55px;"/>
													<col style="width:30px;"/>
													<col style="width:100px;"/>
													<col style="width:30px;"/>
													<col style="width:55px;"/>
													<col style="width:100px;"/>
													<col style="width:30px;"/>
													<col style="width:100px;"/>
													<col style="width:110px;"/>
													<col style="width:17px;"/>
												</colgroup>
												<tr>
													<td>이름</td>
													<td>성별</td>
													<td>연락처</td>
													<td>나이</td>
													<td>코치</td>
													<td>전형</td>
													<td>부수</td>
													<td>등록일</td>
													<td>비고</td>
													<td></td>
												</tr>
											</table>
										</div>
										<div id="divBodyScroll">
											<table id="tblBody" border="1" style="text-align: center;">
												<colgroup>
							                        <col style="width:55px;" class="right_border" />
							                        <col style="width:30px;" class="right_border" />
							                        <col style="width:100px;" class="right_border" />
							                        <col style="width:30px;" class="right_border" />
							                        <col style="width:55px;" class="right_border" />
							                        <col style="width:100px;" class="right_border" />
							                        <col style="width:30px;" class="right_border" />
							                        <col style="width:100px;" class="right_border" />
							                        <col style="width:110px;" class="right_border" />
							                    </colgroup>
												<c:forEach var="MMList" items="${ defaultMMList }">
													<tr>
														<td>${ MMList.name }</td>
														<c:choose>
															<c:when test="${ MMList.sex eq 0}">
																<td>남</td>
															</c:when>
															<c:otherwise>
																<td>여</td>
															</c:otherwise>
														</c:choose>
														<td>${ MMList.tel }</td>
														<c:choose>
															<c:when test="${ MMList.age eq 00 || MMList.age eq 0}">
																<td></td>
															</c:when>
															<c:otherwise>
																<td>${ MMList.age }</td>
															</c:otherwise>
														</c:choose>
														<td>${ MMList.name }</td>
														<c:choose>
															<c:when test="${ MMList.style eq 0}">
																<td></td>
															</c:when>
															<c:when test="${ MMList.style eq 1}">
																<td>펜홀더</td>
															</c:when>
															<c:when test="${ MMList.style eq 2}">
																<td>쉐이크핸드</td>
															</c:when>
															<c:otherwise>
																<td>중국식 펜홀더</td>
															</c:otherwise>
														</c:choose>
														<td>${ MMList.grade }</td>
														<td>${ MMList.month_registerdate }</td>
														<td>${ MMList.note }</td>
													</tr>
												</c:forEach>
											</table>
										</div>
									</div>--%>
									<div id="tab4" class="tab_content" style="overflow:scroll; width: 590px; height: 260px;">
										<div id="divHeadScroll" style="width: 660px;">
								            <table id="tblHead" border="0" style="text-align: center;">
												<colgroup>
													<col style="width:60px;"/>
													<col style="width:30px;"/>
													<col style="width:90px;"/>
													<col style="width:120px;"/>
													<col style="width:30px;"/>
													<col style="width:50px;"/>
													<col style="width:30px;"/>
													<col style="width:100px;"/>
													<col style="width:150px;"/>
												</colgroup>
												<tr>
													<td>이름</td>
													<td>성별</td>
													<td>연락처</td>
													<td>레슨요일</td>
													<td>나이</td>
													<td>전형</td>
													<td>부수</td>
													<td>등록일</td>
													<td>비고</td>
												</tr>
											</table>
										</div>
										<div id="divBodyScroll" style="width: 660px;">
											<table id="tblBody" border="1" style="text-align: center;">
												<colgroup>
							                        <col style="width:60px;" class="right_border" />
							                        <col style="width:30px;" class="right_border" />
							                        <col style="width:90px;" class="right_border" />
							                        <col style="width:120px;" class="right_border" />
							                        <col style="width:30px;" class="right_border" />
							                        <col style="width:50px;" class="right_border" />
							                        <col style="width:30px;" class="right_border" />
							                        <col style="width:100px;" class="right_border" />
							                        <col style="width:150px;" class="right_border" />
							                    </colgroup>
												<c:forEach var="CoachList" items="${ defaultCoachList }">
													<tr>
														<td>${ CoachList.name }<input type="hidden" value="${ CoachList.member_code }"></td>
														<c:choose>
															<c:when test="${ CoachList.sex eq 0}">
																<td>남</td>
															</c:when>
															<c:otherwise>
																<td>여</td>
															</c:otherwise>
														</c:choose>
														<td>${ CoachList.tel }</td>
														<c:set var="tempWeekDay" value="${ fn:replace(CoachList.work_weekday,'false', '')}"/>
														<c:set var="tempWorkWeekDay" value="${ fn:replace(tempWeekDay,',', '')}"/>
														<td>${ tempWorkWeekDay }</td>
														<c:choose>
															<c:when test="${ CoachListList.age eq 00 || CoachList.age eq 0}">
																<td></td>
															</c:when>
															<c:otherwise>
																<td>${ CoachList.age }</td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${ CoachList.style eq 0}">
																<td></td>
															</c:when>
															<c:when test="${ CoachList.style eq 1}">
																<td>펜홀더</td>
															</c:when>
															<c:when test="${ CoachList.style eq 2}">
																<td>쉐이크핸드</td>
															</c:when>
															<c:otherwise>
																<td>중국식 펜홀더</td>
															</c:otherwise>
														</c:choose>
														<td>${ CoachList.grade }</td>
														<td>${ CoachList.coach_registerdate }</td>
														<td>${ CoachList.note }</td>
													</tr>
												</c:forEach>
											</table>
										</div>
									</div>
								</div>
							</div>
						</td>
					</tr>
					<!-- <tr class="situationSheet">
						<td colspan="5">
							<input type="text" style="width: 575px; background-color: #606060;" readonly="readonly">
						</td>
					</tr> -->
					<tr>
						<td colspan="5">
							<!-- 테이블 선택값 전송용 -->
							<input type="hidden" id="memberId" name="memberId" value="">
							<input type="hidden" id="memberName" name="memberName" value="">
							<input type="hidden" id="memberSex" name="memberSex" value="">
							<input type="hidden" id="memberTel" name="memberTel" value="">
							<input type="hidden" id="memberAge" name="memberAge" value="">
							<input type="hidden" id="memberBday" name="memberBday" value="">
							<input type="hidden" id="memberAddr" name="memberAddr" value="">
							<input type="hidden" id="memberEmail" name="memberEmail" value="">
							<input type="hidden" id="memberStyle" name="memberStyle" value="">
							<input type="hidden" id="memberGrade" name="memberGrade" value="">
							<input type="hidden" id="memberRegDay" name="memberRegDay" value="">
							<input type="hidden" id="memberNote" name="memberNote" value="">
							
							<!-- 검색 조건 전송용 -->
							<input type="hidden" id="searchingName" name="searchingName" value="">
							<input type="hidden" id="searchingSex" name="searchingSex" value="">
							<input type="hidden" id="searchingStyle" name="searchingStyle" value="">
							<input type="hidden" id="searchingGrade" name="searchingGrade" value="">
							<input type="hidden" id="searchingStart" name="searchingStart" value="">
							<input type="hidden" id="searchingEnd" name="searchingEnd" value="">							
							
							<input type="button" id="memberEditBtn" value="회원정보 수정">
							<input type="button" value="회원정보 삭제">
						</td>
					</tr>
					<tr>
						<td colspan="5">
							<input type="button" id="monthMemberEditBtn" value="월 회원 수정">
							<input type="button" id="monthMemberDelBtn" value="월 회원 삭제">
						</td>
					</tr>
					<tr>
						<td colspan="5">
							<input type="button" id="coachAddBtn" value="코치 추가">
							<input type="button" id="coachEditBtn" value="코치 수정">
							<input type="button" id="coachDelBtn" value="코치 삭제">
						</td>
					</tr>					
				</table>
			</div>	
		</div>
	</form>
</body>
</html>