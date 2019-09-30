<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
	String enos = (String) session.getAttribute("eno");
	String enames = (String) session.getAttribute("ename");
%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="./resources/styles.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
</script>
<style type="text/css">
body {
	font-family: 'Malgun Gothic';
	margin: 0;
	margin-left: 40px;
	margin-right: 40px;
	height:100%;
}

#header {
	margin-top: 5px;
	height:70px;
}

#container {
	margin-right: 0px;
	padding-top: 20px;
}


li {
	width: 200px;
}
.info {
	position: absolute;
	top: 1%;
	right:0%;
}
.main-img {
	text-align: center;
}
.info-table {
	width: 250px;
	border: 0px solid black !important;
}
</style>

<div class="body">
    <div id="header">
	    <div class="main-img">
	    	<a href="./main.do"><img src="./resources/img/kicmark.png" class="main-icon" /></a>
	    </div>
	    <div class="info">
	    <table class="info-table">
	    	<tr>
	    	<td><%=enames %> 님</td>
	    	<td><a href="./logout.do"><img src="./resources/img/logout.png" class="main-icon" /></a></td>
	    	</tr>
	    </table>
	    </div>
	</div>
    <div id='cssmenu'>
	<ul>
   <li class="home"><a href="./main.do">Home</a></li>
   <li><a href="#">공지사항</a></li><!-- 공지 사항-->
   <li><a href='./authpage.do'>전자결재</a></li><!-- 전자 -->
   <li><a href='./project.do'>프로젝트</a></li><!-- 프젝 -->
   <li><a href='#'>게시판</a></li><!-- 게시판 -->
   <li><a href='./cal.do'>캘린더</a></li>
   <li><a href='./address.do'>조직도</a></li><!-- 조직 -->
   <li><a href='./mypage.do'>My page</a></li><!-- 마이 -->
	</ul>
	</div>
	</div>
    

