<%@page import="com.kic.groupware.model1.calendar.CalendarTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<CalendarTO> callist = (ArrayList<CalendarTO>)request.getAttribute("callist");
	JSONArray arrayObj = new JSONArray();
	JSONObject jsonObj = new JSONObject();

	for(CalendarTO to : callist) {
		JSONObject resultObj = new JSONObject();
		
		resultObj.put("title", to.getCdname() );
		resultObj.put("start", to.getStartdate());
		resultObj.put("end", to.getEnddate());
		resultObj.put("className", "green");
		
		arrayObj.add(resultObj);
	}
	
	String json = arrayObj.toJSONString();
%>
<%= json%>