package com.kic.groupware;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kic.groupware.model1.calendar.CalendarDAO;
import com.kic.groupware.model1.calendar.CalendarTO;
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
		model.setViewName( "Calendar/cal" );
		
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
    
    @RequestMapping(value = "/calone_ok.do")
    public ModelAndView calOne_ok(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "calOne_ok 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		CalendarTO to = new CalendarTO();
		to.setEno(request.getParameter("eno"));
		to.setCddiv(request.getParameter("cddiv"));
		to.setDeptno(request.getParameter("deptno"));
		to.setCddivision(request.getParameter("cddivision"));
		to.setCdname(request.getParameter("cdname"));
		to.setStartdate(request.getParameter("startdate"));
		to.setEnddate(request.getParameter("enddate"));
		to.setContents(request.getParameter("contents"));
		
    	CalendarDAO dao = new CalendarDAO();
    	int flag = dao.caloneadd(to);
    	
    	model.addObject("flag", flag);
    	model.setViewName( "Calendar/calOne_ok" );
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
        
		String eno = (String) request.getAttribute("eno");
		
		ModelAndView model = new ModelAndView();
		CalendarDAO dao = new CalendarDAO();
		
		ArrayList<CalendarTO> callist = dao.cdList(eno);
		model.addObject("callist", callist);
		model.setViewName( "Calendar/jsontest" );
		
		return model;
    }
}
