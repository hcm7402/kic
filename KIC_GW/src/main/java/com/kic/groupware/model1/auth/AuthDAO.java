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
		ResultSet rs = null;
		String sql;
		try {
			sql = "select * from auth_businesstrip left join emp on auth_businesstrip.eno=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, to.getEno());
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				to.setEno(rs.getString("eno"));
				to.setEname( rs.getString("ename") );
				to.setDeptno( rs.getString("deptno") );
			}
			if(count == 1) {
				sql = "insert into auth_businesstrip values ( ?, ?, 0, now(), ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, "1");
				pstmt.setString(2, to.getEno());
				pstmt.setString(3, to.getDeptno());
				pstmt.setString(4, to.getEname());
				pstmt.setString(5, to.getBspot());
				pstmt.setString(6, to.getBpurpose());
				pstmt.setString(7, "1");
				//pstmt.setString(7, to.getAuthstate());
				
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
	
	public int busitripin1(AuthbusitripTO to, int count) {
		int flag = 1;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		try {
			sql = "select * from auth_businesstrip_schedule left join auth_businesstrip on auth_businesstrip.bno=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, to.getEno());
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				to.setEno(rs.getString("eno"));
				to.setEname( rs.getString("ename") );
				to.setDeptno( rs.getString("deptno") );
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
		ResultSet rs = null;
		try {
			String sql = "select * from auth_vacation left join emp on auth_vacation.eno=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, to.getEno());
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				to.setEno(rs.getString("eno"));
				to.setEname( rs.getString("ename") );
				to.setJob( rs.getString("job") );
				to.setDeptno( rs.getString("deptno") );
			}
			
			sql = "insert into auth_vacation values ( 0, ?, ?, ?, ?, now(), ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, to.getEno());
			pstmt.setString(2, "2");
			pstmt.setString(3, to.getEname());
			pstmt.setString(4, to.getDeptno());
			pstmt.setString(5, to.getJob());
			pstmt.setString(6, to.getVtype());
			pstmt.setString(7, to.getVstart());
			pstmt.setString(8, to.getVend());
			pstmt.setString(9, to.getVreason());
			pstmt.setString(10, "1");
			
			int result = pstmt.executeUpdate();
			if( result == 1 ) {
				flag = 0;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if( rs != null ) try { rs.close(); } catch(SQLException e) {};
			if( pstmt != null ) try { pstmt.close(); } catch(SQLException e) {};
			if( conn != null ) try { conn.close(); } catch(SQLException e) {};
		}
		
		
		return flag;
	}
	
	public AuthvacationTO vacationview(AuthvacationTO to) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			String sql = "select vno, eno, authno, ename, deptno, date_format(vdate, '%Y.%m.%d') vdate, job, vtype, vstart, vend, vreason, authstate  from auth_vacation where vno=?";
			pstmt = conn.prepareStatement( sql );
			pstmt.setString( 1, to.getVno() );
			System.out.println("dfdsf");
			rs = pstmt.executeQuery();
			if( rs.next() ) {
				to.setEno( rs.getString( "eno" ) );
				to.setAuthno( rs.getString( "authno" ) );
				to.setEname( rs.getString( "ename" ) );
				to.setDeptno( rs.getString( "deptno" ) );
				to.setVdate( rs.getString( "vdate" ) );
				to.setJob( rs.getString( "job" ) );
				to.setVtype( rs.getString( "vtype" ) );
				to.setVstart( rs.getString( "vstart" ) );
				to.setVend( rs.getString( "vend" ) );
				to.setVreason( rs.getString( "vreason" ) );
				to.setAuthstate( rs.getString( "authstate" ) );
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
				to.setEno(rs.getString("eno"));
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
		
		ArrayList<AuthbusitripTO> authVLists2 = new ArrayList<AuthbusitripTO>();
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
				authVLists2.add( to );
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try { rs.close(); } catch( SQLException e ) {}
			if(pstmt != null) try { pstmt.close(); } catch( SQLException e ) {}
			if(conn != null) try { conn.close(); } catch( SQLException e ) {}
		}
		return authVLists2;
	}
	
	public ArrayList<AuthtransportationTO> authVList3(String eno) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<AuthtransportationTO> authVLists3 = new ArrayList<AuthtransportationTO>();
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
				authVLists3.add( to );
			}
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try { rs.close(); } catch( SQLException e ) {}
			if(pstmt != null) try { pstmt.close(); } catch( SQLException e ) {}
			if(conn != null) try { conn.close(); } catch( SQLException e ) {}
		}
		return authVLists3;
	}

}
