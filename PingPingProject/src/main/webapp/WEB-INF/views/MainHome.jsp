<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/MainHome.css" rel="stylesheet" type="text/css">
<script	src="https://code.jquery.com/jquery-3.0.0.min.js" integrity="sha256-JmvOoLtYsmqlsWxa7mDSLMwa6dZ9rrIdtrrVYRnDRH0=" crossorigin="anonymous"></script>
<script>

    var intv;
    var current = 0;
    var sIdx = 0;
	var sCnt =  4;
	
    function startTopSlider() {
	    intv = setInterval(function () {
            $("#ul_btns").find("li").eq(current++ % sCnt).click();
        }, 3000);
    }

    function setBnr(idx, bnr, allTab, addCls) {
        $(bnr).css("visibility", "hidden")
              .eq(idx).css("visibility", "visible");
        $(allTab).removeClass(addCls);
        $(allTab).eq(idx).addClass(addCls);
    }

    $(document).ready(function () {
	    
        //set init
        $("#top_0").css("visibility", "visible");
        $("#btn_0").addClass("on");
        startTopSlider();
		
		
		$("#ul_btns").find("a").click(function(){
			var idx = $(this).attr("id").split("_")[1];
			setBnr(idx, "#TopSlider > div" , "#ul_btns > a" , "on" );
		});
    });
</script>
</head>
<body>
	<div id="mainHomePage">
		<p id="mainTitle">Welcome To Hwang Nam Suk Table Tennis Club!</p>
			<div id="TopSlider">
				<div id="top_0">배너 0</div>
				<div id="top_1">배너 1</div>
				<div id="top_2">배너 2</div>
				<div id="top_3">배너 3</div>
			</div>
			<center>
			<div id="TopSliderBtn">
				<ul id="ul_btns">
					<li><a href="#" id="btn_0">tab0</a></li>
					<li><a href="#" id="btn_1">tab1</a></li>
					<li><a href="#" id="btn_2">tab2</a></li>
					<li><a href="#" id="btn_3">tab3</a></li>
				</ul>
			</div>
			</center>
	</div>
</body>
</html>