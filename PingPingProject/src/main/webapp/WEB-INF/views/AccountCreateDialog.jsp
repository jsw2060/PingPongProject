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
	$(function() {
		$('#pwd').keyup(function() {
			$('font[name=check]').text('');
			if($('#pwd').val() == "" || $('#rePwd').val() == ""){
				$('p[name=check]').text('');
				$('p[name=check]').html("수정할 정보를 입력해 주세요.");
			} else{
				if($('#pwd').val() != $('#rePwd').val()){
					$('p[name=check]').text('');
					$('p[name=check]').html("암호틀림");
				} else{
					$('p[name=check]').text('');
					$('p[name=check]').html("암호맞음");
				}	
			}
		});
		
		$('#rePwd').keyup(function() {
			if($('#pwd').val() == "" || $('#rePwd').val() == ""){
				$('p[name=check]').text('');
				$('p[name=check]').html("수정할 정보를 입력해 주세요.");
			} else{
				if($('#pwd').val() != $('#rePwd').val()){
					$('p[name=check]').text('');
					$('p[name=check]').html("암호틀림");
				} else{
					$('p[name=check]').text('');
					$('p[name=check]').html("암호맞음");
				}	
			}
		});
		
		$('#joinBtn').click(function() {
			
			var id = $('#id').val();
			var pwd = $('#pwd').val();
			alert(id);
			alert(pwd);
			if (id.trim() == "") {
				$('#id').focus();
				$('p[name=check]').html("ID를 입력해주세요.");
				return;
			}
			
			if (pwd.trim() == "") {
				$('#pwd').focus();
				$('p[name=check]').html("패스워드를 입력해주세요.");
				return;
			}
			
			$('#joinForm').attr('action', 'AccountCreate.do');
			$('#joinForm').submit();
		});
		
		$('#findMember').click(function() {
			var memberName = $('#memberName').val();
			if (memberName.trim() == "") {
				$('#memberName').focus();
				$('p[name=check]').html("회원이름을 입력해주세요.");
				return;
			}
			
			$('#joinForm').attr('action', 'FindMember.do');
			$('#joinForm').submit();
		});
		
		$(document).ready(function(){
			$("#memberData").attr('onclick', '').click();
		});
	});
</script>
</head>
<body>
	<div class="mainFrame" align="center">
		<div>
			<h1 class="dialogTitle">계정 등록 신청</h1>
		</div>
		<form id="joinForm" action="AccountCreate.do" method="get">
			<div>
				<table border="1">
					<tr>
						<td><label class="editLabel">*ID:</label></td>
						<td colspan="2" width="250" align="right"><input class="editInput" type="text" id="id" name="id"></td>
					</tr>
					<tr>
						<td><label class="editLabel">*PW:</label></td>
						<td colspan="2" width="250" align="right"><input class="editInput" type="password" id="pwd" name="pwd"></td>
					</tr>
					<tr>
						<td><label class="editLabel">*PW 재입력:</label></td>
						<td colspan="2" width="250" align="right"><input class="editInput" type="password" id="rePwd" name="rePwd"></td>
					</tr>
					<tr>
						<td class="checkText" colspan="3" style="text-align: center;">
							<input class="checkInput" type="checkbox" value="2" id="manager" name="manager">관리자 권한
							<input class="checkInput" type="checkbox" value="2" id="coach" name="coach">코치 권한
						</td>
					</tr>
					<tr align="center">
						<td>
							<label class="editLabel">회원:</label>
						</td>
						<td>
							<input type="text" id="memberName" name="memberName">
						</td>
						<td>
							<button type="button" style="border-bottom-style: hidden;" id="findMember"><img class="buttonImg" alt="검색버튼" src="resources/Collection/Find User Male_3.png"></button>
							<button type="button" style="border-bottom-style: hidden;"><img class="buttonImg" alt="추가버튼" src="resources/Collection/Add User Male_2.png"></button>
						</td>
					</tr>
				</table>
			</div>
			<br/>
			<div>
				<table id="memberDataForm" border="1" width="360">
					<tr class="textHead">
						<td rowspan="2" width="70">이름</td>
						<td rowspan="2" width="45">성별</td>
						<td rowspan="2" width="80">등록일</td>
						<td colspan="2" width="auto">권한</td>
					</tr>
					<tr class="textHead">
						<td>관리자</td>
						<td>코치</td>
					</tr>
					<c:forEach var="result" items="${ memberResult }">
						<tr id="memberData">
							<td>${ result.name }</td>
							<td>${ result.sex }</td>
							<td>${ result.registerday }</td>
							<c:choose>
								<c:when test="${ result.manager_status eq 1}">
									<td>Y</td>	
								</c:when>
								<c:otherwise>
									<td>N</td>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${ result.coach_status eq 1}">
									<td>Y</td>
								</c:when>
								<c:otherwise>
									<td>N</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div style="width: 360;">
				<p name="check" style="color: red">수정할 정보를 입력해 주세요.</p>
			</div>
			<div>
				<input type="button" class="dialogBtn" id="joinBtn" value="등록">
				<input type="button" class="dialogBtn" onclick="javascript:history.back()" value="취소">
			</div>
		</form>
	</div>
</body>
</html>