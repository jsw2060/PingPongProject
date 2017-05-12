<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/DialogLayout.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#findMember").click(function(){
		$("#insertMonthFeeForm").attr("action", "FindMonthAndMember.do");
		$("#insertMonthFeeForm").submit();
	});
	
	tableSelection();
});

function tableSelection() {
	var rows = $("#memberDataForm tr");
	if(rows && rows.length > 0) {
		$(rows).each(function (idx) {
			if(idx > 0) {
				var startIdx = 0;
				var endIdx = rows[idx].childNodes.length;
				$(rows[idx]).click(function() {
					var numb = $(rows[idx]).find('td').eq(0).html();
					alert(numb);
	
					$(rows[idx]).find('td input').attr('name', 'memberCode');
					$("#insertMonthFeeForm").attr("action", "InsertMonthFeeInput.do");
					$("#insertMonthFeeForm").submit();
				});
			}
		});
	}
}
</script>
</head>
<body>
	<form id="insertMonthFeeForm" action="InsertMonthFeeInput.do">
	<div align="center">
		<br/>
		<div>
			<h1 class="dialogTitle">월 회원 세부 정보</h1>
		</div>
		<br/>
		<div>
			<table width="350" border="1">
				<tr>
					<td width="150" align="center">*회원: </td>
					<td>
						<input type="text" name="memberName">
						<button type="button" style="border-bottom-style: hidden;" id="findMember"><img class="buttonImg" alt="검색버튼" src="resources/Collection/Find User Male_3.png"></button>
						<button type="button" style="border-bottom-style: hidden;"><img class="buttonImg" alt="추가버튼" src="resources/Collection/Add User Male_2.png"></button>
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<table id="memberDataForm" border="1" width="360">
							<tr class="textHead">
								<td>회원번호</td>
								<td>이름</td>
								<td>성별</td>
								<td>결제 여부</td>
							</tr>
							<c:choose>
								<c:when test="${ memberResult ne null }">
									<c:forEach var="memberInfo" items="${ memberResult }">
										<tr>
											<td>${ memberInfo.member_code }<input name="" type="hidden" value="${ memberInfo.member_code }"></td>
											<td>${ memberInfo.name }</td>
											<c:choose>
												<c:when test="${ memberInfo.sex eq 0}">
													<td>M</td>
												</c:when>
												<c:otherwise>
													<td>F</td>
												</c:otherwise>
											</c:choose>
											<td>${ memberInfo.fee_status }</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="4" style="text-align: center;">검색된 내용이 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</table>
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<p>월 회원 정보를 입력하세요.</p>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" class="dialogBtn" id="enterBtn" value="등록">
						<input type="button" class="dialogBtn" onclick="javascript:history.back()" value="취소">
					</td>
				</tr>
			</table>
		</div>
	</div>
	</form>
</body>
</html>