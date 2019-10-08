<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.kic.groupware.project.TaskTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<TaskTO> taskLists = (ArrayList) request.getAttribute("taskLists");

	JSONObject jsonObject = new JSONObject();
	JSONArray arr = new JSONArray();
	
	
	for( TaskTO to : taskLists ) {
		
		String t_leader = to.getLeader();
		String t_title = to.getTtitle();
		String t_content = to.getTcontent();
		String t_state = to.getTstate();
		
		
		JSONObject results = new JSONObject();
		
		results.put("t_leader", t_leader);
		results.put("t_title", t_title);
		results.put("t_content", t_content);
		results.put("t_state", t_state);
		
		arr.add(results);
		
		jsonObject.put("results", arr);
	}

	String json = jsonObject.toJSONString();
%>
<%=json%>