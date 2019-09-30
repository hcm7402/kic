<%@page import="com.kic.groupware.model1.user.UserTO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserTO to = (UserTO) request.getAttribute("enoflag");

	int flag = to.getFlag();
	int eno = to.getEno();
	int level = to.getLevel();
	String ename = to.getEname();
	 
	JSONObject jsonObject = new JSONObject();
	
	JSONObject logcheckInfo = new JSONObject();
	JSONObject enoInfo = new JSONObject();
	
	logcheckInfo.put("flag", flag);
	logcheckInfo.put("eno", eno);
	logcheckInfo.put("level", level);
	logcheckInfo.put("ename", ename);
	jsonObject.put("logchecks", logcheckInfo);

	String json = jsonObject.toJSONString();
	System.out.println(json);
%>
<%=json %>