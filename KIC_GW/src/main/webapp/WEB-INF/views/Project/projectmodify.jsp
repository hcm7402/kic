<%@page import="com.kic.groupware.project.ProjectTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String eno = (String) session.getAttribute("eno");
	String ename = (String) session.getAttribute("ename");

	ProjectTO to = (ProjectTO) request.getAttribute("to");
	
	String pjseq = to.getPjseq();
	String leader = to.getPjleader();
	String leader_photo = to.getePhoto();
	String title = to.getPjname();
	String content = to.getPjcontent();
	String start = to.getStartdate();
	String end = to.getEnddate();
	
	StringBuffer br = new StringBuffer();
	br.append("<div class='photo'>");
	br.append("<img src='./resources/photo/" + leader_photo + "' class='img' />");
	br.append("</div>");
	br.append("<div class='team'>" + ename + "</div>");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<link rel="stylesheet" href="./resources/css/projectmodify.css">
<link rel="stylesheet" href="./resources/css/bootstrap-datepicker3.css">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<script src="./resources/js/bootstrap-datepicker.min.js"></script>
<script src="./resources/js/bootstrap-datepicker.ko.min.js"></script>
<script src="./resources/js/mdb.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<title>프로젝트 수정</title>
<style type="text/css">
body {
	font-family: 'Malgun Gothic';
	margin-left: 40px;
	margin-right: 40px;
}
</style>
<script type="text/javascript">
	$(document).ready( function() {
		
		var teamlist = function() {
			$.ajax({
				url: './teamlist.do',
				type: 'get',
				dataType: 'JSON',
				async: false,
				cache: false,
				success: function( json ) {
					results = json.results;
					$.each( results, function(index, item) {
						var eno = this.eno;
						var ename = this.ename;
						var deptno = this.deptno;
						var ePhoto = this.ePhoto;
						
						if( deptno == 1 ) {
							var html = '<li class="nav-item"><a class="nav-link push" data-dept=' +deptno+ ' data-value="' + item.eno + '">';
							html += '<div class="photo">';
							html += '<img src="./resources/photo/' + ePhoto +'" class="img" />';
							html += '</div>';
							html += '<div class="team">' + ename + '</div></a></li>';
							$('.team1').append( html );
						
						}else if( deptno == 2 ) {
							var html = '<li class="nav-item"><a class="nav-link push" data-dept=' +deptno+ ' data-value="' + item.eno + '">';
							html += '<div class="photo">';
							html += '<img src="./resources/photo/' + ePhoto +'" class="img" />';
							html += '</div>';
							html += '<div class="team">' + ename + '</div></a></li>';
							$('.team2').append( html );
						}else if( deptno == 3 ) {
							var html = '<li class="nav-item"><a class="nav-link push" data-dept=' +deptno+ ' data-value="' + item.eno + '">';
							html += '<div class="photo">';
							html += '<img src="./resources/photo/' + ePhoto +'" class="img" />';
							html += '</div>';
							html += '<div class="team">' + ename + '</div></a></li>';
							$('.team3').append( html );
						}
					})
				}
			});
		}
		
		teamlist();
		
		$('.start-date').datepicker({
			format : 'yyyy-mm-dd',
			language : 'ko'
		});
		$('.end-date').datepicker({
			format : 'yyyy-mm-dd',
			language : 'ko'
		});

		$('.click').on('click', function() {
			if ($('.team1').is(':visible')) {
				$('.team1').hide();
			} else {
				$('.team1').show();
			}
		});

		$('.click2').on('click', function() {
			if ($('.team2').is(':visible')) {
				$('.team2').hide();
			} else {
				$('.team2').show();
			}
		});
		
		$('.click3').on('click', function() {
			if ($('.team3').is(':visible')) {
				$('.team3').hide();
			} else {
				$('.team3').show();
			}
		});
	
		// 팀원 추가
			$( document ).on('click', '.push', function() {
				var result = $(this).html();
				// eno 값
				var value = $(this).attr('data-value');
				// 부서번호
				var deptno = $(this).attr('data-dept');
				
				var html = '<tr class="in"><td class="out" data-dept=' +deptno+ ' data-value=' + value + '>' + result + '</td></tr>';
				
				$('.addemp').append( html );
				if( $(this).attr('data-value') == value ) {
					$(this).remove();
				}
			});
			// 팀원 제거
			$('.create3').on( 'click', 'table .addemp .in .out',function() {
				var ename = $(this).html();
				var deptno = $(this).attr('data-dept');
				var eno = $(this).attr('data-value');
				
				if( deptno == 1 ) {
					$('.team1').append('<li class="nav-item"><a class="nav-link push" data-dept=' +deptno+ ' data-value="' + eno + '">'+ ename +'</a></li>');
					$(this).remove();
				}else if ( deptno == 2 ) {
					$('.team2').append('<li class="nav-item"><a class="nav-link push" data-dept=' +deptno+ ' data-value="' + eno + '">'+ ename +'</a></li>');
					$(this).hide();
				}else if( deptno == 3 ) {
					$('.team3').append('<li class="nav-item"><a class="nav-link push" data-dept=' +deptno+ ' data-value="' + eno + '">'+ ename +'</a></li>');
					$(this).hide();
				}
				
			});
			
			var modifyok = function( leader, name, start, end, content, team, state ) {
				$.ajax({
					url: './projectmodify_ok.do',
					type: 'get',
					data: {
						pjseq: <%=pjseq %>,
						leader: leader,
						name: name,
						start: start,
						end: end,
						content: content,
						team: team,
						state: state
					},
					dataType: 'JSON',
					success: function( json ) {
						results = json.results;
						$(results).each( function() {
							var flag = this.flag;
							if( flag == 0 ) {
								swal({
									  title: "프로젝트 수정에 성공하였습니다.",
									  icon: "success",
									})
									.then( function(willDelete) {
										  if (willDelete) {
											  location.href = 'project.do';
										  } 
										});
								
							}else {
								swal({
									  title: '프로젝트 수정에 실패하였습니다.',
									  icon: 'warning'
									})
									.then( function(willDelete) {
										  if (willDelete) {
											  location.href = 'project.do';
										  } 
										});
							}
						});
					}
				});
			} // end of modifyok
			
			// 수정하기 버튼 클릭 시
			$( document ).on( 'click', '.project-modify', function() {
				var leader = <%=eno%>;
				var name = $('#name').val();
				var start = $('.start-date').val();
				var end = $('.end-date').val();
				var content = $('#project-content').val();
				var teams = $('.addemp tr td');
				var team = '';
				$.each( teams, function() {
					team += $(this).attr('data-value') + ' ';
				});
				
				var starts = start.split('-');
				var startdate = starts[0] + starts[1] + starts[2];
				var state = $('#select').val();
				
				var ends = end.split('-');
				var enddate = ends[0] + ends[1] + ends[2];
				if( parseInt(startdate) > parseInt(enddate) ) {
					swal({
						  title: '시작일이 마감일보다 늦습니다.',
						  icon: 'warning'
						});
				}else if( leader == '' || leader == null ) {
					swal({
						  title: '담당자가 존재하지 않습니다.',
						  icon: 'warning'
						});
					return false;
				}else if( name == '' || name == null ) {
					swal({
						  title: '프로젝트 이름을 입력하셔야 합니다.',
						  icon: 'warning'
						});
					return false;
				}else if( start == '' || start == null ) {
					swal({
						  title: '프로젝트 시작날짜를 입력하셔야 합니다.',
						  icon: 'warning'
						});
					return false;
				}else if( end == '' || end == null ) {
					swal({
						  title: '프로젝트 마감날짜를 입력하셔야 합니다.',
						  icon: 'warning'
						});
					return false;
				}else if( content == '' || content == null ) {
					swal({
						  title: '프로젝트 개요를 입력하셔야 합니다.',
						  icon: 'warning'
						});
					return false;
				}else if( team == '' || team == null ) {
					swal({
						  title: '프로젝트 팀원을 선택하셔야 합니다.',
						  icon: 'warning'
						});
					return false;
				} else if( state == 0 || state == '' || state == null )  {
					swal({
						  title: '프로젝트 진행상태를 선택하셔야 합니다.',
						  icon: 'warning'
						});
					return false;
				} else {
					modifyok( leader, name, start, end, content, team, state );
				}
			});
			
			// 취소 버튼 클릭 시
			$( document ).on( 'click', '.project-cancle', function() {
				swal({
					  title: '정말 취소하시겠습니까?',
					  text: '작성하신 내용이 저장되지 않습니다.',
					  icon: 'warning'
					})
					.then( function(willDelete) {
						  if (willDelete) {
							  location.href = 'project.do';
						  } 
						});
			});
			
	});
</script>
</head>
<body>
<div class="project-form">
		<div>
			<div class="project-create col-md-6">
				<h1>프로젝트 수정</h1>
			</div>
			<div class="col-md-12" style="text-align: right;">
				<button class="btn btn-primary project-modify" >수정</button>
				<button class="btn btn-primary project-cancle" >취소</button>
			</div>
		</div>
		<form action="" class="create-form">
			<div class="create1 form-group">
				<div class="pro-title">
					<h5>프로젝트 담당자</h5>
				</div>
				<div class="leader"><%=br %></div>
				<div class="etc">* 프로젝트 담당자는 수정할 수 없습니다.</div>
				<label for="name">프로젝트 이름</label>
				<input type="text" class="form-control col-md-6 name" id="name" value="<%=title %>" /><br />
				<div class="form-row">
					<div class="form-group col-md-4">
						<label for="start-date">시작일</label> <input type="text"
							class="form-control start-date" id="start-date" value="<%=start %>"/>
					</div>&nbsp;&nbsp;&nbsp;&nbsp;
					<div class="form-group col-md-4">
						<label for="end-date">마감일</label> <input type="text"
							class="form-control end-date" id="end-date" value="<%=end %>" />
					</div>
				</div>
				<label for="project-content">프로젝트 개요</label>
				<textarea class="form-control col-md-8" id="project-content"
					rows="3"><%=content %></textarea>
				<br />
				<div class="project-state">
				<label for="#select">진행상태</label>
					<select class="browser-default custom-select" id="select" >
					  <option selected value="0">진행상태</option>
					  <option value="1">진행중</option>
					  <option value="2">보류</option>
					  <option value="3">완료</option>
					</select>
				</div>
			</div>

			<div class="create2 form-group">
				<div><h5>프로젝트 팀원</h5></div>
				<div class="container">
					<div class="row">
						<div class="col">
							<div class="add">
								<div class="click" style="float: left;">+</div>
								<div style="padding: 3px; margin-left: 5px;">개발팀</div>
								<ul class="nav team1">
								</ul>
							</div>
							<br />
							<div class="add">
								<div class="click2" style="float: left;">+</div>
								<div style="padding: 3px; margin-left: 5px;">인사팀</div>
								<ul class="nav team2">
								</ul>
							</div>
							<br />
							<div class="add">
								<div class="click3" style="float: left;">+</div>
								<div style="padding: 3px; margin-left: 5px;">재무팀</div>
								<ul class="nav team3">
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="create3 form-group">
				<table class="table table-borderless emp">
					<thead>
						<tr>
							<th>팀원이 추가됩니다.</th>
						</tr>
					</thead>
					<tbody class="addemp">
					</tbody>
				</table>
			</div>
		</form>
	</div>
</body>
</html>