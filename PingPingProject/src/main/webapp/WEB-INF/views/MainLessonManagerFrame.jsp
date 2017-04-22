<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>
	<div>
		<div>
			<table border="1" width="768" cellpadding="0" cellspacing="0" style="text-align: center;">
				<tr>
					<td>
						<label>코치:</label>
						<select>
							<option value="" selected="selected">-- 전체 --</option>
							<option></option>
							<option></option>
						</select>
					</td>
					<td>
						<label>회원명:</label>
						<input type="text">
					</td>
					<td>
						<label>유형:</label>
						<select>
							<option value="" selected="selected">-- 전체 --</option>
							<option></option>
							<option></option>
							<option></option>
						</select>
					</td>
					<td><input type="button" value="검"></td>
					<td><input type="button" value="검"></td>
				</tr>
			</table>
		</div>
		<div>
			<table border="1" width="768" cellpadding="0" cellspacing="0" style="text-align: center;">
				<tr>
					<td>코치</td>
					<td>회원</td>
					<td>유형</td>
					<td>요일</td>
					<td>레슨 시간</td>
					<td>등록일</td>
					<td>비고</td>
					<td width="auto"></td>
				</tr>
			</table>
		</div>
		<div>
			<table border="1" width="768" cellpadding="0" cellspacing="0" style="text-align: center;">
				<tr>
					<td>
						<input type="text">
					</td>
				</tr>
				<tr>
					<td>
						<input type="button" value="레슨정보 수정">
						<input type="button" value="레슨정보 삭제">
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>