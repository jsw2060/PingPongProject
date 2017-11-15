<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	$(document).ready(function(){
		$("#selectedAmount").on("change", function() {
			document.getElementById("updateAmount").value = document.getElementById("selectedAmount").value;
		})
		
		$("#selectedDate").on("change", function() {
			document.getElementById("updateDate").value = document.getElementById("selectedDate").value;
		})
		
		$("#selectedNote").on("change", function() {
			document.getElementById("updateNote").value = document.getElementById("selectedNote").value;
		})
		
		$("#editBtn").click(function() {
			$("#EditFeeInfoForm").submit();
		});
	});
</script>
</head>
<body>
	<div align="center">
	<form id="EditFeeInfoForm" action="FeeInfoUpdate.do">
		<br/>
		<div style="text-align: center;">
			<h1>요금정보 수정</h1>
		</div>
		<br/>
		<div>
			<table width="440" border="1">
				<tr>
					<td width="150" align="center">*요금타입: </td>
					<td>
						<select id="selectBox" style="width: 276px;" disabled="disabled">
							<c:choose>
								<c:when test="${feeInfoMembType eq '일반'}">
									<option id="notUse" value="0">-- 전체 --</option>
									<option id="normal" value="1" selected="selected">일반</option>
									<option id="dayMember" value="2">일회원</option>
									<option id="monthMember" value="3">월회원</option>
								</c:when>
								<c:when test="${feeInfoMembType eq '일회원'}">
									<option id="notUse" value="0">-- 전체 --</option>
									<option id="normal" value="1">일반</option>
									<option id="dayMember" value="2" selected="selected">일회원</option>
									<option id="monthMember" value="3">월회원</option>
								</c:when>
								<c:otherwise>
									<option id="notUse" value="0">-- 전체 --</option>
									<option id="normal" value="1">일반</option>
									<option id="dayMember" value="2">일회원</option>
									<option id="monthMember" value="3" selected="selected">월회원</option>
								</c:otherwise>
							</c:choose>
						</select>
					</td>
				</tr>
				<tr>
					<td width="150" align="center">*금액: </td>
					<td>
						<input type="text" style="width: 272px;" id="selectedAmount" name="selectedAmount" value="${feeInfoAmount }">
					</td>
				</tr>
				<tr>
					<td width="150" align="center">*결제일: </td>
					<td>
						<c:set var="tempFeeDate" value="${ fn:substring(feeInfoDate, 0, 11) }"/>
						<input type="date" style="width: 271px;" id="selectedDate" name="selectedDate" value="${fn:trim(tempFeeDate) }">
					</td>
				</tr>
				<tr>
					<td width="150" align="center">비고: </td>
					<td>
						<textarea style="width: 270px; height: 100px;" id="selectedNote" name="selectedNote">${feeInfoNote }</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" class="dialogBtn" id="editBtn" value="수정">
						<input type="button" class="dialogBtn" onclick="javascript:history.back()" value="취소">
						
						<!-- 수정 데이터 -->
						<input type="hidden" id="updateFeeCode" name="updateFeeCode" value="${feeInfoFeeCode }">
						<input type="hidden" id="updateMembType" name="updateMembType" value="${feeInfoMembType }">
						<input type="hidden" id="updateAmount" name="updateAmount" value="">
						<input type="hidden" id="updateDate" name="updateDate" value="">
						<input type="hidden" id="updateNote" name="updateNote" value="">
					</td>
				</tr>
			</table>		
		</div>
		</form>
	</div>
</body>
</html>