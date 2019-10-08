package com.kic.groupware.model1.user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserDAO {
	private Connection conn = null;
	private Connection conn2 = null;
	
	public UserDAO() {
		String url = "jdbc:mysql://localhost:3306/groupware";
		String user = "group";
		String password = "123456"; 
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
			conn2 = DriverManager.getConnection(url, user, password);
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
			rs.next();
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
	
	public String deptno(String eno) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String deptno = null;
		try {
			String sql = "select deptno from emp where eno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, eno);
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				deptno = rs.getString("deptno");
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		return deptno;
	}
	
	public String empname(String eno) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String ename = null;
		try {
			String sql = "select ename from emp where eno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, eno);
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				ename = rs.getString("ename");
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		return ename;
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
		System.out.println("loginDAO 호출");
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		to.setFlag(2);
		
		try {
			String sql = "select eno, ename, epw, level from emp where eid = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, to.getEid());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(to.getEpw().equals(rs.getString("epw"))) {
					to.setFlag(0);
					to.setEno(rs.getInt("eno"));
					to.setLevel(rs.getInt("level"));
					to.setEname(rs.getString("ename"));
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
	
	public ArrayList<UserTO> addressList(String deptno) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<UserTO> addressList = new ArrayList<UserTO>();
		try {
			String sql = null;
			if(deptno.equals("0")) {
				sql = "select * from emp";
				pstmt = conn2.prepareStatement(sql);
			} else {
				sql = "select * from emp where deptno = ?";
				pstmt = conn2.prepareStatement(sql);
				pstmt.setString(1, deptno);
			}
			
			
			rs = pstmt.executeQuery();
			if(deptno.equals("0")) {
				rs.next();
			}
			while( rs.next() ) {
				UserTO to = new UserTO();
				to.setEno(rs.getInt("eno"));
				to.setEname(rs.getString("ename"));
				to.setEid(rs.getString("eid"));
				to.setJob(rs.getString("job"));
				to.setDeptno(rs.getString("deptno"));
				to.setEphoto(rs.getString("ephoto"));
				to.setLevel(rs.getInt("level"));
				
				addressList.add(to);
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn2 != null) try {conn2.close();} catch(SQLException e) {}
		}
		return addressList;
	}
	
	public ArrayList<UserTO> addressListModify() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<UserTO> addressList = new ArrayList<UserTO>();
		try {
			String sql = "select * from emp where level = 0";
			pstmt = conn2.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				UserTO to = new UserTO();
				to.setEno(rs.getInt("eno"));
				to.setEname(rs.getString("ename"));
				to.setEid(rs.getString("eid"));
				to.setDeptno(rs.getString("deptno"));
				to.setJob(rs.getString("job"));
				to.setEphoto(rs.getString("ephoto"));
				to.setLevel(rs.getInt("level"));
				
				addressList.add(to);
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn2 != null) try {conn2.close();} catch(SQLException e) {}
		}
		return addressList;
	}
	
	public int AddressModify_ok(String eno) {
		PreparedStatement pstmt = null;
		int flag = 1;

		try {
			String sql = "update emp set level = 1 where eno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, eno);

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
	
	public ArrayList<UserTO> addressListModifyLevel() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<UserTO> addressList = new ArrayList<UserTO>();
		try {
			String sql = "select * from emp where level <> 0";
			pstmt = conn2.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			rs.next();
			while( rs.next() ) {
				UserTO to = new UserTO();
				to.setEno(rs.getInt("eno"));
				to.setEname(rs.getString("ename"));
				to.setEid(rs.getString("eid"));
				to.setDeptno(rs.getString("deptno"));
				to.setJob(rs.getString("job"));
				to.setEphoto(rs.getString("ephoto"));
				to.setLevel(rs.getInt("level"));
				
				addressList.add(to);
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn2 != null) try {conn2.close();} catch(SQLException e) {}
		}
		return addressList;
	}
	
	public int AddressModifyLevel_ok(String eno, String level) {
		PreparedStatement pstmt = null;
		int flag = 1;

		try {
			String sql = "update emp set level = ? where eno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, level);
			pstmt.setString(2, eno);

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
