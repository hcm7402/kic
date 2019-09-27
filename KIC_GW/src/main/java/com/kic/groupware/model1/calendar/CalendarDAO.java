package com.kic.groupware.model1.calendar;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CalendarDAO {
	private Connection conn = null;
	
	public CalendarDAO() {
		String url = "jdbc:mysql://localhost:3306/groupware";
		String user = "group";
		String password = "123456";
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public ArrayList<String> cdList(int eno) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<String> cdLists = new ArrayList<String>();
		try {
			String sql = "select cdname, startdate, enddate from calendar_date where eno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, eno);
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				cdLists.add(rs.getString("dname"));
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		return cdLists;
	}
}
