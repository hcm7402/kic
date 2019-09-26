<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
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
		background: green;
		border-radius: 40px;
		box-sizing: border-box;
		animation: stack 2s 1;
	}
	@keyframes stack {
		0% { width: 0;}
		100% { width: 75%;}
	}
</style>
</head>
<body>
	<ul class="project1">
		<li>
			<div class="project-sub" style="text-align: right;">
				<div class="project-number" style="float: left; width: 50%; text-align: left; ">NO.01</div>
				<div class="project-state" style="float: left; width: 50%; text-align: right;">진행상태</div>
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
				<div class="project-number" style="float: left; width: 50%; text-align: left; ">NO.01</div>
				<div class="project-state" style="float: left; width: 50%; text-align: right;">진행상태</div>
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
		<li>3</li>
	</ul>
	<ul class="project1">
		<li>5</li>
		<li>6</li>
		<li>7</li>
	</ul>
</body>
</html>