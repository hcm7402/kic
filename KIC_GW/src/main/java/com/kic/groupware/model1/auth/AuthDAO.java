package com.kic.groupware.model1.auth;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;


public class AuthDAO {
	private Connection conn = null;
	
	public AuthDAO() {
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
	
	public int busitripin(AuthbusitripTO to, int count) {
		int flag = 1;
		
		PreparedStatement pstmt = null;
		String sql;
		try {
			if(count == 1) {
				sql = "insert into auth_businesstrip values ( ?, 0, now(), ? ,? ,?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, "1");
				pstmt.setString(2, to.getDeptno());
				pstmt.setString(3, to.getEname());
				pstmt.setString(4, to.getBspot());
				pstmt.setString(5, to.getBpurpose());
				pstmt.setString(6, "결재대기중");
				//pstmt.setString(6, to.getAuthstate());
				
			}
			
			sql = "insert into auth_businesstrip_schedule values ( ?, 0, now(), ?, ?, ?, ?, ?, ? )";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, to.getBno());
			pstmt.setString(2, to.getSstart());
			pstmt.setString(3, to.getSstarttime());
			pstmt.setString(4, to.getSend());
			pstmt.setString(5, to.getSendtime());
			pstmt.setString(6, to.getTransport());
			pstmt.setString(7, to.getBtinn());
			
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
	
	public int vacationin(AuthvacationTO to) {
		int flag = 1;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "insert into auth_vacation values ( 0, ?, ?, ?, now(), ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "2");
			pstmt.setString(2, to.getEname());
			pstmt.setString(3, to.getDeptno());
			pstmt.setString(4, to.getJob());
			pstmt.setString(5, to.getVtype());
			pstmt.setString(6, to.getVstart());
			pstmt.setString(7, to.getVend());
			pstmt.setString(8, to.getVreason());
			pstmt.setString(9, "결재대기중");
			
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
	
	public int transportationin(AuthtransportationTO to, int count) {
		int flag = 1;
		
		PreparedStatement pstmt = null;
		String sql;
		try {
			if(count == 1) {
				sql = "insert into auth_transport values ( 0, ?, now(), ? ,? ,?, ? )";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, "3");
				pstmt.setString(2, to.getDeptno());
				pstmt.setString(3, to.getJob());
				pstmt.setString(4, to.getEname());
				pstmt.setString(5, to.getAuthstate());
				
			}
			
			sql = "insert into auth_transport_content values ( 0, ?, ?, ?, ?, ?, ? )";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, to.getAtno());
			pstmt.setString(2, to.getAtcdate());
			pstmt.setString(3, to.getAtstart());
			pstmt.setString(4, to.getAtend());
			pstmt.setString(5, to.getAtreason());
			pstmt.setString(6, to.getAtcharge());
			
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
	public AuthTO authEmp(AuthTO to) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Date date1 = new Date();
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
			String date = transFormat.format(date1);
			
			String sql = "select eno, ename, job, deptno from emp where eno=?";
			pstmt = conn.prepareStatement( sql );
			pstmt.setString(1, to.getEno());
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				to.setEname( rs.getString("ename") );
				to.setJob( rs.getString("job") );
				to.setDeptno( rs.getString("deptno") );
				to.setDate(date);
			}
			
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try { rs.close(); } catch( SQLException e ) {}
			if(pstmt != null) try { pstmt.close(); } catch( SQLException e ) {}
			if(conn != null) try { conn.close(); } catch( SQLException e ) {}
		}
		return to;
	}
	
	public ArrayList<AuthvacationTO> authVList1(String eno) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<AuthvacationTO> authVLists = new ArrayList<AuthvacationTO>();
		try {

			String sql = "select vno, eno, authno, ename, deptno, date_format(vdate, '%Y.%m.%d') vdate, job, vtype, vstart, vend, vreason, authstate from auth_vacation where eno=? order by vno desc";
			pstmt = conn.prepareStatement( sql );
			pstmt.setString(1, eno);
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				AuthvacationTO to = new AuthvacationTO();
				to.setVno( rs.getString("vno") );
				to.setEno( rs.getString("eno") );
				to.setAuthno( rs.getString("authno") );
				to.setEname( rs.getString( "ename" ) );
				to.setDeptno( rs.getString( "deptno" ) );
				to.setVdate( rs.getString( "vdate" ) );
				to.setJob( rs.getString( "job" ) );
				to.setVtype( rs.getString( "vtype" ) );
				to.setVstart( rs.getString( "vstart" ) );
				to.setVend( rs.getString( "vend" ) );
				to.setVreason( rs.getString( "vreason" ) );
				to.setAuthstate( rs.getString( "authstate" ) );
				authVLists.add( to );
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try { rs.close(); } catch( SQLException e ) {}
			if(pstmt != null) try { pstmt.close(); } catch( SQLException e ) {}
			if(conn != null) try { conn.close(); } catch( SQLException e ) {}
		}
		return authVLists;
	}

	public ArrayList<AuthbusitripTO> authVList2(String eno) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<AuthbusitripTO> authVLists = new ArrayList<AuthbusitripTO>();
		try {

			String sql = "select authno, eno, bno, date_format(binsertdate, '%Y.%m.%d') binsertdate, deptno, ename, bspot, bpurpose, authstate from auth_businesstrip where eno=? order by bno desc";
			pstmt = conn.prepareStatement( sql );
			pstmt.setString(1, eno);
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				AuthbusitripTO to = new AuthbusitripTO();
				to.setAuthno( rs.getString("authno") );
				to.setEno( rs.getString("eno") );
				to.setBno( rs.getString("bno") );
				to.setBinsertdate( rs.getString( "binsertdate" ) );
				to.setDeptno( rs.getString( "deptno" ) );
				to.setEname( rs.getString( "ename" ) );
				to.setBspot( rs.getString( "bspot" ) );
				to.setBpurpose( rs.getString( "bpurpose" ) );
				to.setAuthstate( rs.getString( "authstate" ) );        
				authVLists.add( to );
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try { rs.close(); } catch( SQLException e ) {}
			if(pstmt != null) try { pstmt.close(); } catch( SQLException e ) {}
			if(conn != null) try { conn.close(); } catch( SQLException e ) {}
		}
		return authVLists;
	}
	
	public ArrayList<AuthtransportationTO> authVList3(String eno) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<AuthtransportationTO> authVLists = new ArrayList<AuthtransportationTO>();
		try {

			String sql = "select atno, eno, authno, date_format(atdate, '%Y.%m.%d') atdate, deptno, job, ename, authstate from auth_transport where eno=? order by atno desc";
			pstmt = conn.prepareStatement( sql );
			pstmt.setString(1, eno);
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				AuthtransportationTO to = new AuthtransportationTO();
				to.setAtno( rs.getString("atno") );
				to.setEno( rs.getString("eno") );
				to.setAuthno( rs.getString("authno") );
				to.setAtdate( rs.getString("atdate") );
				to.setDeptno( rs.getString( "deptno" ) );
				to.setJob( rs.getString( "job" ) );
				to.setEname( rs.getString( "ename" ) );
				to.setAuthstate( rs.getString( "authstate" ) );        
				authVLists.add( to );
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try { rs.close(); } catch( SQLException e ) {}
			if(pstmt != null) try { pstmt.close(); } catch( SQLException e ) {}
			if(conn != null) try { conn.close(); } catch( SQLException e ) {}
		}
		return authVLists;
	}
	
	/*
	
	
	public ArrayList<AuthTO> managelist( String eno ) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<AuthTO> manageLists = new ArrayList<AuthTO>();
		
		try {
			String sql = "select mdate, checkin, checkout from management where eno = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "1");
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				AuthTO to = new AuthTO();
				
				String mdate = rs.getString("mdate");
				String checkin = rs.getString("checkin");
				String checkout = rs.getString("checkout");
				
				to.setM_date(mdate);
				to.setCheckin(checkin);
				to.setCheckout(checkout);
				
				manageLists.add(to);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if( pstmt != null ) try { pstmt.close(); } catch(SQLException e) {};
			if( conn != null ) try { conn.close(); } catch(SQLException e) {};
		}
		
		return manageLists;
	}
	*/
}
