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
	
	// when click enter button
	$("#enterBtn").click(function(){
		console.log("등록");
		console.log("test ", document.getElementById("lockerArticle").value);
		console.log("test ", document.getElementById("selectedArticle").value);
		$("#LockerEditForm").submit();	
	});
	
	$("#lockerArticle").on("change", function() {
		document.getElementById("selectedArticle").value = document.getElementById("lockerArticle").value;
	});
	
	// locker purpose selection
	$("#selectBox").on("change", function() {

		var that = $(this);
		console.log("that.val", that.val());

		switch(that.val()) {
		
		case '0':	// 다른용도 -> 회원용
			alert("회원용");
		
			$("#forStuff").removeAttr('selected');
			$("#notUse").removeAttr('selected');
			$("#forMember").attr('selected', true);
			
			$("#lockerArticle").attr('disabled', true);
			$("#searchName").removeAttr('disabled');
			document.getElementById("selectedPurpose").value = '0';
			break;
		case '1': // 다른 용도 -> 비품용
			alert("비품용");
			
			$("#forMember").removeAttr('selected');
			$("#notUse").removeAttr('selected');
			$("#forStuff").attr('selected', true);
			
			$("#searchName").attr('disabled', true);
			$("#lockerArticle").removeAttr('disabled');
			document.getElementById("selectedPurpose").value = '1';
			break;
		case '2': // 다른용도 -> 미사용
			alert("미사용");
			
			$("#forStuff").removeAttr('selected');
			$("#forMember").removeAttr('selected');
			$("#notUse").attr('selected', true);
			
			$("#lockerArticle").attr('disabled', true);
			$("#searchName").attr('disabled', true);
			document.getElementById("selectedPurpose").value = '2';
			break;
		default: 
			alert("check logic!!");
			break;
		
		}
	
	});
	
	// member searching
	$("#searchBtn").click(function () {
		
		// 검색 테이블 초기화
		$("#searchResult").children().remove();
		var searchName = $("#searchName").val();
		
		console.log("입력값 " + searchName);
		
		jQuery.ajax({
			type:"GET",
			url:"http://localhost:8080/pingPong/LockerSearch.do?searchName=" + searchName + "",
			dataType: "JSON",
			success: function(data) {
				console.log("sending success ");
				console.log(data);
				
				var temp = "";
				var obj_length = Object.keys(data).length;
				var sexTemp = "";
				var statusTemp = "";
				
				if(data != null) {
					for(var idx = 0; idx < obj_length; idx++) {
						if(data[idx].SEX == 0) {
							sexTemp = "M";
						} else {
							sexTemp = "W";
						}
						
						if(data[idx].LOCKER_PURPOSE == 2) {
							statusTemp = "X";
						} else if(data[idx].LOCKER_PURPOSE == 1)
						{
							statusTemp = "O";
						} else {
							console.log("사물함 관리 오류");
						}
						
						temp = "<td>" + data[idx].MEMBER_CODE + "</td>"
						+ "<td>" + data[idx].NAME + "</td>"
						+ "<td>" + sexTemp + "</td>"
						+ "<td>" + statusTemp + "</td>"
						+ "<td>" + data[idx].LOCKER_CODE + "</td>";
					}
				} else {
					temp = "<td colspan='5'>데이터가 없습니다</td>";
				}
				
				console.log("temp ", temp);
				$("#searchResult").append(temp);
				
			},
			error: function(xhr, option, error) {
				console.log("sending fail");
				console.log("오류코드 " + xhr.status);
				console.log(error);
			}
		})
	});
	
	// table selection
	$("#searchResult").click(function() {
		
		var selectedTr = $(this);
		var selectedTd = selectedTr.children();
		console.log("selectedTd ", selectedTd);
		var indexNum = selectedTd.eq(0).text();
		
		alert(selectedTd.eq(1).text() + " 님을 선택하셨습니다.");
		console.log("여기부터 val값");
		console.log(indexNum);
		// store temporary info of selected member
		document.getElementById("selectedMember").value = indexNum;
	});
});
</script>
</head>
<body>
	<div align="center">
	<form id="LockerEditForm" action="LockerUpdate.do">
		<br/>
		<div style="text-align: center;">
			<h1>사물함 정보 수정</h1>
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