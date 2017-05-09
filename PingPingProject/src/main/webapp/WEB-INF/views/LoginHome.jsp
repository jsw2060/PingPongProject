<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>황남숙 탁구교실 통합관리 프로그램</title>

<link rel="shortcut icon" href="resources/images/mainMark.png">
<link href="resources/css/LoginHome.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		$('#logBtn').click(function() {

			var id = $('#id').val();
			var pwd = $('#pwd').val();
			if (id.trim() == "") {
				$('#id').focus();
				$('#errorMsg').html("ID를 입력해주세요.");
				return;
			}
			
			if (pwd.trim() == "") {
				$('#pwd').focus();
				$('#errorMsg').html("패스워드를 입력해주세요.");
				return;
			}
			
			$('#logForm').submit();
			
		});
	});
</script>
</head>
<body>
	<div class="container">
		<div class="row login_box">
			<div class="col-md-12 col-xs-12" align="center">
				<h1>황남숙 탁구교실<br/>
		    		통합관리 프로그램</h1>
	            <div class="outter"><img class="image-main-mark" src="resources/images/mainMark.png"/></div>
		    </div>
	        
	        <div class="col-md-12 col-xs-12 login_control">
	        	<form action="Login.do" method="post" id="logForm">
	                <div class="control" align="center">
	                	<img class="icon" alt="idIcon" src="resources/light/appbar.people.png">
	                    <input type="text" class="form-control" placeholder="아이디를 입력하세요." id="id" name="id"/>
	                </div>
	                <div class="control" align="center">
	                    <img class="icon" alt="pwIcon" src="resources/light/appbar.lock.png">
	                	<input type="password" class="form-control" placeholder="비밀번호를 입력하세요." id="pwd" name="pwd"/>
	                </div>
	                <div align="center">
	                	<button type="button" class="btn btn-orange" id="logBtn">로그인</button>
	                	<button type="button" class="btn btn-orange" onclick="location.href='AccountCreateDialog.do'">회원 가입</button>
	                </div>
	            </form>
	            <div align="center">
                	<br>
               		<span id="errorMsg">${ errorMsg }</span>
        		</div>
	        </div>
	    </div>  
	</div>
</body>
</html>