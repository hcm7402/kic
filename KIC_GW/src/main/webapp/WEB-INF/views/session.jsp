<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	String s_id = (String) request.getAttribute("s_id");
	String s_name = (String) request.getParameter("s_name");
	System.out.println(s_id);
	session.setAttribute("s_id", s_id);
	session.setAttribute("s_name", "A");
%>