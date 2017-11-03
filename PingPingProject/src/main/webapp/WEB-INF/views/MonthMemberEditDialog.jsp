<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>
<body>
	<div align="center">
	<form id="LockerEditForm" action="LockerUpdate.do">
		<br/>
		<div style="text-align: center;">
			<h1>월 회원 수정</h1>
		</div>
		<div>
			<table width="440" border="1">
				<tr>
					<td width="150" align="center">*등록일: </td>
					<td>
						<input type="date" style="width: 270px;" id="registerDate" name="registerDate" value="${memberRegDay }">
					</td>
				</tr>
				<tr>
					<td width="150" align="center">회원: </td>
					<td>
					<c:choose>
						<c:when test="${lockerPurpose eq 0}">
							<input type="text" width="100px" id="searchName" name="searchName" value="${lockerName }">
						</c:when>
						<c:otherwise>
							<input type="text" width="100px" id="searchName" name="searchName" value="" disabled="disabled">
						</c:otherwise>
					</c:choose>
						<input type="button" id="searchBtn" value="검색">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div>
							<table style="background-color: #E1E1E1; text-align: center;" align="center" width="430px;" border="1">
								<tr style="background-color: #DEDEDE;">
									<td>회원번호</td>
									<td>이름</td>
									<td>성별</td>
								</tr>
								<tr id="searchResult">
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">결제 정보:</td>
				</tr>
				<tr>
					<td colspan="2">
						<div>
							<table style="background-color: #E1E1E1; text-align: center;" align="center" width="430px;" border="1">
								<tr style="background-color: #DEDEDE;">
									<td>금액</td>
									<td>결제일</td>
									<td>비고</td>
								</tr>
								<tr id="searchResult">
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" class="dialogBtn" id="enterBtn" value="등록">
						<input type="button" class="dialogBtn" onclick="javascript:history.back()" value="취소">
						
						<input type="hidden" id="selectedMember" name="selectedMember" value="${lockerMemberCode }">
						<input type="hidden" id="selectedLocker" name="selectedLocker" value="${lockerCd }">
						<input type="hidden" id="selectedPurpose" name="selectedPurpose" value="${lockerPurpose }">
						<input type="hidden" id="selectedArticle" name="selectedArticle" value="${lockerStuff }">
					</td>
				</tr>
			</table>		
		</div>
		</form>
	</div>
</body>
</html>