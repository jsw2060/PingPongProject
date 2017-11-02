<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#userName").on("change", function() {
		$("#updateName").attr('value', $(this).val());
	});
	
	console.log("선택 되어 있나?", $("#userSex:radio[value='0']").is(":checked"));
	
	
	if($("#userSex:radio[value='0']").is(":checked") == true){
		$("#userSex").on("change", function (){
			$("#userSex:radio[value='0']").removeAttr("checked");
			$("#userSex:radio[value='1']").attr("checked", true);
			console.log("여자선택");
		});
		
	}
		/* if($("#userSex").val() == 0) {
			console.log("남자선택");
		} else {
			console.log("여자선택");
		} */
	
	
	
	
	$("#userTel").on("change", function() {
		$("#updateTel").attr('value', $(this).val());
	});
	
	$("#userAge").on("change", function() {
		$("#updateAge").attr('value', $(this).val());
	});
	
	$("#userBday").on("change", function() {
		$("#updateBday").attr('value', $(this).val());
	});
	
	$("#userAddr").on("change", function() {
		$("#updateAddr").attr('value', $(this).val());
	});
	
	$("#userEmail").on("change", function() {
		$("#updateEmail").attr('value', $(this).val());
	});
	
	console.log("userName ", $("#selectedName").val());
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
	
	$("#userRegDay").on("change", function() {
		$("#updateRegDay").attr('value', $(this).val());
	});
	
	$("#userNote").on("change", function() {
		$("#updateNote").attr('value', $(this).val());
	});
	
});
</script>
</head>
<body>
	<div align="center">
	<form id="AccountEditForm" action="AccountUpdate.do">
		<div style="text-align: center;">
			<h1>회원 정보 수정</h1>
		</div>
		<div>
			<table width="500" border="1">
				<tr>
					<td width="100" align="center">*이름: </td>
					<td align="center" colspan="2">
						<input type="hidden" name="userCode" value="${memberId }">
						<input type="text" style="width: 120px;" name="userName" id="userName" value="${memberName }">
					</td>
					<td width="100" align="center">*성별: </td>
					<td align="center" width="150">
						<c:choose>
							<c:when test="${memberSex == 1}">
								<input type="radio" class="radioInput" id="userSex" name="userMale" value="0">남자
								&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" class="radioInput" id="userSex" name="userFemale" value="1" checked="checked">여자
							</c:when>
							<c:otherwise>
								<input type="radio" class="radioInput" id="userSex" name="userMale" value="0" checked="checked">남자
								&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" class="radioInput" id="userSex" name="userFemale" value="1">여자
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">*전화번호: </td>
					<td align="center" colspan="4">
						<input type="tel" style="width: 380px;" id="userTel" name="userTel" placeholder="${memberTel }" maxlength="11" value="${memberTel }">
					</td>
				</tr>
				<tr>
					<td width="100" align="center">나이: </td>
					<td align="center" colspan="4">
						<input type="text" style="width: 380px;" id="userAge" name="userAge" value="${memberAge }">					
					</td>
				</tr>
				<tr>
					<td width="100" align="center">생일: </td>
					<td align="center" colspan="4">
						<input type="date" style="width: 380px;" id="userBday" name="userBday" value="${memberBday }">
					</td>
				</tr>
				<tr>
					<td width="100" align="center">주소: </td>
					<td align="center" colspan="4">
						<input type="text" style="width: 380px;" id="userAddr" name="userAddr" value="${memberAddr }">
					</td>
				</tr>
				<tr>
					<td width="100" align="center">이메일: </td>
					<td align="center" colspan="4">
						<input style="width: 380px;" type="email" id="userEmail" name="userEmail" value="${memberEmail }">
					</td>
				</tr>
				<tr>
					<td width="100" align="center">전형: </td>
					<td align="center">
						<select id="userStyle" name="userStyle" style="width: 120px;">
							<c:choose>
								<c:when test="${memberStyle eq 1 }">
									<option value="0">-- 전형 --</option>
									<option value="1" selected="selected">펜홀더</option>
									<option value="2">쉐이크핸드</option>
									<option value="3">중국식 펜홀더</option>
								</c:when>
								<c:when test="${memberStyle eq 2 }">
									<option value="0">-- 전형 --</option>
									<option value="1">펜홀더</option>
									<option value="2" selected="selected">쉐이크핸드</option>
									<option value="3">중국식 펜홀더</option>
								</c:when>
								<c:when test="${memberStyle eq 3 }">
									<option value="0">-- 전형 --</option>
									<option value="1">펜홀더</option>
									<option value="2">쉐이크핸드</option>
									<option value="3" selected="selected">중국식 펜홀더</option>
								</c:when>
								<c:otherwise>
									<option value="0" selected="selected">-- 전형 --</option>
									<option value="1">펜홀더</option>
									<option value="2">쉐이크핸드</option>
									<option value="3">중국식 펜홀더</option>
								</c:otherwise>
							</c:choose>
						</select>
					</td>
					<td width="100" align="center" colspan="2">부수: </td>
					<td align="center">
						<select id="userGrade" name="userGrade" style="width: 120px;">
							<c:choose>
								<c:when test="${memberGrade == 1 }">
									<option value="0">-- 부수 --</option>
									<option value="1" selected="selected">0부</option>
									<option value="2">1부</option>
									<option value="3">2부</option>
									<option value="4">3부</option>
									<option value="5">4부</option>
									<option value="6">5부</option>
									<option value="7">6부</option>
									<option value="8">7부</option>
								</c:when>
								<c:when test="${memberGrade == 1 }">
									<option value="0">-- 부수 --</option>
									<option value="1" selected="selected">0부</option>
									<option value="2">1부</option>
									<option value="3">2부</option>
									<option value="4">3부</option>
									<option value="5">4부</option>
									<option value="6">5부</option>
									<option value="7">6부</option>
									<option value="8">7부</option>
								</c:when>
								<c:when test="${memberGrade == 2 }">
									<option value="0">-- 부수 --</option>
									<option value="1">0부</option>
									<option value="2" selected="selected">1부</option>
									<option value="3">2부</option>
									<option value="4">3부</option>
									<option value="5">4부</option>
									<option value="6">5부</option>
									<option value="7">6부</option>
									<option value="8">7부</option>
								</c:when>
								<c:when test="${memberGrade == 3 }">
									<option value="0">-- 부수 --</option>
									<option value="1">0부</option>
									<option value="2">1부</option>
									<option value="3" selected="selected">2부</option>
									<option value="4">3부</option>
									<option value="5">4부</option>
									<option value="6">5부</option>
									<option value="7">6부</option>
									<option value="8">7부</option>
								</c:when>
								<c:when test="${memberGrade == 4 }">
									<option value="0">-- 부수 --</option>
									<option value="1">0부</option>
									<option value="2">1부</option>
									<option value="3">2부</option>
									<option value="4" selected="selected">3부</option>
									<option value="5">4부</option>
									<option value="6">5부</option>
									<option value="7">6부</option>
									<option value="8">7부</option>
								</c:when>
								<c:when test="${memberGrade == 5 }">
									<option value="0">-- 부수 --</option>
									<option value="1">0부</option>
									<option value="2">1부</option>
									<option value="3">2부</option>
									<option value="4">3부</option>
									<option value="5" selected="selected">4부</option>
									<option value="6">5부</option>
									<option value="7">6부</option>
									<option value="8">7부</option>
								</c:when>
								<c:when test="${memberGrade == 6 }">
									<option value="0">-- 부수 --</option>
									<option value="1">0부</option>
									<option value="2">1부</option>
									<option value="3">2부</option>
									<option value="4">3부</option>
									<option value="5">4부</option>
									<option value="6" selected="selected">5부</option>
									<option value="7">6부</option>
									<option value="8">7부</option>
								</c:when>
								<c:when test="${memberGrade == 7 }">
									<option value="0">-- 부수 --</option>
									<option value="1">0부</option>
									<option value="2">1부</option>
									<option value="3">2부</option>
									<option value="4">3부</option>
									<option value="5">4부</option>
									<option value="6">5부</option>
									<option value="7" selected="selected">6부</option>
									<option value="8">7부</option>
								</c:when>
								<c:when test="${memberGrade == 8 }">
									<option value="0">-- 부수 --</option>
									<option value="1">0부</option>
									<option value="2">1부</option>
									<option value="3">2부</option>
									<option value="4">3부</option>
									<option value="5">4부</option>
									<option value="6">5부</option>
									<option value="7">6부</option>
									<option value="8" selected="selected">7부</option>
								</c:when>
								<c:otherwise>
									<option value="0" selected="selected">-- 부수 --</option>
									<option value="1">0부</option>
									<option value="2">1부</option>
									<option value="3">2부</option>
									<option value="4">3부</option>
									<option value="5">4부</option>
									<option value="6">5부</option>
									<option value="7">6부</option>
									<option value="8">7부</option>
								</c:otherwise>
							</c:choose>
						</select>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">회원 등록일: </td>
					<td align="center" colspan="4">
						<input type="date" style="width: 380px;" id="userRegDay" name="userRegDay" value="${memberRegDay }">
					</td>
				</tr>
				<tr>
					<td width="100" align="center">비고: </td>
					<td align="center" colspan="4">
						<textarea id="userNote" style="width: 380px;" name="userNote">${memberNote }</textarea>
					</td>
				</tr>
				<tr>
					<td align="center" colspan="5">
						<p>수정할 정보를 입력하세요.</p>
					</td>
				</tr>
				<tr>
					<td colspan="5" align="center">
						<input type="text" id="updateName" name="updateName" value="">
						<input type="text" id="updateSex" name="updateSex" value="">
						<input type="text" id="updateTel" name="updateTel" value="">
						<input type="text" id="updateAge" name="updateAge" value="">
						<input type="text" id="updateBday" name="updateBday" value="">
						<input type="text" id="updateAddr" name="updateAddr" value="">
						<input type="text" id="updateEmail" name="updateEmail" value="">
						<input type="text" id="updateStyle" name="updateStyle" value="">
						<input type="text" id="updateGrade" name="updateGrade" value="">
						<input type="text" id="updateRegDay" name="updateRegDay" value="">
						<input type="text" id="updateNote" name="updateNote" value="">
					
						<input type="button" class="dialogBtn" id="enterBtn" value="등록">
						<input type="button" class="dialogBtn" onclick="javascript:history.back()" value="취소">
					</td>
				</tr>
			</table>		
		</div>
		</form>
	</div>
</body>
</html>