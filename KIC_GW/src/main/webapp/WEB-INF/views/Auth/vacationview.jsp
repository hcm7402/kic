<%@page import="com.kic.groupware.model1.auth.AuthvacationTO"%>
<%@page import="com.kic.groupware.model1.auth.AuthTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String eno = (String)session.getAttribute("eno");
	session.setAttribute("eno", eno);
	
	AuthTO to = (AuthTO)request.getAttribute( "to" );
	
	String vdate = to.getDate();
	String ename = to.getEname();
	String job = to.getJob();
	String deptno = to.getDeptno();
	
	/* if(job.equals("0")){
		job = "사원";
	} else if(job.equals("1")){
		job = "팀장";
	} else if(job.equals("2")){
		job = "과장";
	} else if(job.equals("3")){
		job = "부사장";
	} else if(job.equals("4")){
		job = "사장";
	} */
	if(deptno.equals("1")){
		deptno = "개발부";
	} else if(deptno.equals("2")){
		deptno = "인사부";
	} else if(deptno.equals("3")){
		deptno = "총무부";
	} else if(deptno.equals("4")){
		deptno = "재무부";
	}
	
	AuthvacationTO to1 = (AuthvacationTO)request.getAttribute("to1");
	String vno = to1.getVno();
	String vtype = to1.getVtype();
	String vstart = to1.getVstart();
	String vend = to1.getVend();
	String vreason = to1.getVreason();	
	
	
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
<title>전자결재 페이지(휴가신청서)</title>
<style type="text/css">
/* #aside {
	position: absolute;
	left: 0;
} */

.mainleft {
	padding-top: 30px;
	padding-left: 20px;
	width: 1300px;
	height: 700px;
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

table{
	text-align: center; 
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

button {
  color: #4f4f4f;
}

.button {
  display: inline-block;
  padding: 12px 24px;
  border: 1px solid #4f4f4f;
  border-radius: 4px;
  transition: all 0.2s ease-in;
  position: relative;
  overflow: hidden;
}
.button:before {
  content: "";
  position: absolute;
  left: 50%;
  transform: translateX(-50%) scaleY(1) scaleX(1.25);
  top: 100%;
  width: 140%;
  height: 180%;
  background-color: rgba(0, 0, 0, 0.05);
  border-radius: 50%;
  display: block;
  transition: all 0.5s 0.1s cubic-bezier(0.55, 0, 0.1, 1);
  z-index: -1;
}
.button:after {
  content: "";
  position: absolute;
  left: 55%;
  transform: translateX(-50%) scaleY(1) scaleX(1.45);
  top: 180%;
  width: 160%;
  height: 190%;
  background-color: #39bda7;
  border-radius: 50%;
  display: block;
  transition: all 0.5s 0.1s cubic-bezier(0.55, 0, 0.1, 1);
  z-index: -1;
}
.button:hover {
  color: #ffffff;
  border: 1px solid #39bda7;
}
.button:hover:before {
  top: -35%;
  background-color: #39bda7;
  transform: translateX(-50%) scaleY(1.3) scaleX(0.8);
}
.button:hover:after {
  top: -45%;
  background-color: #39bda7;
  transform: translateX(-50%) scaleY(1.3) scaleX(0.8);
}

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
		function tree_menu() {
			  // $('.depth_2');
			  $('ul.depth_2 >li > a').click(function(e) {

			    var temp_el = $(this).next('ul');
			    var depth_3 = $('.depth_3');

			    // 처음에 모두 슬라이드 업 시켜준다
			    depth_3.slideUp(300);
			    // 클릭한 순간 모두 on(-)을 제거한다.// +가 나오도록
			    depth_3.parent().find('em').removeClass('on');

			    if (temp_el.is(':hidden')) {
			      temp_el.slideDown(300);
			      $(this).find('em').addClass('on').html('하위폴더 열림');
			    } else {
			      temp_el.slideUp(300);
			      $(this).find('em').removeClass('on').html('하위폴더 닫힘');
			    }

			    return false;

			  });
			}
			if ($('#tree_menu').is(':visible')) {
			  tree_menu();
			}
	});
	
</script>
</head>
<body>
	
	<form action="./vacation_ok.do" method="post" name="frm">
		<div id="mainleft" class="col-sm-7">
			<meta charset="UTF-8">
<span style="font-family: &quot;맑은 고딕&quot;; font-size: 10pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
<table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 1px; border-collapse: collapse;"><!-- Header --><colgroup><col width="310"><col width="490"></colgroup>
	<tbody>
		<tr>
			<td style="background: white; padding: 0px !important; border: 0px currentColor; height: 90px; text-align: center; color: black; font-size: 36px; font-weight: bold; vertical-align: top;" colspan="2" class="dext_table_border_t dext_table_border_r dext_table_border_b dext_table_border_l">
				
휴가 신청서
			</td>
		</tr>
		<tr>
			<td style="background: white; padding: 0px !important; border: currentColor; text-align: left; color: black; font-size: 12px; font-weight: normal; vertical-align: top;">
				
<table style="border: 1px solid rgb(0, 0, 0); font-family: malgun gothic, dotum, arial, tahoma; margin-top: 1px; border-collapse: collapse;"><!-- User --><colgroup><col width="100"><col width="220"></colgroup>
	<tbody>
		<tr>
			<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
				
기안자
			</td>
			<td name="ename" style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
			<%=ename %>
			</td>
		</tr>
		<tr>
			<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
				
기안부서
			</td>
			<td name="deptno" style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
			<%=deptno %><!-- <input name="deptno" class="ipt_editor" type="text"> -->
			</td>
		</tr>
		<tr>
			<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
				
기안일
			</td>
			<td name="vdate" style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
			<%=vdate %><!-- <input name="vdate" class="ipt_editor" type="text"> -->
			</td>
		</tr>
	</tbody>
</table>
			</td>
			<td style="background: white; padding: 0px !important; border: currentColor; text-align: right; color: black; font-size: 12px; font-weight: normal; vertical-align: top;">
				<!-- 에디터 &nbsp; 버그. 개행과 공백을 최소화 시키자. -->[결재선]
			</td>
		</tr>
	</tbody>
</table>
<table style="border: 0px solid rgb(0, 0, 0); width: 800px; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 10px; border-collapse: collapse;"><!-- 품의서 --><colgroup><col width="200"><col width="350"><col width="200"><col width="200"></colgroup>
	<tbody>
		<tr>
			<td style="padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; vertical-align: middle; background-color: rgb(221, 221, 221);" colspan="2">
				<span style="font-weight: bold; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">신청인</span>
			</td>
		</tr>
		<tr>
			<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
				
소속
			</td>
			<td name="deptno" style="background: rgb(255, 255, 255); border-width: medium 1px 1px; border-style: none solid solid; border-color: currentColor black black; padding: 5px; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;" colspan="3" class="dext_table_border_t">
			<%=deptno %><!-- <input name="deptno" class="ipt_editor" type="text"> -->
			</td>
		</tr>
		<tr>
			<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
				
직책
			</td>
			<td name="job" style="background: rgb(255, 255, 255); border-width: medium 1px 1px; border-style: none solid solid; border-color: currentColor black black; padding: 5px; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;" colspan="3" class="dext_table_border_t">
			<%=job %><!-- <input name="job" class="ipt_editor" type="text"> -->
			</td>
		</tr>
		<tr>
			<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
				
성명
			</td>
			<td name="ename" style="background: rgb(255, 255, 255); border-width: medium 1px 1px; border-style: none solid solid; border-color: currentColor black black; padding: 5px; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;" colspan="3" class="dext_table_border_t">
			<%=ename %><!-- <input name="ename" class="ipt_editor" type="text"> -->
			</td>
		</tr>
		<tr>
			<td style="padding: 5px; border: currentColor; height: 20px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; vertical-align: middle; background-color: rgb(255, 255, 255);" colspan="4">
				<p style="font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: 22px; margin-top: 0px; margin-bottom: 0px;"><br></p>
			</td>
		</tr>
		<tr>
			<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
				
휴가종류
			</td>
			<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;" colspan="3">
			<%=vtype %>
			</td>
		</tr>
		<tr>
			<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
				
휴가기간
			</td>
			<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; vertical-align: middle;">
			<%=vstart %> ~ <%=vend %>
			</td>
			
		</tr>
		<tr>
			<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
				
휴가사유
			</td>
			<td style="background: rgb(255, 255, 255); border-width: medium 1px 1px; border-style: none solid solid; border-color: currentColor black black; padding: 5px; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;" colspan="3" class="dext_table_border_t">
			<%=vreason %>
			</td>
		</tr>
		<tr>
			<td style="border-width: medium 1px 1px; border-style: none solid solid; border-color: currentColor black black; padding: 5px; height: 100px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; vertical-align: middle; background-color: rgb(255, 255, 255);" colspan="4" class="dext_table_border_t">
				<span style="font-weight: bold; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">휴가기준 제 13조에 의거 휴가를 신청하오니 허락하여 주시기 바랍니다.</span>
			</td>
		</tr>
	</tbody>
</table>
</span>
<p style="font-family: &quot;맑은 고딕&quot;; font-size: 10pt; line-height: 20px; margin-top: 0px; margin-bottom: 0px;"><br></p>
		</div>
		<!-- <button class="button" style="color:#4f4f4f; margin-bottom:50px;float:right;text-decoration:none">신청</button> -->
		
	</form>
	
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
