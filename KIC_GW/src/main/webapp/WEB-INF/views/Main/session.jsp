<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String eno = (String) request.getAttribute("eno");
	System.out.println(eno);
	session.setAttribute("eno", eno);
%>