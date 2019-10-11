package com.kic.groupware;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kic.groupware.model1.calendar.CalendarDAO;
import com.kic.groupware.model1.calendar.CalendarTO;
import com.kic.groupware.model1.calendar.MonthTO;
import com.kic.groupware.model1.user.UserDAO;

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
		
		HttpSession session = request.getSession();
        String eno = (String) session.getAttribute("eno");
        System.out.println("session: " + eno);
		
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
    
    @RequestMapping(value = "/cal_ok.do")
    public ModelAndView calOne_ok(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "cal_ok 컨트롤러 호출" );
		
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
    	model.setViewName( "Calendar/cal_ok" );
        return model;
    }
    
    @RequestMapping(value = "/caldepart.do")
    public ModelAndView calDepart(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "caldepart 컨트롤러 호출" );
		ModelAndView model = new ModelAndView();
		MonthTO searchVO = new MonthTO();
		UserDAO userdao = new UserDAO();
		ArrayList<String> deptList = userdao.deptList();
		model.addObject("deptList", deptList);
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
    
    @RequestMapping(value = "/calModify.do")
    public ModelAndView calModify(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "calModify 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		String cddiv = request.getParameter("cddiv");
		String cdno = request.getParameter("cdno");

		CalendarDAO caldao = new CalendarDAO();
		CalendarTO caldata = caldao.calModify(request.getParameter("cdno"));
		String deptno = caldao.deptno(cdno);

		if(cddiv.equals("0")) {
			model.setViewName( "Calendar/calCompanyModify" );
			model.addObject("caldata", caldata);
		} else if(cddiv.equals("1")) {
			UserDAO userdao = new UserDAO();
			ArrayList<String> deptList = userdao.deptList();
			model.setViewName( "Calendar/calDepartModify" );
			model.addObject("deptList", deptList);
			model.addObject("caldata", caldata);
			model.addObject("deptno", deptno);
		} else if(cddiv.equals("2")) {
			model.setViewName( "Calendar/calOneModify" );
			model.addObject("caldata", caldata);
		}
        return model;
    }
    
    @RequestMapping(value = "/calmodify_ok.do")
    public ModelAndView calModify_ok(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "calModify_ok 컨트롤러 호출" );
		
    	HttpSession session = request.getSession();
        String eno = (String)session.getAttribute("eno");
        
		ModelAndView model = new ModelAndView();
		CalendarTO to = new CalendarTO();
		to.setEno(eno);
		to.setCdno(request.getParameter("cdno"));
		to.setDeptno(request.getParameter("deptno"));
		to.setCddivision(request.getParameter("cddivision"));
		to.setCdname(request.getParameter("cdname"));
		to.setStartdate(request.getParameter("startdate"));
		to.setEnddate(request.getParameter("enddate"));
		to.setContents(request.getParameter("contents"));
		
    	CalendarDAO dao = new CalendarDAO();
    	int flag = dao.calModify_ok(to);
    	
    	model.addObject("flag", flag);
    	model.setViewName( "Calendar/cal_ok" );
        return model;
    }

    @RequestMapping(value = "/caldelete.do")
    public ModelAndView calDelete(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "calDelete 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		
		HttpSession session = request.getSession();
        String eno = (String)session.getAttribute("eno");
		
		CalendarDAO caldao = new CalendarDAO();
		CalendarTO to = new CalendarTO();
		to.setEno(eno);
		to.setCdno(request.getParameter("cdno"));
		
		int flag = caldao.calDelete(to);
		
		model.setViewName( "Calendar/cal_ok" );
		model.addObject("flag", flag);
        return model;
    }
    
    @RequestMapping(value = "/jsontest.do")
    public ModelAndView jsontest(HttpServletRequest request, HttpServletResponse response) {
        System.out.println( "jsontest 컨트롤러 호출" );
        HttpSession session = request.getSession();
        String eno = (String) session.getAttribute("eno");

		ModelAndView model = new ModelAndView();
		CalendarDAO caldao = new CalendarDAO();
		UserDAO userdao = new UserDAO();
		String deptno = userdao.deptno(eno);
		
		System.out.println(deptno);
		System.out.println(eno);
		
		ArrayList<CalendarTO> calcompanylist = caldao.cdcompanyList();
		ArrayList<CalendarTO> caldepartlist = caldao.cddepartList(eno, deptno);
		ArrayList<CalendarTO> calonelist = caldao.cdoneList(eno);
		
		model.addObject("calonelist", calonelist);
		model.addObject("caldepartlist", caldepartlist);
		model.addObject("calcompanylist", calcompanylist);
		model.setViewName( "Calendar/jsontest" );
		
		return model;
    }
}