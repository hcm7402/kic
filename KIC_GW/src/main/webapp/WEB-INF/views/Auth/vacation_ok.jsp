<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String eno = (String)session.getAttribute("eno");
	int flag = (Integer)request.getAttribute("flag");

	out.println("<script type='text/javascript'>");
	if(flag == 0) {
		out.println("alert('신청에 성공했습니다.');");
		out.println("location.href='authpage.do'");
	} else {
		out.println("alert('신청에 실패했습니다.');");
		out.println("history.back();");
	}
	out.println("</script>");
%>