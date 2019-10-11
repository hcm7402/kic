<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String eno = (String)session.getAttribute("eno");
	String ename = (String)session.getAttribute("ename");
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
			url : './boardlist.do',
			type : 'get',
			data: {
				eno: <%=eno%>
			},
			dataType : 'text',
			success : function(data) {
				$('#mainleft').html(data);
			}
		});
		// 게시판목록 페이지 가져오는 부분
		function boardlist(eno, cpage) {
			$.ajax({
				url : './boardlist.do',
				type : 'get',
				data: {
					eno: <%=eno%>,
					cpage: cpage
				},
				dataType : 'text',
				success : function(data) {
					$('#mainleft').html(data);
				}
			});
		}

		// 게시판목록 클릭시
		$('.boardlist').on('click', function() {
			boardlist();
		});
		
		
		$(document).on('click','.boardlist', function() {
			var cpage = $(this).attr('data-cpagel');
			boardlist( <%=eno%>, cpage );
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
						    <li class='active has-sub'><a href='#'>게시판</a>
								<ul>
						   			<li><a class="boardlist">사내 게시판</a>
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