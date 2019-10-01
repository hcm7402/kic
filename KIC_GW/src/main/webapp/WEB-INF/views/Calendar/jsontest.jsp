<%@page import="com.kic.groupware.model1.calendar.CalendarTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
	ArrayList<CalendarTO> calonelist = (ArrayList<CalendarTO>)request.getAttribute("calonelist");
	ArrayList<CalendarTO> caldepartlist = (ArrayList<CalendarTO>)request.getAttribute("caldepartlist");
	ArrayList<CalendarTO> calcompanylist = (ArrayList<CalendarTO>)request.getAttribute("calcompanylist");
	JSONArray arrayObj = new JSONArray();
	JSONObject jsonObj = new JSONObject();

	for(CalendarTO to : calonelist) {
		JSONObject resultObj = new JSONObject();
		
		resultObj.put("title", to.getCdname() );
		resultObj.put("start", to.getStartdate());
		resultObj.put("end", to.getEnddate());
		resultObj.put("className", "green");
		resultObj.put("cdno", to.getCdno());
		resultObj.put("cddiv", to.getCddiv());
		
		arrayObj.add(resultObj);
	}
	for(CalendarTO to : caldepartlist) {
		JSONObject resultObj = new JSONObject();
		
		resultObj.put("title", to.getCdname() );
		resultObj.put("start", to.getStartdate());
		resultObj.put("end", to.getEnddate());
		resultObj.put("className", "orange");
		resultObj.put("cdno", to.getCdno());
		resultObj.put("cddiv", to.getCddiv());
		
		arrayObj.add(resultObj);
	}
	for(CalendarTO to : calcompanylist) {
		JSONObject resultObj = new JSONObject();
		
		resultObj.put("title", to.getCdname() );
		resultObj.put("start", to.getStartdate());
		resultObj.put("end", to.getEnddate());
		resultObj.put("className", "purple");
		resultObj.put("cdno", to.getCdno());
		resultObj.put("cddiv", to.getCddiv());
		
		arrayObj.add(resultObj);
	}
	
	String json = arrayObj.toJSONString();
	System.out.println(json);
%>
<%= json%>