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
	private Connection conn2 = null;
	private Connection conn3 = null;
	
	public CalendarDAO() {
		String url = "jdbc:mysql://localhost:3306/groupware";
		String user = "group";
		String password = "123456";
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
			conn2 = DriverManager.getConnection(url, user, password);
			conn3 = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public ArrayList<CalendarTO> cdcompanyList() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<CalendarTO> cdcompanyList = new ArrayList<CalendarTO>();
		try {
			String sql = "select cdno, cddivision, cdname, startdate, enddate, contents from calendar_date where cddiv = ?";
			pstmt = conn3.prepareStatement(sql);
			pstmt.setString(1, "0");
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				CalendarTO to = new CalendarTO();
				to.setCdname(rs.getString("cdname"));
				to.setCddivision(rs.getString("cddivision"));
				to.setStartdate(rs.getString("startdate"));
				to.setEnddate(rs.getString("enddate"));
				to.setCdno(rs.getString("cdno"));
				to.setContents(rs.getString("contents"));
				to.setCddiv("0");
				
				cdcompanyList.add(to);
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn3 != null) try {conn3.close();} catch(SQLException e) {}
		}
		return cdcompanyList;
	}
	
	public ArrayList<CalendarTO> cddepartList(String eno, String deptno) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<CalendarTO> cddepartList = new ArrayList<CalendarTO>();
		try {
			String sql = null;
			if(!eno.equals("0")) {
				sql = "select cdno, cddivision, cdname, startdate, enddate, contents from calendar_date where cddiv = ? and deptno = ?";
				pstmt = conn2.prepareStatement(sql);
				pstmt.setString(1, "1");
				pstmt.setString(2, deptno);
			} else {
				sql = "select cdno, cddivision, cdname, startdate, enddate, contents from calendar_date where cddiv = ?";
				pstmt = conn2.prepareStatement(sql);
				pstmt.setString(1, "1");
			}
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				CalendarTO to = new CalendarTO();
				to.setCdname(rs.getString("cdname"));
				to.setCddivision(rs.getString("cddivision"));
				to.setStartdate(rs.getString("startdate"));
				to.setEnddate(rs.getString("enddate"));
				to.setCdno(rs.getString("cdno"));
				to.setContents(rs.getString("contents"));
				to.setCddiv("1");
				
				cddepartList.add(to);
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn2 != null) try {conn2.close();} catch(SQLException e) {}
		}
		return cddepartList;
	}
	
	public ArrayList<CalendarTO> cdoneList(String eno) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<CalendarTO> cdoneList = new ArrayList<CalendarTO>();
		try {
			String sql = null;
			if(!eno.equals("0")) {
				sql = "select cdno, cddivision, cdname, startdate, enddate, contents from calendar_date where cddiv = ? and eno = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "2");
				pstmt.setString(2, eno);
			} else {
				sql = "select cdno, cddivision, cdname, startdate, enddate, contents from calendar_date where cddiv = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "2");
			}

			rs = pstmt.executeQuery();
			while( rs.next() ) {
				CalendarTO to = new CalendarTO();
				to.setCdname(rs.getString("cdname"));
				to.setCddivision(rs.getString("cddivision"));
				to.setStartdate(rs.getString("startdate"));
				to.setEnddate(rs.getString("enddate"));
				to.setCdno(rs.getString("cdno"));
				to.setContents(rs.getString("contents"));
				to.setCddiv("2");
				
				cdoneList.add(to);
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		return cdoneList;
	}
	
	public String deptno(String cdno) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String deptno = null;
		try {
			String sql = "select deptno from calendar_date where cdno = ?";
			pstmt = conn2.prepareStatement(sql);
			pstmt.setString(1, cdno);
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				deptno = rs.getString("deptno");
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn2 != null) try {conn2.close();} catch(SQLException e) {}
		}
		return deptno;
	}
	
	public int caloneadd(CalendarTO to) {
		PreparedStatement pstmt = null;
		int flag = 1;

		try {
			String sql = "insert into calendar_date values(0, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getEno());
			pstmt.setString(2, to.getCddiv());
			pstmt.setString(3, to.getDeptno());
			pstmt.setString(4, to.getCddivision());
			pstmt.setString(5, to.getCdname());
			pstmt.setString(6, to.getStartdate());
			pstmt.setString(7, to.getEnddate());
			pstmt.setString(8, to.getContents());

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
	
	public CalendarTO calModify(String cdno) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CalendarTO to = new CalendarTO();

		try {
			String sql = "select deptno, cddivision, cdname, startdate, enddate, contents from calendar_date where cdno = ?";;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cdno);

			rs = pstmt.executeQuery();
			while( rs.next() ) {
				to.setDeptno(rs.getString("deptno"));
				to.setCddivision(rs.getString("cddivision"));
				to.setCdname(rs.getString("cdname"));
				to.setStartdate(rs.getString("startdate"));
				to.setEnddate(rs.getString("enddate"));
				to.setContents(rs.getString("contents"));
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		return to;
	}
	
	public int calModify_ok(CalendarTO to) {
		PreparedStatement pstmt = null;
		int flag = 1;

		try {
			String sql = "update calendar_date set deptno=?, cddivision=?, cdname=?, startdate=?, enddate=?, contents=? where cdno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getDeptno());
			pstmt.setString(2, to.getCddivision());
			pstmt.setString(3, to.getCdname());
			pstmt.setString(4, to.getStartdate());
			pstmt.setString(5, to.getEnddate());
			pstmt.setString(6, to.getContents());
			pstmt.setString(7, to.getCdno());

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
	
	public int calDelete(CalendarTO to) {
		PreparedStatement pstmt = null;
		int flag = 1;

		try {
			String sql = null;
			if(to.getEno().equals("0")) {
				sql = "delete from calendar_date where cdno = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, to.getCdno());
			} else {
				sql = "delete from calendar_date where cdno = ? and eno = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, to.getCdno());
				pstmt.setString(2, to.getEno());
			}

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
