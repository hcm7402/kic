<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String enos = (String) session.getAttribute("eno");
	System.out.println(enos);
%>
<style type="text/css">

.board-table {
	text-align: center;  
	border: 3px solid #56bafc;
	width: 100%;
	height: 100%;
	border-collapse: collapse;
}

.board-table th {
	text-align: center;   
	border-right: 2px solid #56bafc;          
	padding: 8px;
	background-color: #56bafc;
	opacity: 0.5;
	color: black;
}
.board-table td {
	border-right: 2px solid #56bafc;
	text-align: center;
	padding: 8px;
}
tr:nth-child(even){background-color: #f2f2f2}
</style>

<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript">
	var today = null;
	var year = null;
	var month = null;
	var firstDay = null;
	var lastDay = null;
	
	$(document).ready( function() {
		cal();
		drawcal();
		
		var managelist = function( enos ) {
			$.ajax({
				url: './managelist.do',
				type: 'get',
				data: {
					eno: enos
				},
				cache:false,
				dataType: 'JSON',
				success: function( json ) {
					results = json.results;
					$.each( results, function() {
						var mdate = this.mdate;
						var checkins = this.checkin;
						var checkouts = this.checkout;
						var total = this.total;
						var etc = this.etc;
						
						var checkin = checkins.split(' ');
						var checkout = '';
						if( checkouts == '' || checkouts == null ) {
								for ( var i =1; i<=31; i++ ) {
									var date = $('.date'+i).text();
									if( date == mdate ) {
										$( '.checkin'+i ).html(checkin[1].substring(0,8));
										$( '.checkout'+i ).html('');
										$( '.total'+i ).html( total );
										$( '.etc'+i ).html( etc );
									}
								}
							}else {
							checkout = checkouts.split(' ');
							for ( var i =1; i<=31; i++ ) {
								var date = $('.date'+i).text();
								if( date == mdate ) {
									$( '.checkin'+i ).html(checkin[1].substring(0,8));
									$( '.checkout'+i ).html(checkout[1].substring(0,8));
									$( '.total'+i ).html( total );
									$( '.etc'+i ).html( etc );
								}
						}
					}
				});
			}
		});
		}//end of manage
		managelist(<%=enos%>);
		
		
		$('.lastmonth').on( 'click', function() {
			month--;
			if( month <= 0 ) {
				month = 12;
				year--;
			}
			firstDay = new Date(year,month-1,1);
			lastDay = new Date(year,month,0);
			drawcal();
			managelist(<%=enos%>);
		});
		
		$('.nextmonth').on( 'click', function() {
			month++;
			if( month > 12 ) {
				month = 1;
				year++;
			}
			firstDay = new Date(year,month-1,1);
			lastDay = new Date(year,month,0);
			drawcal();
			managelist(<%=enos%>);
			console.log('asd');
		});
	});
	//달력 초기화
	function cal() {
		today = new Date();
		year = today.getFullYear();
		month = today.getMonth()+1;
		firstDay = new Date(year,month-1,1);
		lastDay = new Date(year,month,0);
	}
	// 년 월 일 출력
	function drawcal() {
		var html = '';
		for( var i=firstDay.getDate(); i<=lastDay.getDate(); i++ ) {
			html += '<tr>';
			var months = '';
			if( month < 10 ) {
				months = '0' + month;
			} else {
				months = month;
			}
				if( i < 10 ) {
					html += '<td class="date'+ i +'">' + year + '-' + months + '-0' + i + '</td>';
				} else {
					html += '<td class="date'+ i +'">' + year + '-' + months + '-' + i + '</td>';
				}
				html += '<td class="checkin'+ i +'"></td>';
				html += '<td class="checkout'+ i +'"></td>';
				html += '<td class="total'+ i +'"></td>';
				html += '<td class="etc'+ i +'"></td>';
				html += '</tr>';
			}
		$('.calendar').html( html );
	}
	
	// 페이지 새로고침
	/*   if (self.name != 'reload') {
        self.name = 'reload';
        self.location.reload(true);
    }
    else self.name = ''; */
</script>
		
		<div style="float: left; width: 33%;" >
		<button class="lastmonth">&lt;</button>
		</div>
		<div style="float: left; width: 34%;">
		<h3 style="text-align: center;">근태현황</h3>
		</div>
		<div style="float: left; width: 33%; text-align: right;">
		<button class="nextmonth">&gt;</button>
		</div>
		
	<table class="board-table" >
		<thead>
			<tr>
				<th scope="col" class="date">날짜</th>
				<th scope="col" class="in_time">출근 시간</th>
				<th scope="col" class="out_time">퇴근 시간</th>
				<th scope="col" class="total_time">근무 시간</th>
				<th scope="col" class="other">기타</th>
			</tr>
			
		</thead>
		<tbody class="calendar">
		</tbody>
	</table>

