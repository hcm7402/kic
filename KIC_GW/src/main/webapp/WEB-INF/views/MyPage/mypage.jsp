<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String eno = (String) session.getAttribute("eno");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
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
		myinfo();
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
				cache: false,
				success : function( data ) {
					$('#mainleft').html( data );
				}
			});
		}
		
		// 내정보 페이지 가져오는 부분
		function myinfo() {
			$.ajax({
				url : './myinfo.do',
				type : 'get',
				data: {
					eno: <%=eno %>
				},
				dataType : 'text',
				cache: false,
				success : function(data) {
					$('#mainleft').html( data );
				}
			});
		}
		
		// 근태현황 클릭시
		$('.manage').on('click', function() {
			management();
		});
		// 내정보 클릭시
		$('.myinfo').on('click', function() {
			 myinfo();
		});
		// 비밀번호 수정 클릭시
		$('.infopassword').on('click', function() {
			
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
							<li class='active has-sub'><a>내정보</a>
								<ul>
									<li><a class="myinfo">내정보 조회</a></li>
									<li><a class="infopassword" data-toggle="modal" data-target="#password_modal" >비밀번호 변경</a></li>
								</ul>
								</li>
							<li class='active has-sub'><a>근태관리</a>
								<ul>
									<li><a class="manage">근태 현황</a></li>
								</ul>
						</ul>
					</div>
				</div>
				<div id="mainleft" class="col-sm-8"></div>
			</div>
		</div>

	</div>
	<!-- 비밀번호 변경 modal -->
	<div class="modal" id="password_modal" role="dialog"  data-backdrop="static" data-keyboard="false">
		<div class = "modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class= "modal-title">비밀번호 변경</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
				<div>
					<div class="delete-form form-group" style="text-align: center;">
						<label for="password1" style="font-size: 25px;">변경할 비밀번호를 입력하세요.</label><br />
						<input class="form-controll project-password" id="password1" type="password" style="width: 300px; height: 40px" placeholder="비밀번호를 입력하세요." /><br />
						<label for="password2" style="font-size: 25px;">비밀번호 확인</label><br />
						<input class="form-controll project-password" id="password2" type="password" style="width: 300px; height: 40px" placeholder="비밀번호를 입력하세요." /><br />
					</div>
				</div>
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-primary dialog-password" value="변경하기" />
					<input type="button" data-dismiss="modal" class="btn btn-primary cancle" value="취소" />
				</div>
			</div>
		</div>
	</div>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>