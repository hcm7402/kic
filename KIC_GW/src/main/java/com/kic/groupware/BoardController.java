package com.kic.groupware;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kic.groupware.model1.auth.AuthDAO;
import com.kic.groupware.model1.auth.AuthTO;
import com.kic.groupware.model1.auth.AuthvacationTO;
import com.kic.groupware.model1.board.BoardDAO;
import com.kic.groupware.model1.board.BoardListTO;
import com.kic.groupware.model1.board.BoardTO;

@Controller 
public class BoardController {

    static final Logger LOGGER = LoggerFactory.getLogger(BoardController.class);
    
    /**
     * 리스트.
     */
    		 
    @RequestMapping(value = "/boardpage.do")
   	public ModelAndView boardpage( HttpServletRequest request, HttpServletResponse response) {
   		System.out.println( "boardpage 컨트롤러 호출" );
   		
   		ModelAndView model = new ModelAndView();
   		model.setViewName( "Board/boardpage" );
   		
   		return model;
   	}
    
    @RequestMapping(value = "/boardlist.do")
	public ModelAndView boardlist( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "boardlist 컨트롤러 호출" );

		BoardDAO dao = new BoardDAO();
		BoardListTO listTO = new BoardListTO();
	       if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals( "" )) {
	          listTO.setCpage(Integer.parseInt(request.getParameter("cpage")));
	       }
	       listTO = dao.boardList(listTO);
	       
       ArrayList<BoardTO> boardLists = listTO.getBoardLists();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "Board/boardlist" );
		modelAndView.addObject("boardLists", boardLists);
		modelAndView.addObject("listTO", listTO);

		return modelAndView;
	} 
      
    @RequestMapping(value = "/boardview.do")
	public ModelAndView boardview( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "boardview 컨트롤러 호출" );
/*
		AuthTO to = new AuthTO();
		to.setEno( request.getParameter( "eno" ) );
		AuthDAO dao1 = new AuthDAO();
		to = dao1.authEmp( to );
		System.out.println(request.getParameter( "eno" ));
		*/
		BoardTO to1 = new BoardTO();
		to1.setSeq( request.getParameter( "seq" ) );
		BoardDAO dao2 = new BoardDAO();
		to1 = dao2.boardView( to1 );

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("Board/boardview");
		//modelAndView.addObject("to", to);
		modelAndView.addObject("to1", to1);
		return modelAndView;
	}

    @RequestMapping(value = "/board_write.do")
   	public ModelAndView board_write( HttpServletRequest request, HttpServletResponse response) {
   		System.out.println( "board_write 컨트롤러 호출" );

   		AuthTO to = new AuthTO();
   		to.setEno( request.getParameter( "eno" ) );
   		AuthDAO dao1 = new AuthDAO();
   		to = dao1.authEmp( to );
   		System.out.println(request.getParameter( "eno" ));

   		ModelAndView modelAndView = new ModelAndView();
   		modelAndView.setViewName("Board/board_write");
   		modelAndView.addObject("to", to);
   		return modelAndView;
   	}
    
    @RequestMapping(value = "/board_write_ok.do")
   	public ModelAndView board_write_ok( HttpServletRequest request, HttpServletResponse response) {
   		System.out.println( "board_write_ok 컨트롤러 호출" );

   		AuthTO to = new AuthTO();
   		to.setEno( request.getParameter( "eno" ) );
   		to.setEname( request.getParameter( "ename" ) );
   		System.out.println(request.getParameter("eno"));
   		System.out.println("ename:"+request.getParameter("ename"));
   		AuthDAO dao1 = new AuthDAO();
   		to = dao1.authEmp( to );
   		System.out.println(request.getParameter( "eno" ));
   		
   		BoardTO to1 = new BoardTO();
   		BoardDAO dao2 = new BoardDAO();
   		int flag = dao2.boardWriteOk( to1 );

   		ModelAndView modelAndView = new ModelAndView();
   		modelAndView.setViewName("Board/board_write_ok");
   		modelAndView.addObject("flag", flag);
   		return modelAndView;
   	}
    
    @RequestMapping(value = "/board_delete.do")
   	public ModelAndView board_delete( HttpServletRequest request, HttpServletResponse response) {
   		System.out.println( "board_delete 컨트롤러 호출" );

   		AuthTO to = new AuthTO();
   		to.setEno( request.getParameter( "eno" ) );
   		AuthDAO dao1 = new AuthDAO();
   		to = dao1.authEmp( to );
   		System.out.println(request.getParameter( "eno" ));
   		
   		BoardTO to1 = new BoardTO();
   		to1.setSeq( request.getParameter( "seq" ) );
   		BoardDAO dao2 = new BoardDAO();
   		to1 = dao2.boardDelete( to1 );

   		ModelAndView modelAndView = new ModelAndView();
   		modelAndView.setViewName("Board/board_delete");
   		modelAndView.addObject("to", to);
   		modelAndView.addObject("to1", to1);
   		return modelAndView;
   	}
    
    @RequestMapping(value = "/board_delete_ok.do")
   	public ModelAndView board_delete_ok( HttpServletRequest request, HttpServletResponse response) {
   		System.out.println( "board_delete_ok 컨트롤러 호출" );

   		AuthTO to = new AuthTO();
   		to.setEno( request.getParameter( "eno" ) );
   		AuthDAO dao1 = new AuthDAO();
   		to = dao1.authEmp( to );
   		System.out.println(request.getParameter( "eno" ));
   		
   		BoardTO to1 = new BoardTO();
   		to1.setSeq( request.getParameter( "seq" ) );
   		BoardDAO dao2 = new BoardDAO();
   		int flag = dao2.boardDeleteOk( to1 );

   		ModelAndView modelAndView = new ModelAndView();
   		modelAndView.setViewName("Board/board_delete_ok");
   		modelAndView.addObject("to", to);
   		modelAndView.addObject("flag", flag);
   		return modelAndView;
   	}
    
    @RequestMapping(value = "/board_modify.do")
   	public ModelAndView board_modify( HttpServletRequest request, HttpServletResponse response) {
   		System.out.println( "board_modify 컨트롤러 호출" );

   		AuthTO to = new AuthTO();
   		to.setEno( request.getParameter( "eno" ) );
   		AuthDAO dao1 = new AuthDAO();
   		to = dao1.authEmp( to );
   		System.out.println(request.getParameter( "eno" ));
   		
   		BoardTO to1 = new BoardTO();
   		to1.setSeq( request.getParameter( "seq" ) );
   		BoardDAO dao2 = new BoardDAO();
   		to1 = dao2.boardModify( to1 );

   		ModelAndView modelAndView = new ModelAndView();
   		modelAndView.setViewName("Board/board_modify");
   		modelAndView.addObject("to", to);
   		modelAndView.addObject("to1", to1);
   		return modelAndView;
   	}
    
    @RequestMapping(value = "/board_modify_ok.do")
   	public ModelAndView board_modify_ok( HttpServletRequest request, HttpServletResponse response) {
   		System.out.println( "board_modify_ok 컨트롤러 호출" );

   		AuthTO to = new AuthTO();
   		to.setEno( request.getParameter( "eno" ) );
   		AuthDAO dao1 = new AuthDAO();
   		to = dao1.authEmp( to );
   		System.out.println(request.getParameter( "eno" ));
   		
   		BoardTO to1 = new BoardTO();
   		to1.setSeq( request.getParameter( "seq" ) );
   		BoardDAO dao2 = new BoardDAO();
   		int flag = dao2.boardModifyOk( to1 );

   		ModelAndView modelAndView = new ModelAndView();
   		modelAndView.setViewName("Board/board_modify_ok");
   		modelAndView.addObject("to", to);
   		modelAndView.addObject("flag", flag);
   		return modelAndView;
   	}
    
}
