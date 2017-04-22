<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="http://lorempixel.com/output/people-q-c-100-100-1.jpg">
<link href="resources/css/MainHomeFrame.css" rel="stylesheet" type="text/css">
<title>황남숙 탁구교실 통합관리 프로그램</title>

</head>
<body >
<div>
	<div class="mainHomeButtonsPane">
		<jsp:include page="${ MainHomeButtonsPane }.jsp" flush="false"/>
	</div>
	<div class="mainHomeView">
		<jsp:include page="${ view }.jsp" flush="false"/>
	</div>
</div>

</body>
</html>