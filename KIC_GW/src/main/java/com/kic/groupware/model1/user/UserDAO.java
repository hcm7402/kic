package com.kic.groupware.model1.user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserDAO {
	private Connection conn = null;
	
	public UserDAO() {
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
	
	public ArrayList<String> deptList() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<String> deptLists = new ArrayList<String>();
		try {
			String sql = "select dname from department";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				deptLists.add(rs.getString("dname"));
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		return deptLists;
	}
	
	public int useradd(UserTO to) {
		PreparedStatement pstmt = null;
		int flag = 1;

		try {
			String sql = "insert into emp values(0, ?, 0, ?, 0, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getEname());
			/*pstmt.setString(2, to.getPno());*/
			pstmt.setString(2, to.getHiredate());
			/*pstmt.setString(3, to.getSal());*/
			pstmt.setString(3, to.getBirth());
			pstmt.setString(4, to.getAddress());
			pstmt.setString(5, to.getDeptno());
			pstmt.setString(6, to.getEmail());
			pstmt.setString(7, to.getEphoto());
			pstmt.setString(8, to.getEid());
			pstmt.setString(9, to.getEpw());
			pstmt.setString(10, to.getAuthphoto());

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
	
	public UserTO login(UserTO to) {
		// 0 - 성공 / 1 - 비밀번호가 다름 / 2 - id가 없음
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		to.setFlag(2);
		
		try {
			String sql = "select eno, epw, level from emp where eid = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, to.getEid());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(to.getEpw().equals(rs.getString("epw"))) {
					to.setFlag(0);
					to.setEno(rs.getInt("eno"));
					to.setLevel(rs.getInt("level"));
				}else {
					to.setFlag(1);
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		return to;
	}
	
	public int id_certify(String eid) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int flag = 0;
		
		try {
			String sql = "select eid from emp where eid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, eid);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String u_id = rs.getString("eid");
				
				if(!u_id.equals(eid)) {
					flag = 0;
				} else {
					return flag = 1;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		return flag;
	}
}
