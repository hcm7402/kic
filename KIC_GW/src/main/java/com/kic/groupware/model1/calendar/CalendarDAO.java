package com.kic.groupware.model1.calendar;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.kic.groupware.model1.user.UserTO;

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
	
	public ArrayList<CalendarTO> cdList(String eno) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<CalendarTO> cdLists = new ArrayList<CalendarTO>();
		try {
			String sql = "select cdname, startdate, enddate from calendar_date where eno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, eno);
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				CalendarTO to = new CalendarTO();
				to.setCdname(rs.getString("cdname"));
				to.setStartdate(rs.getString("startdate"));
				to.setEnddate(rs.getString("enddate"));
				
				cdLists.add(to);
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
	
	public int caloneadd(CalendarTO to) {
		PreparedStatement pstmt = null;
		int flag = 1;

		try {
			String sql = "insert into emp values(0, ?, 2, 0, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getEno());
			pstmt.setString(2, to.getCddivision());
			pstmt.setString(3, to.getCdname());
			pstmt.setString(4, to.getStartdate());
			pstmt.setString(5, to.getEnddate());
			pstmt.setString(6, to.getContents());

			int result = pstmt.executeUpdate();
			if(result == 1) {
				flag = 0;
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		return flag;
	}
}
