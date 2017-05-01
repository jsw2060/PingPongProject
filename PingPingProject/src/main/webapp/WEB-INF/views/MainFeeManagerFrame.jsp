<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/FrameLayout.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="defaultPage" id="mainFeeManagerPage">
		<div>
			<table>
				<tr>
					<td>
						<label>기간:</label>
						<input type="date">
						 - <input type="date">
					</td>
					<td>
						<label>유형:</label>
						<select>
							<option value="" selected="selected">-- 전체 --</option>
							<option></option>
							<option></option>
						</select>
					</td>
					<td>
						<input type="button" value="검">
					</td>
				</tr>
			</table>
		</div>
		<div>
			<table>
				<tr class="dataSheet">
					<td>유형</td>
					<td>금액</td>
					<td>지불일</td>
					<td>이름</td>
					<td>비교</td>
				</tr>
				<tr>
					<td>일 회원</td>
					<td>7000</td>
					<td>2017-02-18</td>
					<td>회원</td>
					<td>김영기 회원님</td>
				</tr>
			</table>
		</div>
		<div>
			<table>
				<tr class="situationSheet">
					<td colspan="4">
						<input type="text">
					</td>
				</tr>
				<tr>
					<td>
						<label>통계:</label>
						<input type="text" placeholder="yyyy">년
						<input type="text" placeholder="MM">월
					</td>
					<td>
						<label>유형:</label>
						<select>
							<option value="" selected="selected">-- 전체 --</option>
							<option></option>
							<option></option>
						</select>
					</td>
					<td>
						<input type="radio" value="일 통계">일 통계
						<input type="radio" value="월 통계">월 통계
					</td>
					<td>
						<input type="button" value="차트">
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="button" value="요금정보 수정">
						<input type="button" value="요금정보 삭제">
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>