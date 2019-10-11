<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String seq = (String)request.getAttribute( "seq" );
	int flag = (Integer)request.getAttribute( "flag" );

	out.println( "<script type='text/javascript'>" );
	if( flag == 0 ) {
		out.println( "alert('글수정에 성공');" );
		out.println( "location.href='board_list.do';" );
	} else if( flag == 1 ) {
		out.println( "alert('비밀번호 오류');" );
		out.println( "history.back();" );
	} else if( flag == 2 ) {
		out.println( "alert('글수정에 실패');" );
		out.println( "history.back();" );
	}
	out.println( "</script>" );
%>