<%@page import="com.kic.groupware.model1.auth.AuthtransportationTO"%>
<%@page import="com.kic.groupware.model1.auth.AuthbusitripTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.kic.groupware.model1.auth.AuthvacationTO"%>
<%@page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("UTF-8");
	String eno = (String)session.getAttribute("eno");
	if(eno == null || eno.equals("")) {
	      out.println("<script type='text/javascript'>");
	      out.println("alert('로그인이 필요합니다.')");
	      out.println("location.href='./login.do'");
	      out.println("</script>");
	} 

	ArrayList<AuthvacationTO> authVLists1 = (ArrayList)request.getAttribute( "authVLists1" );
	ArrayList<AuthbusitripTO> authVLists2 = (ArrayList)request.getAttribute( "authVLists2" );
	ArrayList<AuthtransportationTO> authVLists3 = (ArrayList)request.getAttribute( "authVLists3" );
	
	int totalRecord = 0;
	StringBuffer html1 = new StringBuffer();
	
	for( AuthvacationTO to : authVLists1) {
		String vno = to.getVno();
		String authno = to.getAuthno();
		String ename = to.getEname();
		String deptno = to.getDeptno();
		String vdate = to.getVdate();
		String job = to.getJob();
		String vtype = to.getVtype();
		String vstart = to.getVstart();
		String vend = to.getVend();
		String vreason = to.getVreason();
		String authstate = to.getAuthstate();
		if(authstate.equals("1")){
			authstate = "결재대기중";
		}
		if(authno.equals("1")){
			authno = "출장신청";
		} else if(authno.equals("2")){
			authno = "휴가신청";
		} else if(authno.equals("3")){
			authno = "교통비신청";
		}
		html1.append("<tr>");
		html1.append("<td>" + vno + "</td>");
		html1.append("<td class='left'>");
		html1.append("	<a href='./vacation.do?vno=" + vno + "'>" + vreason + "</a>");
		html1.append("</td>");
		html1.append("<td>" + vdate + "</td>");
		html1.append("<td>" + authno + "</td>");
		html1.append("<td>" + ename + "</td>");
		html1.append("<td>" + authstate + "</td>");
		html1.append("</tr>");
		
		totalRecord++;
	}
	
	StringBuffer html2 = new StringBuffer();
	
	for( AuthbusitripTO to : authVLists2) {
		String authno = to.getAuthno();
		String bno = to.getBno();
		String binsertdate = to.getBinsertdate();
		String deptno = to.getDeptno();
		String ename = to.getEname();
		String bspot = to.getBspot();
		String bpurpose = to.getBpurpose();
		String authstate = to.getAuthstate();

		html2.append("<tr>");
		html2.append("<td>" + bno + "</td>");
		html2.append("<td class='left'>");
		html2.append("	<a href='./busitrip.do?bno=" + bno + "'>" + bpurpose + "</a>");
		html2.append("</td>");
		html2.append("<td>" + binsertdate + "</td>");
		html2.append("<td>" + authno + "</td>");
		html2.append("<td>" + ename + "</td>");
		html2.append("<td>" + authstate + "</td>");
		html2.append("</tr>");
		
		totalRecord++;
	}
	
	StringBuffer html3 = new StringBuffer();
	
	for( AuthtransportationTO to : authVLists3) {
		String atno = to.getAtno();
		String authno = to.getAuthno();
		String atdate = to.getAtdate();
		String deptno = to.getDeptno();
		String job = to.getJob();
		String ename = to.getEname();
		String authstate = to.getAuthstate();
		String atreason = to.getAtreason();
		
		html1.append("<tr>");
		html1.append("<td>" + atno + "</td>");
		html1.append("<td class='left'>");
		html1.append("	<a href='./vacation.do?atno=" + atno + "'>" + atreason + "</a>");
		html1.append("</td>");
		html1.append("<td>" + atdate + "</td>");
		html1.append("<td>" + authno + "</td>");
		html1.append("<td>" + ename + "</td>");
		html1.append("<td>" + authstate + "</td>");
		html1.append("</tr>");
		
		totalRecord++;
	}
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="./resources/tree.css">
<link rel="stylesheet" href="./resources/styles.css">
<link rel="stylesheet" href="./resources/menu.css">
<title>전자결재 페이지</title>
<style type="text/css">
/* #aside {
	position: absolute;
	left: 0;
} */

.mainleft {
	padding-top: 30px;
	padding-left: 20px;
	width: 1300px;
	height: 500px;
}

.checkin {
	/* 버튼 디자인  */
	
}

.checkout {
	/* 버튼 디자인  */
}

.board-table {
	border: 3px solid #47c9af;
	width: 150%;
}

th {
	text-align: center;                 
	padding: 1em;
	background-color: #47c9af;
	opacity: 0.5;
	color: white;
}

table.greenTable {
  font-family: Georgia, serif;
  border: 6px solid #24943A;
  background-color: #D4EED1;
  text-align: center;
  width : 50%;
}
table.greenTable td, table.greenTable th {
  border: 1px solid #24943A;
  padding: 3px 2px;
}
table.greenTable tbody td {
  font-size: 13px;
}
table.greenTable thead {
  background: #24943A;
  background: -moz-linear-gradient(top, #5baf6b 0%, #3a9e4d 66%, #24943A 100%);
  background: -webkit-linear-gradient(top, #5baf6b 0%, #3a9e4d 66%, #24943A 100%);
  background: linear-gradient(to bottom, #5baf6b 0%, #3a9e4d 66%, #24943A 100%);
  border-bottom: 0px solid #444444;
}
table.greenTable thead th {
  font-size: 19px;
  font-weight: bold;
  color: #F0F0F0;
  text-align: left;
  border-left: 2px solid #24943A;
}
table.greenTable thead th:first-child {
  border-left: none;
}

table.greenTable tfoot {
  font-size: 13px;
  font-weight: bold;
  color: #F0F0F0;
  background: #24943A;
  background: -moz-linear-gradient(top, #5baf6b 0%, #3a9e4d 66%, #24943A 100%);
  background: -webkit-linear-gradient(top, #5baf6b 0%, #3a9e4d 66%, #24943A 100%);
  background: linear-gradient(to bottom, #5baf6b 0%, #3a9e4d 66%, #24943A 100%);
  border-top: 1px solid #24943A;
}
table.greenTable tfoot td {
  font-size: 13px;
}
table.greenTable tfoot .links {
  text-align: right;
}
table.greenTable tfoot .links a{
  display: inline-block;
  background: #FFFFFF;
  color: #24943A;
  padding: 2px 8px;
  border-radius: 5px;
  
}
tr:nth-child(even){background-color: #f2f2f2}


body {
	margin: 0;
	margin-left: 40px;
	margin-right: 40px;
	height:100%;
}

#header {
	height:70px;
}

#container {
	margin-right: 0px;
	padding-top: 20px;
}


li {
	width: 200px;
}
</style>



<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="./resources/js/jquery.animateNumber.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

	   

	});
	
</script>
</head>
<body>
	
	<div id="mainleft" class="col-sm-9">
		<!-- 전자결재 -->
		<table class="table table-hover">
			<thead>
				<tr>
					<th>no.</th>
					<th>결재명</th>
					<th>작성일</th>
					<th>결재종류</th>
					<th>신청자명</th>
					<th>결재상태</th>
				</tr>
			</thead>
			<tbody>
				<%=html1 %>
				<%=html2 %>
				<%=html3 %>
			<!-- 
			<tr>
				<td>1</td>
				<td onClick="location.href='./auth5.do'">휴가에 대한 건</td>
				<td>2019.10.01</td>
				<td>휴가</td>
				<td>마승호</td>
				<td>결재대기중</td>
			</tr>
			
			<tr>
				<td>2</td>
				<td>교통비에 대한 건</td>
				<td>2019.10.01</td>
				<td>교통비</td>
				<td>홍길동</td>
				<td>결재완료</td>
			</tr>
			
			<tr>
				<td>3</td>
				<td>출장에 대한 건</td>
				<td>2019.10.01</td>
				<td>출장</td>
				<td>박문수</td>
				<td>결재대기중</td>
			</tr>
			
			 -->
			
			</tbody>
		</table>

	</div>

</body>
</html>
