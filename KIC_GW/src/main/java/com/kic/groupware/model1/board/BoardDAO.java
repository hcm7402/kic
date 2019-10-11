package com.kic.groupware.model1.board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BoardDAO {
	
	private Connection conn = null;
	//private BoardListTO listTO;
	
	public BoardDAO() {
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

	//메서드는 페이지와 1:1 (페이지 1개에 메서드 1개)
	
	public void boardWrite() {}
	
	public int boardWriteOk(BoardTO to) {
		
		PreparedStatement pstmt = null;
		
		int flag=1;
		
		try {
			
			String sql = "insert into board1 values (0, ?, ?, ?, ?, ?, 0, ?, now())";
			pstmt = conn.prepareStatement( sql );
			pstmt.setString(1, to.getEno());
			pstmt.setString(2, to.getSubject());
			pstmt.setString(3, to.getWriter());
			pstmt.setString(4, to.getMail());
			pstmt.setString(5, to.getContent());
			pstmt.setString(6, to.getWip());
			
			int result = pstmt.executeUpdate();
			if( result == 1 ) {
				flag = 0;
			}
			
		}  catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(pstmt != null) try{pstmt.close();} catch(SQLException e) {}
			if(conn != null) try{conn.close();} catch(SQLException e) {}
		}	
		
		return flag;
	}
	
	public BoardListTO boardList(BoardListTO listTO) {

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int cpage = listTO.getCpage();
		int recordPerPage = listTO.getRecordPerPage();
		int blockPerPage = listTO.getBlockPerPage();

		try {
			
			String sql = "select seq, subject, writer, date_format(wdate, '%Y.%m.%d') wdate, hit, datediff(now(), wdate) wgap from board1 order by seq desc";
			pstmt = conn.prepareStatement( sql );
			rs = pstmt.executeQuery();
			
			rs.last();
			listTO.setTotalRecord(rs.getRow());
			rs.beforeFirst();
			
			listTO.setTotalPage(((listTO.getTotalRecord()-1)/recordPerPage)+1);
			
			int skip = (cpage - 1)*recordPerPage;
			if(skip != 0)rs.absolute(skip);
			
			ArrayList<BoardTO> boardLists = new ArrayList<BoardTO>();
			
			for(int i=0; i<recordPerPage && rs.next() ; i++) {
				
				BoardTO to1 = new BoardTO();
				to1.setSeq(rs.getString("seq"));
				to1.setSubject(rs.getString("subject"));
				to1.setWriter(rs.getString("writer"));
				to1.setWdate(rs.getString("wdate"));
				to1.setHit(rs.getString("hit"));
				to1.setWgap(rs.getInt("wgap"));
				
				boardLists.add(to1);
			}
			
			listTO.setBoardLists(boardLists);
			
			listTO.setStartBlock(((cpage - 1)/blockPerPage)*blockPerPage+1);
			listTO.setEndBlock(((cpage - 1)/blockPerPage)*blockPerPage+blockPerPage);
			
			if(listTO.getEndBlock() >= listTO.getTotalPage()) {
				listTO.setEndBlock(listTO.getTotalPage());
			}
		}catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try{rs.close();} catch(SQLException e) {}
			if(pstmt != null) try{pstmt.close();}catch(SQLException e) {}
			if(conn != null) try{conn.close();}catch(SQLException e) {}
		}
		
		return listTO;
	}
	
	public ArrayList<BoardTO> boardList() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<BoardTO> boardLists = new ArrayList<BoardTO>();
		
		try {
			
			String sql = "select seq, subject, writer, date_format(wdate, '%Y-%m-%d %h시%i분') wdate, hit, datediff(now(), wdate) wgap from board1 order by seq desc";
			pstmt = conn.prepareStatement( sql );
			
			rs = pstmt.executeQuery();
			while( rs.next() ) {
				BoardTO to = new BoardTO();
				
				to.setSeq(rs.getString( "seq" ));
				to.setSubject(rs.getString( "subject" ));
				to.setWriter(rs.getString( "writer" )); 
				to.setWdate(rs.getString( "wdate" ));
				to.setHit(rs.getString( "hit" )); 
				to.setWgap(rs.getInt( "wgap" ));
				
				boardLists.add(to);
	
			}
			
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try{rs.close();} catch(SQLException e) {}
			if(pstmt != null) try{pstmt.close();}catch(SQLException e) {}
			if(conn != null) try{conn.close();}catch(SQLException e) {}
		}
		
		return boardLists;
	}
	
	public BoardTO boardView(BoardTO to) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "update board1 set hit = hit + 1 where seq = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, to.getSeq());
			pstmt.executeUpdate();
			
			sql = "select eno, subject, writer, mail, wip, date_format(wdate, '%Y년%m월%d일 %H시%i분') wdate, hit, content from board1 where seq=?";
			pstmt = conn.prepareStatement( sql );
			pstmt.setString( 1, to.getSeq() );
			
			rs = pstmt.executeQuery();
			if( rs.next() ) {
				to.setEno(rs.getString( "eno" ));
				to.setSubject(rs.getString( "subject" ));
				to.setWriter(rs.getString( "writer" ));
				to.setMail(rs.getString( "mail" ));
				to.setWip( rs.getString( "wip" ));
				to.setWdate( rs.getString( "wdate" ));
				to.setHit(rs.getString( "hit" ));
				to.setContent(rs.getString( "content" ).replaceAll( "\n", "<br />" ));
			}
			
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try{rs.close();}catch(SQLException e) {}
			if(pstmt != null) try{pstmt.close();}catch(SQLException e) {}
			if(conn != null) try{conn.close();}catch(SQLException e) {}
		}
		
		return to;
	}
	
	
	public BoardTO boardModify(BoardTO to) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String sql = "select subject, writer, mail, content from board1 where seq=?";
			pstmt = conn.prepareStatement( sql );
			pstmt.setString( 1, to.getSeq() );
			
			rs = pstmt.executeQuery();
			if( rs.next() ) {
				to.setSubject(rs.getString( "subject" ));
				to.setWriter(rs.getString( "writer" ));
				to.setMail(rs.getString("mail"));
				to.setContent(rs.getString( "content" ));
			}
			
		}catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try{rs.close();}catch(SQLException e) {}
			if(pstmt != null) try{pstmt.close();}catch(SQLException e) {}
			if(conn != null) try{conn.close();}catch(SQLException e) {}
		}
		return to;
	}
	public int boardModifyOk(BoardTO to) {

		PreparedStatement pstmt = null;

		int flag = 2;
		try {

			String sql = "update board1 set subject=?, mail=?, content=? where seq=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getSubject());
			pstmt.setString(2, to.getMail());
			pstmt.setString(3, to.getContent());
			pstmt.setString(4, to.getSeq());

			int result = pstmt.executeUpdate();
			if (result == 0) {
				flag = 1;
			} else if (result == 1) {
				flag = 0;
			}

		}  catch (SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(pstmt != null) try{pstmt.close();}catch(SQLException e) {}
			if(conn != null) try{conn.close();}catch(SQLException e) {}
		}

		return flag;
	}
	
	
	
	public BoardTO boardDelete(BoardTO to) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String sql = "select subject, writer from board1 where seq=?";
			pstmt = conn.prepareStatement( sql );
			pstmt.setString( 1, to.getSeq() );
			
			rs = pstmt.executeQuery();
			if( rs.next() ) {
				to.setSubject(rs.getString( "subject" ));
				to.setWriter( rs.getString( "writer" ));
			}
			
		} catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}
		
		return to;
	}
	public int boardDeleteOk(BoardTO to) {
		PreparedStatement pstmt = null;
		
		int flag = 2;
		try {
			
			String sql = "delete from board1 where seq=? and eno=?";
			pstmt = conn.prepareStatement( sql );
			pstmt.setString(1,to.getSeq());
			pstmt.setString(2,to.getEno());
			
			int result = pstmt.executeUpdate();
			if( result == 0 ) {
				flag = 1;
			} else if( result == 1 ) {
				flag = 0;
			}
			
		}catch(SQLException e) {
			System.out.println("[에러] " + e.getMessage());
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
			if(conn != null) try {conn.close();} catch(SQLException e) {}
		}	
			
		return flag;
	}
	
}
