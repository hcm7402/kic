<%@page import="com.kic.groupware.model1.user.UserTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String eno = (String) session.getAttribute("eno");

	UserTO to = (UserTO) request.getAttribute("to");

	String ename = to.getEname();
	String ephoto = to.getEphoto();
	String address = to.getAddress();
	String epw = to.getEpw();
	String email = to.getEmail();
	String dname = to.getDname();
	String hiredate = to.getHiredate();
	String job = to.getJob();
	String birth = to.getBirth();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$( document ).ready( function() {
		var modify = function() {
			$.ajax({
				url: './myinfomodify.do',
				type: 'post',
				data: {
					eno: <%=eno %>
				},
				cache: false,
				dataType: 'text',
				success: function( data ) {
					$('.info-body').empty();
					$('.info-body').html( data );
				}
			});
		} // end of modify
		
		var password = function( password ) {
			$.ajax({
				url: './password.do',
				type: 'post',
				data: {
					eno: <%=eno %>,
					password: password
				},
				dataType: 'JSON',
				success: function( json ) {
					results = json.results;
					$(results).each( function() {
						var flag = this.flag;
						if( flag == 0 ) {
							swal({
								  title: "비밀번호가 수정되었습니다.",
								  icon: "success",
								})
								.then( function(willDelete) {
									  if (willDelete) {
										  location.href = 'mypage.do';
									  } 
									});
							
						}else {
							swal({
								  title: '비밀번호 수정에 실패하였습니다.',
								  icon: 'warning'
								})
								.then( function(willDelete) {
									  if (willDelete) {
										  location.href = 'mypage.do';
									  } 
									});
						}
					});
				}
			});
		} // end of password
		
		$(document).on( 'click', '.info-modify', function() {
			modify();
		});
		var passflag = '';
		$('#password2').keyup( function() {
			if( $(this).val() == $('#password1').val() ) {
				$('#chkpassword').css('color', '#00bf00');
				$('#chkpassword').css('font-weight', 'bold');
				$('#chkpassword').css('float', 'right');
				$('#chkpassword').html('확인');
				passflag = 0;
			} else {
				$('#chkpassword').css('color', 'red');
				$('#chkpassword').css('font-weight', 'bold');
				$('#chkpassword').css('float', 'right');
				$('#chkpassword').html('비밀번호가 서로 다릅니다');
				passflag = 1;
			}
		})
		
		// 비밀번호 수정 클릭시
		$('.dialog-password').on('click', function() {
			var pass = $('#password1').val();
			if( passflag == 1 ) {
				swal({
					  title: '비밀번호가 서로 다릅니다!',
					  icon: 'warning'
					});
				return false;
			} else if ( passflag == 0 ) {
				password( pass );
			}
		});
	});
</script>
<style type="text/css">
	body {
		font-family: 'Malgun Gothic';
	}
	.myinfo-table {
		width: 100%;
		
	}
	.myinfo-table td {
		border-bottom: 3px solid #EAEAEA;
		padding: 20px;
	}
	.myinfo-table td.myinfo-sub {
		border-right: 3px solid #ccc;
		width: 15%;
		text-align: center;
		padding: 2em;
	}
	img.ephoto {
		width: 160px;
		height: 180px;
	}
	.myinfo-img {
		text-align: center;
		padding: 1em;
		border-bottom: 3px solid #EAEAEA;
	}
	.align-right {
		margin: 10px;
	}
</style>
<title><%=job %>&nbsp;&nbsp;<%=ename %></title>
</head>
<body>
<div class="info-body">
<table class="myinfo-table" >
<tr>
	<th class="myinfo-img" colspan="2"><img class="ephoto" src="./resources/photo/<%=ephoto %>" ></th>
</tr>
<tr>
	<td class="myinfo-sub">이 름</td>
	<td class="myinfo-name" ><%=ename %></td>
</tr>
<tr>
	<td class="myinfo-sub">부 서</td>
	<td class="myinfo-dept" ><%=dname %></td>
</tr>
<tr>
	<td class="myinfo-sub">직 책</td>
	<td class="myinfo-job" ><%=job %></td>
</tr>
<tr>
	<td class="myinfo-sub">입사일</td>
	<td class="myinfo-hiredate" ><%=hiredate %></td>
</tr>
<tr>
	<td class="myinfo-sub">생년월일</td>
	<td class="myinfo-birth" ><%=birth %></td>
</tr>
<tr>
	<td class="myinfo-sub">주 소</td>
	<td class="myinfo-addr" ><%=address %></td>
</tr>
<tr>
	<td class="myinfo-sub">메 일</td>
	<td class="myinfo-mail" ><%=email %></td>
</tr>
</table>
<div class="align-right">
	<button class="btn btn-primary info-modify">정보 수정</button>
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
						<label for="password1" style="font-size: 25px;">변경할 비밀번호 입력</label><br />
						<input class="form-controll project-password1" id="password1" type="password" style="width: 300px; height: 40px" placeholder="비밀번호를 입력하세요." /><br />
						<label for="password2" style="font-size: 25px;">변경할 비밀번호 확인</label><br />
						<input class="form-controll project-password2" id="password2" type="password" style="width: 300px; height: 40px" placeholder="비밀번호를 입력하세요." /><br />
						<div id="chkpassword"></div>
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
</body>
</html>