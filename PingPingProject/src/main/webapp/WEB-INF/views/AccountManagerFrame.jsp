<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/FrameLayout.css" rel="stylesheet" type="text/css">
<style type="text/css">
	.menu1{
		list-style:none;
	}
	.menu2{
		list-style:none;
	}
	.menu a{
		cursor: pointer;
	}
	.menu .hide{
		display:none;
		margin-top: 10px;
		margin-bottom: 10px;
		height: 370px;
	}
	.innerMenu{
		margin: 0 0 0 0;
		border-bottom: 1.5px solid gray;
		border-top: 1.5px solid gray;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		var submenu1 = $(".menu1>a").next(".hide1").slideDown();
		var submenu2 = $(".menu2>a").next(".hide2").slideUp();
		
		$(".menu1>a").click(function(){
			if(submenu2.is(":visible")){
				submenu2.slideUp();
				submenu1.slideDown();
			} else {
				submenu1.slideDown();
			}
		});
		$(".menu2>a").click(function(){
			if(submenu1.is(":visible")){
				submenu1.slideUp();
				submenu2.slideDown();
			} else {
				submenu2.slideDown();
			}
		});
		$(".selectedData").click(function(){
			alert("클릭");
			var selectedCode = $(".selectedRow").val();
			alert(selectedCode);
			$("#accountUpdateBtn").click(function(){
				
			});
		});
	});
</script>
</head>
<body>
	<div class="defaultPage">
		<form action="AccountUpdate.do">
		<table class="outLineTable" border="1px;" align="center">
			<tr>
				<td colspan="4" height="460">
					<ul style="margin-top: 0px; padding-left: 0px; border: 1px solid gray; background-color: #E1E1E1;">
						<li class="menu1"><a><p class="innerMenu">승인대기 목록</p></a>
							<table class="hide1" border="1" cellpadding="0" cellspacing="0" align="center">
								<tr class="tableHead">
									<td rowspan="2" width="150">ID</td>
									<td colspan="2" width="150">신청여부</td>
									<td rowspan="2" width="150">신청일</td>
									<td colspan="2" width="150">승인선택</td>
								</tr>
								<tr class="tableHead">
									<td>관리자</td>
									<td>코치</td>
									<td>승인</td>
									<td>거부</td>
								</tr>
								<c:forEach var="result" items="${ confirmList }">
								<tr class="confirmData" style="background-color: #F5F5F5;">
									<td>${ result.id }<input type="hidden" id="applier_code" name="applier_code" value="${ result.member_code }"/></td>
									<c:choose>
										<c:when test="${ result.manager_status eq 2}">
											<td>Y</td>
										</c:when>
										<c:otherwise>
											<td>N</td>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${ result.coach_status eq 2}">
											<td>Y</td>
										</c:when>
										<c:otherwise>
											<td>N</td>
										</c:otherwise>
									</c:choose>
									<td>${ result.registerday }</td>
									<td><a href="AuthorizationConfirm.do?id=${ result.id }&member_code=${ result.member_code }&manager_status=${ result.manager_status }&coach_status=${ result.coach_status }&agreeBtn=1">승</a></td>
									<td><a href="AuthorizationConfirm.do?id=${ result.id }&member_code=${ result.member_code }&manager_status=${ result.manager_status }&coach_status=${ result.coach_status }&agreeBtn=0">거</a></td>
								</tr>
								</c:forEach>
							</table>
						</li>
						<li class="menu2"><a><p class="innerMenu">계정 목록</p></a>
							<table class="hide2" border="1" cellpadding="0" cellspacing="0" align="center">
								<tr class="tableHead">
									<td rowspan="2" width="120">ID</td>
									<td colspan="2" width="120">권한여부</td>
									<td rowspan="2" width="60">이름</td>
									<td rowspan="2" width="60">성별</td>
									<td rowspan="2" width="120">연락처</td>
									<td rowspan="2" width="120">가입일</td>
								</tr>
								<tr class="tableHead">
									<td>관리자</td>
									<td>코치</td>
								</tr>
								<c:forEach var="members" items="${ memberList }">
									<tr class="selectedData" style="background-color: #F5F5F5;">
										<td>${ members.id }<input type="text" class="selectedRow" value="${ members.member_code }"></td>
										<c:choose>
											<c:when test="${ members.manager_status eq 1 }">
												<td>Y</td>
											</c:when>
											<c:otherwise>
												<td>N</td>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${ members.coach_status eq 1 }">
												<td>Y</td>
											</c:when>
											<c:otherwise>
												<td>N</td>
											</c:otherwise>
										</c:choose>
										<td>${ members.name }</td>
										<c:choose>
											<c:when test="${ members.sex eq 0}">
												<td>남</td>
											</c:when>
											<c:otherwise>
												<td>여</td>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${ members.tel eq 0}">
												<td></td>
											</c:when>
											<c:otherwise>
												<td>${ members.tel }</td>
											</c:otherwise>
										</c:choose>
										<td>${ members.registerday }</td>
									</tr>
								</c:forEach>
							</table>
						</li>
					</ul>
				</td>
			</tr>
			<tr>
				<td><input type="text"></td>
				<td><input type="button" id="accountUpdateBtn" value="계정 수정"></td>
				<td><input type="button" id="accountDeleteBtn" value="계정 삭제"></td>
			</tr>
		</table>
		</form>
	</div>
</body>
</html>