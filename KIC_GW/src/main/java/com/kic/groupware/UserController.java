package com.kic.groupware;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
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
    
    @RequestMapping(value = "/logout.do")
    public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "login 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();

		model.setViewName( "Main/logout" );
		
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
    public ModelAndView useradd_ok(MultipartHttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "useradd_ok 컨트롤러 호출" );
    	UserTO to = new UserTO();
    	String fileName = "";
		
		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		
    	to.setEname(request.getParameter("ename"));
    	to.setHiredate(request.getParameter("hiredate"));
    	to.setBirth(request.getParameter("birth"));
    	to.setAddress(request.getParameter("address"));
    	to.setDeptno(request.getParameter("deptno"));
    	to.setEmail(request.getParameter("email"));
    	to.setEphoto(fileName + request.getFile("ephoto").getOriginalFilename());
    	to.setEid(request.getParameter("eid"));
    	to.setEpw(request.getParameter("epw"));
    	to.setAuthphoto(fileName + request.getFile("authphoto").getOriginalFilename());
    	
    	File ephotoFile = new File("C:/Users/kitcoop/git/kic/KIC_GW/src/main/webapp/resources/photo",to.getEphoto());
    	File authphotoFile = new File("C:/Users/kitcoop/git/kic/KIC_GW/src/main/webapp/resources/sign",to.getAuthphoto());

        try {
        	request.getFile("ephoto").transferTo(ephotoFile);
        	request.getFile("authphoto").transferTo(authphotoFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
		
		UserDAO dao = new UserDAO();
		int flag = dao.useradd(to);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Main/useradd_ok" );
		model.addObject("flag", flag);
		
		return model;
    }
    
    @RequestMapping(value="/login_ok.do")
	public ModelAndView login_ok(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("login_ok 호출");
		
		String id = request.getParameter("u_id");
		String pwd = request.getParameter("u_password");
		
		UserTO to = new UserTO();
		to.setEid(id);
		to.setEpw(pwd);
		UserDAO dao = new UserDAO();
		UserTO enoflag = dao.login(to);
		int eno = enoflag.getEno();
		
		HttpSession session = request.getSession();
        session.setAttribute("eno", eno);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("Main/login_ok");
		modelAndView.addObject("enoflag", enoflag);
		return modelAndView;
	}
	
	@RequestMapping(value="/session.do")
	public ModelAndView session(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("session() 호출");
		
		String eno = request.getParameter("eno");
		String level = request.getParameter("level");
		String ename = request.getParameter("ename");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("Main/session");
		modelAndView.addObject("eno", eno);
		modelAndView.addObject("level", level);
		modelAndView.addObject("ename", ename);
		return modelAndView;
	}
	
	@RequestMapping(value="/id_check.do")
	public ModelAndView id_check(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("id_check() 호출");
		
		String eid = request.getParameter("eid");
		UserDAO dao = new UserDAO();
		
		int flag = dao.id_certify(eid);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("Main/id_check");
		modelAndView.addObject("flag", flag); 
		
		return modelAndView;
	}
}
