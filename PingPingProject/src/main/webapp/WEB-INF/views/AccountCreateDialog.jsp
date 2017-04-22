<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/DialogLayout.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="mainFrame" align="center">
		<div>
			<h1 class="dialogTitle">계정 등록 신청</h1>
		</div>
		<div>
			<table border="1">
				<tr>
					<td><label class="editLabel">*ID:</label></td>
					<td colspan="2" width="250" align="right"><input class="editInput" type="text"></td>
				</tr>
				<tr>
					<td><label class="editLabel">*PW:</label></td>
					<td colspan="2" width="250" align="right"><input class="editInput" type="text"></td>
				</tr>
				<tr>
					<td><label class="editLabel">*PW 재입력:</label></td>
					<td colspan="2" width="250" align="right"><input class="editInput" type="text"></td>
				</tr>
				<tr>
					<td colspan="3" style="text-align: center;">
						<input type="checkbox">관리자 권한
						<input type="checkbox">코치 권한
					</td>
				</tr>
				<tr align="center">
					<td>
						<label class="editLabel">회원:</label>
					</td>
					<td>
						<input type="text">
					</td>
					<td>
						<input type="button" value="검">
						<input type="button" value="검">
					</td>
				</tr>
			</table>
		</div>
		<br/>
		<div>
			<table border="1" width="360">
				<tr class="textHead">
					<td rowspan="2" width="70">이름</td>
					<td rowspan="2" width="45">성별</td>
					<td rowspan="2" width="80">등록일</td>
					<td colspan="2" width="100">권한</td>
					<td rowspan="2" width="auto;"></td>
				</tr>
				<tr class="textHead">
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
		<div style="width: 360;">
			<p>수정할 정보를 입력해 주세요.</p>
		</div>
		<div>
			<input type="button" class="dialogBtn" value="등록">
			<input type="button" class="dialogBtn" onclick="javascript:history.back()" value="취소">
		</div>
	</div>
</body>
</html>