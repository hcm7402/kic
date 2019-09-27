<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute("flag");
	int eno = (Integer)request.getAttribute("eno");
	int level = (Integer)request.getAttribute("level");
	 
	JSONObject jsonObject = new JSONObject();
	
	JSONObject logcheckInfo = new JSONObject();
	JSONObject enoInfo = new JSONObject();
	
	logcheckInfo.put("flag", flag);
	logcheckInfo.put("eno", eno);
	logcheckInfo.put("level", level);
	jsonObject.put("logchecks", logcheckInfo);

	String json = jsonObject.toJSONString();
	System.out.println(json);
%>
<%=json %>