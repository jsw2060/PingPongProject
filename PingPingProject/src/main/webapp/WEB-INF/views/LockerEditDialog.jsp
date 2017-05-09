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
	
});
</script>
</head>
<body>
	<form id="" action="">
	<div align="center">
		<br/>
		<div>
			<h1 class="dialogTitle">사물함 정보 수정</h1>
		</div>
		<br/>
		<div>
			<h1 class="dialogTitle">사물함 A030</h1>
		</div>
		<div>
			<table width="350" border="1">
				<tr>
					<td width="150" align="center">용도: </td>
					<td>
						<select id="" name="" style="width: 200px;">
							<option value="">-- 용도 --</option>
							<option value="">미사용</option>
							<option value="">비품용</option>
							<option value="">회원용</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="150" align="center">비고: </td>
					<td>
						<input type="text">
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
	</div>
	</form>
</body>
</html>