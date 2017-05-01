<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/FrameLayout.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="defaultPage" align="center">
		<div>
			<table>
				<tr>
					<td>
						<label style="font-size: 20px;">요금 입력 내역</label>
						<input type="date">
					</td>
					<td>
						<input type="text">
					</td>
				</tr>
			</table>
		</div>
		<div>
			<table>
				<tr class="dataSheet">
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
		</div>
		<div>
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
						<select>
							<option value="" selected="selected">종류를 선택하세요.</option>
							<option>일반</option>
							<option>일 회원</option>
							<option>월 회원</option>
							<option>레슨 등록</option>
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
						<textarea style="width: 590px;"></textarea>	
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="text" style="width: 590px; background-color: #606060;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="button" value="입력">
						<input type="button" value="초기화">
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>