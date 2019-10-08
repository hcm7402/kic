<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.kic.groupware.project.ProjectTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<ProjectTO> pjLists = (ArrayList) request.getAttribute("pjLists");

	JSONObject jsonObject = new JSONObject();
	JSONArray arr = new JSONArray();
	
	
	for( ProjectTO to : pjLists ) {
		
		String pjseq = to.getPjseq();
		String pjleader = to.getPjleader();
		String pjname = to.getPjname();
		String startdate = to.getStartdate();
		String enddate = to.getEnddate();
		String pjcontent = to.getPjcontent();
		String team = to.getTeam();
		String pjstate = to.getPjstate();
		String ename = to.getEname();
		String pjpercent = to.getPjpercent();
		
		JSONObject results = new JSONObject();
		
		results.put("pjseq", pjseq);
		results.put("pjleader", pjleader);
		results.put("pjname", pjname);
		results.put("startdate", startdate);
		results.put("enddate", enddate);
		results.put("pjcontent", pjcontent);
		results.put("team", team);
		results.put("pjstate", pjstate);
		results.put("ename", ename);
		results.put("pjpercent", pjpercent);
		
		arr.add(results);
		
		jsonObject.put("results", arr);
	}

	String json = jsonObject.toJSONString();
%>
<%=json%>