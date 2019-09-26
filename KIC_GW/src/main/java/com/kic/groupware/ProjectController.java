package com.kic.groupware;

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
	@RequestMapping(value = "/projectlist.do")
	public ModelAndView projectlist( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "project 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/projectlist" );
		
		return model;
	}
	
	@RequestMapping(value = "/projectcreate.do")
	public ModelAndView projectcreate( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "project 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Project/projectcreate" );
		
		return model;
	}
}
