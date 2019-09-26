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
	
	public int busitripin(AuthTO to) {
		int flag = 1;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "insert into auth_businesstrip ( authno, bno, binsertdate, deptno, ename, bspot, bpurpose, authstate ) values ( ?, ?, now(), ? ,? ,?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, to.getAuthno());
			pstmt.setString(2, to.getBno());
			pstmt.setString(3, to.getDeptno());
			pstmt.setString(4, to.getEname());
			pstmt.setString(5, to.getBspot());
			pstmt.setString(6, to.getBpurpose());
			pstmt.setString(7, to.getAuthstate());
			
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
			String sql = "insert into auth_vacation values ( 0, ?, ?, ?, now(), ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, to.getAuthno());
			pstmt.setString(2, to.getEname());
			pstmt.setString(3, to.getDeptno());
			pstmt.setString(4, to.getPno());
			pstmt.setString(5, to.getVtype());
			pstmt.setString(6, to.getVtime());
			pstmt.setString(7, to.getVreason());
			
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
	
	public ArrayList<AuthvacationTO> authVList() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<AuthvacationTO> authVLists = new ArrayList<AuthvacationTO>();
		try {

			String sql = "select vno, authno, ename, deptno, date_format(vdate, '%Y.%m.%d') vdate, pno, vtype, vtime, vreason from auth_vacation order by vno desc";
			pstmt = conn.prepareStatement( sql );
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				AuthvacationTO to = new AuthvacationTO();
				to.setVno( rs.getString("vno") );
				to.setAuthno( rs.getString("authno") );
				to.setEname( rs.getString( "ename" ) );
				to.setDeptno( rs.getString( "deptno" ) );
				to.setVdate( rs.getString( "vdate" ) );
				to.setPno( rs.getString( "pno" ) );
				to.setVtype( rs.getString( "vtype" ) );
				to.setVtime( rs.getString( "vtime" ) );
				to.setVreason( rs.getString( "vreason" ) );
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
