<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="com.kic.groupware.model1.board.BoardTO" %>
<%@ page import="com.kic.groupware.model1.board.BoardListTO" %>
<%@ page import="com.kic.groupware.model1.board.BoardDAO" %>
<%@ page import="java.util.ArrayList" %>
<%
	request.setCharacterEncoding("UTF-8");
	String eno = (String)session.getAttribute("eno");
	String ename = (String)session.getAttribute("ename");
	
	if(eno == null || eno.equals("")) {
	      out.println("<script type='text/javascript'>");
	      out.println("alert('로그인이 필요합니다.')");
	      out.println("location.href='./login.do'");
	      out.println("</script>");
	} 

 
	
	 BoardListTO listTO = (BoardListTO)request.getAttribute("listTO");
	 ArrayList<BoardTO> boardLists = (ArrayList)request.getAttribute("boardLists");
	int cpage = listTO.getCpage();
	
	int totalRecord = listTO.getTotalRecord();
	int totalPage = listTO.getTotalPage();
	
	int blockPerPage = listTO.getBlockPerPage();
	int startBlock = listTO.getStartBlock();
	int endBlock = listTO.getEndBlock();
	
	   StringBuffer html = new StringBuffer();
	
	
	for(BoardTO to : boardLists){
		String seq=to.getSeq();
		String subject = to.getSubject();
		String writer = to.getWriter();
		String wdate = to.getWdate();
		String hit = to.getHit();
		int wgap = to.getWgap();
		html.append("<tr>");
		html.append("<td>" + seq + "</td>");
		html.append("<td class='left'>");
		html.append("	<a class='button_view' data-seqv=" + seq + ">" + subject + "</a>");
		if( wgap == 0 ) {
			html.append("	<img src='./resources/img/new.png' alt='NEW'>");
		}
		html.append("</td>");
		html.append("<td>" + writer + "</td>");
		html.append("<td>" + wdate + "</td>");
		html.append("<td>" + hit + "</td>");
		html.append("</tr>");
		
		totalRecord++;
	}
	
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
<title>전자결재 페이지</title>
<style type="text/css">
/* #aside {
	position: absolute;
	left: 0;
} */

.mainleft {
	padding-top: 30px;
	padding-left: 20px;
	width: 1300px;
	height: 500px;
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

td {
	text-align: center;
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
		
		function board_write() {
			$.ajax({
				url : './board_write.do',
				type : 'get',
				data: {
					eno: <%=eno%>
				},
				dataType : 'text',
				success : function(data) {
					$('#mainleft').html(data);
				}
			});
		}
		
		function boardview(eno, seq, cpage) {
			$.ajax({
				url : './boardview.do',
				type : 'get',
				data: {
					eno: eno,
					seq: seq,
					cpage: cpage
				},
				dataType : 'text',
				success : function(data) {
					$('#mainleft').html(data);
				}
			});
		}
		
		function boardlist(cpage) {
			$.ajax({
				url : './boardlist.do',
				type : 'get',
				data: {
					cpage: cpage
				},
				dataType : 'text',
				cache: false,
				success : function(data) {
					$('#mainleft').html(data);
				}
			});
		}

		$(document).on('click','.button_write', function() {
			board_write();
		});
		
		$(document).on('click','.button_view', function() {
			var seq = $(this).attr('data-seqv');
			var cpage = $(this).attr('data-cpage');
			boardview( <%=eno%>, seq, cpage );
		});
		$(document).on('click','.listb', function() {
			var cpage = $(this).attr('data-cpage');
			boardlist( cpage );
		});

	});

</script>
</head>
<body>
	
	<div id="mainleft" class="col-sm-9">
		<!-- 전자결재 -->
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>글쓴이</th>
					<th>등록일</th>
					<th>조회</th>
				</tr>
			</thead>
			<tbody>
				<%=html %>

			</tbody>
		</table>

	</div>
<div class="paginate_regular">
			<div align="center">
<%
	if( endBlock >= totalPage ) {
		endBlock = totalPage;
	}
	if( startBlock == 1 ) {
		out.println( "<span>&lt;&lt;</span>" );
	} else {
		out.println( "<span><a class='listb' data-cpage=" + ( startBlock - blockPerPage) + "'>&lt;&lt;</a></span>" );
	}	
	out.println( "&nbsp;" );	
	
	
	if( cpage == 1 ) {
		out.println( "<span>&lt;</span>" );
	} else {
		out.println( "<span><a class='listb' data-cpage=" + (cpage -1 ) + "'>&lt;</a></span>" );
	}
	out.println( "&nbsp;&nbsp;" );
	
	for(int i=startBlock ; i<=endBlock ; i++) {
		if( cpage == i ) {
			out.println( "<span>[ " + i + " ]</span>" );	
		} else {
			out.println( "<span><a class='listb' data-cpage=" + i + ">" + i + "</a></span>" );
		}
	}
	
	out.println( "&nbsp;&nbsp;" );
	if( cpage == totalPage ) {
		out.println( "<span>&gt;</span>" );
	} else {
		out.println( "<span><a class='listb' data-cpage=" + ( cpage+1 )+ "'>&gt;</a></span>" );
	}

	out.println( "&nbsp;");
	if( startBlock == totalPage ) {
		out.println( "<span>&gt;&gt;</span>" );
	} else {
		out.println( "<span><a class='listb' data-cpage=" + ( startBlock + blockPerPage) + "'>&gt;&gt;</a></span>" );
	}
%>
			</div>
		</div>
		<!--//페이지넘버-->
		<div class="col-md-12" style="text-align: right;">
				<div class="light-button submit-wrapper button_write">
					<div class="submit">
						<span>
							쓰기
						</span>
					</div>  
				</div>
			</div>
	
</body>
</html>
