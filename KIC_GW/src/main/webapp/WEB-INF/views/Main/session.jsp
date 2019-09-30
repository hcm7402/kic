<%@page import="com.kic.groupware.model1.user.UserTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String eno = (String) request.getAttribute("eno");
	String level = (String) request.getAttribute("level");
	String ename = (String) request.getAttribute("ename");
	
	session.setAttribute("eno", eno); 
	session.setAttribute("level", level);
	session.setAttribute("ename", ename);
%>