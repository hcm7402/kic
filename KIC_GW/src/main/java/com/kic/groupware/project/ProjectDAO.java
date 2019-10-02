package com.kic.groupware.project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class ProjectDAO {
	private Connection conn = null;
	
	public ProjectDAO() {
		// TODO Auto-generated constructor stub
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
	public ArrayList<ProjectTO> pjlist() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ProjectTO> pjLists = new ArrayList<ProjectTO>();
		
		try {
			String sql = "select * from project inner join emp on pjleader = eno order by pjseq";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				ProjectTO to = new ProjectTO();
				
				String pjseq = rs.getString("pjseq");
				String pjleader = rs.getString("pjleader");
				String pjname = rs.getString("pjname");
				String startdate = rs.getString("startdate");
				String enddate = rs.getString("enddate");
				String pjcontent = rs.getString("pjcontent");
				String team = rs.getString("team");
				String pjstate = rs.getString("pjstate");
				String ename = rs.getString("ename");
				String pjpercent = rs.getString("pjpercent");
				
				to.setPjseq(pjseq);
				to.setPjleader(pjleader);
				to.setPjname(pjname);
				to.setStartdate(startdate);
				to.setEnddate(enddate);
				to.setPjcontent(pjcontent);
				to.setTeam(team);
				to.setPjstate(pjstate);
				to.setEname(ename);
				to.setPjpercent(pjpercent);
				
				pjLists.add(to);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if( rs != null ) try { rs.close(); } catch(SQLException e) {};
			if( pstmt != null ) try { pstmt.close(); } catch(SQLException e) {};
			if( conn != null ) try { conn.close(); } catch(SQLException e) {};
		}
		
		return pjLists;
	}
	
	public ArrayList<ProjectTO> pjpercent() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ProjectTO> percentLists = new ArrayList<ProjectTO>();
		
		try {
			String sql = "select pjseq, pjstate, pjpercent from project";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				ProjectTO to = new ProjectTO();
				
				String pjseq = rs.getString("pjseq");
				String pjstate = rs.getString("pjstate");
				String pjpercent = rs.getString("pjpercent");
				
				to.setPjseq(pjseq);
				to.setPjstate(pjstate);
				to.setPjpercent(pjpercent);
				
				percentLists.add(to);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if( rs != null ) try { rs.close(); } catch(SQLException e) {};
			if( pstmt != null ) try { pstmt.close(); } catch(SQLException e) {};
			if( conn != null ) try { conn.close(); } catch(SQLException e) {};
		}
		
		return percentLists;
	}
	
	public ArrayList<ProjectTO> teamlist() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ProjectTO> teamLists = new ArrayList<ProjectTO>();
		
		try {
			String sql = "select eno, ename, deptno from emp";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				ProjectTO to = new ProjectTO();
				
				String eno = rs.getString("eno");
				String ename = rs.getString("ename");
				String deptno = rs.getString("deptno");
				
				to.setEno(eno);
				to.setEname(ename);
				to.setDeptno(deptno);
				
				teamLists.add(to);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if( rs != null ) try { rs.close(); } catch(SQLException e) {};
			if( pstmt != null ) try { pstmt.close(); } catch(SQLException e) {};
			if( conn != null ) try { conn.close(); } catch(SQLException e) {};
		}
		
		return teamLists;
	}
	
	public int create( String leader, String name, String start, String end, String content, String team ) {
		PreparedStatement pstmt = null;
		int flag = 1;
		
		try {
				String sql ="insert into project values( 0, ?, ?, ?, ?, ?, ?, 1 , 0 )";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, leader );
				pstmt.setString(2, name );
				pstmt.setString(3, start );
				pstmt.setString(4, end );
				pstmt.setString(5, content );
				pstmt.setString(6, team);
				
				int result = pstmt.executeUpdate();
				if( result == 1 ) {
					flag = 0;
				}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if( pstmt != null ) try { pstmt.close(); } catch(SQLException e) {};
			if( conn != null ) try { conn.close(); } catch(SQLException e) {};
		}
		
		return flag;
	}
	
	public ProjectTO view( String pjseq ) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ProjectTO to = new ProjectTO();
		
		try {
			String sql = "select * from project where pjseq = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pjseq);
			
			rs = pstmt.executeQuery();
			if( rs.next() ) {
				String pjleader = rs.getString("pjleader");
				String pjname = rs.getString("pjname");
				String startdate = rs.getString("startdate");
				String enddate = rs.getString("enddate");
				String pjcontent = rs.getString("pjcontent");
				String pjstate = rs.getString("pjstate");
				String pjpercent = rs.getString("pjpercent");
				
				to.setPjleader(pjleader);
				to.setPjname(pjname);
				to.setStartdate(startdate);
				to.setEnddate(enddate);
				to.setPjcontent(pjcontent);
				to.setPjstate(pjstate);
				to.setPjpercent(pjpercent);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if( rs != null ) try { rs.close(); } catch(SQLException e) {};
			if( pstmt != null ) try { pstmt.close(); } catch(SQLException e) {};
			if( conn != null ) try { conn.close(); } catch(SQLException e) {};
		}
		
		return to;
	}
	
	public ArrayList<ProjectTO> teams( String pjseq ) {
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		ResultSet rst = null;
		ArrayList<ProjectTO> teamsList = new ArrayList<ProjectTO>();
		
		try {
			String sql = "select * from project where pjseq = ?";
			pstmt1 = conn.prepareStatement(sql);
			
			pstmt1.setString(1, pjseq);
			
			rs = pstmt1.executeQuery();
			String team = "";
			if( rs.next() ) {
				team = rs.getString("team");
			}
			String[] teams = team.split(" ");
			for( int i = 0; i < teams.length - 1; i++ ) {
				
				sql = "select * from emp where eno = ?";
				pstmt2 = conn.prepareStatement(sql);
				
				pstmt2.setString(1, teams[i]);
				
				rst = pstmt2.executeQuery();
				
				if( rst.next() ) {
					ProjectTO to = new ProjectTO();
					String teamm = rst.getString("ename");
					String authPhoto = rst.getString("authphoto");
					
					to.setTeam(teamm);
					to.setAuthPhoto(authPhoto);
					
					teamsList.add(to);
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if( rst != null ) try { rst.close(); } catch(SQLException e) {};
			if( rs != null ) try { rs.close(); } catch(SQLException e) {};
			if( pstmt1 != null ) try { pstmt1.close(); } catch(SQLException e) {};
			if( conn != null ) try { conn.close(); } catch(SQLException e) {};
		}
		
		return teamsList;
	}
}
