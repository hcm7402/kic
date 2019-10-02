<%@page import="com.kic.groupware.project.ProjectTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	ArrayList<ProjectTO> pjLists = (ArrayList) request.getAttribute("pjLists");
	
	StringBuffer result = new StringBuffer();
	
	for( ProjectTO to : pjLists ) {
		String pjseq = to.getPjseq();
		String pjleader = to.getPjleader();
		String pjname = to.getPjname();
		String startdate = to.getStartdate();
		String enddate = to.getEnddate();
		String pjcontent = to.getPjcontent();
		String team = to.getTeam();
		String pjstate = to.getPjstate();
		String ename = to.getEname();
		String pjpercent = to.getPjpercent();
		
		if( Integer.parseInt(pjstate) == 1 ) {
			String[] teams = team.split(" ");
			
			result.append("<li class='view' data-seq=" + pjseq + ">");
			result.append("<div class='project-sub' style='text-align: right;'>");
			result.append("<div class='project-number' style='float: left; width: 60%; text-align: left; '>NO." + pjseq + "</div>");
			result.append("<div class='project-state ing' style='float: left; width: 40%; text-align: center;'>진행중</div>");
			result.append("</div>");
			result.append("<div class='project-name'>");
			result.append("<h5>" + pjname + "</h5></div>");
			result.append("<div class='project-task'>등록된 Task 개수(3)</div>");// 나중에 추가
			result.append("<div class='project-people'>" + ename + " 외 " + (teams.length - 1) + "명</div>");
			result.append("<div class='project-date'>" + startdate + " ~ " + enddate + "</div><br />");
			result.append("<div id='project-progress' class='project-ing' data-seq=" + pjseq + " data-percent=" + pjpercent + " >");
			result.append("<span></span>");
			result.append("</div></li>");
			
		} else if( Integer.parseInt(pjstate) == 2 ) {
			String[] teams = team.split(" ");
			
			result.append("<li class='view' data-seq=" + pjseq + ">");
			result.append("<div class='project-sub' style='text-align: right;'>");
			result.append("<div class='project-number' style='float: left; width: 60%; text-align: left; '>NO." + pjseq + "</div>");
			result.append("<div class='project-state stop' style='float: left; width: 40%; text-align: center;'>보 류</div>");
			result.append("</div>");
			result.append("<div class='project-name'>");
			result.append("<h5>" + pjname + "</h5></div>");
			result.append("<div class='project-task'>등록된 Task 개수(3)</div>");// 나중에 추가
			result.append("<div class='project-people'>" + ename + " 외 " + (teams.length - 1) + "명</div>");
			result.append("<div class='project-date'>" + startdate + " ~ " + enddate + "</div><br />");
			result.append("<div id='project-progress' class='project-stop' data-seq=" + pjseq + " data-percent=" + pjpercent + " >");
			result.append("<span></span>");
			result.append("</div></li>");
		} else if ( Integer.parseInt(pjstate) == 3 ) {
			String[] teams = team.split(" ");
			
			result.append("<li class='view' data-seq=" + pjseq + ">");
			result.append("<div class='project-sub' style='text-align: right;'>");
			result.append("<div class='project-number' style='float: left; width: 60%; text-align: left; '>NO." + pjseq + "</div>");
			result.append("<div class='project-state com' style='float: left; width: 40%; text-align: center;'>완 료</div>");
			result.append("</div>");
			result.append("<div class='project-name'>");
			result.append("<h5>" + pjname + "</h5></div>");
			result.append("<div class='project-task'>등록된 Task 개수(3)</div>");// 나중에 추가
			result.append("<div class='project-people'>" + ename + " 외 " + (teams.length - 1) + "명</div>");
			result.append("<div class='project-date'>" + startdate + " ~ " + enddate + "</div><br />");
			result.append("<div id='project-progress' class='project-com' data-seq=" + pjseq + " data-percent=" + pjpercent + " >");
			result.append("<span></span>");
			result.append("</div></li>");
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<link rel="stylesheet" href="./resources/css/button-project.css">
<script type="text/javascript" src="./resources/js/jquery-3.4.1.js"></script>
<title>프로젝트 리스트</title>
<style type="text/css">
	li {
		width: 250px;
	}
	/* 프로젝트 대기중 노란색, 진행중 초록, 완료 파란색 */
	ul.project1, ol.project1 {
	    list-style: none;
	    padding: 0px;
	    width: 100%;
	    font-family: 'Malgun Gothic';
	}
	  
	ul.project1 li, ol.project1 li {
		margin-right: 60px;
		margin-bottom: 50px;
	    display: inline-block;
	    padding: 10px;
	    border: 2px solid #ccc;
	    font-size: 12px;
	    cursor: pointer;
	    border-radius: 10px;
	}
	ul.project1 li:hover {
		box-shadow: 2px;
		transform: scale(1.15);
	}
	.project-ing {
		height: 20px;
		background: #ccc;
		border-radius: 40px;
	}
	.project-ing span {
		display: block;
		padding: 0 10px;
		height: 20px;
		line-height: 20px;
		background: #6aeb6a;
		border-radius: 40px;
		box-sizing: border-box;
		width: 50%;
		animation: stack 1.5s 1;
	}
	@keyframes stack {
		0% { width: 0;}
		100% { width: 50%;}
	}
	.project-stop {
		height: 20px;
		background: #ccc;
		border-radius: 40px;
	}
	.project-stop span {
		display: block;
		padding: 0 10px;
		width: 50%;
		height: 20px;
		line-height: 20px;
		background: #454545;
		border-radius: 40px;
		box-sizing: border-box;
		animation: stack1 2s 1;
	}
	@keyframes stack1 {
		0% { width: 0;}
		100% { width: 50%;}
	}
	
	
	.project-com {
		height: 20px;
		background: #ccc;
		border-radius: 40px;
	}
	.project-com span {
		display: block;
		padding: 0 10px;
		width: 100%;
		height: 20px;
		line-height: 20px;
		background: #56bafc;
		border-radius: 40px;
		box-sizing: border-box;
		animation: stack2 2s 1;
	}
	@keyframes stack2 {
		0% { width: 0;}
		100% { width: 100%;}
	}
	
</style>
<script type="text/javascript">
	$( document ).ready( function() {
		
		$('.view').on( 'click', function() {
			var seq = $(this).attr('data-seq');
			//location.href='./projectview.do?seq=' + seq;
			projectview( seq );
		});
		
		function projectview( seq ) {
			$.ajax({
				url : './projectview.do',
				type : 'get',
				data: {
					seq: seq
				},
				dataType : 'text',
				cache: false,
				success : function(data) {
					$('.pjbody').html(data);
				}
			});
		}
		
		 var pjpercent = function() {
			$.ajax({
				url: './pjpercent.do',
				type: 'get',
				dataType: 'JSON',
				cache: false,
				success: function ( json ) {
					results = json.results;
					$( results ).each( function() {
						var pjseq = this.pjseq;
						var pjstate = this.pjstate;
						var pjpercent = this.pjpercent;
						
					});
				}
			});
		} 
	});
</script>
</head>
<body>
	<div class="pjbody">
	<ul class="project1">
	<%=result %>
	</ul>
	</div>
</body>
</html>