<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<link rel="stylesheet" href="./resources/css/bootstrap-datepicker.css">
<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<script src="./resources/js/bootstrap-datepicker.min.js"></script>
<script src="./resources/js/bootstrap-datepicker.ko.min.js"></script>
<style>
.project-form {
	width: 100%;
	height: 100%;
	border: 1px solid black;
	margin-left: -40px !important;
}
	.create1 {
		border: 2px solid pink;
		float:left; width: 40%; height: 100%;
	}
	.create2 {
		border: 2px solid yellow;
		float:left; width: 30%; height: 100%;
	}
	.create3 {
		border: 2px solid blue;
		float:left; width: 30%; height: 100%;
	}
	body {
		font-family: Sans-Serif;
	}
</style>
<script type="text/javascript">
	$( document ).ready( function() {
		$('.start-date').datepicker({
			format: 'yyyy-mm-dd',
			language: 'ko'
		});
		$('.end-date').datepicker({
			format: 'yyyy-mm-dd',
			language: 'ko'
		});
	});
</script>

</head>
<body>

<div class ="project-form">
	<div class="project-create"><h1>프로젝트 생성</h1></div>
	<form action="" class="create-form">
		<div class="create1">
			프로젝트 담당자 <div class="leader">사원 홍길동</div>
			<div class="etc">* 프로젝트 담당자는 프로젝트를 생성한 사람입니다.(폰트적용)</div>
			프로젝트 이름<br />
			<input type="text" class="name" /><br />
			프로젝트 기간<br />
			<div><input type="text" class="start-date" /></div><div><input type="text" class="end-date" /></div><br />
			
			프로젝트 개요<br />
			<input type="text" class="name" /><br />
		</div>
		<div class="create2">
			프로젝트 팀원
		</div>
		<div class="create3">
			팀원이 추가됩니다
		</div>
	</form>
</div>

</body>
</html>