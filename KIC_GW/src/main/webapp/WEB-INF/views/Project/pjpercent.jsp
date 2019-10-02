<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.kic.groupware.project.ProjectTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<ProjectTO> percentLists = (ArrayList) request.getAttribute("percentLists");

	JSONObject jsonObject = new JSONObject();
	JSONArray arr = new JSONArray();
	
	for( ProjectTO to : percentLists ) {
		String pjseq = to.getPjseq();
		String pjstate = to.getPjstate();
		String pjpercent = to.getPjpercent();
		
		JSONObject results = new JSONObject();
		
		results.put("pjseq", pjseq);
		results.put("pjstate", pjstate);
		results.put("pjpercent", pjpercent);
		
		arr.add(results);
		
		jsonObject.put("results", arr);
	}

	String json = jsonObject.toJSONString();
	System.out.println( json );
%>
<%=json%>