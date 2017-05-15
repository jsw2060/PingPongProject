<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="resources/images/mainMark.png">
<link href="resources/css/DialogLayout.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		$('#pwd').keyup(function() {
			$('font[name=check]').text('');
			if($('#pwd').val() == "" || $('#rePwd').val() == ""){
				$('p[name=check]').text('');
				$('p[name=check]').html("정보를 입력해 주세요.");
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
		
		$('#id').keyup(function() {
			if($('#id').val() == ""){
				$('p[name=check]').text('');
				$('p[name=check]').html("id를 입력해 주세요.");
			}
		});
		
		$('#userName').keyup(function() {
			if($('#userName').val() == ""){
				$('p[name=check]').text('');
				$('p[name=check]').html("이름을 입력해 주세요.");
			}
		});
		
		$('#userAge').keyup(function() {
			if($('#userAge').val() == ""){
				$('p[name=check]').text('');
				$('p[name=check]').html("나이를 입력해 주세요.");
			}
		});
		
		$('#userTel').keyup(function() {
			if($('#userTel').val() == ""){
				$('p[name=check]').text('');
				$('p[name=check]').html("전화번호를 입력해 주세요.");
			}
		});
		
		$('#userBday').keyup(function() {
			if($('#userBday').val() == ""){
				$('p[name=check]').text('');
				$('p[name=check]').html("생일을 입력해 주세요.");
			}
		});
		
		$('#joinBtn').click(function() {
			
			var id = $('#id').val();
			var pwd = $('#pwd').val();
			var repwd = $('#rePwd').val();
			var name = $('#userName').val();
			var age = $('#userAge').val();
			var sex = $('#userSex').val();
			var tel = $('#userTel').val();
			var bDay = $('#userBday').val();
			
			alert(id);
			alert(pwd);
			if (id.trim() == "") {
				$('#id').focus();
				$('p[name=check]').html("ID를 입력해주세요.");
				return;
			}
			
			else if (pwd.trim() == "") {
				$('#pwd').focus();
				$('p[name=check]').html("패스워드를 입력해주세요.");
				return;
			}
			
			else if (repwd.trim() == "") {
				$('#repwd').focus();
				$('p[name=check]').html("패스워드를 입력해주세요.");
				return;
			}
			
			else if ($('#pwd').val() != $('#rePwd').val()) {
				$('p[name=check]').text('');
				$('p[name=check]').html("암호가 틀립니다.");
				return;	
			}	
			
			else if (name.trim() == "") {
				$('#userName').focus();
				$('p[name=check]').html("이름를 입력해주세요.");
				return;
			}
			
			else if (age.trim() == "") {
				$('#userAge').focus();
				$('p[name=check]').html("나이를 입력해주세요.");
				return;
			}
			
			else if (tel.trim() == "") {
				$('#userTel').focus();
				$('p[name=check]').html("전화번호를 입력해주세요.");
				return;
			}
			
			else if (bDay.trim() == "") {
				$('#userBday').focus();
				$('p[name=check]').html("생일을 입력해주세요.");
				return;
			}
			
			$('#joinForm').attr('action', 'AccountCreate.do');
			$('#joinForm').submit();
		});
	});
</script>
</head>
<body>
	<div align="center">
		<div>
			<h1 class="dialogTitle">계정 등록 신청</h1>
		</div>
		<div>
			<p class="dialogTitle" style="color: red;font-size: 15px;">* 표시는 필수입력 하여야 합니다.</h1>
		</div>
		<form id="joinForm" action="AccountCreate.do" method="get">
			<div>
				<table>
					<tr>
						<td><label class="editLabel">*ID:</label></td>
						<td colspan="2" width="250" align="center"><input class="editInput" type="text" id="id" name="id"></td>
					</tr>
					<tr>
						<td><label class="editLabel">*PW:</label></td>
						<td colspan="2" width="250" align="center"><input class="editInput" type="password" id="pwd" name="pwd"></td>
					</tr>
					<tr>
						<td><label class="editLabel">*PW 재입력:</label></td>
						<td colspan="2" width="250" align="center"><input class="editInput" type="password" id="rePwd" name="rePwd"></td>
					</tr>
					<tr>
						<td><label class="editLabel">권한:</label></td>
						<td class="checkText" colspan="2" style="text-align: center;">
							<input class="checkInput" type="checkbox" value="2" id="manager" name="manager">관리자 권한
							<input class="checkInput" type="checkbox" value="2" id="coach" name="coach">코치 권한
						</td>
					</tr>
					<tr>
						<td><label class="editLabel">*성명:</label></td>
						<td colspan="2" width="250" align="center"><input class="editInput" type="text" id="userName" name="userName"></td>
					</tr>
					<tr>
						<td><label class="editLabel">*나이:</label></td>
						<td colspan="2" width="250" align="center"><input class="editInput" type="password" id="userAge" name="userAge"></td>
					</tr>
					<tr>
						<td><label class="editLabel">*성별:</label></td>
						<td align="center" colspan="2">
							<input type="radio" class="radioInput" id="userSex" name="userSex" value="0">남자
							&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" class="radioInput" id="userSex" name="userSex" value="1">여자
						</td>
					</tr>
					<tr>
						<td><label class="editLabel">*전화번호:</label></td>
						<td colspan="2" width="250" align="center">
							<input class="editInput" type="text" id="userTel" name="userTel" placeholder="예시)01024336500">
						</td>
					</tr>
					<tr>
						<td><label class="editLabel">이메일:</label></td>
						<td colspan="2" width="250" align="center">
							<input style="width: 80px; box-shadow: 3px 3px 5px 1px #A2A2A2;
							margin: 10px 10px 10px 10px;" type="text" id="userEmail1" name="userEmail1">@
							<input style="width: 80px; box-shadow: 3px 3px 5px 1px #A2A2A2;
							margin: 10px 10px 10px 10px;" type="text" id="userEmail2" name="userEmail2">
						</td>
					</tr>
					<tr>
						<td><label class="editLabel">주소:</label></td>
						<td colspan="2" width="250" align="center"><input class="editInput" type="text" id="userAddr" name="userAddr"></td>
					</tr>
					<tr>
						<td><label class="editLabel">*생일:</label></td>
						<td colspan="2" width="250" align="center"><input class="editInput" type="date" id="userBday" name="userBday"></td>
					</tr>
					<tr>
						<td><label class="editLabel">전형:</label></td>
						<td colspan="2" width="250" align="center">
							<select id="userStyle" name="userStyle" style="width: 200px;">
								<option value="0" selected="selected">-- 전형 --</option>
								<option value="1">펜홀더</option>
								<option value="2">쉐이크핸드</option>
								<option value="3">중국식 펜홀더</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><label class="editLabel">부수:</label></td>
						<td colspan="2" width="250" align="center">
							<select id="userGrade" name="userGrade" style="width: 200px;">
								<option value="0" selected="selected">-- 부수 --</option>
								<option value="1">0부</option>
								<option value="2">1부</option>
								<option value="3">2부</option>
								<option value="4">3부</option>
								<option value="5">4부</option>
								<option value="6">5부</option>
								<option value="7">6부</option>
								<option value="8">7부</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><label class="editLabel">비고:</label></td>
						<td colspan="2" width="250" align="center"><input class="editInput" type="textarea" id="userNote" name="userNote"></td>
					</tr>
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