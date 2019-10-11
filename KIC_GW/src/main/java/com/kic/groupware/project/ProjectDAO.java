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
			String sql = "select eno, ename, deptno, ephoto from emp";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				ProjectTO to = new ProjectTO();
				
				String eno = rs.getString("eno");
				String ename = rs.getString("ename");
				String deptno = rs.getString("deptno");
				String ePhoto = rs.getString("ephoto");
				
				to.setEno(eno);
				to.setEname(ename);
				to.setDeptno(deptno);
				to.setePhoto(ePhoto);
				
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
			String sql = "select * from project inner join emp on pjleader = eno where pjseq = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pjseq);
			
			rs = pstmt.executeQuery();
			if( rs.next() ) {
				String seq = rs.getString("pjseq");
				String pjleader = rs.getString("pjleader");
				String pjname = rs.getString("pjname");
				String startdate = rs.getString("startdate");
				String enddate = rs.getString("enddate");
				String pjcontent = rs.getString("pjcontent");
				String pjstate = rs.getString("pjstate");
				String pjpercent = rs.getString("pjpercent");
				String ename = rs.getString("ename");
				String ePhoto = rs.getString("ephoto");
				// 직책부분 추가
				
				to.setPjseq(seq);
				to.setPjleader(pjleader);
				to.setPjname(pjname);
				to.setStartdate(startdate);
				to.setEnddate(enddate);
				to.setPjcontent(pjcontent);
				to.setPjstate(pjstate);
				to.setPjpercent(pjpercent);
				to.setEname(ename);
				to.setePhoto(ePhoto);
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
			for( int i = 0; i < teams.length; i++ ) {
				
				sql = "select * from emp where eno = ?";
				pstmt2 = conn.prepareStatement(sql);
				
				pstmt2.setString(1, teams[i]);
				
				rst = pstmt2.executeQuery();
				
				if( rst.next() ) {
					
					ProjectTO to = new ProjectTO();
					String eno = rst.getString("eno");
					String teamm = rst.getString("ename");
					String ePhoto = rst.getString("ephoto");
					
					to.setEno(eno);
					to.setTeam(teamm);
					to.setePhoto(ePhoto);
					
					teamsList.add(to);
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if( rst != null ) try { rst.close(); } catch(SQLException e) {};
			if( rs != null ) try { rs.close(); } catch(SQLException e) {};
			if( pstmt2 != null ) try { pstmt2.close(); } catch(SQLException e) {};
			if( pstmt1 != null ) try { pstmt1.close(); } catch(SQLException e) {};
			if( conn != null ) try { conn.close(); } catch(SQLException e) {};
		}
		
		return teamsList;
	}
	
	public ArrayList<TaskTO> tasklist( String pjseq ) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<TaskTO> taskLists = new ArrayList<TaskTO>();
		
		try {
			String sql = "select * from task where pjseq = ? order by t_seq desc";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pjseq);
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				TaskTO to = new TaskTO();
				
				to.setLeader(rs.getString("t_leader"));
				to.setTtitle(rs.getString("t_title"));
				to.setTcontent(rs.getString("t_content"));
				to.setTstate(rs.getString("t_state"));
				
				taskLists.add(to);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if( rs != null ) try { rs.close(); } catch(SQLException e) {};
			if( pstmt != null ) try { pstmt.close(); } catch(SQLException e) {};
			if( conn != null ) try { conn.close(); } catch(SQLException e) {};
		}
		
		return taskLists;
	}
	
	public int taskadd( TaskTO to ) {
		PreparedStatement pstmt = null;
		int flag = 1;
		
		try {
			String sql = "insert into task values( ?, 0, ?, ?, ?, 1 )";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, to.getPjseq() );
			pstmt.setString(2, to.getTtitle() );
			pstmt.setString(3, to.getTcontent() );
			pstmt.setString(4, to.getLeader() );
			
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
	
	public int deleteproject( String pjseq, String leader, String password ) {
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		
		int flag = 1;
		
		try {
			String strsql = "select * from emp where eno = ? and epw = ?";
			pstmt1 = conn.prepareStatement(strsql);
			
			pstmt1.setString(1, leader);
			pstmt1.setString(2, password);
			
			rs = pstmt1.executeQuery();
			
			String pjleader = ""; 
			if( rs.next() ) {
				pjleader = rs.getString("eno");
			}
			
			String sql = "delete from task where pjseq = ?";
			pstmt2 = conn.prepareStatement(sql);
			
			pstmt2.setString(1, pjseq);
			
			pstmt2.executeUpdate();
			
			sql = "delete from project_comment where pjseq = ?";
			pstmt2 = conn.prepareStatement(sql);
			
			pstmt2.setString(1, pjseq);
			
			pstmt2.executeUpdate();
			
			sql = "delete from project where pjseq = ? and pjleader = ?";
			pstmt2 =conn.prepareStatement(sql);
			
			pstmt2.setString(1, pjseq);
			pstmt2.setString(2, pjleader);
			
			int result = pstmt2.executeUpdate();
			
			if( result == 1 ) {
				flag = 0;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if( rs != null ) try { rs.close(); } catch(SQLException e) {};
			if( pstmt1 != null ) try { pstmt1.close(); } catch(SQLException e) {};
			if( pstmt2 != null ) try { pstmt2.close(); } catch(SQLException e) {};
			if( conn != null ) try { conn.close(); } catch(SQLException e) {};
		}
		
		return flag;
	}
	
	public int modifyok( String pjseq, String pjleader, String name, String start, String end, String content, String team, String state ) {
		PreparedStatement pstmt = null;
		
		int flag = 1;
		
		try {
			String sql = "update project set pjname =?, startdate =?, enddate=?, pjcontent=?, team=?, pjstate= ? where pjseq = ? and pjleader = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, name);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			pstmt.setString(4, content);
			pstmt.setString(5, team);
			pstmt.setString(6, state);
			pstmt.setString(7, pjseq);
			pstmt.setString(8, pjleader);
			
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
	
	public int comment( String pjseq, String eno, String content ) {
		PreparedStatement pstmt = null;
		int flag = 1;
		
		try {
			String sql = "insert into project_comment values ( ?, 0, ?, now(), ? )";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pjseq);
			pstmt.setString(2, eno);
			pstmt.setString(3, content);
			
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
	
	public ArrayList<CommentTO> commentlist( String pjseq ) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<CommentTO> commentLists = new ArrayList<CommentTO>();
		
		try {
			String sql = "select * from project_comment inner join emp on c_writer = eno where pjseq = ? order by c_seq";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pjseq);
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				CommentTO to = new CommentTO();
				
				String c_seq = rs.getString("c_seq");
				String c_writer = rs.getString("c_writer");
				String ename = rs.getString("ename");
				String ePhoto = rs.getString("ephoto");
				String c_content = rs.getString("c_content");
				String c_date = rs.getString("c_date");
				
				to.setC_seq(c_seq);
				to.setC_writer(c_writer);
				to.setC_content(c_content);
				to.setC_date(c_date);
				to.setEname(ename);
				to.setEphoto(ePhoto);
				
				commentLists.add(to);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if( rs != null ) try { rs.close(); } catch(SQLException e) {};
			if( pstmt != null ) try { pstmt.close(); } catch(SQLException e) {};
			if( conn != null ) try { conn.close(); } catch(SQLException e) {};
		}
		
		return commentLists;
	}
	
	public int commentdelete( String eno, String c_seq ) {
		PreparedStatement pstmt = null;
		int flag = 1;
		
		try {
			String sql = "delete from project_comment where c_writer =? and c_seq = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, eno);
			pstmt.setString(2, c_seq);
			
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
	
	public int commentmodify( String c_writer, String c_seq, String c_content ) {
		PreparedStatement pstmt = null;
		int flag = 1;
		
		try {
			String sql = "update project_comment set c_content = ? , c_date = now() where c_writer = ? and c_seq = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, c_content);
			pstmt.setString(2, c_writer);
			pstmt.setString(3, c_seq);
			
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
	
}
