<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/FrameLayout.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
	$(function () {
		// memberType selection
		$("#searchMember").on("change", function() {
			
			var that = $(this);
			console.log("that.val", that.val());

			switch(that.val()) {
			
			case '0':
				$("#normal").removeAttr('selected');
				$("#dayMember").removeAttr('selected');
				$("#monthMember").removeAttr('selected');
				$("#notUse").attr('selected', true);

				break;
			case '1':
				$("#notUse").removeAttr('selected');
				$("#monthMember").removeAttr('selected');
				$("#dayMember").removeAttr('selected');
				$("#normal").attr('selected', true);
				
				document.getElementById("searchingMember").value = "일반";
				break;
			case '2':
				$("#notUse").removeAttr('selected');
				$("#normal").removeAttr('selected');
				$("#monthMember").removeAttr('selected');
				$("#dayMember").attr('selected', true);
				
				document.getElementById("searchingMember").value = "일회원";
				break;
			case '3':
				$("#notUse").removeAttr('selected');
				$("#normal").removeAttr('selected');
				$("#dayMember").removeAttr('selected');
				$("#monthMember").attr('selected', true);
				
				document.getElementById("searchingMember").value = "월회원";
				break;
			default: 
				alert("check logic!!");
				break;	
			}
		});
		
		$("#startDate").on("change", function() {
			$("#searchingStart").attr('value', $(this).val());
		});
		
		$("#endDate").on("change", function() {
			$("#searchingEnd").attr('value', $(this).val());
		});
		
		$("#searchBtn").on("click", function() {
			$("#FeeSearchForm").submit();	
		});
		
		// table selection
		$("#tblBody tr").click(function () {
			alert("클릭 ");
			var tdArr = new Array();
			
			// get each td from seleted row
			var selectedTr = $(this);
			var selectedTd = selectedTr.children();

			console.log("??  ", selectedTd);
			
			selectedTd.each(function(i) {
				tdArr.push(selectedTd.eq(i).text());
			});
			console.log("배열에 담긴 값 : "+tdArr);
			
			// store temporary info in each hidden input
			var feeMembType = selectedTd.eq(0).text();
			var feeAmount = selectedTd.eq(1).text();
			var feeDate = selectedTd.eq(2).text();
			var feeName = selectedTd.eq(3).text();
			var feeCode = selectedTd.eq(3).children().eq(0).val();
			var feeNote = selectedTd.eq(4).text();
			
			console.log("feeMembType ", feeMembType);
			console.log("feeAmount ", feeAmount);
			console.log("feeDate ", feeDate);
			console.log("feeName ", feeName);
			console.log("feeFeeCode ", feeCode);
			console.log("feeNote ", feeNote);
			
			document.getElementById("selectMembType").value = feeMembType;
			document.getElementById("selectAmount").value = feeAmount;
			document.getElementById("selectDate").value = feeDate;
			document.getElementById("selectName").value = feeName;
			document.getElementById("selectFeeCode").value = feeCode;
			document.getElementById("selectNote").value = feeNote;
		});
		
		$("#feeUpdateBtn").on("click", function() {
			$("#FeeSearchForm").attr("action", "FeeEditDialog.do").submit();
		});
	});
	
</script>
</head>
<body>
	<form id="FeeSearchForm" action="singleFeeSearch.do">
		<div class="defaultPage">
			<div>
				<table border="1" class="outLineTable" align="center">
					<tr>
						<td width="370">
							<label>기간:</label>
							<input type="date" id="startDate"> - <input type="date" id="endDate">
						</td>
						<td width="140">
							<label>유형:</label>
							<select id="searchMember">
								<option id="notUse" value="0" selected="selected">-- 전체 --</option>
								<option id="normal" value="1">일반</option>
								<option id="dayMember" value="2">일회원</option>
								<option id="monthMember" value="3">월회원</option>
							</select>
						</td>
						<td colspan="2">
							<button type="button" style="border-bottom-style: hidden;" id="searchBtn">
								<img style="width: 25px;" alt="검색버튼" src="resources/Collection/Single Browse.png">
							</button>
						</td>
					</tr>
					<tr height="365">
						<td colspan="4">
							<table class="dataSheet" id="tblBody" width="100%" height="360" border="1" style="overflow: auto;">
								<tr height="25px">
									<td>유형</td>
									<td>금액</td>
									<td>지불일</td>
									<td>이름</td>
									<td>비고</td>
								</tr>
								<c:forEach var="fees" items="${feeList }">
									<tr height="25px">
										<td>${fees.fee_type }</td>
										<td>${fees.fee_amount }</td>
										<td>${fees.fee_date }</td>
										<td>${fees.name }<input type="hidden" value="${fees.fee_code }"></td>
										<td>${fees.note }</td>
									</tr>
								</c:forEach>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<table>
								<!-- <tr class="situationSheet">
									<td colspan="4">
										<input type="text" style="width: 575px; background-color: #606060;" readonly="readonly">
									</td>
								</tr> -->
								<tr>
									<td>
										<label>통계:</label>
										<input type="text" style="width: 50px;" placeholder="yyyy">년
										<input type="text" style="width: 30px;" placeholder="MM">월
									</td>
									<td>
										<label>유형:</label>
										<select>
											<option value="" selected="selected">-- 전체 --</option>
											<option></option>
											<option></option>
										</select>
									</td>
									<td>
										<input type="radio" value="일 통계">일 통계
										<input type="radio" value="월 통계">월 통계
									</td>
									<td>
										<input type="button" value="차트">
									</td>
								</tr>
								<tr>
									<td colspan="4">
										<input type="button" id="feeUpdateBtn" value="요금정보 수정">
										<input type="button" id="feeDeleteBtn" value="요금정보 삭제">
									</td>
								</tr>
							</table>
						</td>
					<tr>
				</table>
			</div>
		</div>
		<!-- 검색 데이터 -->
		<input type="hidden" id="searchingMember" name="searchingMember" value="">
		<input type="hidden" id="searchingStart" name="searchingStart" value="">
		<input type="hidden" id="searchingEnd" name="searchingEnd" value="">
		
		<!-- 수정 데이터 -->
		<input type="hidden" id="selectMembType" name="selectMembType" value="">
		<input type="hidden" id="selectAmount" name="selectAmount" value="">
		<input type="hidden" id="selectDate" name="selectDate" value="">
		<input type="hidden" id="selectName" name="selectName" value="">
		<input type="hidden" id="selectFeeCode" name="selectFeeCode" value="">
		<input type="hidden" id="selectNote" name="selectNote" value="">
	</form>
</body>
</html>