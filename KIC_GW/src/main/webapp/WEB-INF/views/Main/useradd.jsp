<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>Login 페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="./resources/util.css">
<link rel="stylesheet" type="text/css" href="./resources/main.css">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<link href="./resources/css/datepicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<script src="./resources/js/bootstrap-datepicker.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#useradd').on('click', function() {
		if( $('#ename').val() == '' ) {
			alert('이름을 입력하셔야 합니다.');
			return false;
		}else if( $('#eid').val() == '' ) {
			alert('아이디를 입력하셔야 합니다.');
			return false;
		}else if( $('#epw').val() == '' || $('#epw_ok').val() == '') {
			alert('비밀번호를 입력하셔야 합니다.');
			return false;
		}else if( $('#epw').val() !=  $('#epw_ok').val()) {
			alert( '비밀번호가 서로 다릅니다.');
			return false;
		}else if( $('#epw').val().length < 10 || $('#epw').val().length > 15) {
			alert('비밀번호는 10~15자만 가능합니다.');
			$('#epw').val('');
			$('#epw_ok').val('');
			return false;
		}else if( $('#pno').val() == '') {
			alert( '직책을 입력하셔야 합니다.');
			return false;
		}else if( $('#hiredate').val() == '') {
			alert( '입사일을 입력하셔야 합니다.');
			return false;
		}else if( $('#sal').val() == '') {
			alert( '연봉을 입력하셔야 합니다.');
			return false;
		}else if( $('#birth').val() == '') {
			alert( '생년월일을 입력하셔야 합니다.');
			return false;
		}else if( $('#deptno').val() == '') {
			alert( '부서를 선택하셔야 합니다.');
			return false;
		}else if( $('#address').val() == '') {
			alert( '주소를 입력하셔야 합니다.');
			return false;
		}else if( $('#email').val() == '') {
			alert( '이메일을 입력하셔야 합니다.');
			return false;
		}else if( $('#ephoto').val() == '') {
			alert( '증명사진을 등록하셔야 합니다.');
			return false;
		}else if( $('#authphoto').val() == '') {
			alert( '도장을 등록하셔야 합니다.');
			return false;
		}else {
			document.frm.submit();
		}
	});
	
	$('#cancel').on('click', function() {
		history.back();
	});
});

window.onload = function() {
    $('#hiredate').datepicker().on('changeDate', function(ev) {
        if (ev.viewMode=="days"){
            $('#hiredate').datepicker('hide');
        }
    });
    $('#birth').datepicker().on('changeDate', function(ev) {
        if (ev.viewMode=="days"){
            $('#birth').datepicker('hide');
        }
    });
}
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
	</style>
</head>
<body>
	<div id="main">
		<div class="limiter">
		<div class="container-login100">
		<div class="wrap-login100">
			<form class="login100-form validate-form" action="./useradd_ok.do" name="frm" method="post">
				<div class="wrap-input100" data-validate = "Enter username">
					<label>이름</label>
					<input class="input70" name="ename" type="text" id="ename">
				</div>
	
				<div class="wrap-input100" data-validate = "Enter username">
					<input class="input100" type="text" name="eid" id="eid">
					<span class="focus-input100" data-placeholder="아이디"></span>
				</div>
				
				<div class="wrap-input100" data-validate="Enter password">
					<input class="input100" type="password" name="epw" id="epw">
					<span class="focus-input100" data-placeholder="비밀번호"></span>
				</div>
				
				<div class="wrap-input100" data-validate="Enter password_ok">
					<input class="input100" type="password" id="epw_ok">
					<span class="focus-input100" data-placeholder="비밀번호 확인"></span>
				</div>
				<%-- <div>
					직책 :
					<select id="pno" id="pno" class="form-control">
						<c:forEach var="pno" items="1,2,3,4,5" varStatus="status">
				    		<option value="${status.count}">${pno}</option>
					 	</c:forEach>
					</select>
				</div> --%>
				<div class="wrap-input100" data-validate = "Enter pno">
					<input class="input100" type="text" name="pno" id="pno">
					<span class="focus-input100" data-placeholder="직책"></span>
				</div>
				<div class="wrap-input100">
					<label>입사일</label>
					<input class="input100 form-control" size="16" id="hiredate" name="hiredate" readonly>
				</div>
				<div class="wrap-input100" data-validate = "Enter sal">
					<label>연봉</label>
					<input class="input70" type="text" name="sal" id="sal">
				</div>
				<div class="wrap-input100">
					<label>생년월일</label>
					<input class="form-control" size="16" id="birth" name="birth" readonly>
				</div>
				<hr />
				<div class="wrap-input100">
					<label>부서</label>
					<select id="deptno" name="deptno" class="form-control">
						<c:forEach var="dname" items="${deptList}" varStatus="status">
				    		<option value="${status.count}">${dname}</option>
					 	</c:forEach>
					</select>
				</div>
				<div class="wrap-input100" data-validate = "Enter address">
					<input class="input100" type="text" name="address" id="address">
					<span class="focus-input100" data-placeholder="주소"></span>
				</div>
				<div class="wrap-input100" data-validate = "Enter email">
					<input class="input100" type="text" name="email" id="email">
					<span class="focus-input100" data-placeholder="이메일"></span>
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