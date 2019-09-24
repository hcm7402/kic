<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute("flag");
	
	JSONObject jsonObject = new JSONObject();
	
	JSONObject logcheckInfo = new JSONObject();
	
	logcheckInfo.put("flag", flag);
	jsonObject.put("logchecks", logcheckInfo);
	
	String json = jsonObject.toJSONString();
%>
<%=json %>