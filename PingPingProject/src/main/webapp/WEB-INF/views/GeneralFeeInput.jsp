<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/DialogLayout.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#enterBtn").click(function(){
		var selectedTime = $("#playTimeBox").val();
		var selectedNum = $("#tableNumBox").val();
		var selectedType = $(".radioInput").val();
		alert(selectedTime);
		
		if(selectedTime != 0 && selectedNum != 0 && selectedType != null){
			$("#InsertGeneralFee").submit();
		} else {
			if(selectedTime == 0){
				alert("이용시간을 선택해주세요.");
			} else if(selectedNum == 0){
				alert("테이블 갯수를 선택해주세요.");
			} else if(selectedType == null){
				alert("일반, 학생 여부를 선택해주세요.");
			}	
		}
	});
});
</script>
</head>
<body>
	<form id="InsertGeneralFee" action="InsertGeneralFee.do">
	<div align="center">
		<br/>
		<div>
			<h1 class="dialogTitle">일반 요금</h1>
		</div>
		<br/>
		<div>
			<table width="350" border="1">
				<tr>
					<td width="150" align="center">이용 시간: </td>
					<td>
						<select id="playTimeBox" name="playTime" style="width: 200px;">
							<option value="0">-- 시간 --</option>
							<option value="30">30분</option>
							<option value="60">1시간</option>
							<option value="90">1시간 30분</option>
							<option value="120">2시간</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="150" align="center">테이블 수: </td>
					<td>
						<select id="tableNumBox" name="tableNum" style="width: 200px;">
							<option value="0">-- 갯수 --</option>
							<option value="1">1대</option>
							<option value="2">2대</option>
							<option value="3">3대</option>
							<option value="4">4대</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<input type="radio" name="status" value="0">일반
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="status" value="1">학생
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<p>이용 시간과 이용 테이블 수를 입력하세요.</p>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" id="enterBtn" value="입력">
						<input type="button" onclick="javascript:history.back()" value="취소">
					</td>
				</tr>
			</table>
		</div>
	</div>
	</form>
</body>
</html>