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
			<c:forEach var="bootrackItems" items="${ bootrackList }">
				<c:if test="${bootrackItems.bootrack_code%6 == 1}">
					<tr>
				</c:if>
					<td class="bootrack">
						<p class="trackNum">${bootrackItems.bootrack_code}</p>
						<c:choose>
							<c:when test="${bootrackItems.bootrack_status ne 'E'}">
								<p class="trackName">${bootrackItems.name}</p>
							</c:when>
							<c:otherwise>
								<p class="trackName">미사용</p>
							</c:otherwise>
						</c:choose>
						<button type="button" class="trackBtn">o</button>
					</td>
				<c:if test="${bootrackItems.bootrack_code%6 == 0}">		
					</tr>
				</c:if>
			</c:forEach>
		</table>
	</div>
</body>
</html>