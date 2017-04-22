<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/DialogLayout.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div>
		<div>
			<h1>계정 정보 수정</h1>
		</div>
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
</html>