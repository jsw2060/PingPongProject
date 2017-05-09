<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/FrameLayout.css" rel="stylesheet" type="text/css">
<link href="resources/css/Clock.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var monthNames = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
		var dayNames = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" ];
		
		var newDate = new Date();
		newDate.setDate(newDate.getDate());
		$('#Date').html(dayNames[newDate.getDay()] + " " + newDate.getDate() + ' ' + monthNames[newDate.getMonth()] + ' ' + newDate.getFullYear());
		
		setInterval(function() {
			var seconds = new Date().getSeconds();
			
			$("#sec").html(( seconds < 10 ? "0" : "") + seconds);
		}, 1000);
		
		setInterval(function() {
			var minutes = new Date().getMinutes();
			
			$("#min").html(( minutes < 10 ? "0" : "") + minutes);
		}, 1000);
		
		setInterval(function() {
			var hours = new Date().getHours();
			
			$("#hours").html(( hours < 10 ? "0" : "") + hours);
		}, 1000);
		
		$("#feeDate").change(function(){
			$("#FindFeeForm").submit();
		});
		
		$("#fee-launcher").click(function () {
			var selectedPage = $('#selectFeeInputPage option:selected').val();
			alert(selectedPage);
			if(selectedPage == "0"){ alert("요금 종류를 선택해주세요."); }
			if(selectedPage == "1"){
				$("#FindFeeForm").attr("action", "GeneralFeeInput.do");
				$("#FindFeeForm").submit();
			}
			if(selectedPage == "2"){
				$("#FindFeeForm").attr("action", "OneDayFeeInput.do");
				$("#FindFeeForm").submit();
			}
			if(selectedPage == "3"){
				$("#FindFeeForm").attr("action", "MonthFeeInput.do");
				$("#FindFeeForm").submit();
			}
			if(selectedPage == "4"){
				$("#FindFeeForm").attr("action", "LessonFeeInput.do");
				$("#FindFeeForm").submit();
			}
		});
		
		$("#enterBtn").click(function(){
			var feeType = $("#specifyFeeInputPage").val();
			if(feeType == 1){
				$("#FindFeeForm").attr("action", "InsertGeneralFeeToDB.do");
				$("#FindFeeForm").submit();	
			}
			if(feeType == 2){
				$("#FindFeeForm").attr("action", "InsertOnedayFeeToDB.do");
				$("#FindFeeForm").submit();	
			}
		});
	});
</script>
</head>
<body>
	<div class="defaultPage" align="center">
		<div>
			<form id="FindFeeForm" action="FindFeeList.do">
			<table border="1" class="outLineTable">
				<tr>
					<td>
						<label style="font-size: 20px;">요금 입력 내역</label>
						<input type="date" id="feeDate" name="feeDate">
					</td>
					<td class="container">
						<ul id="numbers">
							<li id="Date"></li>
							<li id="hours"></li>
							<li id="point">:</li>
							<li id="min"></li>
							<li id="point">:</li>
							<li id="sec"></li>
						</ul>
					</td>
				</tr>
				<tr height="250">
					<td colspan="2">
						<table class="dataSheet" border="1" width="100%" height="245" style="overflow: auto; table-layout: fixed;">
							<tr class="theadTr">
								<td>요금 종류</td>
								<td>금액</td>
								<td>이름</td>
								<td>결제일</td>
								<td>비고</td>
							</tr>
							<%-- <c:if test="${ dataFeeList ne null }"> --%>
							<c:forEach var="feeItems" items="${ dateFeeList }">
								<tr>
									<td>${ feeItems.fee_type }</td>
									<td>${ feeItems.fee_amount }</td>
									<td>${ feeItems.name }<input type="hidden" value="${ feeItems.member_code }"></td>
									<td>${ feeItems.fee_date }</td>
									<td>${ feeItems.note }</td>
								</tr>
							</c:forEach>
							<%-- </c:if> --%>
							<%-- <c:if test="${ dataFeeList eq null }">
								<tr>
									<td colspan="5">검색된 데이터가 없습니다.</td>
								</tr>
							</c:if> --%>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<table>
							<tr class="situationSheet">
								<td colspan="4" align="left">
									<label style="font-size: 20px;">요금 입력</label>
								</td>
							</tr>
							<tr>
								<td>
									<label>요금 종류:</label>
								</td>
								<td>
									<select id="selectFeeInputPage" name="selectFeeInputPage">
										<option value="0" selected="selected">종류를 선택하세요.</option>
										<option value="1">일반</option>
										<option value="2">일 회원</option>
										<option value="3">월 회원</option>
										<option value="4">레슨 등록</option>
									</select>
								</td>
								<td>
									<label>요금:</label>
									<input type="text" name="costInput" placeholder="${ specifyInput.calFee }"><label>원</label>
								</td>
								<td>
									<input type="button" id="fee-launcher" value="세부 정보 입력">
								</td>
							</tr>
							<tr>
								<td colspan="4" align="left">
									<label>비고:</label>
								</td>
							</tr>
							<tr>
								<td colspan="4" align="left">
									<textarea name="noteInput" style="width: 575px;"></textarea>	
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input type="text" style="width: 575px; background-color: #606060;" readonly="readonly">
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input type="button" id="enterBtn" value="입력">
									<input type="button" value="초기화">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="text" name="specifyMemberCode" value="${ specifyInput.memberCode }">
			<input type="text" id="specifyFeeInputPage" name="specifyFeeInputPage" value="${ specifyInput.feeInputPage }">
			<input type="text" name="specifyPlayTime" value="${ specifyInput.playTime }">
			<input type="text" name="specifyTableNum" value="${ specifyInput.tableNum }">
			<input type="text" name="specifyStatus" value="${ specifyInput.status }">
			</form>
		</div>
	</div>
</body>
</html>