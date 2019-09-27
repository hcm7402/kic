<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int flag = (Integer) request.getAttribute("flag");
 
	JSONObject jsonObject = new JSONObject();

	JSONObject idInfo = new JSONObject();
	
	idInfo.put("flag", flag);
	jsonObject.put("checks", idInfo);
	
	String json = jsonObject.toJSONString();
	System.out.println(json);
%>
<%=json %>