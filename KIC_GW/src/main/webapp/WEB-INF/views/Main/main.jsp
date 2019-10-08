<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String eno = (String)session.getAttribute("eno");
	String level = (String)session.getAttribute("level");
	String ename = (String)session.getAttribute("ename");
	 
	if(eno == null || eno.equals("")) {
		out.println("<script type='text/javascript'>");
		out.println("alert('로그인이 필요합니다.')");
		out.println("location.href='./login.do'");
		out.println("</script>");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<title>메인페이지</title>
<style type="text/css">
body {
	font-family: 'Malgun Gothic';
}
.checkin-time {
	margin-top: 10px;
}
.checkin, .checkout {
	margin-top: 10px;
	text-align: center;
}

.row {

	margin-top: 40px;
	margin-right: 10px;
	margin-bottom: 100px;
}
#mainleft {
	padding: 15px;
}

.clock-form {
	padding-top: 5px;
	border-radius: 10px;
	border: 5px solid #353535;
	text-align: center;
	height: 130px;
}

#clock {
	color: black;
	font-family: 'Malgun Gothic';
	font-size: 50px;
}

table {
font-family: 'Malgun Gothic';
font-size: 18px;
width: 100% ;
margin: 20px;
}

 
table.one {                                  
margin-bottom: 3em; 
border-collapse:collapse;   }   
 
td {                            /* removed the border from the table data rows  */
text-align: center;     
width: 10em;                    
padding: 3px;       }       
 
th {
text-align: center;                 
padding: 1em;
background-color: #56bafc;
color: black;
}
 
tr {    
height:     }
 
table tr:nth-child(even) {            /* added all even rows a #eee color  */
    background-color: #eee;     }
 
table tr:nth-child(odd) {            /* added all odd rows a #fff color  */
background-color:#fff;      }

.checkbox {
	margin-bottom: 10px;
}
.calday {
	margin-bottom:0;
}
.title {
	text-align: left;
}
</style>
<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="./resources/js/jquery.animateNumber.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	/* 	// 현재 시각 출력 함수호출
		printClock();
		 */
		var checkinout = function( eno ) {
			$.ajax({
				url: './checkinout.do',
				type: 'get',
				data: {
					eno: eno
				},
				cache: false,
				dataType: 'JSON',
				success: function( json ) {
					results = json.results;
					$.each( results, function() {
						var checkin = this.checkin;
						var checkout = this.checkout;
						
						if( checkin == '' || checkin == null ) {
							$('.checkin-time').html('출근시간 : 미확인');
						}else {
							var intime = checkin.split(' ');
							$( '.checkin-time').html( '출근시간 : ' + intime[1].substring(0,8) );
							$('.checkin').val('출근완료').prop( 'disabled', true );
						}
						
						if( checkout == '' || checkout == null ) {
							$('.checkout-time').html('퇴근시간 : 미확인');
						} else {
							var outtime = checkout.split(' ');
							$( '.checkout-time').html( '퇴근시간 : ' + outtime[1].substring(0,8) );
							$('.checkout').val('퇴근완료').prop( 'disabled', true );
						}
						
						
					});
				}
			});
		} // end of checkinout
		
		// 출근, 퇴근 시간 출력
		checkinout(<%=eno%>);
		
		var checkin = function( eno, indate ) {
			$.ajax({
				url: './checkin.do',
				type: 'get',
				data: {
					eno: eno,
					date: indate
				},
				dataType: 'JSON',
				success: function( json ) {
					results = json.results;
					$( results ).each( function() {
						var flag = this.flag;
						if( flag == 0 ) {
							swal({
								  title: '출근 처리 되었습니다.',
								  icon: 'success'
								});
							var intime = indate.split(' ');
							$( '.checkin-time').html( '출근시간 : ' + intime[1] );
							$('.checkin').val('출근완료').prop( 'disabled', true );
						}else {
							swal({
								  title: '출근하기에 실패하였습니다.',
								  text: '계속 문제가 있을시 담당관리자에게 문의 하시기 바랍니다',
								  icon: 'warning'
								});
						}
					});
				},
				error: function( xhr, status, error ) {
					alert( '에러 : ' + status + '\n\n' + error );
				}
			});
		} // end of checkin
		var checkout = function( eno, outdate ) {
			
			$.ajax({
				url: './checkout.do',
				type: 'get',
				data: {
					eno: eno,
					date: outdate
				},
				dataType: 'JSON',
				success: function( json ) {
					results = json.results;
					$( results ).each( function() {
						var flag = this.flag;
						if( flag == 0 ) {
							swal({
								  title: '퇴근 처리 되었습니다.',
								  icon: 'success'
								});
							var outtime = outdate.split(' ');
							$( '.checkout-time').html( '퇴근시간 : ' + outtime[1] );
							$('.checkout').val('퇴근완료').prop( 'disabled', true );
						}else {
							swal({
								  title: '퇴근하기에 실패하였습니다.',
								  text: '계속 문제가 있을시 담당관리자에게 문의 하시기 바랍니다',
								  icon: 'warning'
								});
						}
					});
				},
				error: function( xhr, status, error ) {
					alert( '에러 : ' + status + '\n\n' + error );
				}
			});
		} // end of checkout
		var indate = '';
		/* 출근하기 눌렀을때 초까지 저장 */
		$('.checkin').on('click', function() {
			// 출근 시간
			indate = printClock();
			checkin( <%=eno %>, indate );
			
		});
		var outdate = '';
		/* 퇴근하기 눌렀을 때 */
		$('.checkout').on('click', function() {
				outdate = printClock();
				checkout( <%=eno%>, outdate );
		});
		
		
		$('.count').animateNumber({
			number: 6
		});
		
	});
	function printClock() {

		var week = [ '일', '월', '화', '수', '목', '금', '토' ];
		var clock = document.getElementById("clock"); // 출력할 장소 선택
		var currentDate = new Date(); // 현재시간
		var calendar = currentDate.getFullYear() + "-"
				+ (currentDate.getMonth() + 1) + "-" + currentDate.getDate() // 현재 날짜
		var currentHours = addZeros(currentDate.getHours(), 2);
		var currentMinute = addZeros(currentDate.getMinutes(), 2);
		var currentSecond = addZeros(currentDate.getSeconds(), 2);
		var currentSeconds = addZeros(currentDate.getSeconds(), 2);

		if (currentSeconds >= 0) {		// 50초 이상일 때 색을 변환해 준다.
			currentSeconds = '<span style="color:grey;">' + currentSeconds
					+ '</span>'
		}
		// 요일 출력 구문 
		var dayWeek = week[currentDate.getDay()];
		clock.innerHTML = "<div class='calday' style='font-size: 20px'>" + calendar + ' (' +dayWeek + ') '
				+ "</div>" + currentHours + ":" + currentMinute + ":"
				+ currentSeconds; //날짜를 출력해 줌

		setTimeout("printClock()", 1000); // 1초마다 printClock() 함수 호출

		return calendar + " " + currentHours + ":" + currentMinute + ":" + currentSecond;
	}

	function addZeros(num, digit) { // 자릿수 맞춰주기
		var zero = '';
		num = num.toString();
		if (num.length < digit) {
			for (i = 0; i < digit - num.length; i++) {
				zero += '0';
			}
		}
		return zero + num;
	}
	
	// 페이지 새로고침
	 if (self.name != 'reload') {
         self.name = 'reload';
         self.location.reload(true);
     }
     else self.name = ''; 
	
</script>
</head>
<body onload="javascript:printClock();">
	<div id="wrapper">
		<%@include file="../Menu/topmenu.jsp"%>
		<div id="container">
		<div class="row">
			<div id="aside" class="col-sm-2">
				<!-- 출결 체크박스 -->
				<div class="checkbox"><img alt="check" src="./resources/img/check.png" width="20" /> 근태관리</div>
				<div class="clock-form">
					<div id="clock"></div>
				</div>
				<div>
					<div class="checkin-time">출근시간 : 미확인</div>
					<div class="checkout-time">퇴근시간 : 미확인</div>
					<button class="btn btn-outline-dark checkin">출근하기</button>&nbsp;&nbsp;
					<button class="btn btn-outline-dark checkout">퇴근하기</button>
				</div>
			</div>

			<div id="mainleft" class="col-sm-4">
				<!-- 공지사항 -->
				<div class="board">
					<h3>공지사항</h3>
					<table class="board-table">
						<thead>
							<tr>
								<th scope="col" class="title">제목</th>
								<th scope="col" class="date">작성일</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="title"><a href="#">(공지) 하반기 실적 </a></td>
								<td class="date">2019-09-29 14:24:32</td>
							</tr>
							<tr>
								<td class="title"><a href="#">(공지) 그룹웨어 도입</a></td>
								<td class="date">2019-09-25 17:12:02</td>
							</tr>
							<tr>
								<td class="title"><a href="#">(공지) 회사 워크샵 공지 </a></td>
								<td class="date">2019-09-22 11:35:09</td>
							</tr>
							<tr>
								<td class="title"><a href="#">(공지) 상반기 실적 </a></td>
								<td class="date">2019-06-18 14:45:29</td>
							</tr>
						</tbody>
					</table>
					<a href="#" class="more"><img
						src="http://img.echosting.cafe24.com/skin/base_ko_KR/board/btn_board_more.gif" alt="더보기" /></a>
				</div>

				<div class="sign" style="padding-top: 60px;">
				<h3>전자결재</h3>
					<table class="greenTable">
						<thead>
							<tr>
								<th colspan="5">나의 결재대기 문서</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="5" class="count" style="color:black; font-size: 40px; font-weight: bold;">0</td>
							</tr>
						</tbody>
					</table>
					<a href="#" class="more"><img
						src="http://img.echosting.cafe24.com/skin/base_ko_KR/board/btn_board_more.gif" alt="더보기" /></a>
				</div>
			</div>
			<div class="col-sm-5" style="margin-left: 30px; padding: 15px;">
			<h3>TO DO</h3>
				<table class="todo-cop">
						<thead>
							<tr>
								<th colspan="5">오늘 회사는?</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="5" style="color:black; font-size: 20px; background: #eee">
									일정 없음
								</td>
							</tr>
						</tbody>
					</table>
					<table class="todo-group">
						<thead>
							<tr>
								<th colspan="5">오늘 우리 부서는?</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="5" style="color:black; font-size: 20px; background: #eee">
									부서 회식
								</td>
							</tr>
						</tbody>
					</table>
					<table class="todo-me">
						<thead>
							<tr>
								<th colspan="5">오늘 나는?</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="5" style="color:black; font-size: 20px; background: #eee">
									KIC 그룹웨어 사용법 터득하기
								</td>
							</tr>
						</tbody>
					</table>
					<a href="#" class="more"><img
						src="http://img.echosting.cafe24.com/skin/base_ko_KR/board/btn_board_more.gif" alt="더보기" /></a>
			</div>
			</div>
		</div>
	</div>
	<script src="./resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
