<%@page import="com.kic.groupware.model1.user.UserTO"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%
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
		$( document ).on( 'click', '.info-modify-cancle', function() {
			location.href = './mypage.do';
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
<title>Insert title here</title>
</head>
<body>
<table class="myinfo-table" >
	<tr>
		<th class="myinfo-img" colspan="2"><img class="ephoto" src="./resources/photo/<%=ephoto %>" ></th>
	</tr>
	<tr>
		<td class="myinfo-sub">이 름</td>
		<td class="myinfo-name" >
		<input type="text" class="form-controll" disabled="disabled" value=<%=ename %> />
		</td>
	</tr>
	<tr>
		<td class="myinfo-sub">부 서</td>
		<td class="myinfo-dept" >
		<select id="deptno" name="deptno" class="form-control">
				<c:forEach var="dname" items="${deptList}" varStatus="status">
				   	<option value="${status.count}">${dname}</option>
			 	</c:forEach>
		</select>
		</td>
	</tr>
	<tr>
		<td class="myinfo-sub">직 책</td>
		<td class="myinfo-job" >
			<input type="text" class="form-controll" disabled="disabled" value=<%=myjob %> />
		</td>
	</tr>
	<tr>
		<td class="myinfo-sub">입사일</td>
		<td class="myinfo-hiredate" >
			<input type="text" class="form-controll" disabled="disabled" value=<%=hiredate %> />
		</td>
	</tr>
	<tr>
		<td class="myinfo-sub">생년월일</td>
		<td class="myinfo-birth" >
			<input type="text" class="form-controll" disabled="disabled" value=<%=birth %> />
		</td>
	</tr>
	<tr>
		<td class="myinfo-sub">주 소</td>
		<td class="myinfo-addr" >
			<input type="text" class="form-controll address" value=<%=address %> />
		</td>
	</tr>
	<tr>
		<td class="myinfo-sub">메 일</td>
		<td class="myinfo-mail" >
			<input type="text" class="form-controll email" value=<%=email %> />
		</td>
	</tr>
	</table>
	<div class="align-right">
		<button class="btn btn-primary info-modify-ok">수정</button>
		<button class="btn btn-primary info-modify-cancle">취소</button>
	</div>
</body>
</html>