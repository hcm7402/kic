<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (int) request.getAttribute("flag");

	out.println("<script type='text/javascript'>");
	if(flag == 0) {
		out.println("alert('아이디가 생성되었습니다.')");
		out.println("location.href='login.do'");
	}else if(flag == 1) {
		out.println("alert('아이디 생성에 실패했습니다.')"); 
		out.println("history.back()");
	} 
	out.println("</script>");
%>