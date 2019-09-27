package com.kic.groupware;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kic.groupware.model1.user.UserDAO;
import com.kic.groupware.model1.user.UserTO;

@Controller 
public class UserController {

    static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
    
    /**
     * 리스트.
     */
    @RequestMapping(value = "/login.do")
    public ModelAndView login(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "login 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();

		model.setViewName( "Main/login1" );
		
		return model;
    }
    
    @RequestMapping(value = "/useradd.do")
    public ModelAndView useradd(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "useradd 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		UserDAO dao = new UserDAO();
		ArrayList<String> deptList = dao.deptList();
		
		model.setViewName( "Main/useradd" );
		model.addObject("deptList", deptList);
		
		return model;
    }
    
    @RequestMapping(value = "/useradd_ok.do")
    public ModelAndView useradd_ok(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "useradd_ok 컨트롤러 호출" );
    	UserTO to = new UserTO();
    	to.setEname(request.getParameter("ename"));
    	/*to.setPno(request.getParameter("pno"));*/
    	to.setHiredate(request.getParameter("hiredate"));
    	/*to.setSal(request.getParameter("sal"));*/
    	to.setBirth(request.getParameter("birth"));
    	to.setAddress(request.getParameter("address"));
    	to.setDeptno(request.getParameter("deptno"));
    	to.setEmail(request.getParameter("email"));
    	to.setEphoto(request.getParameter("ephoto"));
    	to.setEid(request.getParameter("eid"));
    	to.setEpw(request.getParameter("epw"));
    	to.setAuthphoto(request.getParameter("authphoto"));
    	System.out.println(to.getEid());
		
		UserDAO dao = new UserDAO();
		dao.useradd(to);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Main/useradd_ok" );
		
		return model;
    }
    
    @RequestMapping(value="/login_ok.do")
	public ModelAndView login_ok(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("login_ok() 호출");
		
		String id = request.getParameter("u_id");
		String pwd = request.getParameter("u_password");
		
		UserTO to = new UserTO();
		to.setEid(id);
		to.setEpw(pwd);
		UserDAO dao = new UserDAO();
		UserTO enoflag = dao.login(to);
		int flag = enoflag.getFlag();
		int eno = enoflag.getEno();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("Main/login_ok");
		modelAndView.addObject("flag", flag);
		modelAndView.addObject("eno", eno);
		return modelAndView;
	}
	
	@RequestMapping(value="/session.do")
	public ModelAndView session(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("session() 호출");
		
		String eno = request.getParameter("eno");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("Main/session");
		modelAndView.addObject("eno", eno);
		return modelAndView;
	}
}
