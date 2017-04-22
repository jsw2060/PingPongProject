<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>
	<ul>
		<li>승인대기 목록
			<table border="1" width="768" cellpadding="0" cellspacing="0" style="text-align: center;">
				<tr>
					<td rowspan="2" width="120">ID</td>
					<td colspan="2" width="120">신청여부</td>
					<td rowspan="2" width="120">신청일</td>
					<td colspan="2" width="120">승인선택</td>
					<td rowspan="2" width="auto"></td>
				</tr>
				<tr>
					<td width="60">관리자</td>
					<td width="60">코치</td>
					<td width="60">승인</td>
					<td width="60">거부</td>
				</tr>
				<tr>
					<td>sample</td>
					<td>N</td>
					<td>N</td>
					<td>2017-02-18</td>
					<td>승</td>
					<td>거</td>
					<td></td>
				</tr>
			</table>
		</li>
		<li>계정 목록
			<table border="1" width="768" cellpadding="0" cellspacing="0" style="text-align: center;">
				<tr>
					<td rowspan="2" width="120">ID</td>
					<td colspan="2" width="120">권한여부</td>
					<td rowspan="2" width="60">이름</td>
					<td rowspan="2" width="60">성별</td>
					<td rowspan="2" width="120">연락처</td>
					<td rowspan="2" width="120">가입일</td>
					<td rowspan="2" width="auto"></td>
				</tr>
				<tr>
					<td width="60">관리자</td>
					<td width="60">코치</td>
				</tr>
				<tr>
					<td>admin</td>
					<td>Y</td>
					<td>N</td>
					<td>최유성</td>
					<td>M</td>
					<td>010-7736-3574</td>
					<td>2017-02-06</td>
					<td></td>
				</tr>
			</table>
		</li>
	</ul>
	<input type="text">
	<input type="button" value="계정 수정">
	<input type="button" onclick="" value="계정 삭제">
</body>
</html>