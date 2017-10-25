<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/FrameLayout.css" rel="stylesheet" type="text/css">
<link href="resources/css/TabMenu2.css" rel="stylesheet" type="text/css">
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
		width: 70px;
		height: 87px;
	}
	.trackBtn{
		width: 23px;
		height: 23px;
	}
</style>
<script type="text/javascript">
	var $menuEle = $('dt'); // 탭메뉴를 변수에 지정
	$menuEle.click(function() { // 탭메뉴 클릭 이벤트
	   $('dd').addClass('hidden');
	   $(this).next().removeClass('hidden');
	})
</script>
</head>
<body>
	<div class="defaultPage" align="center">
		<table border="1" class="outLineTable">	
			<tr>
				<td style="vertical-align: top;">
					<div class="tab-wrap">
				    <ul>
				        <li><a href="#tab1">tab1</a></li>
				        <li><a href="#tab2">tab2</a></li>
				        <li><a href="#tab3">tab3</a></li>
				    </ul>
				    <c:forEach var="i" begin="1" end="120" step="1">
				    	<c:if test="${ (i - 1) % 40 eq 0 }">
				    		<c:choose>
				    			<c:when test="${(i - 1) / 40 + 1 eq 1 }">
				    				<article id="tab1">
				    				<h1>사물함 A 구역</h1>
				    			</c:when>
				    			<c:when test="${(i - 1) / 40 + 1 eq 2 }">
				    				<article id="tab2">
				    				<h1>사물함 B 구역</h1>
				    			</c:when>
				    			<c:when test="${(i - 1) / 40 + 1 eq 3}">
				    				<article id="tab3">
				    				<h1>사물함 C 구역</h1>
				    			</c:when>
				    		</c:choose>
					        <table border="1">
				    	</c:if>
				    	<c:if test="${ i%8 == 1 }">
									<tr>
						</c:if>
										<td class="bootrack">
											<p class="trackNum">${i}</p>
											<p class="trackName">정성원</p>
											<button type="button" class="trackBtn">o</button>
										</td>
						<c:if test="${ i%8 == 0 }">		
									</tr>
						</c:if>
						<c:if test="${ i%40 == 0 }">
								</table>
					        </article>
						</c:if>
				    </c:forEach>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>