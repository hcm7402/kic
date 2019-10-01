<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html> 
<html>
<head>
<title>Login 페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="./resources/util.css">
<link rel="stylesheet" type="text/css" href="./resources/main.css">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<link rel="stylesheet" href="./resources/css/bootstrap-datepicker3.css">
<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<script src="./resources/js/bootstrap-datepicker.min.js"></script>
<script src="./resources/js/bootstrap-datepicker.ko.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var idcertify = 0;
	var check = function( eid ) {
		$.ajax({
			url: './id_check.do',
			type: 'get',
			data: {
				eid: eid
			},
			dataType: 'JSON',
			success: function( json ) {
				checks = json.checks;
				$(checks).each( function() {
					var flag = this.flag;
					
					if(flag == 1) {
						swal({
							  title: '존재하는 아이디입니다.',
							  icon: 'warning'
						});
						idcertify = 0;
					}else {
						swal({
							  title: '사용 가능한 아이디입니다.',
							  icon: 'success'
						});
						idcertify = 1;
					}
				});
			},
			error: function(xhr, status, error ) {
				alert('에러 : ' + status + '\n\n' + error );
			}
		});
	} // end of idCheck
	
	$('#id_certify').on('click', function() {
		if($('#eid').val() == '') {
			swal({
				  title: '아이디를 입력하셔야 합니다.',
				  icon: 'warning'
			});
		}else {
			var eid = $('#eid').val();
			check(eid);
		}
	});
	
	$('#useradd').on('click', function() {
		if( $('#ename').val() == '' ) {
			swal({
				  title: '이름을 입력하셔야 합니다.',
				  icon: 'warning'
			});
			return false;
		}else if ( idcertify != 1) {
			swal({
				  title: '아이디 중복검사 하셔야 합니다.',
				  icon: 'warning'
			});
			return false;
		}else if( $('#epw').val() == '' || $('#epw_ok').val() == '') {
			swal({
				  title: '비밀번호를 입력하셔야 합니다.',
				  icon: 'warning'
			});
			return false;
		}else if( $('#epw').val() !=  $('#epw_ok').val()) {
			swal({
				  title: '비밀번호가 서로 다릅니다.',
				  icon: 'warning'
			});
			return false;
		}else if( $('#epw').val().length < 6 || $('#epw').val().length > 15) {
			swal({
				  title: '비밀번호는 6~15자만 가능합니다.',
				  icon: 'warning'
			});
			$('#epw').val('');
			$('#epw_ok').val('');
			return false;
		}else if( $('#hiredate').val() == '') {
			swal({
				  title: '입사일을 입력하셔야 합니다.',
				  icon: 'warning'
			});
			return false;
		}else if( $('#birth').val() == '') {
			swal({
				  title: '생년월일을 입력하셔야 합니다.',
				  icon: 'warning'
			});
			return false;
		}else if( $('#deptno').val() == '') {
			swal({
				  title: '부서를 선택하셔야 합니다.',
				  icon: 'warning'
			});
			return false;
		}else if( $('#address').val() == '') {
			swal({
				  title: '주소를 입력하셔야 합니다.',
				  icon: 'warning'
			});
			return false;
		}else if( $('#email').val() == '') {
			swal({
				  title: '이메일을 입력하셔야 합니다.',
				  icon: 'warning'
			});
			return false;
		}else if( $('#ephoto').val() == '') {
			swal({
				  title: '증명사진을 등록하셔야 합니다.',
				  icon: 'warning'
			});
			return false;
		}else if( $('#authphoto').val() == '') {
			swal({
				  title: '도장을 등록하셔야 합니다.',
				  icon: 'warning'
			});
			return false;
		}else {
			useradd_ok();
		}
	});
	
	$('#cancel').on('click', function() {
		location.href='login.do';
	});
});
$( document ).ready( function() {
	$('#hiredate').datepicker({
		format: 'yyyy-mm-dd',
		language: 'ko'
	});
	$('#birth').datepicker({
		format: 'yyyy-mm-dd',
		language: 'ko'
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

@keyframes drift {
  from { transform: rotate(0deg); }
  from { transform: rotate(360deg); }
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}
label {
	margin-bottom: 0;
}
	</style>
</head>
<body>
	<div id="main">
		<div class="limiter">
		<div class="container-login100">
		<div class="wrap-login100">
			<form class="login100-form validate-form" action="./useradd_ok.do" name="frm" method="post" enctype="multipart/form-data">
				<div class="wrap-input100" data-validate = "Enter username">
					<label>이름</label>
					<input class="input100" name="ename" type="text" id="ename">
				</div>
	
				<div class="wrap-input100" data-validate = "Enter username">
					<label>아이디</label><input type="button" class="btn btn-success" id="id_certify" style="float: right;" value="중복확인">
					<input class="input100" type="text" name="eid" id="eid">
				</div>
				
				<div class="wrap-input100" data-validate="Enter password">
					<label>비밀번호</label>
					<input class="input100" type="password" name="epw" id="epw">
				</div>
				
				<div class="wrap-input100" data-validate="Enter password_ok">
					<label>비밀번호 확인</label>
					<input class="input100" type="password" id="epw_ok">
				</div>
				<%-- <div>
					직책 :
					<select id="pno" id="pno" class="form-control">
						<c:forEach var="pno" items="1,2,3,4,5" varStatus="status">
				    		<option value="${status.count}">${pno}</option>
					 	</c:forEach>
					</select>
				</div> --%>
				<%-- <div class="wrap-input100" data-validate = "Enter pno">
					<input class="input100" type="text" name="pno" id="pno">
					<span class="focus-input100" data-placeholder="직책"></span>
				</div> --%>
				<div class="wrap-input100">
					<label>입사일</label>
					<input class="input100 form-control" size="16" id="hiredate" name="hiredate" readonly>
				</div>
				<!-- <div class="wrap-input100" data-validate = "Enter sal">
					<label>연봉</label>
					<input class="input70" type="text" name="sal" id="sal">
				</div> -->
				<div class="wrap-input100">
					<label>생년월일</label>
					<input class="form-control" size="16" id="birth" name="birth" readonly>
				</div>
				<div class="wrap-input100">
					<label>부서</label>
					<select id="deptno" name="deptno" class="form-control">
						<c:forEach var="dname" items="${deptList}" varStatus="status">
				    		<option value="${status.count}">${dname}</option>
					 	</c:forEach>
					</select>
				</div>
				<div class="wrap-input100" data-validate = "Enter address">
					<label>주소</label>
					<input class="input100" type="text" name="address" id="address">
				</div>
				<div class="wrap-input100" data-validate = "Enter email">
					<label>이메일</label>
					<input class="input100" type="text" name="email" id="email">
				</div>
				
				<div class="wrap-input100">
					증명사진 : <input type="file" style="float: right" name="ephoto" id="ephoto">
				</div>
				<div class="wrap-input100">
					도장 : <input type="file" style="float: right" name="authphoto" id="authphoto">
				</div>
				<br />
				<div class="container-login100-form-btn">
					<input type="submit" class="login50-form-btn" id="useradd" value="가입하기" />
					<input type="button" class="login50-form-btn" id="cancel" value="취소" />
				</div>
			</form>
			</div>
		</div>
	</div>
	</div>


</body>
</html>