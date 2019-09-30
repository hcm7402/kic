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
		}
		
		return teamLists;
	}
}
