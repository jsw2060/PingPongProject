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
		$("#insertLessonFeeForm").attr("action", "FindLessonAndMember.do");
		$("#insertLessonFeeForm").submit();
	});
	
	$("#findCoach").click(function(){
		$("#insertLessonFeeForm").attr("action", "FindLessonAndCoach.do");
		$("#insertLessonFeeForm").submit();
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
					$("#insertLessonFeeForm").attr("action", "InsertLessonFeeInput.do");
					$("#insertLessonFeeForm").submit();
				});
			}
		});
	}
}
</script>
</head>
<body>
	<form id="insertLessonFeeForm" action="InsertLessonFeeInput.do">
		<div>
			<h1 class="dialogTitle">레슨 세부 정보</h1>
		</div>
		<br/>
		<table align="center">
			<tr>
				<td>
					<table width="290" border="1" height="400">
						<tr height="50">
							<td width="120" align="center">*회원: </td>
							<td>
								<input type="text" width="160" name="memberName">
								<button type="button" style="border-bottom-style: hidden;" id="findMember"><img class="buttonImg" alt="검색버튼" src="resources/Collection/Find User Male_3.png"></button>
								<button type="button" style="border-bottom-style: hidden;"><img class="buttonImg" alt="추가버튼" src="resources/Collection/Add User Male_2.png"></button>
							</td>
						</tr>
						<tr>
							<td align="center" colspan="2">
								<table id="memberDataForm" border="1" width="290">
									<tr class="textHead">
										<td>회원번호</td>
										<td>이름</td>
										<td>성별</td>
									</tr>
									<c:forEach var="memberInfo" items="${ memberResult }">
										<tr>
											<td>${ memberInfo.member_code }</td>
											<td>${ memberInfo.name }</td>
											<c:choose>
												<c:when test="${ memberInfo.sex eq 0}">
													<td>M</td>
												</c:when>
												<c:otherwise>
													<td>F</td>
												</c:otherwise>
											</c:choose>
										</tr>
									</c:forEach>
								</table>
							</td>
						</tr>
						<tr height="50">
							<td width="120" align="center">*코치: </td>
							<td>
								<input type="text" width="160" name="coachName">
								<button type="button" style="border-bottom-style: hidden;" id="findCoach"><img class="buttonImg" alt="검색버튼" src="resources/Collection/Find User Male_3.png"></button>
								<button type="button" style="border-bottom-style: hidden;"><img class="buttonImg" alt="추가버튼" src="resources/Collection/Add User Male_2.png"></button>
							</td>
						</tr>
						<tr>
							<td align="center" colspan="2">
								<table id="coachDataForm" border="1" width="290">
									<tr class="textHead">
										<td>코치번호</td>
										<td>이름</td>
										<td>성별</td>
									</tr>
									<c:forEach var="coachInfo" items="${ coachResult }">
										<tr>
											<td>${ coachInfo.member_code }</td>
											<td>${ coachInfo.name }</td>
											<c:choose>
												<c:when test="${ coachInfo.sex eq 0}">
													<td>M</td>
												</c:when>
												<c:otherwise>
													<td>F</td>
												</c:otherwise>
											</c:choose>
										</tr>
									</c:forEach>
								</table>
							</td>
						</tr>
						<tr height="40">
							<td align="center" colspan="2">
								<p>레슨 정보를 입력하세요.</p>
							</td>
						</tr>
						<tr height="40">
							<td colspan="2" align="center">
								<input type="button" class="dialogBtn" id="enterBtn" value="등록">
								<input type="button" class="dialogBtn" onclick="javascript:history.back()" value="취소">
							</td>
						</tr>
					</table>
				</td>
				<td>
					<table width="290" border="1" height="400">
						<tr>
							<td colspan="2" style="text-align: right;"><input type="checkbox">회수제 레슨</td>
						</tr>
						<tr>
							<td width="120" align="center">레슨 유형: </td>
							<td>
								<select id="lessonType" name="lessonType" style="width: 160px;">
									<option value="0"></option>
									<option value="1">주 2회 20분</option>
									<option value="2">주 2회 30분</option>
									<option value="3">주 3회 20분</option>
									<option value="4">주 3회 30분</option>
									<option value="5">학생 주 2회 20분</option>
									<option value="6">오전 단체 주 2회</option>
									<option value="7">오전 단체 주 3회</option>
									<option value="8">주말 레슨</option>
								</select>
							</td>
						</tr>
						<tr>
							<td width="120" align="center">레슨 요일: </td>
							<td>
								<select id="lessonDay" name="lessonDay" style="width: 160px;">
									<option value="0">요일을 모두 선택하세요.</option>
									<option value="1">월요일</option>
									<option value="2">화요일</option>
									<option value="3">수요일</option>
									<option value="4">목요일</option>
									<option value="5">금요일</option>
									<option value="6">토요일</option>
									<option value="7">일요일</option>
								</select>
							</td>
						</tr>
						<tr>
							<td align="center" colspan="2">
								<table id="lessonDataForm" border="1" width="290">
									<tr class="textHead">
										<td>요일</td>
										<td>시간</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td colspan="2">
							비고:<br/>
								<textarea rows="4" cols="32">
								</textarea>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>