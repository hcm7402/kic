<%@page import="com.kic.groupware.model1.board.BoardTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.sql.DataSource" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>	

<%
	request.setCharacterEncoding("UTF-8");

	String eno = (String)session.getAttribute("eno");
	String cpage = request.getParameter( "cpage" );
	String seq = request.getParameter( "seq" );
	
	BoardTO to = (BoardTO)request.getAttribute( "to1" );
	
	String subject = to.getSubject();
	String writer = to.getWriter();
	String mail = to.getMail();
	String wip = to.getWip();
	String wdate = to.getWdate();
	String hit = to.getHit();
	String content = to.getContent();
	
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
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<title>게시판 페이지(view)</title>
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
	background-color: #56bafc;
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

.submit-wrapper {
        display: inline-block;
        margin: 5px 5px;
        padding: 10px;
    }
    .submit {
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
    .submit span {
        display: block;
        padding: 10px 20px;
        background: #D5D5D5;
        z-index: 100;
        position: relative;
        transition: all .35s ease-in-out .35s;
    }
    .submit:hover span {
        background: #56bafc;
        color: #fff;
        transition: all .35s ease-in-out .35s;
    }
    .submit:after {
        bottom: -100%;
        right: -100%;
        content: "";
        width: 100%;
        height: 100%;
        position: absolute;
        background: #56bafc;
        transition: all .35s ease-in-out .5s;
    }
    .submit:hover:after {
        right: 0;
        bottom: 0;
        transition: all ease-in-out .35s;
    }
    .submit:before {
        top: -100%;
        left: -100%;
        content: "";
        width: 100%;
        height: 100%;
        position: absolute;
        background: #56bafc;
        transition: all .35s ease-in-out .5s;
    }
    .submit:hover:before {
        left: 0;
        top: 0;
        transition: all ease-in-out .35s;
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
			function boardlist() {
				$.ajax({
					url : './boardlist.do',
					type : 'get',
					data: {
						eno: <%=eno%>,
						cpage: cpage
					},
					dataType : 'text',
					success : function(data) {
						$('#mainleft').html(data);
					}
				});
			}
			
			
			function button_delete_ok( eno, seq ) {
				$.ajax({
					url : './button_delete_ok.do',
					type : 'get',
					data: {
						eno: eno,
						seq: seq
					},
					dataType : 'text',
					success : function(data) {
						$('#mainleft').html(data);
					}
				});
			}
			
			function board_modify( eno, seq ) {
				$.ajax({
					url : './board_modify.do',
					type : 'get',
					data: {
						eno: eno,
						seq: seq
					},
					dataType : 'text',
					success : function(data) {
						$('#mainleft').html(data);
					}
				});
			}

			$('.button_list').on('click', function() {
				boardlist();
			});
			
			$(document).on('click','.button_delete_ok', function() {
				var seq = $(this).attr('data-seqv');
				board_delete_ok( <%=eno%>, seq );
			});
			$(document).on('click','.button_modify', function() {
				var seq = $(this).attr('data-seqv');
				board_modify( <%=eno%>, seq );
			});
	});
	
</script>
</head>
<body>
	<div class="con_title">
	<h3>게시판</h3>
	<p>게시판 &gt; <strong>사내게시판</strong></p>
</div>
<div class="con_txt">
	<div class="contents_sub">
		<!--게시판-->
		<div class="boardview">
			<table>
			<tr>
				<th width="10%">제목</th>
				<td width="20%"><%=subject %></td>
				<th width="10%">등록일</th>
				<td width="20%"><%=wdate %></td>
			</tr>
			<tr>
				<th>글쓴이</th>
				<td><%=writer %></td>
				<th>조회</th>
				<td><%=hit %></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="4" height="200" valign="top" style="padding: 20px; line-height: 160%"><%=content %></td>
			</tr>
			</table>
		</div>

		<div class="btn_area">
			<div class="align_left">
				<div class="col-md-12" style="text-align: right;">
				<div class="light-button submit-wrapper button_list">
					<div class="submit">
						<span>
							목록
						</span>
					</div>  
				</div>
			</div>
			</div>
			<div class="align_right">
			 	<button data-seqv="<%=seq %>" class="button_modify" style="color:#4f4f4f; margin-bottom:50px;float:right;text-decoration:none">수정</button>
				<button data-seqv="<%=seq %>" class="button_delete_ok" style="color:#4f4f4f; margin-bottom:50px;float:right;text-decoration:none">삭제</button>
			</div>
		</div>	
		<!--//게시판-->
	</div>
</div>
<!-- 하단 디자인 -->

	<script src="./resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
