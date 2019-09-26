<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="./resources/menu.css">
<title>프로젝트</title>
<style type="text/css">
	.row {
	padding-left: 14px;
	padding-bottom: 30px;
	width: auto;
	height: auto;
	}
</style>
<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		// 페이지 로딩 시 프로젝트 리스트 출력 함수
		projectlist();
		// 메뉴 효과
		$('#menu li.active').addClass('open').children('ul').show();
   		$('#menu li.has-sub>a').on('click', function(){
   			$(this).removeAttr('href');
   			var element = $(this).parent('li');
   			if (element.hasClass('open')) {
   				element.removeClass('open');
   				element.find('li').removeClass('open');
   				element.find('ul').slideUp(200);
   			}
   			else {
   				element.addClass('open');
   				element.children('ul').slideDown(200);
   				element.siblings('li').children('ul').slideUp(200);
   				element.siblings('li').removeClass('open');
   				element.siblings('li').find('li').removeClass('open');
   				element.siblings('li').find('ul').slideUp(200);
   			}
   		});
		// 근태현황 페이지 가져오는 부분
		function management() {
			$.ajax({
				url : './Management.do',
				type : 'get',
				dataType : 'text',
				success : function(data) {
					$('#mainleft').html(data);
				}
			});
		}
		
		// list 페이지 가져오는 부분
		function projectlist() {
			$.ajax({
				url : './projectlist.do',
				type : 'get',
				dataType : 'text',
				success : function(data) {
					$('#mainleft').html(data);
				}
			});
		}
		
		// create 페이지 가져오는 부분
		 function project_create() {
			$.ajax({
				url : './projectcreate.do',
				type : 'get',
				dataType : 'text',
				success : function(data) {
					$('#mainleft').html(data);
				}
			});
		} 
		
		// 생성 클릭시
		$('.create').on('click', function() {
			project_create();
		});
		// 내정보 클릭시
		$('.myinfo').on('click', function() {
			
		});
		// 내 정보 수정 클릭시
		$('.infomodify').on('click', function() {
			
		});
		// 내 일정 클릭 시
		$('.mycal').on('click', function() {
			
		});
	});
</script>
</head>
<body>
	<div id="wrapper">
		<%@include file="../Menu/topmenu.jsp"%>
		<div id="container">
			<div class="row">
				<div class="menubar col-sm-3">
					<div id='menu'>
						<ul>
							<li class='active has-sub'><a>프로젝트</a>
								<ul>
									<li><a class="create">프로젝트 생성</a></li>
									<li><a class="">진행중 Project</a></li>
        							<li><a class="">완성된 Project</a></li>
								</ul>
								</li>
							<li class='active has-sub'><a>About</a>
								<ul>
									<li><a class="">About</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
				<div id="mainleft" class="col-sm-8"></div>
			</div>
		</div>

	</div>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>