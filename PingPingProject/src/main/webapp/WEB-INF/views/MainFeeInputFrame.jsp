<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	});
</script>
</head>
<body>
	<div class="defaultPage" align="center">
		<div>
			<table border="1" class="outLineTable">
				<tr>
					<td>
						<label style="font-size: 20px;">요금 입력 내역</label>
						<input type="date">
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
						<table class="dataSheet" width="100%" height="245" style="overflow: auto">
							<tr>
								<td>요금 종류</td>
								<td>금액</td>
								<td>이름</td>
								<td>결제일</td>
								<td>비고</td>
							</tr>
							<tr>
								<td>일 회원</td>
								<td>7000</td>
								<td>회원</td>
								<td>2017-02-18</td>
								<td>김영기 회원님</td>
							</tr>
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
									<select name="selectFeeInputPage">
										<option selected="selected">종류를 선택하세요.</option>
										<option value="1">일반</option>
										<option value="2">일 회원</option>
										<option value="3">월 회원</option>
										<option value="4">레슨 등록</option>
									</select>
								</td>
								<td>
									<label>요금:</label>
									<input type="text"><label>원</label>
								</td>
								<td>
									<input type="button" value="세부 정보 입력">
								</td>
							</tr>
							<tr>
								<td colspan="4" align="left">
									<label>비고:</label>
								</td>
							</tr>
							<tr>
								<td colspan="4" align="left">
									<textarea style="width: 575px;"></textarea>	
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input type="text" style="width: 575px; background-color: #606060;" readonly="readonly">
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input type="button" value="입력">
									<input type="button" value="초기화">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>