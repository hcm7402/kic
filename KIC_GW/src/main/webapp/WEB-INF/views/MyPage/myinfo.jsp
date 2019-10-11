<%@page import="com.kic.groupware.model1.user.UserTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String eno = (String) session.getAttribute("eno");

	UserTO to = (UserTO) request.getAttribute("to");

	String ename = to.getEname();
	String ephoto = to.getEphoto();
	String address = to.getAddress();
	String email = to.getEmail();
	String dname = to.getDname();
	String hiredate = to.getHiredate();
	int job = Integer.parseInt(to.getJob());
	String birth = to.getBirth();
	String myjob = "";
	
	if ( job == 1 || job == 0 ) {
		myjob = "사원";
	}else if( job == 2 ) {
		myjob = "팀장";
	} else if( job == 3 ) {
		myjob = "부장";
	}
	
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
					$('.info-body').html( data );
				}
			});
		}
		
		$(document).on( 'click', '.info-modify', function() {
			modify();
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
<title><%=myjob %>&nbsp;&nbsp;<%=ename %></title>
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
	<td class="myinfo-job" ><%=myjob %></td>
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
</body>
</html>