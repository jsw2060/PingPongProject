<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/MainHomeButtonsPane.css" rel="stylesheet" type="text/css">

<script type="text/javascript" >
function beforeUnloadHandler(){
       return 'message' ;
}
$(window).bind('beforeunload', beforeUnloadHandler);
</script>

</head>
<body>
	<ul class="menuList">
		<li class="menuLi"><a href="MainHomeMenuList"><img class="layout_img" alt="menu" src="resources/light/appbar.lines.horizontal.4.png"></a></li>
		<li class="menuLi"><a href="MainHomeFrame"><img class="layout_img" alt="menu" src="resources/light/appbar.home.png"></a></li>
		<li class="menuLi"><a><img class="layout_img" alt="menu" src="resources/light/appbar.lock.png"></a></li>
		<li class="menuLi"><a><img class="layout_img" alt="menu" src="resources/light/appbar.layout.collapse.right.variant.png"></a></li>
		<li class="menuLi">
			<div class="mainHomeInfo">
			<a onclick="return false;">admin(최유성)님
			<br/>환영합니다.[관리자계정]</a>
			</div>
		</li>
		<li class="menuLi">
			<div class="mainHomeTitle">
			<a onclick="return false;"><%=request.getParameter("MainHomeTitle") %></a>
			</div>
		</li>
		<li class="menuLi"><img class="layout_img" alt="menu" src="resources/light/appbar.information.circle.png"></li>
	</ul>
</body>
</html>