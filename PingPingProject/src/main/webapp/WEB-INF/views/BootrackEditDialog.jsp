<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/DialogLayout.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	$(document).ready(function(){
		/* $("#enterBtn").click(function(){
			console.log("계정 수정");
			$("#AccountEditForm").submit();
		}); */
		
		// Use, notUse selection
		$("#selectBox").on("change", function() {

			var that = $(this);
			
			console.log("that.val", that.val());

			if (that.val() == '0') { // 사용 -> 미사용
				
				$("#use").removeAttr('selected');
				$("#notUse").attr('selected', true);
				
				that.val('0');
				console.log(that.val());
				
				console.log("값 ", $("#searchName").val());
				
				$("#searchName").val("");
				$("#searchName").removeAttr('value');
				console.log("값 ", $("#searchName").val());
				$("#searchName").attr('disabled', true);
				
			} else if (that.val() == '1') { // 미사용 -> 사용
				
				$("#notUse").removeAttr('selected');
				$("#use").attr('selected', true);
				
				that.val('1');
				console.log(that.val());
				
				$("#searchName").removeAttr('disabled', true);
				$("#searchName").attr('value', "");
				
			} else {
				alert('check logic!!');
			}
		});
		
		// member searching
		$("#searchBtn").click(function () {
			
			// 검색 테이블 초기화
			$("#searchResult").children().remove();
			var searchName = $("#searchName").val();
			
			console.log("입력값 " + searchName);
			
			jQuery.ajax({
				type:"GET",
				url:"http://localhost:8080/pingPong/BootrackSearch.do?searchName=" + searchName + "",
				dataType: "JSON",
				success: function(data) {
					console.log("sending success ");
					console.log(data);
					
					var temp = "";
					var obj_length = Object.keys(data).length;
					var sexTemp = "";
					var statusTemp = "";
					
					if(data != null) {
						for(var idx = 0; idx < obj_length; idx++) {
							if(data[idx].SEX == 0) {
								sexTemp = "M";
							} else {
								sexTemp = "W";
							}
							
							if(data[idx].BOOTRACK_STATUS == 0) {
								statusTemp = "X";
							} else {
								statusTemp = "O";
							}
							
							temp = "<td>" + data[idx].MEMBER_CODE + "</td>"
							+ "<td>" + data[idx].NAME + "</td>"
							+ "<td>" + sexTemp + "</td>"
							+ "<td>" + statusTemp + "</td>"
							+ "<td>" + data[idx].BOOTRACK_CODE + "</td>";
						}
					} else {
						temp = "<td colspan='5'>데이터가 없습니다</td>";
					}
					
					console.log("temp ", temp);
					$("#searchResult").append(temp);
					
				},
				error: function(xhr, option, error) {
					console.log("sending fail");
					console.log("오류코드 " + xhr.status);
					console.log(error);
				}
			})
		});
		
		// table selection
		$("#searchResult").click(function() {
			alert("클릭");
			var selectedTr = $(this);
			var selectedTd = selectedTr.children();
			console.log("selectedTd ", selectedTd);
			var indexNum = selectedTd.eq(0).text();
			
			console.log("여기부터 val값");
			console.log(indexNum);
			// store temporary info of selected member
			document.getElementById("selectedMember").value = indexNum;
		});
	});
</script>
</head>
<body>
	<div align="center">
	<!-- <form id="AccountEditForm" action="AccountUpdate.do"> -->
		<br/>
		<div style="text-align: center;">
			<h1>신발장 정보 수정</h1>
		</div>
		<br/>
		<div>
			<table width="440" border="1">
				<tr>
					<td align="center" colspan="2">
						신발장 ${bootrackCd }
					</td>
				</tr>
				<tr>
					<td width="150" align="center">상태: </td>
					<td>
						<select id="selectBox" style="width: 173px;">
							<c:choose>
								<c:when test="${bootrackSt eq 0}">
									<option id="notUse" value="0" selected="selected">미사용</option>
									<option id="use" value="1">사용</option>
								</c:when>
								<c:otherwise>
									<option id="notUse" value="0">미사용</option>
									<option id="use" value="1" selected="selected">사용</option>
								</c:otherwise>
							</c:choose>
						</select>
					</td>
				</tr>
				<tr>
					<td width="150" align="center">회원: </td>
					<td>
					<c:choose>
						<c:when test="${bootrackSt eq 0}">
							<input type="text" width="100px" id="searchName" name="searchName" value="" disabled="disabled">
						</c:when>
						<c:otherwise>
							<input type="text" width="100px" id="searchName" name="searchName" value="${bootrackName }">
						</c:otherwise>
					</c:choose>
						<input type="button" id="searchBtn" value="검색">
						<input type="button" id="addBtn" value="추가">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div>
							<table style="background-color: #E1E1E1; text-align: center;" align="center" width="430px;" border="1">
								<tr style="background-color: #DEDEDE;">
									<td rowspan="2">번호</td>
									<td rowspan="2">이름</td>
									<td rowspan="2">성별</td>
									<td colspan="2">사물함사용</td>
								</tr>
								<tr>
									<td>여부</td>
									<td>번호</td>
								</tr>
								<tr id="searchResult">
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" class="dialogBtn" id="enterBtn" value="등록">
						<input type="button" class="dialogBtn" onclick="javascript:history.back()" value="취소">
						<input type="hidden" id="selectedMember" value="">
					</td>
				</tr>
			</table>		
		</div>
		<%-- </c:forEach> --%>
		<!-- </form> -->
	</div>
</body>
</html>