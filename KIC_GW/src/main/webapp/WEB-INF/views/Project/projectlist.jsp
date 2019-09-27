<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<link rel="stylesheet" href="./resources/css/button-project.css">
<title>프로젝트 리스트</title>
<style type="text/css">
	/* 프로젝트 대기중 노란색, 진행중 초록, 완료 파란색 */
	ul.project1, ol.project1 {
	    list-style: none;
	    padding: 0px;
	    width: 100%;
	    font-family: Sans-Serif;
	}
	  
	ul.project1 li, ol.project1 li {
		margin: 50px;
	    display: inline-block;
	    padding: 10px;
	    margin-bottom: 5px;
	    border: 2px solid black;
	    font-size: 12px;
	    cursor: pointer;
	    border-radius: 10px;
	}
	ul.project1 li:hover {
		box-shadow: 2px;
		transform: scale(1.15);
	}
	.project-progress {
		height: 20px;
		background: #ccc;
		border-radius: 40px;
	}
	.project-progress span {
		display: block;
		padding: 0 10px;
		width: 75%;
		height: 20px;
		line-height: 20px;
		background: #6aeb6a;
		border-radius: 40px;
		box-sizing: border-box;
		animation: stack 2s 1;
	}
	@keyframes stack {
		0% { width: 0;}
		100% { width: 75%;}
	}
	.project-progress1 {
		height: 20px;
		background: #ccc;
		border-radius: 40px;
	}
	.project-progress1 span {
		display: block;
		padding: 0 10px;
		width: 50%;
		height: 20px;
		line-height: 20px;
		background: #454545;
		border-radius: 40px;
		box-sizing: border-box;
		animation: stack1 2s 1;
	}
	@keyframes stack1 {
		0% { width: 0;}
		100% { width: 50%;}
	}
	.project-progress2 {
		height: 20px;
		background: #ccc;
		border-radius: 40px;
	}
	.project-progress2 span {
		display: block;
		padding: 0 10px;
		width: 100%;
		height: 20px;
		line-height: 20px;
		background: #56bafc;
		border-radius: 40px;
		box-sizing: border-box;
		animation: stack2 2s 1;
	}
	@keyframes stack2 {
		0% { width: 0;}
		100% { width: 100%;}
	}
	
</style>
</head>
<body>
	<ul class="project1">
		<li>
			<div class="project-sub" style="text-align: right;">
				<div class="project-number" style="float: left; width: 60%; text-align: left; ">NO.01</div>
				<div class="project-state ing" style="float: left; width: 40%; text-align: center;">진행중</div>
			</div>
			<div class="project-name">
				<h5>쇼핑몰 웹사이트</h5>
			</div>
			<div class="project-task">등록된 Task 개수(3)</div>
			<div class="project-people">홍길동 외 4명</div>
			<div class="project-date">2019-08-11 ~ 2019-09-30</div><br />
			<div class="project-progress">
				<span></span>
			</div>
		</li>
		<li>
			<div class="project-sub" style="text-align: right;">
				<div class="project-number" style="float: left; width: 60%; text-align: left; ">NO.02</div>
				<div class="project-state stop" style="float: left; width: 40%; text-align: center;">보 류</div>
			</div>
			<div class="project-name">
				<h5>KIC Final Project</h5>
			</div>
			<div class="project-task">등록된 Task 개수(5)</div>
			<div class="project-people">이몽룡 외 4명</div>
			<div class="project-date">2019-10-11 ~ 2019-10-30</div><br />
			<div class="project-progress1">
				<span></span>
			</div>
		</li>
		<li>
			<div class="project-sub" style="text-align: right;">
				<div class="project-number" style="float: left; width: 60%; text-align: left; ">NO.03</div>
				<div class="project-state com" style="float: left; width: 40%; text-align: center;">완 료</div>
			</div>
			<div class="project-name">
				<h5>KIC Semi Project</h5>
			</div>
			<div class="project-task">등록된 Task 개수(4)</div>
			<div class="project-people">이민기 외 6명</div>
			<div class="project-date">2019-08-11 ~ 2019-09-05</div><br />
			<div class="project-progress2">
				<span></span>
			</div>
		</li>
	</ul>
	<!-- <ul class="project1">
		<li>5</li>
		<li>6</li>
		<li>7</li>
	</ul> -->
</body>
</html>