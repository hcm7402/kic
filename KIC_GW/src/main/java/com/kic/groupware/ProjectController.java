package com.kic.groupware;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kic.groupware.project.ProjectDAO;
import com.kic.groupware.project.ProjectTO;

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
}
