<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link href="resources/css/MainFeeManagerFrame.css" rel="stylesheet" type="text/css"> -->
<link href="resources/css/FrameLayout.css" rel="stylesheet" type="text/css">
<link href="resources/css/TabMenu.css" rel="stylesheet" type="text/css">
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
		<div>
			<table border="1" class="outLineTable">
				<tr>
					<td>
						<label>이름:</label>
						<input type="text" style="width: 75px;"">
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
					            <table border="1" height="265" width="100%" cellpadding="0" cellspacing="0" style="text-align: center; overflow: auto;">
									<tr>
										<td width="100">유형</td>
										<td width="140">금액</td>
										<td width="140">지불일</td>
										<td width="100">이름</td>
										<td width="140">비고</td>
									</tr>
									<tr>
										<td>일 회원</td>
										<td>7000</td>
										<td>2017-02-18</td>
										<td>회원</td>
										<td>김영기 회원님</td>
									</tr>
								</table>
					        </article>
					        <article id="tab2">
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
					        </article>
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