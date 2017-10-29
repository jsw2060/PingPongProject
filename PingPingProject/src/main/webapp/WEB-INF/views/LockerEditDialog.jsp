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
	
});
</script>
</head>
<body>
	<div align="center">
	<form id="BootrackEditForm" action="BootrackUpdate.do">
		<br/>
		<div style="text-align: center;">
			<h1>신발장 정보 수정</h1>
		</div>
		<div>
			<h1 class="dialogTitle">사물함 ${lockerCd }</h1>
		</div>
		<div>
			<table width="440" border="1">
				<tr>
					<td width="150" align="center">용도: </td>
					<td>
						<select id="selectBox" style="width: 274px;">
							<c:choose>
								<c:when test="${lockerPurpose eq 0}">
									<option id="forMember" value="0" selected="selected">회원용</option>
									<option id="forStuff" value="1">비품용</option>
									<option id="notUse" value="2">미사용</option>
									
								</c:when>
								<c:when test="${lockerPurpose eq 1}">
									<option id="forMember" value="0">회원용</option>
									<option id="forStuff" value="1" selected="selected">비품용</option>
									<option id="notUse" value="2">미사용</option>
									
								</c:when>
								<c:otherwise>
									<option id="forMember" value="0">회원용</option>
									<option id="forStuff" value="1">비품용</option>
									<option id="notUse" value="2" selected="selected">미사용</option>
								</c:otherwise>
							</c:choose>
						</select>
					</td>
				</tr>
				<tr>
					<td width="150" align="center">비고: </td>
					<td>
					<c:choose>
						<c:when test="${lockerPurpose eq 1}">
							<input type="text" style="width: 270px;" id="lockerArticle" name="lockerArticle" value="${lockerStuff }">
						</c:when>
						<c:otherwise>
							<input type="text" style="width: 270px;" id="lockerArticle" name="lockerArticle" value="" disabled="disabled">
						</c:otherwise>
					</c:choose>
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
						<input type="button" id="addBtn" value="추가">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div>
							<table style="background-color: #E1E1E1; text-align: center;" align="center" width="430px;" border="1">
								<tr style="background-color: #DEDEDE;">
									<td rowspan="2">번호</td>
									<td rowspan="2">이름</td>
									<td rowspan="2">성별</td>
									<td colspan="2">사물함사용</td>
								</tr>
								<tr>
									<td>여부</td>
									<td>번호</td>
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
						<input type="hidden" id="selectedMember" name="selectedMember" value="">
						<input type="hidden" id="selectedBootrack" name="selectedBootrack" value="${bootrackCd }">
					</td>
				</tr>
			</table>		
		</div>
		</form>
	</div>
</body>
</html>