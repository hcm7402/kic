package com.kic.groupware;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kic.groupware.project.CommentTO;
import com.kic.groupware.project.ProjectDAO;
import com.kic.groupware.project.ProjectTO;
import com.kic.groupware.project.TaskTO;

@Controller 
public class ProjectController {

    static final Logger LOGGER = LoggerFactory.getLogger(ProjectController.class);
    
    /**
     * 리스트.
     */

	@RequestMapping(value = "/project.do")
	public ModelAndView project( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "project 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/project" );
		
		return model;
	}
	@RequestMapping(value = "/projectview.do")
	public ModelAndView projectview( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "projectview 컨트롤러 호출" );
		
		String pjseq = request.getParameter("seq");
		
		ProjectDAO dao = new ProjectDAO();
		
		ProjectTO to = dao.view(pjseq);
		ProjectDAO dao2 = new ProjectDAO();
		ArrayList<ProjectTO> teamsList = dao2.teams(pjseq);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/projectview" );
		model.addObject("to", to);
		model.addObject("teamsList", teamsList );
		
		return model;
	}
	
	@RequestMapping(value = "/projectlist.do")
	public ModelAndView projectlist( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "projectlist 컨트롤러 호출" );
		
		ProjectDAO dao = new ProjectDAO();
		ArrayList<ProjectTO> pjLists = dao.pjlist();
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/projectlist" );
		model.addObject("pjLists", pjLists);
		
		return model;
	}
	
	@RequestMapping(value = "/projectcreate.do")
	public ModelAndView projectcreate( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "projectcreate 컨트롤러 호출" );
		
		String eno = request.getParameter("eno");
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/projectcreate" );
		model.addObject("eno", eno);
		
		return model;
	}
	
	@RequestMapping(value = "/projectcreate_ok.do")
	public ModelAndView projectcreate_ok( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "projectcreate_ok 컨트롤러 호출" );
		
		String leader = request.getParameter("leader");
		String name = request.getParameter("name");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String content = request.getParameter("content");
		String team = request.getParameter("team");
		
		ProjectDAO dao = new ProjectDAO();
		int flag = dao.create(leader, name, start, end, content, team);
		
		System.out.println( flag + ": 2");
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/projectcreate_ok" );
		model.addObject("flag", flag );
		
		return model;
	}
	
	@RequestMapping(value = "/teamlist.do")
	public ModelAndView teamlist( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "teamlist 컨트롤러 호출" );
		
		ProjectDAO dao = new ProjectDAO();
		
		ArrayList<ProjectTO> teamLists = dao.teamlist();
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/teamlist" );
		model.addObject( "teamLists", teamLists );
		
		return model;
	}
	
	@RequestMapping(value = "/pjlist.do")
	public ModelAndView pjlist( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "pjlist 컨트롤러 호출" );
		
		ProjectDAO dao = new ProjectDAO();
		
		ArrayList<ProjectTO> pjLists = dao.pjlist();
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/pjlist" );
		model.addObject( "pjLists", pjLists );
		
		return model;
	}
	
	@RequestMapping(value = "/pjpercent.do")
	public ModelAndView pjpercent( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "pjpercent 컨트롤러 호출" );
		
		ProjectDAO dao = new ProjectDAO();
		
		ArrayList<ProjectTO> percentLists = dao.pjpercent();
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/pjpercent" );
		model.addObject( "percentLists", percentLists );
		
		return model;
	}
	
	@RequestMapping(value = "/tasklist.do")
	public ModelAndView tasklist( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "tasklist 컨트롤러 호출" );
		
		String pjseq = request.getParameter("pjseq");
		System.out.println( pjseq );
		
		ProjectDAO dao = new ProjectDAO();
		
		ArrayList<TaskTO> taskLists = dao.tasklist(pjseq);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/tasklist" );
		model.addObject("taskLists", taskLists );
		
		return model;
	}
	
	@RequestMapping(value = "/taskadd.do")
	public ModelAndView taskadd( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "taskadd 컨트롤러 호출" );
		
		TaskTO to = new TaskTO();
		String pjseq = request.getParameter("pjseq");
		String task_title = request.getParameter("task_title");
		String task_content = request.getParameter("task_content");
		String task_leader = request.getParameter("task_leader");
		
		to.setPjseq(pjseq);
		to.setTtitle(task_title);
		to.setTcontent(task_content);
		to.setLeader(task_leader);
		
		ProjectDAO dao = new ProjectDAO();
		
		int flag = dao.taskadd(to);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/taskadd" );
		model.addObject( "flag", flag );
		
		return model;
	}
	
	@RequestMapping(value = "/deleteproject.do")
	public ModelAndView deleteproject( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "deleteproject 컨트롤러 호출" );
		
		String pjseq = request.getParameter("pjseq");
		String leader = request.getParameter("pjleader");
		String password = request.getParameter("password");
		
		ProjectDAO dao = new ProjectDAO();
		
		int flag = dao.deleteproject(pjseq, leader, password);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/deleteproject" );
		model.addObject( "flag", flag );
		
		return model;
	}
	
	@RequestMapping(value = "/projectmodify.do")
	public ModelAndView projectmodify( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "projectmodify 컨트롤러 호출" );
		
		String pjseq = request.getParameter("pjseq");
		
		ProjectDAO dao = new ProjectDAO();
		
		ProjectTO to = dao.view(pjseq);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/projectmodify" );
		model.addObject("to", to);
		
		return model;
	}
	
	@RequestMapping(value = "/projectmodify_ok.do")
	public ModelAndView projectmodify_ok( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "projectmodify_ok 컨트롤러 호출" );
		
		String pjseq = request.getParameter("pjseq");
		String leader = request.getParameter("leader");
		String name = request.getParameter("name");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String content = request.getParameter("content");
		String team = request.getParameter("team");
		String state = request.getParameter("state");
		
		ProjectDAO dao = new ProjectDAO();
		
		int flag = dao.modifyok(pjseq, leader, name, start, end, content, team, state);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/projectmodify_ok" );
		model.addObject("flag", flag);
		
		return model;
	}
	
	@RequestMapping(value = "/commentlist.do")
	public ModelAndView commentlist( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "commentlist 컨트롤러 호출" );
		
		String pjseq = request.getParameter("pjseq");
		
		ProjectDAO dao = new ProjectDAO();
		
		ArrayList<CommentTO> commentLists = dao.commentlist(pjseq);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/commentlist" );
		model.addObject("commentLists", commentLists);
		
		return model;
	}
	
	@RequestMapping(value = "/comment_ok.do")
	public ModelAndView comment_ok( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "comment_ok 컨트롤러 호출" );
		
		String pjseq = request.getParameter("pjseq");
		String eno = request.getParameter("eno");
		String content = request.getParameter("content");
		
		ProjectDAO dao = new ProjectDAO();
		
		int flag = dao.comment(pjseq, eno, content);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/comment_ok" );
		model.addObject("flag", flag);
		
		return model;
	}
	
	@RequestMapping(value = "/commentdelete.do")
	public ModelAndView commentdelete( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "commentdelete 컨트롤러 호출" );
		
		String eno = request.getParameter("eno");
		String c_seq = request.getParameter("c_seq");
		
		ProjectDAO dao = new ProjectDAO();
		
		int flag = dao.commentdelete(eno, c_seq);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/commentdelete" );
		model.addObject("flag", flag);
		
		return model;
	}
	
	@RequestMapping(value = "/commentmodify.do")
	public ModelAndView commentmodify( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "commentmodify 컨트롤러 호출" );
		
		String c_writer = request.getParameter("c_writer");
		String c_seq = request.getParameter("c_seq");
		String c_content = request.getParameter("c_content");
		
		ProjectDAO dao = new ProjectDAO();
		
		int flag = dao.commentmodify(c_writer, c_seq, c_content);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/commentmodify" );
		model.addObject("flag", flag);
		
		return model;
	}
}
