<%@page import="com.kic.groupware.project.ProjectTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String eno = (String) session.getAttribute("eno");

	ProjectTO to = (ProjectTO) request.getAttribute("to");

	String pjseq = to.getPjseq();
	String leader = to.getPjleader();
	String name = to.getPjname();
	String startdate = to.getStartdate();
	String enddate = to.getEnddate();
	String pjcontent = to.getPjcontent();
	String pjstate = to.getPjstate();
	String pjpercent = to.getPjpercent();
	String pjleader = to.getEname();
	
	String leaderPhoto = to.getePhoto();

	
	StringBuffer br = new StringBuffer();
	br.append("<div class='photo'>");
	br.append("<img src='./resources/photo/" + leaderPhoto + "' class='img' />");
	br.append("</div>");
	br.append("<div class='team'>" + pjleader + "</div>");
	
	int state = Integer.parseInt(pjstate);
	
	if( state == 1 ) {
		pjstate = "진행중";
	} else if( state == 2 ) {
		pjstate = "보 류";
	} else if( state == 3 ) {
		pjstate = "완 료";
	}
	
	ArrayList<ProjectTO> teamList = (ArrayList) request.getAttribute("teamsList");
	
	StringBuffer result = new StringBuffer();
	StringBuffer teamlist = new StringBuffer();
	for( ProjectTO pto : teamList ) {
		String teamno = pto.getEno();
		String team = pto.getTeam();
		String teamPhoto = pto.getePhoto();
		
		result.append("<li>");
		result.append("<div class='photo'>");
		result.append("<img src='./resources/photo/" + teamPhoto + "' class='img' />");
		result.append("</div>");
		result.append( "<div class='team'>"+ team +"</div>" );
		result.append("</li>");
		
		teamlist.append("<li>");
		teamlist.append("<a class='push' data-eno=" + teamno + ">");
		teamlist.append("<div class='photo'>");
		teamlist.append("<img src='./resources/photo/" + teamPhoto + "' class='img' />");
		teamlist.append("</div>");
		teamlist.append( "<div class='team'>"+ team +"</div>" );
		teamlist.append("</a>");
		teamlist.append("</li>");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<link rel="stylesheet" href="./resources/css/projectview.css">
<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$( document ).ready( function() {
		
		percent(<%=pjpercent %>);
		
		function percent( pjpercent ) {
			var state = <%=state %>;
			if( state == 1 ) {
				$('.pjpercent > span').css('backgroundColor', '#6aeb6a');
				$('.pjpercent > span').animate({
					width: pjpercent + '%'
				}, 1500);
			} else if( state == 2 ) {
				$('.pjpercent > span').css('backgroundColor', '#454545');
				$('.pjpercent > span').animate({
					width: pjpercent + '%'
				}, 1500);
			} else if( state == 3 ) {
				$('.pjpercent > span').css('backgroundColor', '#56bafc');
				$('.pjpercent > span').animate({
					width: pjpercent + '%'
				}, 1500);
			}
		}
		
		var tasklist = function( pjseq ) {
			$.ajax({
				url: './tasklist.do',
				type: 'get',
				data: {
					pjseq: pjseq
				},
				cache: false,
				dataType: 'JSON',
				success: function( json ) {
					results = json.results;
					$( results ).each( function() {
						var t_leader = this.t_leader;
						var t_title = this.t_title;
						var t_content = this.t_content;
						var t_state = this.t_state;
						
						var html = '<li>';
						html += '<div class="task-title" style="font-size: 16px; font-family: Malgun Gothic; font-weight: bold;">' + t_title + '</div>';
						html += '<div class="task-content">' + t_content + '</div>';
						html += '<div class="task-progress progress-" style=" margin: 5px;">';
						html += '<span></span></div>'
						html += '<div class="custom-control custom-radio" style="float: left;">';
						html += '<input type="radio" name="jb-radio" id="jb-radio-1" class="custom-control-input">';
						html += '<label class="custom-control-label" for="jb-radio-1">진행</label>';
						html += '</div>';
						html += '<div class="custom-control custom-radio" style="float: left; margin-left: 10px;">';
						html += '<input type="radio" name="jb-radio" id="jb-radio-2" class="custom-control-input">';
						html += '<label class="custom-control-label" for="jb-radio-2">완료</label>';
						html += '</div>';
						html += '<button class="btn btn-primary" style="float: right; margin-left: 4px;">삭제</button>';
						html += '<button class="btn btn-primary" style="float: right;">수정</button></li>';
						
						$('.tasklist').append( html );
					});
				}
			});
		} //end of tasklist
		tasklist( <%=pjseq %> );
		
		var deleteproject = function( pjseq, password ) {
			$.ajax({
				url: './deleteproject.do',
				type: 'post',
				data: {
					pjseq: pjseq,
					pjleader: <%=leader %>,
					password: password
				},
				dataType: 'JSON',
				cache: false,
				success: function( json ) {
					results = json.results;
					$( results ).each( function() {
						var flag = this.flag;
						
						if( flag == 0 ) {
							swal({
								  title: "프로젝트가 삭제 되었습니다.",
								  icon: "success",
								})
								.then( function(willDelete) {
									  if (willDelete) {
										  history.go(0);
									  } 
									});
							
						}else {
							swal({
								  title: '프로젝트 삭제에 실패하였습니다.',
								  icon: 'warning'
								})
								.then( function(willDelete) {
									  if (willDelete) {
										  history.go(0);
									  } 
									});
						}
					});
				}
			});
		}
		// 리더 추가 시
		$( document ).on('click', '.push', function() {
			var result = $(this).html();
			
			var eno = $(this).attr('data-eno');
			
			var html = '<tr class="in"><td class="out" data-eno=' + eno + '>' + result + '</td></tr>';
			
			$('.addleader').append( html );
			if( $(this).attr('data-eno') == eno ) {
				$(this).remove();
			}
		});
		
		// 리더 제거 시
		$( document ).on( 'click', 'table .addleader .in .out', function() {
			var result = $(this).html();
			
			var eno = $(this).attr('data-eno');
			
			var html = '<li><a class="push" data-value="' + eno + '">'+ result +'</a></li>';
			
			$('.task-team').append( html );
			if( $(this).attr('data-eno') == eno ) {
				$(this).remove();
			}
		});
		
		$( document ).on( 'click', '#jb-radio-1', function() {
			$('.task-progress > span').css('backgroundColor', '#6aeb6a');
			$('.task-progress > span').animate({
				width: '40%'
			}, 1000);
		});
		$( document ).on( 'click', '#jb-radio-2', function() {
			$('.task-progress > span').css('backgroundColor', '#56bafc');
			$('.task-progress > span').animate({
				width: '100%'
			}, 1000);
		});
		
		$('.submit-task').on( 'click', function() {
			var task_title = $('.task-subject').val();
			var task_content = $('#task-content').val();
			var task_leader = $('.addleader tr td').attr('data-eno');
			
			if( $('.addleader tr').length >= 2 ) {
				swal({
					  title: 'Task 리더는 한명만 지정할 수 있습니다.',
					  icon: 'warning'
					});
				return false;
			} else if( $('.addleader tr').length < 1 ) {
				swal({
					  title: 'Task 리더를 지정하셔야 합니다.',
					  icon: 'warning'
					});
				return false;
			} else if( task_title == '' || task_title == null ){
				swal({
					  title: 'Task 제목을 입력하셔야 합니다.',
					  icon: 'warning'
					});
				return false;
			} else if( task_content == '' || task_content == null ) {
				swal({
					  title: 'Task 본문을 입력하셔야 합니다.',
					  icon: 'warning'
					});
				return false;
			} else {
				taskadd( <%=pjseq%>, task_title, task_content, task_leader );
			}
			
			
		});
		
		var taskadd = function( pjseq, task_title, task_content, task_leader ) {
			$.ajax({
				url: './taskadd.do',
				type: 'get',
				data: {
					pjseq: pjseq,
					task_title: task_title,
					task_content: task_content,
					task_leader: task_leader
				},
				cache: false,
				dataType: 'JSON',
				success: function( json ) {
					results = json.results;
					$(results).each( function() {
						var flag = this.flag;
						
						if( flag == 0 ) {
								swal({
									  title: "Task 생성에 성공하였습니다.",
									  icon: "success",
									})
									.then( function(willDelete) {
										  if (willDelete) {
											  history.go(0);
										  } 
										});
								
							}else {
								swal({
									  title: 'Task 생성에 실패하였습니다.',
									  icon: 'warning'
									})
									.then( function(willDelete) {
										  if (willDelete) {
											  history.go(0);
										  } 
										});
							}
					});
				}
			});
		} // end of taskadd
		
		$( document ).on('click', '.dialog-delete', function() {
			var password = $('.project-password').val();
			
			swal({
				  title: '정말로 삭제하시겠습니까?',
				  text: 'Task도 삭제됩니다!',
				  icon: 'warning'
				})
				.then( function(willDelete) {
					  if (willDelete) {
						  deleteproject( <%=pjseq %>, password );
					  } 
					});
		});
		
		var modify = function() {
			$.ajax({
				url: './projectmodify.do',
				type: 'get',
				data: {
					pjseq: <%=pjseq %>
				},
				dataType: 'html',
				cache: false,
				success: function ( data ) {
					$('.contents1').html( data );
				}
			});
		} 
		
		$( document ).on('click', '.project-modify', function() {
			// 수정 창
			modify();
		});
		
		var commentlist = function() {
			$.ajax({
				url: './commentlist.do',
				type: 'get',
				data: {
					pjseq: <%=pjseq %>
				},
				dataType: 'JSON',
				cache: false,
				success: function( json ) {
					results = json.results;
					$( results ).each( function() {
						var c_seq = this.c_seq;
						var c_content = this.c_content;
						var c_date = this.c_date;
						var ename = this.ename;
						var ephoto = this.ephoto;
						var c_writer = this.c_writer;
						
						var html = '<tr>';
						html += '<td style="width: 20%; text-align: center;" data-seq=' + c_seq + '>';
						html += '<div class="photo">';
						html += '<img src="./resources/photo/' + ephoto + '" class="img" />';
						html += '</div>';
						html += '<div class="team">' + ename + '</div>';
						html += '<div>(' + c_date + ')</div>';
						html += '</td>';
						html += '<td style="width: 60%" class="c_content">' + c_content + '</td>';
						html += '<td style="width: 20%; text-align: center;">';
						if( c_writer == <%=eno %>) {
							html += '<button class="btn btn-primary" id="modify-comment" type="button" data-writer=' + c_writer + ' data-seq=' + c_seq + '>수정</button>&nbsp;';
							html += '<button class="btn btn-primary" id="delete-comment" type="button" data-writer=' + c_writer + ' data-seq=' + c_seq + '>삭제</button>';
						}
						html += '</td>';
						html += '</tr>';
						
						$('.comment-list').append( html );
					});
				}
			});
		} // end of commentList
		commentlist();
		
		var commentok = function( content ) {
			$.ajax({
				url: './comment_ok.do',
				type: 'get',
				data: {
					content: content,
					pjseq: <%=pjseq %>,
					eno: <%=eno %>
				},
				dataType: 'JSON',
				cache: false,
				success: function( json ) {
					results = json.results;
					$(results).each( function() {
						var flag = this.flag;
						
						if( flag == 0 ) {
							swal({
								  title: "댓글이 등록되었습니다.",
								  icon: "success",
								})
								.then( function(willDelete) {
									  if (willDelete) {
										  // commentlist 불러오기
										  $('.comment-list').html('');
										  
										  commentlist();
										  $('#comment').val('');
									  } 
									});
							
						}else {
							swal({
								  title: '댓글 등록에 실패하였습니다.',
								  icon: 'warning'
								})
								.then( function(willDelete) {
									  if (willDelete) {
										  commentlist();
									  } 
									});
						}
					});
				}
			});
		}// end of comment_ok
		
		var commentdelete = function( c_seq ) {
			$.ajax({
				url: './commentdelete.do',
				type: 'post',
				data: {
					eno: <%=eno %>,
					c_seq: c_seq
				},
				dataType: 'JSON',
				success: function( json ) {
					results = json.results;
					$( results ).each( function() {
						var flag = this.flag;
						
						if( flag == 0 ) {
							swal({
								  title: "댓글이 삭제되었습니다.",
								  icon: "success",
								})
								.then( function(willDelete) {
									  if (willDelete) {
										  // commentlist 불러오기
										  $('.comment-list').html('');
										  
										  commentlist();
										  $('#comment').val('');
									  } 
									});
							
						}else {
							swal({
								  title: '댓글 삭제에 실패하였습니다.',
								  icon: 'warning'
								})
								.then( function(willDelete) {
									  if (willDelete) {
										  $('.comment-list').html('');
										  commentlist();
									  } 
									});
						}
					});
				}
			});
		} // end of commentdelete
		
		var commentmodify = function( c_seq, c_writer, c_content ) {
			$.ajax({
				url: './commentmodify.do',
				type: 'get',
				data: {
					c_seq: c_seq,
					c_writer: c_writer,
					c_content: c_content
				},
				dataType: 'JSON',
				success: function( json ) {
					results = json.results;
					$( results ).each( function() {
						var flag = this.flag;
						
						if( flag == 0 ) {
							swal({
								  title: "댓글이 수정되었습니다.",
								  icon: "success",
								})
								.then( function(willDelete) {
									  if (willDelete) {
										  // commentlist 불러오기
										  $('.comment-list').html('');
										  
										  commentlist();
										  $('#comment').val('');
									  } 
									});
							
						}else {
							swal({
								  title: '댓글 수정에 실패하였습니다.',
								  icon: 'warning'
								})
								.then( function(willDelete) {
									  if (willDelete) {
										  $('.comment-list').html('');
										  commentlist();
									  } 
									});
						}
					});
				}
			});
		}
		
		// 댓글 등록 버튼 클릭 시
		$( document ).on('click', '.comment-submit', function() {
			var content = $('#comment').val();
			
			if( content == '' || content == null ) {
				swal({
					  title: '댓글 내용을 작성하셔야 합니다.',
					  icon: 'warning'
					});
				return false;
			} else {
				commentok( content );
			}
		});
		
		// 댓글 삭제 버튼 클릭 시
		$( document ).on( 'click', '#delete-comment', function() {
			var c_seq = $(this).attr('data-seq');
			var c_writer = $(this).attr('data-writer');
			
			swal({
				  title: '정말로 삭제하시겠습니까?',
				  icon: 'warning'
				})
				.then( function(willDelete) {
					  if (willDelete) {
						  commentdelete( c_seq );
					  } 
					});
		});
		
		// 댓글 수정 버튼 클릭 시
		$( document ).on( 'click', '#modify-comment', function() {
			var c_seq = $(this).attr('data-seq');
			var c_writer = $(this).attr('data-writer');
			var c_content = $(this).closest('tr').find('.c_content').html();
			
			var html = '<input style="width: 50%; height:30%; margin: 5px;" type="text" data-seq=' + c_seq + ' data-writer= ' + c_writer + ' class="modify-text" value="'+ c_content +'" />';
			html += '<button class="btn btn-primary" id="modify-submit" type="button" data-seq=' + c_seq + ' data-writer= ' + c_writer + '>완료</button>&nbsp;';
			html += '<button class="btn btn-primary" id="modify-cancle" type="button">취소</button>';
			
			 $(this).closest('tr').find('.c_content').html( html );
			
		});
		// 댓글 수정 완료 버튼 클릭 시
		$( document ).on( 'click', '#modify-submit', function() {
			var c_seq = $(this).attr('data-seq');
			var c_writer = $(this).attr('data-writer');
			var c_content = $('.modify-text').val();
			
			if( c_content == '' || c_content == null ) {
				swal({
					  title: '댓글 내용을 입력하셔야 합니다.',
					  icon: 'warning'
					});
				return false;
			} else {
				commentmodify( c_seq, c_writer, c_content );
			}
			
		});
		// 댓글 수정 취소 버튼 클릭 시
		$( document ).on( 'click', '#modify-cancle', function() {
			$('.comment-list').html('');
			  commentlist();
		});
	});
</script>
</head>
<body>
	<!-- 상단 디자인 -->
	<div class="contents1">
		<div class="con_title">
		</div>

		<div class="contents_sub">
			<!--게시판-->
			<div class="board_view">
				<table class="tables">
					<tr>
						<th width="15%">프로젝트명</th>
						<td width="50%"><%=name %></td>
						<th width="15%">프로젝트 기간</th>
						<td width="30%" style="font-size: 15px;"><%=startdate %> ~ <%=enddate %></td>
					</tr>
					<tr>
						<th>프로젝트 개요</th>
						<td><%=pjcontent %></td>
						<th>프로젝트 리더</th>
						<td>
						<%=br %>
						</td>
					</tr>
					<tr>
						<th>진   행   률 <div class="state">(<%=pjstate %>)</div></th>
						<td colspan="3">
							<div class="progress- pjpercent">
								<span><%=pjpercent + "%"%></span>
							</div>
						</td>
					</tr>
					<tr>
						<th colspan="2">Task</th>
						<th>팀 원</th>
					</tr>
					<tr>
						<td colspan="2" height="400" valign="top" style="padding: 20px; line-height: 160%">
							<div id="project-task" class="project-task" style="border: 1px solid black; height: 300px; width: 70%; float: left; overflow: auto;">
								<ul class="tasklist">
								</ul>
							</div>
							<div class="Task-button">
							<%
							if( eno == leader || eno.equals(leader) ) {
								out.println("<input type='button' data-toggle='modal' data-target='#task_add_modal' class='btn btn-primary task-add' value='Task 추가' style='margin-left: 15px;' />");
							}
							%>
							</div>
						</td>
						<td colspan="2">
						<div style="line-height: 160%;">팀원</div>
						<ul class= "teamlist">
						<%=result %>
						</ul>
						</td>
						
					</tr>
				</table>
				<table id="commentList" class="table table-borderless comment-list" style="margin-bottom:0px; padding: 3px; background: #F6F6F6; width: 1000px;">
				
				</table> 
				<form class="form-group" action="" method="post" name="cfrm">
					<table class="table table-borderless comment" style="padding: 3px; background: #F6F6F6; width: 1000px;">
						<tr>
							<td class="bg01" style="width: 80%;">
							<div class="form-group">
							<textarea id="comment" name="comment-content" rows="4" cols="110" class="coment_input_text form-controll"></textarea>
							</div>
							</td>
							<td align="right" class="bg01">
								<div class="light-button button-wrapper">
						    <div class="button comment-submit">
						        <span>
						          	  댓글등록
						        </span>
						    </div>  
						</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="btn_area">
			<button class="btn btn-primary project-list" type="button" onclick="javascript: history.go(0);">목록</button>
			
				<div class="align_right" style=" text-align: right;">
				<% 
				if( eno == leader || eno.equals(leader) ) {
					out.println("<button class='btn btn-primary project-modify' type='button' >수정</button>");
					out.println("<button class='btn btn-primary project-delete' data-toggle='modal' data-target='#delete_modal' type='button' >삭제</button>");
				}
				%>
				</div>
			</div>
			<!--//게시판-->
		</div>
		<!-- 하단 디자인 -->
	</div>
	<!-- Task 추가 모달 -->
	<div class="modal fade" id="task_add_modal" role="dialog"  data-backdrop="static" data-keyboard="false">
	<div class = "modal-dialog modal-lg"><!-- modal-lg 추가해서 팀원리스트 -->
		<div class="modal-content">
			<div class="modal-header">
				<h4 class= "modal-title">Task 추가</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
			<div style="float: left;">
				<div class="title-form form-group">
					<label for="task-subject" style="font-size: 25px;">Task 제목을 입력하세요.</label><br />
					<input class="form-controll task-subject" id="task-subject" type="text" style="width: 300px; height: 40px" placeholder="Task 제목을 입력하세요." /><br />
				</div>
				<div class="content-form form-group" style="float: left;">
					<label for="task-content" style="font-size: 25px;">Task 본문</label><br />
					<textarea class="form-controll task-content" id="task-content" rows="4" style="width: 300px; height: 80px" placeholder="Task 내용을 입력하세요."></textarea>
				</div>
			</div>
				<div class="leader-form form-group" style="float: left; width: 30%;">
					<div>
						<ul class="task-team">
							<%=teamlist %>
						</ul>
					</div>
				</div>
				<div class="form-group" style="float: left;">
					<table class="table table-borderless t-leader">
						<thead>
							<tr>
								<th>리더가 추가됩니다.</th>
							</tr>
						</thead>
						<tbody class="addleader">
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<input type="button" class="btn btn-primary submit-task" value="등록" />
				<input type="button" data-dismiss="modal" class="btn btn-primary cancle" value="취소" />
			</div>
		</div>
	</div>
</div>

<!-- 삭제 모달 -->
<div class="modal" id="delete_modal" role="dialog"  data-backdrop="static" data-keyboard="false">
	<div class = "modal-dialog"><!-- modal-lg 추가해서 팀원리스트 -->
		<div class="modal-content">
			<div class="modal-header">
				<h4 class= "modal-title">프로젝트 삭제</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
			<div>
				<div class="delete-form form-group" style="text-align: center;">
					<label for="password" style="font-size: 25px;">비밀번호를 입력하세요.</label><br />
					<input class="form-controll project-password" id="password" type="password" style="width: 300px; height: 40px" placeholder="비밀번호를 입력하세요." /><br />
				</div>
			</div>
			</div>
			<div class="modal-footer">
				<input type="button" class="btn btn-primary dialog-delete" value="삭제" />
				<input type="button" data-dismiss="modal" class="btn btn-primary cancle" value="취소" />
			</div>
		</div>
	</div>
</div>
</body>
</html>