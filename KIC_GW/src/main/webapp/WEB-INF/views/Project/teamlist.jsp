<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.kic.groupware.project.ProjectTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<ProjectTO> teamLists = (ArrayList) request.getAttribute("teamLists");

	JSONObject jsonObject = new JSONObject();
	JSONArray arr = new JSONArray();
	
	
	for( ProjectTO to : teamLists ) {
		String eno = to.getEno();
		String ename = to.getEname();
		String deptno = to.getDeptno();
		String ePhoto = to.getePhoto();
		
		JSONObject results = new JSONObject();
		
		results.put("eno", eno);
		results.put("ename", ename);
		results.put("deptno", deptno);
		results.put("ePhoto", ePhoto);
		
		arr.add(results);
		
		jsonObject.put("results", arr);
	}

	String json = jsonObject.toJSONString();
	System.out.println( json );
%>
<%=json%>