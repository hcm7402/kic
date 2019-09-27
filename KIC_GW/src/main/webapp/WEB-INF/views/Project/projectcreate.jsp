<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<link rel="stylesheet" href="./resources/css/bootstrap-datepicker3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<script src="./resources/js/bootstrap-datepicker.min.js"></script>
<script src="./resources/js/bootstrap-datepicker.ko.min.js"></script>
<style>
.project-form {
	width: 100%;
	height: 100%;
}
	.create1 {
		border: 0px solid pink;
		float:left; width: 40%; height: 100%;
	}
	.create2 {
		border: 0px solid yellow;
		float:left; width: 30%; height: 100%;
	}
	.create3 {
		border: 0px solid blue;
		float:left; width: 30%; height: 100%;
	}
	body {
		font-family: Sans-Serif;
		margin-left: 40px;
		margin-right: 40px;
	}
	.etc {
		font-size: 12px;
		color: #47C83E;
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
		<div class="create1 form-group">
			프로젝트 담당자 <div class="leader ">사원 홍길동</div>
			<div class="etc">* 프로젝트 담당자는 프로젝트를 생성한 사람입니다.(폰트적용)</div>
			<label for="name">프로젝트 이름</label>
			<input type="text" class="form-control col-md-5 name" id="name"/><br />
			<div class="form-row">
				<div class="form-group col-md-4">
					<label for="start-date">시작일</label>
					<input type="text" class="form-control start-date" id="start-date"/>
				</div>
				<div class="form-group col-md-4">
					<label for="start-date">마감일</label>
					<input type="text" class="form-control end-date" id="end-date"/>
				</div>
			</div><br />
				<textarea class="form-control col-md-5" id="project-content" rows="3"></textarea>
			</div>
		
		<div class="create2 form-group">
			프로젝트 팀원
		</div>
		<div class="create3 form-group">
			팀원이 추가됩니다
		</div>
	</form>
</div>

</body>
</html>