<%@page import="java.io.Console"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="com.kic.groupware.model1.calendar.MonthTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%
	request.setCharacterEncoding("UTF-8");
	String eno = (String)session.getAttribute("eno");
	String level = (String)session.getAttribute("level");
	 
	if(eno == null || eno.equals("")) {
		out.println("<script type='text/javascript'>");
		out.println("alert('로그인이 필요합니다.')");
		out.println("location.href='./login.do'");
		out.println("</script>");
	}
	System.out.println(level);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<title>켈린더 일정 관리</title>
<style type="text/css">
#mainleft {
	border: 1px solid #000;
	padding: 15px;
}
.row {
	padding-left: 14px;
	padding-bottom: 30px;
	width: auto;
	height: auto;
}

.timeInput {
	font-family: 나눔고딕, NanumGothic;
	font-size: 4em;
	border: 1 #fff;
	color: #684816;
	text-align: center;
	padding: 30px;
	border-radius: 5px;
	font-weight: bold;
}

a {
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
.swal-button--confirm {
    background: #39bda7;
}
</style>
<link rel="stylesheet" href="./resources/css/bootstrap-datepicker.min.css">
<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="./resources/js/jquery.animateNumber.min.js"></script>
<script src="./resources/js/bootstrap-datepicker.min.js"></script>
<script src="./resources/js/bootstrap-datepicker.ko.min.js"></script>
<script src="./resources/js/project9.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
function fn_formSubmit(){
	if( $('#cdname').val() == '' ) {
		swal({
			  title: '일정명을 입력하셔야 합니다.',
			  icon: 'warning'
		});
		return false;
	} else if ( $('#startdate').val() == '' ) {
		swal({
			  title: '시작날짜를 선택 하셔야 합니다.',
			  icon: 'warning'
		});
		return false;
	} else if ( $('#enddate').val() == '' ) {
		swal({
			  title: '끝날짜를 선택 하셔야 합니다.',
			  icon: 'warning'
		});
		return false;
	} else if ( $("#startdate").val() > $("#enddate").val() ) {
		swal({
			  title: '날짜를 정확하게 선택하셔야 합니다.',
			  icon: 'warning'
		});
		return false;
	}
	
	swal({
		  title: "저장하시겠습니까?",
		  buttons: [true, "저장"],
		})
		.then(function(willDelete) {
			if (willDelete) {
			    swal("저장완료!", {
			      	icon: "success",
			      	button: false,
			    });
				setTimeout(function () {
					$("#form1").submit();
				}, 1000);
			} else {
				close: true;
			}
	});
}
$( document ).ready( function() {
	$('#startdate').datepicker({
		format: 'yyyy-mm-dd',
		language: 'ko'
	});
	$('#enddate').datepicker({
		format: 'yyyy-mm-dd',
		language: 'ko'
	});
});
</script>
</head>
<body>
	<div id="wrapper">
		<%@include file="../Menu/topmenu.jsp"%>
		<div id="container">
			<div class="row">
				<div class="col-sm-2">
					<%@include file="../Menu/calmenu.jsp"%>
				</div>
				<form id="form1" class="col-sm-10" name="form1" role="form" action="./cal_ok.do" method="post" >
					<input type="hidden" name="eno" value="<%= eno %>">
					<input type="hidden" name="deptno" value="0">
					<input type="hidden" name="cddiv" value="2">
					<div id="container" style="padding-top: 0">
						<div class="row">
							<div class="col-sm-2"></div>
							<div class="col-sm-8" class="panel panel-default">
								<div class="panel-body">
									<div class="row form-group" style="text-align: center;">
										<div class="col-lg-1"></div>
										<div class="col-lg-8">
				                            <h2>개인 일정 추가</h2>
				                        </div>
				                        <div class="col-lg-2"></div>
			                        </div>
									<div class="row form-group">
			                            <label class="col-lg-2">일정명</label>
			                            <div class="col-lg-8">
			                            	<input type="text" class="form-control" id="cdname" name="cdname" maxlength="50" 
			                            	value="<c:out value="${caldata.cdname}"/>">
			                            </div>
			                        </div>
			                        <div class="row form-group">
			                            <label class="col-lg-2">구분</label>
			                            <div class="col-lg-2">
											<select id="cddivision" name="cddivision" class="form-control">
												<c:forTokens var="item" items="업무,회의,외근,출장,교육,휴가,기타" delims=",">
					                           		<option value="${item}" <c:if test='${item==caldata.cddivision}'>selected</c:if>>${item}</option>
											 	</c:forTokens>
											</select>
			                            </div>
			                        </div>
									<div class="row form-group">
										<label class="col-lg-2">일정 날짜</label>
										<div class="col-lg-2">
										<input class="form-control" size="16" id="startdate" name="startdate" value="<c:if test='${searchVO.date != null and caldata.cdno == null}'>${searchVO.date}</c:if><c:if test='${caldata.cdno != null}'><c:out value="${caldata.startdate}"/></c:if>" readonly>
										</div>
										<div class="col-sm-1" style="text-align: center;"><p>~</p></div>
										<div class="col-lg-2">
										<input class="form-control" size="16" id="enddate" name="enddate" value="<c:if test='${searchVO.date != null and caldata.cdno == null}'>${searchVO.date}</c:if><c:if test='${caldata.cdno != null}'><c:out value="${caldata.enddate}"/></c:if>" readonly>
										</div>
										<div class="col-sm-2"></div>
									</div>
									<div class="row form-group">
			                            <label class="col-lg-2">내용</label>
			                            	<div class="col-lg-8">
			                            	<textarea class="form-control" id="contents" name="contents" style="resize: none; height: 150px"><c:out value="${caldata.contents}"/></textarea>
			                            </div>
			                        </div>
			                        <div class="row form-group" style="float: right; margin-right: 138px">
			                            <a onclick="fn_formSubmit()" class="button" style="text-decoration:none">등록</a>
			                      		<a href="./cal.do" class="button" style="margin-left:10px; text-decoration:none">취소</a>
			                        </div>
								</div>
							</div>
							<div class="col-sm-2"></div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
