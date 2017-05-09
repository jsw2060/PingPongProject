<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/FrameLayout.css" rel="stylesheet" type="text/css">
<style type="text/css">
	.trackNum{
		margin: 0;
		font-weight: bold;
	}
	.trackName{
		margin: 0;
		font-weight: bold;
	}
	.bootrack{
		background-color: #E6B34D;
	}
</style>
</head>
<body>
	<div class="defaultPage" align="center">
		<table border="1" class="outLineTable">
			<c:forEach var="i" begin="1" end="36" step="1">
				<c:if test="${i%6 == 1}">
					<tr>
				</c:if>
					<td class="bootrack">
						<p class="trackNum">${i}</p>
						<p class="trackName">정성원</p>
						<button type="button" class="trackBtn">o</button>
					</td>
				<c:if test="${i%6 == 0}">		
					</tr>
				</c:if>
			</c:forEach>
		</table>
	</div>
</body>
</html>