<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<link rel="stylesheet" href="./resources/css/bootstrap-datepicker3.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
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
	float: left;
	width: 40%;
	height: 100%;
}

.create2 {
	border: 0px solid yellow;
	float: left;
	width: 30%;
	height: 100%;
}

.create3 {
	border: 0px solid blue;
	float: left;
	width: 30%;
	height: 100%;
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

.click, .click2 {
	-moz-box-shadow: inset 0px 1px 0px 0px #fcfffe;
	-webkit-box-shadow: inset 0px 1px 0px 0px #fcfffe;
	box-shadow: inset 0px 1px 0px 0px #fcfffe;
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #47c9af
		), color-stop(1, #03ffcd));
	background: -moz-linear-gradient(center top, #47c9af 5%, #03ffcd 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#47c9af',
		endColorstr='#03ffcd');
	background-color: #47c9af;
	-webkit-border-top-left-radius: 42px;
	-moz-border-radius-topleft: 42px;
	border-top-left-radius: 42px;
	-webkit-border-top-right-radius: 42px;
	-moz-border-radius-topright: 42px;
	border-top-right-radius: 42px;
	-webkit-border-bottom-right-radius: 42px;
	-moz-border-radius-bottomright: 42px;
	border-bottom-right-radius: 42px;
	-webkit-border-bottom-left-radius: 42px;
	-moz-border-radius-bottomleft: 42px;
	border-bottom-left-radius: 42px;
	text-indent: 0px;
	border: 1px solid #47c9af;
	display: inline-block;
	color: #ffffff;
	font-family: Arial;
	font-size: 48px;
	font-weight: bold;
	font-style: normal;
	height: 31px;
	line-height: 31px;
	width: 30px;
	text-decoration: none;
	text-align: center;
	text-shadow: 1px 1px 0px #689324;
}

.click:hover, .click2:hover {
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #03ffcd
		), color-stop(1, #47c9af));
	background: -moz-linear-gradient(center top, #03ffcd 5%, #47c9af 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#03ffcd',
		endColorstr='#47c9af');
	background-color: #03ffcd;
}

.click:active, .click2:active {
	position: relative;
	top: 1px;
}

.click-option {
	margin: 5px;
}

.submit {
	-moz-box-shadow: inset 0px 1px 0px 0px #47c9af;
	-webkit-box-shadow: inset 0px 1px 0px 0px #47c9af;
	box-shadow: inset 0px 1px 0px 0px #47c9af;
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #3dedca
		), color-stop(1, #00cfa6));
	background: -moz-linear-gradient(center top, #3dedca 5%, #00cfa6 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#3dedca',
		endColorstr='#00cfa6');
	background-color: #3dedca;
	-webkit-border-top-left-radius: 15px;
	-moz-border-radius-topleft: 15px;
	border-top-left-radius: 15px;
	-webkit-border-top-right-radius: 15px;
	-moz-border-radius-topright: 15px;
	border-top-right-radius: 15px;
	-webkit-border-bottom-right-radius: 15px;
	-moz-border-radius-bottomright: 15px;
	border-bottom-right-radius: 15px;
	-webkit-border-bottom-left-radius: 15px;
	-moz-border-radius-bottomleft: 15px;
	border-bottom-left-radius: 15px;
	text-indent: 0;
	border: 1px solid #ffffff;
	display: inline-block;
	color: #ffffff;
	font-family: Arial;
	font-size: 19px;
	font-weight: bold;
	font-style: normal;
	height: 43px;
	line-height: 43px;
	width: 79px;
	text-decoration: none;
	text-align: center;
	text-shadow: 1px 1px 0px #86ae47;
}

.submit:hover {
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #00cfa6
		), color-stop(1, #3dedca));
	background: -moz-linear-gradient(center top, #00cfa6 5%, #3dedca 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#00cfa6',
		endColorstr='#3dedca');
	background-color: #00cfa6;
}

.submit:active {
	position: relative;
	top: 1px;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$('.start-date').datepicker({
			format : 'yyyy-mm-dd',
			language : 'ko'
		});
		$('.end-date').datepicker({
			format : 'yyyy-mm-dd',
			language : 'ko'
		});

		$('.click').on('click', function() {
			if ($('.click-option1').is(':visible')) {
				$('.click-option1').hide();
			} else {
				$('.click-option1').show();
			}
		});

		$('.click2').on('click', function() {
			if ($('.click-option2').is(':visible')) {
				$('.click-option2').hide();
			} else {
				$('.click-option2').show();
			}
		});

		$('.test').on('click', function() {
			var text = $('.test').text();
			var html = '<tr>';
			html += '<td>' + text + '</td></tr>';
			$('.addemp').append(html);
		});
	});
</script>

</head>
<body>

	<div class="project-form">
		<div>
			<div class="project-create col-md-6">
				<h1>프로젝트 생성</h1>
			</div>
			<div class="col-md-12" style="text-align: right;">
				<button class="submit">등 록</button>
			</div>
		</div>
		<form action="" class="create-form">
			<div class="create1 form-group">
				<div class="pro-title">
					<h5>프로젝트 담당자</h5>
				</div>
				<div class="leader ">사원 홍길동</div>
				<div class="etc">* 프로젝트 담당자는 프로젝트를 생성한 사람입니다</div>
				<label for="name">프로젝트 이름</label>
				<input type="text" class="form-control col-md-6 name" id="name" placeholder="프로젝트 이름 입력" /><br />
				<div class="form-row">
					<div class="form-group col-md-4">
						<label for="start-date">시작일</label> <input type="text"
							class="form-control start-date" id="start-date" placeholder="연도-월-일" />
					</div>&nbsp;&nbsp;&nbsp;&nbsp;
					<div class="form-group col-md-4">
						<label for="end-date">마감일</label> <input type="text"
							class="form-control end-date" id="end-date" placeholder="연도-월-일"/>
					</div>
				</div>
				<label for="project-content">프로젝트 개요</label>
				<textarea class="form-control col-md-8" id="project-content"
					rows="3"></textarea>
			</div>

			<div class="create2 form-group">
				<div><h5>프로젝트 팀원</h5></div>
				<div class="container">
					<div class="row">
						<div class="col">
							<div class="add">
								<div class="click" style="float: left;">+</div>
								<div style="padding: 3px; margin-left: 5px;">개발팀</div>
								<ul class="nav click-option1">
									<li class="nav-item"><a class="nav-link active">사원 홍길동</a>
									</li>
									<li class="nav-item"><a class="nav-link test" href="#">사원
											박문수</a></li>
									<li class="nav-item"><a class="nav-link">사원 이몽룡</a></li>
								</ul>
							</div>
							<br />
							<div class="add">
								<div class="click2" style="float: left;">+</div>
								<div style="padding: 3px; margin-left: 5px;">인사팀</div>
								<ul class="nav click-option2">
									<li class="nav-item"><a class="nav-link">사원 성춘향</a></li>
									<li class="nav-item"><a class="nav-link">사원 고창석</a></li>
									<li class="nav-item"><a class="nav-link">사원 이민기</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="create3 form-group">
				<table class="table table-borderless">
					<thead>
						<tr>
							<th>팀원이 추가됩니다.</th>
						</tr>
					</thead>
					<tbody class="addemp">
					</tbody>
				</table>
			</div>
		</form>
	</div>

</body>
</html>