<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.kic.groupware.project.CommentTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<CommentTO> commentLists = (ArrayList) request.getAttribute("commentLists");

	JSONObject jsonObject = new JSONObject();
	JSONArray arr = new JSONArray();
	
	
	for( CommentTO to : commentLists ) {
		
		String c_seq = to.getC_seq();
		String ename = to.getEname();
		String ephoto = to.getEphoto();
		String c_content = to.getC_content();
		String c_date = to.getC_date();
		String c_writer = to.getC_writer();
		
		JSONObject results = new JSONObject();
		
		results.put("c_seq", c_seq);
		results.put("ename", ename);
		results.put("ephoto", ephoto);
		results.put("c_content", c_content);
		results.put("c_date", c_date);
		results.put("c_writer", c_writer);
		
		arr.add(results);
		
		jsonObject.put("results", arr);
	}

	String json = jsonObject.toJSONString();
%>
<%=json%>