<%@page import="com.kic.groupware.project.ProjectTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ProjectTO to = (ProjectTO) request.getAttribute("to");

	String leader = to.getPjleader();
	String name = to.getPjname();
	String startdate = to.getStartdate();
	String enddate = to.getEnddate();
	String pjcontent = to.getPjcontent();
	String pjstate = to.getPjstate();
	String pjpercent = to.getPjpercent();
	
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
	for( ProjectTO pto : teamList ) {
		String team = pto.getTeam();
		String authPhoto = pto.getAuthPhoto();
		
		result.append("<li>");
		result.append("<div class='photo'>");
		result.append("<img src='" + authPhoto + "' class='img' />");
		result.append("</div>");
		result.append( "<div class='team'>"+ team +"</div>" );
		result.append("</li>");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximun-scale=1.0">
<title>Insert title here</title>
<style type="text/css">

	.team {
		line-height: 50px;
		padding-left: 15px;
	}
	.photo {
	    width: 50px;
	    height: 50px;
	    position: relative;
	    overflow: hidden;
	    border-radius: 50%;
	    float: left;
	    margin-right: 15px;
	}
	.img {
	    display: inline;
	    margin: 0 auto;
	    height: 100%;
	    width: 100%;
	}
	.tables {
		font-family: 'Malgun Gothic';
		border: 0px solid black;
		width:100%;
	}
	th {
		text-align: center;
		padding: 10px;
	}
	.teamlist li {
		padding: 5px 0px 5px 5px;
	    margin-bottom: 5px;
	    border-bottom: 1px solid #efefef;
	    font-family: 'Malgun Gothic';
	}
	.button-wrapper {
        display: inline-block;
        margin: 5px 5px;
        padding: 10px;
    }
    .button {
        background: #D5D5D5;
        border: none;
        padding: 2px;
        cursor: pointer;
        display: block;
        position: relative;
        overflow: hidden;
        transition: all .35s ease-in-out .35s;
        margin: 0 auto;
        width: 80px;
        text-align: center;
    }
    .button span {
        display: block;
        padding: 10px 20px;
        background: #D5D5D5;
        z-index: 100;
        position: relative;
        transition: all .35s ease-in-out .35s;
    }
    .button:hover span {
        background: #56bafc;
        color: #fff;
        transition: all .35s ease-in-out .35s;
    }
    .button:after {
        bottom: -100%;
        right: -100%;
        content: "";
        width: 100%;
        height: 100%;
        position: absolute;
        background: #56bafc;
        transition: all .35s ease-in-out .5s;
    }
    .button:hover:after {
        right: 0;
        bottom: 0;
        transition: all ease-in-out .35s;
    }
    .button:before {
        top: -100%;
        left: -100%;
        content: "";
        width: 100%;
        height: 100%;
        position: absolute;
        background: #56bafc;
        transition: all .35s ease-in-out .5s;
    }
    .button:hover:before {
        left: 0;
        top: 0;
        transition: all ease-in-out .35s;
    }
    ul.tasklist, ol.tasklist {
	    list-style: none;
	    padding: 0px;
	    width: 100%;
	    font-family: 'Malgun Gothic';
	}
	  
	ul.tasklist li, ol.tasklist li {
		margin-left: 15px;
		margin-right: 15px;
		margin-top: 5px;
		margin-bottom: 5px;
	    display: inline-block;
	    padding: 10px;
	    border: 2px solid #ccc;
	    font-size: 12px;
	    cursor: pointer;
	    border-radius: 10px;
	}
	ul.tasklist li:hover {
		box-shadow: 2px;
		transform: scale(1.05);
	}
</style>
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
						<td width="30%"><%=startdate %> ~ <%=enddate %></td>
					</tr>
					<tr>
						<th>프로젝트 개요</th>
						<td><%=pjcontent %></td>
						<th>프로젝트 담당자</th>
						<td>글쓴</td>
					</tr>
					<tr>
						<th>진   행   률 <div class="state">(<%=pjstate %>)</div></th>
						<td colspan="3">
							<div class="progress">
								<span></span>
							</div>
						</td>
					</tr>
					<tr>
						<th colspan="2">Task</th>
						<th>팀 원</th>
					</tr>
					<tr>
						<td colspan="2" height="400" valign="top" style="padding: 20px; line-height: 160%">
							<div id="priject-task" style="border: 1px solid black; height: 100%; width: 60%;">
								<ul class="tasklist">
									<li>
									<div class="task-content">Task1</div>
									<div class="task-progress progress" style=" margin: 5px;">
										<span></span>
									</div>
									<div class="custom-control custom-radio" style="float: left;">
										<input type="radio" name="jb-radio" id="jb-radio-1" class="custom-control-input">
										<label class="custom-control-label" for="jb-radio-1">진행</label>
									</div>
									<div class="custom-control custom-radio" style="float: left; margin-left: 10px;">
										<input type="radio" name="jb-radio" id="jb-radio-2" class="custom-control-input">
										<label class="custom-control-label" for="jb-radio-2">완료</label>
									</div>
									</li>
								</ul>
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
				<table id="commentList" class="comment_table">
				</table> 

				<form action="" method="post" name="cfrm">
					<table class="comment">
						<tr>
							<td class="bg01"><textarea id="comment" name="ccontent" cols="" rows=""
									class="coment_input_text"></textarea></td>
							<td align="right" class="bg01">
								<div class="light-button button-wrapper">
						    <div class="button">
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
				<div class="align_right">
						<div class="light-button button-wrapper">
						    <div class="button">
						        <span>
						          	  목록
						        </span>
						    </div>  
						</div>
						<div class="light-button button-wrapper">
						    <div class="button">
						        <span>
						          	  수정
						        </span>
						    </div>  
						</div>
						<div class="light-button button-wrapper">
						    <div class="button">
						        <span>
						          	  삭제
						        </span>
						    </div>  
						</div>
				</div>
			</div>
			<!--//게시판-->
		</div>
		<!-- 하단 디자인 -->
	</div>

</body>
</html>