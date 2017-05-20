<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/MainHome.css" rel="stylesheet" type="text/css">
<script	src="https://code.jquery.com/jquery-3.0.0.min.js" integrity="sha256-JmvOoLtYsmqlsWxa7mDSLMwa6dZ9rrIdtrrVYRnDRH0=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.19.1/TweenMax.min.js"></script>
<script type="text/javascript">
	$(function() {
		var current = 0;
		var max = 0;
		var container;
		
		function init(){
			container = $(".slide ul");
			max = container.children().length;
			
			events();
		}
		function events(){
			$("button.prev").on("click", prev);
			$("button.next").on("click", next);
			
		}
		function prev(e){
			current--;
			if(current < 0) current = 0;
			animate();
			console.log(current);
		}
		function next(e){
			current++;
			if(current > max-1) current = max-1;
			animate();
			console.log(current);
		}
		function animate(){
			var moveX = current * 550;
			TweenMax.to(container, 0.8, {marginLeft:-moveX, ease:Expo.easeQut})
		}
		$(document).ready( init );
	});
</script>
</head>
<body>
	<center>
		<div id="mainHomePage">
			<br/>
			<p id="mainTitle">Welcome To Hwang Nam Suk Table Tennis Club!</p>
			<br/>
			<div class="slide">
				<button type="button" class="prev"><img src="resources/light/appbar.chevron.left.png" alt="prevDirection"/></button>
				<ul>
					<li><img class="mainSlideImg" src="resources/images/img1.jpg" alt="PingPongImg1"/></li>
					<li><img class="mainSlideImg" src="resources/images/img2.jpg" alt="PingPongImg2"/></li>
					<li><img class="mainSlideImg" src="resources/images/img3.jpg" alt="PingPongImg3"/></li>
					<li><img class="mainSlideImg" src="resources/images/img4.jpg" alt="PingPongImg4"/></li>
					<li><img class="mainSlideImg" src="resources/images/img5.jpg" alt="PingPongImg5"/></li>
				</ul>
				<button type="button" class="next"><img src="resources/light/appbar.chevron.right.png" alt="nextDirection"/></button>
			</div>
		</div>
	</center>
</body>
</html>