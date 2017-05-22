<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/FrameLayout.css" rel="stylesheet" type="text/css">
<link href="resources/css/TabMenu.css" rel="stylesheet" type="text/css">
<link href="resources/css/MainMemberTable.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
	var $menuEle = $('dt'); // 탭메뉴를 변수에 지정
	$menuEle.click(function() { // 탭메뉴 클릭 이벤트
	   $('dd').addClass('hidden');
	   $(this).next().removeClass('hidden');
	});
	
	$(function () {
    // divBodyScroll의 스크롤이 동작할때에 함수를 불러옵니다.
    	$('#divBodyScroll').scroll(function () {
        // divBodyScroll의 x좌표가 움직인 거리를 가져옵니다.
        var xPoint = $('#divBodyScroll').scrollLeft();

        // 가져온 x좌표를 divHeadScroll에 적용시켜 같이 움직일수 있도록 합니다.
        $('#divHeadScroll').scrollLeft(xPoint);
    	});
	});
</script>
</head>
<body>
	<div class="defaultPage" align="center">
		<div>
			<table border="1" class="outLineTable">
				<tr>
					<td>
						<label>이름:</label>
						<input type="text" style="width: 75px;">
					</td>
					<td>
						<label>성별:</label>
						<select>
							<option value="" selected="selected">-- 전체 --</option>
							<option value="">남</option>
							<option value="">여</option>
						</select>
					</td>
					<td>
						<label>전형:</label>
						<select>
							<option value="" selected="selected">-- 전체 --</option>
							<option value="">펜홀더</option>
							<option value="">쉐이크핸드</option>
							<option value="">중국식 펜홀더</option>
						</select>
					</td>
					<td>
						<label>부수:</label>
						<select>
							<option value="" selected="selected">-- 전체 --</option>
							<option value="">0부</option>
							<option value="">1부</option>
							<option value="">2부</option>
							<option value="">3부</option>
							<option value="">4부</option>
							<option value="">5부</option>
							<option value="">6부</option>
							<option value="">7부</option>
						</select>
					</td>
					<td>
						<input type="button" value="검">
					</td>
				</tr>
				<tr>
					<td>
						<label>권한:</label>
						<select>
							<option value="" selected="selected">-- 전체 --</option>
							<option value="">마스터</option>
							<option value="">관리자</option>
							<option value="">코치</option>
							<option value="">일반</option>
						</select>
					</td>
					<td colspan="3">
						<label>기간:</label>
						<input type="date"> - <input type="date">
					</td>
					<td>
						<input type="button" value="검">
					</td>
				</tr>
				<tr class="dataSheet" height="300">
					<td colspan="5">
						<div class="tab-wrap">
						    <ul>
						        <li><a href="#tab1">tab1</a></li>
						        <li><a href="#tab2">tab2</a></li>
						    </ul>
					        <article id="tab1">
					        	<h1>전체 회원 정보</h1>
					        	<div id="divHeadScroll">
						            <table id="tblHead" border="0" style="text-align: center;">
										<colgroup>
											<col style="width:55px;"/>
											<col style="width:30px;"/>
											<col style="width:100px;"/>
											<col style="width:30px;"/>
											<col style="width:100px;"/>
											<col style="width:30px;"/>
											<col style="width:300px;"/>
											<col style="width:140px;"/>
											<col style="width:100px;"/>
											<col style="width:100px;"/>
											<col style="width:110px;"/>
											<col style="width:17px;"/>
										</colgroup>
										<tr>
											<td>이름</td>
											<td>성별</td>
											<td>연락처</td>
											<td>나이</td>
											<td>전형</td>
											<td>부수</td>
											<td>주소</td>
											<td>이메일</td>
											<td>생일</td>
											<td>등록일</td>
											<td>비고</td>
											<td></td>
										</tr>
									</table>
								</div>
								<div id="divBodyScroll">
									<table id="tblBody" border="1" style="text-align: center;">
										<colgroup>
					                        <col style="width:55px;" class="right_border" />
					                        <col style="width:30px;" class="right_border" />
					                        <col style="width:100px;" class="right_border" />
					                        <col style="width:30px;" class="right_border" />
					                        <col style="width:100px;" class="right_border" />
					                        <col style="width:30px;" class="right_border" />
					                        <col style="width:300px;" class="right_border" />
					                        <col style="width:140px;" class="right_border" />
					                        <col style="width:100px;" class="right_border" />
					                        <col style="width:100px; "class="right_border" />
					                        <col style="width:110px;" class="right_border" />
					                    </colgroup>
										<c:forEach var="TMList" items="${ defaultTMList }">
											<tr>
												<td>${ TMList.name }</td>
												<c:choose>
													<c:when test="${ TMList.sex eq 0}">
														<td>남</td>
													</c:when>
													<c:otherwise>
														<td>여</td>
													</c:otherwise>
												</c:choose>
												<td>${ TMList.tel }</td>
												<c:choose>
													<c:when test="${ TMList.age eq 00 || TMList.age eq 0}">
														<td></td>
													</c:when>
													<c:otherwise>
														<td>${ TMList.age }</td>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${ TMList.style eq 0}">
														<td></td>
													</c:when>
													<c:when test="${ TMList.style eq 1}">
														<td>펜홀더</td>
													</c:when>
													<c:when test="${ TMList.style eq 2}">
														<td>쉐이크핸드</td>
													</c:when>
													<c:otherwise>
														<td>중국식 펜홀더</td>
													</c:otherwise>
												</c:choose>
												<td>${ TMList.grade }</td>
												<td>${ TMList.addr }</td>
												<td>${ TMList.email }</td>
												<td>${ TMList.birthday }</td>
												<td>${ TMList.registerday }</td>
												<td>${ TMList.note }</td>
											</tr>
										</c:forEach>
									</table>
								</div>
					        </article>
					        <!-- <article id="tab2">
					            <h1>월 회원 정보</h1>
					            <table border="1" height="265" width="100%" cellpadding="0" cellspacing="0" style="text-align: center; overflow: auto;">
									<tr>
										<td width="100">유형</td>
										<td width="140">금액</td>
										<td width="140">지불일</td>
										<td width="100">이름</td>
										<td width="140">비고</td>
									</tr>
									<tr>
										<td>월 회원</td>
										<td>3000</td>
										<td>2017-03-33</td>
										<td>회원</td>
										<td>김영기 회원님</td>
									</tr>
								</table>
					        </article> -->
						</div>
					</td>
				</tr>
				<tr class="situationSheet">
					<td colspan="5">
						<input type="text" style="width: 575px; background-color: #606060;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td colspan="5">
						<input type="button" value="회원 추가">
						<input type="button" value="회원정보 수정">
						<input type="button" value="회원정보 삭제">
					</td>
				</tr>
				<tr>
					<td colspan="5">
						<input type="button" value="월 회원 수정">
						<input type="button" value="월 회원 삭제">
					</td>
				</tr>
				<tr>
					<td colspan="5">
						<input type="button" value="코치 추가">
						<input type="button" value="코치 수정">
						<input type="button" value="코치 삭제">
					</td>
				</tr>					
			</table>
		</div>
	</div>
</body>
</html>