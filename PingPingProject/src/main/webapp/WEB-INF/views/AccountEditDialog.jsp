<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/DialogLayout.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div align="center">
	<!-- <form id="InsertGeneralFee" action="InsertGeneralFee.do">  -->
		<c:forEach var="infos" items="${selectedInfo }">
		<br/>
		<div style="text-align: center;">
			<h1>계정 정보 수정</h1>
		</div>
		<br/>
		<div>
			<table width="350" border="1">
				<tr>
					<td width="150" align="center">ID: </td>
					<td>
						<input type="text" value="${infos.id }">
					</td>
				</tr>
				<tr>
					<td width="150" align="center">PW 재설정: </td>
					<td>
						<input type="password" value="${infos.password }">
					</td>
				</tr>
				<tr>
					<td width="150" align="center">PW 재입력: </td>
					<td>
						<input type="password" value="${infos.password }">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
					<c:choose>
						<c:when test="${ infos.manager_status eq 1}">
							관리자 권한 <input type="checkbox" value="1" checked="checked">
						</c:when>
						<c:otherwise>
							관리자 권한 <input type="checkbox" value="0">
						</c:otherwise>
					</c:choose>
					&nbsp;&nbsp;
					<c:choose>
						<c:when test="${ infos.coach_status eq 1}">
							코치 권한 <input type="checkbox" value="1" checked="checked">
						</c:when>
						<c:otherwise>
							코치 권한 <input type="checkbox" value="0">
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<p>수정할 정보를 입력하세요.</p>
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
		</c:forEach>
	</div>
</body>
</html>