<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String eno = (String) request.getAttribute("eno");
	String level = (String) request.getAttribute("level");
	System.out.println(eno);
	System.out.println(level);
	session.setAttribute("eno", eno);
	session.setAttribute("level", level);
%>