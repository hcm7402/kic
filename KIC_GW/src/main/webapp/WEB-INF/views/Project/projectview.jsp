<%@page import="com.kic.groupware.project.ProjectTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<ProjectTO> teamList = (ArrayList) request.getAttribute("teamsList");
	ProjectTO to = (ProjectTO) request.getAttribute("to");
	
	StringBuffer result = new StringBuffer();
	for( ProjectTO pto : teamList ) {
		String team = pto.getTeam();
		String authPhoto = pto.getAuthPhoto();
		
		/* result.append("<div class='photo'>");
		result.append("<img src='" + authPhoto + "' class='img' />");
		result.append("</div>");
		result.append("<div class='team'>");
		result.append(team);
		result.append("</div>"); */
		
		result.append("<td class='photo'>");
		result.append("<img src='" + authPhoto + "' class='img' />");
		result.append("  ");
		result.append(team + "</td>");
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
		float: left;
		width: 33%;
	}
	.photo {
	    width: 50px;
	    height: 50px;
	    position: relative;
	    overflow: hidden;
	    border-radius: 50%;
	    float: left;
	}
	.img {
	    display: inline;
	    margin: 0 auto;
	    height: 100%;
	    width: 100%;
	}
	.tables {
		border: 0px solid black;
		width:100%;
	}
	th {
		text-align: center;
		padding: 10px;
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
						<td width="50%">ㅁㄴㅇㅁㄴㅇ</td>
						<th width="15%">프로젝트 기간</th>
						<td width="30%">2019</td>
					</tr>
					<tr>
						<th>프로젝트 개요</th>
						<td>개요</td>
						<th>프로젝트 담당자</th>
						<td>글쓴</td>
					</tr>
					<tr>
						<th>진   행   률</th>
						<td colspan="3">~~</td>
					</tr>
					<tr>
						<td colspan="2" height="200" valign="top" style="padding: 20px; line-height: 160%">
							<div id="priject-task">
							</div>
						</td>
						<td colspan="2">
							<div style="line-height: 50px;">1</div>
							<div style="line-height: 50px;">1</div>
							<div style="line-height: 50px;">1</div>
							<div style="line-height: 50px;">1</div>
							<div style="line-height: 50px;">1</div>
							<div style="line-height: 50px;">1</div>
							<div style="line-height: 50px;">1</div>
							<div style="line-height: 50px;">1</div>
						</td>
						
					</tr>
				</table>
				<table id="commentList" class="comment_table">
				</table> 

				<form action="" method="post" name="cfrm">
					<input type="hidden" name="seq" value="" />
					<input type="hidden" name="cpage" value="" />
					<table>
						<tr>
							<td width="94%" class="coment_re">글쓴이 <input type="text" id="cwriter"
								name="cwriter" maxlength="5" class="coment_input" />&nbsp;&nbsp;
								비밀번호 <input type="password" id="cpassword" name="cpassword"
								class="coment_input pR10" />&nbsp;&nbsp;
							</td>
							<td width="6%" class="bg01"></td>
						</tr>
						<tr>
							<td class="bg01"><textarea id="comment" name="ccontent" cols="" rows=""
									class="coment_input_text"></textarea></td>
							<td align="right" class="bg01">
								<button type="button" id="submit1" seq="" class="btn_re btn_txt01">댓글등록</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="btn_area">
				<div class="align_left">
					<button type="button" class="btn_list btn_txt02"
						style="cursor: pointer;" onclick="location.href='./list.do'">목록</button>
				</div>
				<div class="align_right">
					<button type="button" class="btn_list btn_txt02"
						style="cursor: pointer;"
						onclick="location.href='./modify.do?cpage=&seq='">수정</button>
					<button type="button" class="btn_list btn_txt02"
						style="cursor: pointer;"
						onclick="location.href='./delete.do?cpage=&seq='">삭제</button>
					<button type="button" class="btn_write btn_txt01"
						style="cursor: pointer;"
						onclick="location.href='./write.do?cpage='">쓰기</button>
				</div>
			</div>
			<!--//게시판-->
		</div>
		<!-- 하단 디자인 -->
	</div>

</body>
</html>