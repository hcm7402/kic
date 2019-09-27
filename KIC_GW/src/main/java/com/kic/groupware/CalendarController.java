package com.kic.groupware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kic.groupware.model1.calendar.MonthTO;

@Controller 
public class CalendarController {

    static final Logger LOGGER = LoggerFactory.getLogger(CalendarController.class);
    
    /**
     * 리스트.
     */
    @RequestMapping(value = "/cal.do")
    public ModelAndView calList(HttpServletRequest request, HttpServletResponse response) {
        System.out.println( "calList 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Calendar/cal3" );
		
		return model;
    }
    
    @RequestMapping(value = "/calone.do")
    public ModelAndView calOne(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "calOne 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		MonthTO searchVO = new MonthTO();
		
    	searchVO.setDate(request.getParameter("date"));
    	model.addObject("searchVO", searchVO);
    	model.setViewName( "Calendar/calOne" );
        return model;
    }
    
    @RequestMapping(value = "/caldepart.do")
    public ModelAndView calDepart(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "caldepart 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		MonthTO searchVO = new MonthTO();
		
    	searchVO.setDate(request.getParameter("date"));
    	model.addObject("searchVO", searchVO);
    	model.setViewName( "Calendar/calDepart" );
        return model;
    }
    
    @RequestMapping(value = "/calcompany.do")
    public ModelAndView calCompany(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "calCompany 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		MonthTO searchVO = new MonthTO();
		
    	searchVO.setDate(request.getParameter("date"));
    	model.addObject("searchVO", searchVO);
    	model.setViewName( "Calendar/calCompany" );
        return model;
    }
    
    @RequestMapping(value = "/jsontest.do")
    public ModelAndView jsontest(HttpServletRequest request, HttpServletResponse response) {
        System.out.println( "jsontest 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Calendar/jsontest" );
		
		return model;
    }
}
