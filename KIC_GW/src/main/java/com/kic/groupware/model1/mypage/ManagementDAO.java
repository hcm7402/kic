package com.kic.groupware.model1.mypage;

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

public class ManagementDAO {
	private Connection conn = null;
	
	public ManagementDAO() {
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
	
	public int checkin( String date ) {
		int flag = 1;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "insert into management ( eno, mdate, checkin ) values ( ?, now(), ? )";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "1");
			pstmt.setString(2, date);
			
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
	
	public int checkout( String checkout ) {
		int flag = 1;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String mno = null;
			String checkin = null, hours = null, second = null, minute = null;
			long diff = 0, sec = 0, min = 0, hour = 0;
			
			String sql = "select mno, checkin from management where eno = ? and mdate = date_format( now(), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "1");
			
			rs = pstmt.executeQuery();
			if( rs.next() ) {
				mno = rs.getString("mno");
				checkin = rs.getString("checkin");
			}
			SimpleDateFormat format = new SimpleDateFormat( "kk:mm:ss", Locale.KOREA );
			
			try {
				Date d1 = format.parse(checkin.substring(11, 19));
				Date d2 = format.parse(checkout.substring(10));
				
				diff = d2.getTime() - d1.getTime();
				sec = diff/1000;
				
				min = sec / 60;
				hour = min / 60;
				sec = sec % 60;
				min = min % 60;
				
				if( hour < 10 ) {
					hours = "0" + hour;
				}else {
					hours = "" + hour;
				}
				
				if( min < 10 ) {
					minute = "0" + min;
				}else {
					minute = "" + min;
				}
				
				if( sec < 10 ) {
					second = "0" + sec;
				}else {
					second = "" + sec;
				}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			String total = hours + ":" + minute + ":" + second;
			
			sql = "update management set checkout = ?, total = ? where mno =? and eno = ? and mdate = date_format( now(), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString( 1, checkout );
			pstmt.setString( 2, total );
			pstmt.setString( 3, mno );
			pstmt.setString( 4, "1" );
			
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
	
	public ManagementTO checkinout( String eno ) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ManagementTO to = new ManagementTO();
		
		try {
			String sql = "select checkin, checkout from management where eno = ? and mdate = date_format( now(), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "1");
			
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				String checkin = rs.getString("checkin");
				String checkout = rs.getString("checkout");
				
				to.setCheckin(checkin);
				to.setCheckout(checkout);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if( pstmt != null ) try { pstmt.close(); } catch(SQLException e) {};
			if( conn != null ) try { conn.close(); } catch(SQLException e) {};
		}
		
		
		return to;
	}
	
public ArrayList<ManagementTO> managelist( String eno ) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ManagementTO> manageLists = new ArrayList<ManagementTO>();
		
		try {
			String sql = "select * from management where eno = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "1");
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				ManagementTO to = new ManagementTO();
				
				String mdate = rs.getString("mdate");
				String checkin = rs.getString("checkin");
				String checkout = rs.getString("checkout");
				String total = rs.getString("total");
				String etc = rs.getString("etc");
				
				to.setM_date(mdate);
				to.setCheckin(checkin);
				to.setCheckout(checkout);
				to.setTotal(total);
				to.setEtc(etc);
				
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
}
