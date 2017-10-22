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
		
		$("#selectBox").on("change", function() {

			var that = $(this);
			if (that.val() == '1') {
				alert('관리자 체크 해제');
				that.val('0');
				//that.removeAttr('checked');
				//$("#updateMng").val(that.val());
			} else if (that.val() == '0') {
				alert('관리자 체크');
				that.val('1');
				//that.attr('checked', true);
				//$("#updateMng").val(that.val());
			} else {
				alert('check logic!!');
			}
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
			<table width="350" border="1">
				<tr>
					<td align="center" colspan="2">
						신발장 ${bootrackCd }
					</td>
				</tr>
				<tr>
					<td width="150" align="center">상태: </td>
					<td>
						<select name="selectBox" style="width: 160px;">
							<c:choose>
								<c:when test="${bootrackSt eq 0}">
									<option value="0" selected="selected">미사용</option>
									<option value="1">사용</option>
								</c:when>
								<c:otherwise>
									<option value="0">미사용</option>
									<option value="1" selected="selected">사용</option>
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
							<input type="text" width="100px" value="">
						</c:when>
						<c:otherwise>
							<input type="text" width="100px" value="${bootrackName }">
						</c:otherwise>
					</c:choose>
						<input type="button" value="검색">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" class="dialogBtn" id="enterBtn" value="등록">
						<input type="button" class="dialogBtn" onclick="javascript:history.back()" value="취소">
					</td>
				</tr>
			</table>		
		</div>
		<%-- </c:forEach> --%>
		<!-- </form> -->
	</div>
</body>
</html>