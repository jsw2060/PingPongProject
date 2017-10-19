<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/DialogLayout.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div align="center">
		<br/>
		<div style="text-align: center;">
			<h1>계정 정보 수정</h1>
		</div>
		<br/>
		<div>
			<label>ID:</label>
			<input type="text">
			<label>PW 재설정:</label>
			<input type="text">
			<label>PW 재입력:</label>
			<input type="text">		
		</div>
		<div>
			<input type="checkbox" value="관리자 권한">
			<input type="checkbox" value="코치 권한">
		</div>
		<div>
			<label>회원:</label>
			<input type="text">
			<input type="button" value="검">
			<input type="button" value="검">
		</div>
		<div>
			<table>
				<tr>
					<td rowspan="2">이름</td>
					<td rowspan="2">성별</td>
					<td rowspan="2">등록일</td>
					<td colspan="2">권한</td>
					<td rowspan="2"></td>
				</tr>
				<tr>
					<td>관리자</td>
					<td>코치</td>
				</tr>
				<tr>
					<td>코치샘플</td>
					<td>M</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</div>
		<div>
			<p>수정할 정보를 입력해 주세요.</p>
		</div>
		<div>
			<input type="button" value="등록">
			<input type="button" value="취소">
		</div>
	</div>
</body>


	<!-- <form id="InsertGeneralFee" action="InsertGeneralFee.do">  -->
		
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
						<input type="radio" class="radioInput" name="status" value="0">일반
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" class="radioInput" name="status" value="1">학생
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<p>이용 시간과 이용 테이블 수를 입력하세요.</p>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" class="dialogBtn" id="enterBtn" value="입력">
						<input type="button" class="dialogBtn" onclick="javascript:history.back()" value="취소">
					</td>
				</tr>
			</table>
		</div>



</html>