<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/* String eno = (String)session.getAttribute("eno");

	if(eno != null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='./main.do'"); 
		out.println("</script>");
	} */
%>
<!DOCTYPE html>
<html>
<head>
<title>Login 페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="./resources/util.css">
<link rel="stylesheet" type="text/css" href="./resources/main.css">
<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="./resources/js/jquery-ui.js"></script>
<link rel="stylesheet" href="./resources/css/base/jquery-ui.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
	$(document).ready( function() {
		
		// session 값 부여 함수
		var session = function( eno, level, ename ) {
			$.ajax({
				url: './session.do',
				type: 'post',
				data: {
					eno: eno,
					level: level,
					ename: ename
				},
				success: function() {
					location.href = './main.do';
				}
			});
		}
		
		var logcheck = function( u_id, u_password ) {
			$.ajax({
				url: './login_ok.do',
				type: 'post',
				data: {
					u_id: u_id,
					u_password: u_password
				},
				dataType: 'JSON',
				success: function( json ) {
					logchecks = json.logchecks;
					
					$(logchecks).each( function () {
						var flag = this.flag;
						var eno = this.eno;
						var level = this.level;
						var ename = this.ename;
							
						if(flag == 2) {
							swal({
								  title: '존재하지 않는 아이디 입니다.',
								  icon: 'warning'
							});
						}else if(flag == 1) {
							swal({
								  title: '비밀번호가 다릅니다.',
								  icon: 'warning'
							});
						}else {
							if( level == 0 ) {
								swal({
									  title: "관리자 허가가 필요합니다",
									  icon: "warning",
									})
									.then( function(willDelete) {
										  if (willDelete) {
											  location.href = './login.do';
										  } 
									});
								return false;
							} else {
								swal({
									  title: "로그인에 성공하였습니다.",
									  icon: "success",
									})
									.then( function(willDelete) {
										  if (willDelete) {
											  session( eno, level, ename );
										  } 
									});
							}
						}
					});
					
				},
				error: function(xhr, status, error ) {
					alert('에러 : ' + status + '\n\n' + error );
				}
			});
		} // end of logcheck
		
		// 로그인 버튼 클릭 시 이벤트
		
		$('#submit').on('click', function() {
			if( $('#u_id').val() == '' ) {
				swal({
					  title: '아이디를 입력하셔야 합니다.',
					  icon: 'warning'
				});
			}else if( $('#u_password').val() == '' ){
				swal({
					  title: '비밀번호를 입력하셔야 합니다.',
					  icon: 'warning'
				});
			}else {
				var u_id = $('#u_id').val();
				var u_password = $('#u_password').val();
				logcheck( u_id, u_password );
			}
		});
	});
</script>
	<style type="text/css">
	.arial {font-family: arial;
			z-index: 20;
			color : #000;
			font-weight: bold;	
	}
	
	.s3 { text-shadow: 2px 2px 6px black; }
	
.box {
  border-radius: 5px;
  box-shadow: 0 2px 30px rgba(black, .2);
  background: lighten(#f0f4c3);
  position: relative;
  overflow: hidden;
  transform: translate3d(0, 0, 0);
}

.wave {
  opacity: 0.3;
  position: absolute;
  top: 3%;
  left: 50%;
  background: #0af;
  width: 500px;
  height: 500px;
  margin-left: -250px;
  margin-top: -250px;
  transform-origin: 50% 48%;
  border-radius: 43%;
  animation: drift 3000ms infinite linear;
}

.wave.-three {
  animation: drift 5000ms infinite linear;
}

.wave.-two {
  animation: drift 7000ms infinite linear;
  
  background: #56bafc;
}

.box:after {
  content: '';
  display: block;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(to bottom, rgba(#e8a, 1), rgba(#def, 0) 80%, rgba(white, .5));
  z-index: 11;
  transform: translate3d(0, 0, 0);
}

.title {
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  z-index: 1;
  line-height: 300px;
  text-align: center;
  transform: translate3d(0, 0, 0);
  color: white;
  text-transform: uppercase;
  font-family: 'Malgun Gothic';
  letter-spacing: .4em;
  font-size: 24px;
  text-shadow: 0 1px 0 rgba(black, .1);
  text-indent: .3em;
}

@keyframes drift {
  from { transform: rotate(0deg); }
  from { transform: rotate(360deg); }
}
</style>
</head>
<body>
	<div id="main">
		<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-85 p-b-20 fs-50 box">
				<form class="login100-form validate-form" action="login_ok.do" method="post" name="frm">
					<div class='wave -one'></div>
  					<div class='wave -two'></div>
  					<div class='wave -three'></div>
					<span class="login100-form-title arial s3"> KIC Groupware</span> <br /><br />
					<div class="wrap-input100 validate-input m-t-85 m-b-35" data-validate = "Enter username">
						<input class="input100" type="text" id="u_id" placeholder="아이디">
					</div>

					<div class="wrap-input100 validate-input m-b-50" data-validate="Enter password">
						<input class="input100" type="password" id="u_password" placeholder="비밀번호">
					</div>

					<div class="container-login100-form-btn">
						<button type="button" id="submit" class="login100-form-btn">로그인</button>
					</div>
					<ui>
						<li class="m-b-0">
							<a href="#" class="txt2">
								아이디 / 비밀번호
							</a>
							<span class="txt1">
								찾기
							</span>
						</li>
						<li>
							<span class="txt1">
								아이디가 없으신가요?
							</span>
							<a href="./useradd.do" class="txt2">
								회원가입
							</a>
						</li>
					</ui>
				</form>
			</div>
		</div>
	</div>
	</div>


</body>
</html>