<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (int) request.getAttribute("flag");

	out.println("<script type='text/javascript'>");
	if(flag == 0) {
		out.println("alert('회원가입이 완료되었습니다.')");
		out.println("location.href='login.do'");
	}else if(flag == 1) {
		out.println("alert('가입에 실패하였습니다.')");
		out.println("history.back()");
	}
	out.println("</script>");
%>