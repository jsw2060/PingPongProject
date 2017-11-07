<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript">
//요일 배열 생성
var week = [false,false,false,false,false,false,false];

var dayCheck = function(obj) {
	var that = $(obj);
	var day = parseInt(that.val()-1);
	console.log("week ", week);
	switch(day) {
	case 0:
		if(false == week[0]) {
			week[0] = '월';
			document.getElementById("mon").style.backgroundColor = "#91D8FA";
			that.val(0);
			that.children().eq(0).text('요일을 선택하세요.');
		} else {
			week[0] = false;
			document.getElementById("mon").style.backgroundColor = "white";
			that.val(0);
			that.children().eq(0).text('요일을 선택하세요.');
		}
		break;
	case 1:
		if(false == week[1]) {
			week[1] = '화';
			document.getElementById("tue").style.backgroundColor = "#91D8FA";
			that.val(0);
			that.children().eq(0).text('요일을 선택하세요.');
		} else {
			week[1] = false;
			document.getElementById("tue").style.backgroundColor = "white";
			that.val(0);
			that.children().eq(0).text('요일을 선택하세요.');
		}
		break;
	case 2:
		if(false == week[2]) {
			week[2] = '수';
			document.getElementById("wed").style.backgroundColor = "#91D8FA";
			that.val(0);
			that.children().eq(0).text('요일을 선택하세요.');
		} else {
			week[2] = false;
			document.getElementById("wed").style.backgroundColor = "white";
			that.val(0);
			that.children().eq(0).text('요일을 선택하세요.');
		}
		break;
	case 3:
		if(false == week[3]) {
			week[3] = '목';
			document.getElementById("thu").style.backgroundColor = "#91D8FA";
			that.val(0);
			that.children().eq(0).text('요일을 선택하세요.');
		} else {
			week[3] = false;
			document.getElementById("thu").style.backgroundColor = "white";
			that.val(0);
			that.children().eq(0).text('요일을 선택하세요.');
		}
		break;
	case 4:
		if(false == week[4]) {
			week[4] = '금';
			document.getElementById("fri").style.backgroundColor = "#91D8FA";
			that.val(0);
			that.children().eq(0).text('요일을 선택하세요.');
		} else {
			week[4] = false;
			document.getElementById("fri").style.backgroundColor = "white";
			that.val(0);
			that.children().eq(0).text('요일을 선택하세요.');
		}
		break;
	case 5:
		if(false == week[5]) {
			week[5] = '토';
			document.getElementById("sat").style.backgroundColor = "#91D8FA";
			that.val(0);
			that.children().eq(0).text('요일을 선택하세요.');
		} else {
			week[5] = false;
			document.getElementById("sat").style.backgroundColor = "white";
			that.val(0);
			that.children().eq(0).text('요일을 선택하세요.');
		}
		break;
	case 6:
		if(false == week[6]) {
			week[6] = '일';
			document.getElementById("sun").style.backgroundColor = "#91D8FA";
			that.val(0);
			that.children().eq(0).text('요일을 선택하세요.');
		} else {
			week[6] = false;
			document.getElementById("sun").style.backgroundColor = "white";
			that.val(0);
			that.children().eq(0).text('요일을 선택하세요.');
		}
		break;	
	}
	document.getElementById("coachDay").setAttribute("value", week);
	console.log("저장된 값 ", document.getElementById("coachDay").value);
}

	$(document).ready(function(){
		
		// member searching
		$("#searchBtn").click(function () {
			
			// 검색 테이블 초기화
			$("#searchResult").children().remove();
			var searchName = $("#searchName").val();
			
			console.log("입력값 " + searchName);
			
			jQuery.ajax({
				type:"GET",
				url:"http://localhost:8080/pingPong/CoachSearch.do?searchName=" + searchName + "",
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
							
							if(data[idx].COACH_STATUS != 1) {
								statusTemp = "X";
							} else {
								statusTemp = "O";
							}
							
							temp = "<td>" + data[idx].MEMBER_CODE + "</td>"
							+ "<td>" + data[idx].NAME + "</td>"
							+ "<td>" + sexTemp + "</td>"
							+ "<td>" + statusTemp + "</td>";
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
		
		$("#enterBtn").click(function() {
			$("#AddCoachForm").submit();
		});
	});
</script>
</head>
<body>
	<div align="center">
	<form id="AddCoachForm" action="AddCoach.do">
		<br/>
		<div style="text-align: center;">
			<h1>코치 추가</h1>
		</div>
		<div>
			<table width="440" border="1">
				<tr>
					<td width="150" align="center">등록일: </td>
					<td>
						<input type="date" style="width: 270px;" id="coachRegDay" name="coachRegDay">
					</td>
				</tr>
				<tr>
					<td width="150" align="center">레슨요일: </td>
					<td>
						<select style="width: 275px;" id="lessonDay" name="lessonDay" onchange="dayCheck(this);">
							<option id="notUse" value="0" selected="selected">요일을 선택하세요.</option>
							<option id="mon" value="1" >월</option>
							<option id="tue" value="2">화</option>
							<option id="wed" value="3">수</option>
							<option id="thu" value="4">목</option>
							<option id="fri" value="5">금</option>
							<option id="sat" value="6">토</option>
							<option id="sun" value="7">일</option>
						</select>
						<input type="hidden" id="coachDay" name="coachDay" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td width="150" align="center">*회원: </td>
					<td>
						<input type="text" width="100px" id="searchName" name="searchName" value="${lockerName }">
						<input type="button" id="searchBtn" value="검색">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div>
							<table style="background-color: #E1E1E1; text-align: center;" align="center" width="430px;" border="1">
								<tr style="background-color: #DEDEDE;">
									<td>회원번호</td>
									<td>이름</td>
									<td>성별</td>
									<td>코치여부</td>
								</tr>
								<tr id="searchResult">
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">비고:</td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea id="coachNote" style="width: 425px; height: 50px;" name="coachNote"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" class="dialogBtn" id="enterBtn" value="등록">
						<input type="button" class="dialogBtn" onclick="javascript:history.back()" value="취소">
						<input type="hidden" id="selectedMember" name="selectedMember" value="">
					</td>
				</tr>
			</table>		
		</div>
		</form>
	</div>
</body>
</html>