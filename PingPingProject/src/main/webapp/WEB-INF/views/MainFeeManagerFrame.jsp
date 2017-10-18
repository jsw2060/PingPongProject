<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/FrameLayout.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="defaultPage">
		<div>
			<table border="1" class="outLineTable" align="center">
				<tr>
					<td width="370">
						<label>기간:</label>
						<input type="date"> - <input type="date">
					</td>
					<td width="140">
						<label>유형:</label>
						<select>
							<option value="" selected="selected">-- 전체 --</option>
							<option></option>
							<option></option>
						</select>
					</td>
					<td colspan="2">
						<input type="button" value="검">
					</td>
				</tr>
				<tr height="365">
					<td colspan="4">
						<table class="dataSheet" width="100%" height="360" style="overflow: auto;">
							<tr>
								<td>유형</td>
								<td>금액</td>
								<td>지불일</td>
								<td>이름</td>
								<td>비고</td>
							</tr>
							<tr>
								<td>일 회원</td>
								<td>7000</td>
								<td>2017-02-18</td>
								<td>회원</td>
								<td>김영기 회원님</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<table>
							<tr class="situationSheet">
								<td colspan="4">
									<input type="text" style="width: 575px; background-color: #606060;" readonly="readonly">
								</td>
							</tr>
							<tr>
								<td>
									<label>통계:</label>
									<input type="text" style="width: 50px;" placeholder="yyyy">년
									<input type="text" style="width: 30px;" placeholder="MM">월
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
					</td>
				<tr>
			</table>
		</div>
	</div>
</body>
</html>