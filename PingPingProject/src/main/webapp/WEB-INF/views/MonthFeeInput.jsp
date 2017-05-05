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
			<h1 class="dialogTitle">월 회원 세부 정보</h1>
		</div>
		<br/>
		<div>
			<table width="350" border="1">
				<tr>
					<td width="150" align="center">*등록일: </td>
					<td>
						<input type="date">
					</td>
				</tr>
				<tr>
					<td width="150" align="center">*회원: </td>
					<td>
						<input type="text">
						<button type="button" style="border-bottom-style: hidden;" id="findMember"><img class="buttonImg" alt="검색버튼" src="resources/Collection/Find User Male_3.png"></button>
						<button type="button" style="border-bottom-style: hidden;"><img class="buttonImg" alt="추가버튼" src="resources/Collection/Add User Male_2.png"></button>
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<table id="memberDataForm" border="1" width="360">
							<tr class="textHead">
								<td>회원번호</td>
								<td>이름</td>
								<td>성별</td>
								<td>결제 여부</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<p>월 회원 정보를 입력하세요.</p>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" class="dialogBtn" id="enterBtn" value="등록">
						<input type="button" class="dialogBtn" onclick="javascript:history.back()" value="취소">
					</td>
				</tr>
			</table>
		</div>
	</div>
	</form>
</body>
</html>