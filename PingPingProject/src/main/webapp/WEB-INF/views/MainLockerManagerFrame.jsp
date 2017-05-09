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
	}
</style>
<script type="text/javascript">
	var $menuEle = $('dt'); // 탭메뉴를 변수에 지정
	$menuEle. click(function() { // 탭메뉴 클릭 이벤트
	   $('dd').addClass('hidden');
	   $(this).next().removeClass('hidden');
	})
</script>
</head>
<body>
	<div class="defaultPage" align="center">
		<table border="1" class="outLineTable">	
			<tr>
				<td>
					<div class="tab-wrap">
				    <ul>
				        <li><a href="#tab1">tab1</a></li>
				        <li><a href="#tab2">tab2</a></li>
				        <li><a href="#tab3">tab3</a></li>
				    </ul>
			        <article id="tab1">
			        	<h1>사물함 A 구역</h1>
			            <table border="1">
							<c:forEach var="i" begin="1" end="40" step="1">
								<c:if test="${i%8 == 1}">
									<tr>
								</c:if>
									<td class="bootrack">
										<p class="trackNum">${i}</p>
										<p class="trackName">정성원</p>
										<button type="button" class="trackBtn">o</button>
									</td>
								<c:if test="${i%8 == 0}">		
									</tr>
								</c:if>
							</c:forEach>
						</table>
			        </article>
			        <article id="tab2">
			        	<h1>사물함 B 구역</h1>
			            <table border="1">
							<c:forEach var="i" begin="1" end="40" step="1">
								<c:if test="${i%8 == 1}">
									<tr>
								</c:if>
									<td class="bootrack">
										<p class="trackNum">${i}</p>
										<p class="trackName">정성원</p>
										<button type="button" class="trackBtn">o</button>
									</td>
								<c:if test="${i%8 == 0}">		
									</tr>
								</c:if>
							</c:forEach>
						</table>
			        </article>
			        <article id="tab3">
			        	<h1>사물함 C 구역</h1>
			            <table border="1">
							<c:forEach var="i" begin="1" end="40" step="1">
								<c:if test="${i%8 == 1}">
									<tr>
								</c:if>
									<td class="bootrack">
										<p class="trackNum">${i}</p>
										<p class="trackName">정성원</p>
										<button type="button" class="trackBtn">o</button>
									</td>
								<c:if test="${i%8 == 0}">		
									</tr>
								</c:if>
							</c:forEach>
						</table>
			        </article>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>