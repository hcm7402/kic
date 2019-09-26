<%@page import="java.util.ArrayList"%>
<%@page import="com.kic.groupware.model1.mypage.ManagementTO"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	ArrayList<ManagementTO> manageLists = (ArrayList) request.getAttribute("manageLists");

	JSONObject jsonObject = new JSONObject();
	JSONArray arr = new JSONArray();
	
	
	for( ManagementTO to : manageLists ) {
		String mdate = to.getM_date();
		String checkin = to.getCheckin();
		String checkout = to.getCheckout();
		String total = to.getTotal();
		String etc = to.getEtc();
		
		JSONObject results = new JSONObject();
		
		results.put("mdate", mdate);
		results.put("checkin", checkin);
		results.put("checkout", checkout);
		results.put("total", total);
		results.put("etc", etc);
		
		arr.add(results);
		
		jsonObject.put("results", arr);
	}

	String json = jsonObject.toJSONString();
%>
<%=json%>