<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String eno = (String)session.getAttribute("eno");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="./resources/menu.css">
<title>마이페이지</title>
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
   		
   		
   		$.ajax({
			url : './authlist.do',
			type : 'get',
			data: {
				eno: <%=eno%>
			},
			dataType : 'text',
			success : function(data) {
				$('#mainleft').html(data);
			}
		});
		// 결재목록 페이지 가져오는 부분
		function authlist() {
			$.ajax({
				url : './authlist.do',
				type : 'get',
				data: {
					eno: <%=eno%>
				},
				dataType : 'text',
				success : function(data) {
					$('#mainleft').html(data);
				}
			});
		}
		
		// 휴가 신청서 페이지 가져오는 부분
		function vacation() {
			$.ajax({
				url : './vacation.do',
				type : 'get',
				data: {
					eno: <%=eno%>
				},
				dataType : 'text',
				success : function(data) {
					$('#mainleft').html(data);
				}
			});
		}
		
		// 출장 신청서 페이지 가져오는 부분
		function busitrip() {
			$.ajax({
				url : './busitrip.do',
				type : 'get',
				data: {
					eno: <%=eno%>
				},
				dataType : 'text',
				success : function(data) {
					$('#mainleft').html(data);
				}
			});
		}
		
		function vacationview( eno, vno ) {
			$.ajax({
				url : './vacationview.do',
				type : 'get',
				data: {
					eno: eno,
					vno: vno
				},
				dataType : 'text',
				success : function(data) {
					$('#mainleft').html(data);
				}
			});
		}
		
		// 교통비 신청서 페이지 가져오는 부분
		function transportation() {
			$.ajax({
				url : './transportation.do',
				type : 'get',
				data: {
					eno: <%=eno%>
				},
				dataType : 'text',
				success : function(data) {
					$('#mainleft').html(data);
				}
			});
		}
	
		// 결재목록 클릭시
		$('.authlist').on('click', function() {
			authlist();
		});
		// 휴가신청서 클릭시
		$('.vacation').on('click', function() {
			vacation();
		});
		// 출장신청서 클릭시
		$('.busitrip').on('click', function() {
			busitrip();
		});
		// 교통비신청서 클릭 시
		$('.transportation').on('click', function() {
			transportation();
		});
		$(document).on('click','a.test', function() {
			var vno = $(this).attr('data-vno');
			vacationview( <%=eno%>, vno );
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
						    <li class='active has-sub'><a href='#'>결재</a>
								<ul>
						   			<li><a class="authlist">결재 목록</a>
						   		</ul>
						   	</li>
						  	<li class='active has-sub'><a href='#'>신청서</a>
						  		 <ul>
								   	<li><a class="vacation">휴가 신청서</a>
								   	<li><a class="busitrip">출장 신청서</a>
								   	<li><a class="transportation">교통비 신청서</a>
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