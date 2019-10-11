<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
	$( document ).ready( function() {
		
		
		
		var logout = function() {
			swal({
				  title: "로그아웃 되었습니다.",
				  icon: "success",
				})
				.then( function(willDelete) {
					  if (willDelete) {
						  location.href = 'login.do';
					  } 
					});
		}
		logout();
	});
</script>
</head>
<body>
<%
	// 로그인 세션 삭제
	session.invalidate();
%>
</body>
</html>