<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/FrameLayout.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="defaultPage" align="center">
		<div>
			<table border="1" class="outLineTable">
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
						<input type="text" style="width: 60px;">
					</td>
					<td>
						<label>유형:</label>
						<select>
							<option value="" selected="selected">-- 전체 --</option>
							<option>주 2회 20분</option>
							<option>주 2회 30분</option>
							<option>주 3회 20분</option>
							<option>주 3회 30분</option>
							<option>학생 주 2회 20분</option>
							<option>오전 단체 주 2회</option>
							<option>오전 단체 주 3회</option>
							<option>주말 레슨</option>
						</select>
					</td>
					<td><input type="button" value="검"></td>
					<td><input type="button" value="검"></td>
				</tr>
				<tr height="405">
					<td colspan="5">
						<table border="1" class="dataSheet" width="100%" height="400" style="overflow: auto;">
							<tr>
								<td width="70">코치</td>
								<td width="70">회원</td>
								<td width="100">유형</td>
								<td width="70">요일</td>
								<td width="80">레슨 시간</td>
								<td width="100">등록일</td>
								<td width="60">비고</td>
							</tr>
							<tr>
								<td>신현준</td>
								<td>김성옥</td>
								<td>주 2회 30분</td>
								<td>수목금</td>
								<td>30분</td>
								<td>2017-01-01</td>
								<td></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr class="situationSheet">
					<td colspan="5">
						<input type="text" style="width: 575px; background-color: #606060;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td colspan="5">
						<input type="button" value="레슨정보 수정">
						<input type="button" value="레슨정보 삭제">
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>