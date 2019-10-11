<%@page import="com.kic.groupware.model1.board.BoardTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	

<%
	BoardTO to = (BoardTO)request.getAttribute( "to1" );

	String seq = to.getSeq();
	
	String subject = to.getSubject();
	String writer = to.getWriter();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="./css/board_write.css">
<script type="text/javascript">
	window.onload = function() {
		/* document.getElementById( 'submit1' ).onclick = function() {
			if( document.frm.password.value.trim() == '' ) {
				alert( '비밀번호를 입력하셔야 합니다.' );
				return false;
			}
			document.frm.submit();
		}; */
	};
</script>
</head>

<body>
<!-- 상단 디자인 -->
<div class="con_title">
	<h3>게시판</h3>
	<p>HOME &gt; 게시판 &gt; <strong>게시판</strong></p>
</div>
<div class="con_txt">
	<form action="./controller" method="post" name="frm">
		<input type="hidden" name="action" value="delete_ok" />
		<input type="hidden" name="seq" value="<%=seq %>" />
		<div class="contents_sub">	
			<!--게시판-->
			<div class="board_write">
				<table>
				<tr>
					<th class="top">글쓴이</th>
					<td class="top" colspan="3"><input type="text" name="writer" value="<%=writer %>" class="board_view_input_mail" maxlength="5" readonly/></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><input type="text" name="subject" value="<%=subject %>" class="board_view_input" readonly/></td>
				</tr>
				<!-- <tr>
					<th>비밀번호</th>
					<td colspan="3"><input type="password" name="password" value="" class="board_view_input_mail"/></td>
				</tr> -->
				</table>
			</div>
			
			<div class="btn_area">
				<div class="align_left">
					<button class="boardlist" style="color:#4f4f4f; margin-bottom:50px;float:right;text-decoration:none">목록</button>
					<button class="button_view" data-seqv="<%=seq %>" style="color:#4f4f4f; margin-bottom:50px;float:right;text-decoration:none">보기</button>
				</div>
				<div class="align_right">
					<button id="submit1" class="button_delete_ok" style="color:#4f4f4f; margin-bottom:50px;float:right;text-decoration:none">삭제</button>
				</div>
			</div>
			<!--//게시판-->
		</div>
	</form>
</div>
<!-- 하단 디자인 -->

</body>
</html>
