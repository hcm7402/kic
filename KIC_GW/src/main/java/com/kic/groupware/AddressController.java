package com.kic.groupware;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kic.groupware.model1.user.UserDAO;
import com.kic.groupware.model1.user.UserTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class AddressController {
	
	@RequestMapping(value = "/address.do")
    public ModelAndView address(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "address 컨트롤러 호출" );
		ModelAndView model = new ModelAndView();
		UserDAO userdao = new UserDAO();
		ArrayList<String> deptList = userdao.deptList();
		
		HttpSession session = request.getSession();
        String eno = (String) session.getAttribute("eno");
		
        model.addObject("eno", eno);
		model.addObject("deptList", deptList);
    	model.setViewName( "Address/address" );
        return model;
    }
	
	@RequestMapping(value = "/addressList.do")
    public ModelAndView addressList(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "addressList 컨트롤러 호출" );
		ModelAndView model = new ModelAndView();
		UserDAO userdao = new UserDAO();
		ArrayList<String> deptList = userdao.deptList();
		String deptno = request.getParameter("deptno");
		ArrayList<UserTO> addressList = userdao.addressList(deptno);
		
		HttpSession session = request.getSession();
        String eno = (String) session.getAttribute("eno");
		
        model.addObject("eno", eno);
		model.addObject("deptList", deptList);
		model.addObject("addressList", addressList);
    	model.setViewName( "Address/address" );
        return model;
    }
	
	@RequestMapping(value = "/addressModify.do")
    public ModelAndView addressModify(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "addressModify 컨트롤러 호출" );
		ModelAndView model = new ModelAndView();
		UserDAO userdao = new UserDAO();
		ArrayList<String> deptList = userdao.deptList();
		ArrayList<UserTO> addressList = userdao.addressListModify();
		
		HttpSession session = request.getSession();
        String eno = (String) session.getAttribute("eno");
		
        model.addObject("eno", eno);
		model.addObject("deptList", deptList);
		model.addObject("addressList", addressList);
    	model.setViewName( "Address/addressModify" );
        return model;
    }
	
	@RequestMapping(value = "/addressModify_ok.do")
    public ModelAndView addressModify_ok(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "addressModify_ok 컨트롤러 호출" );
		ModelAndView model = new ModelAndView();
		UserDAO userdao = new UserDAO();
		int flag = userdao.AddressModify_ok(request.getParameter("eno"));

		model.addObject("flag", flag);
    	model.setViewName( "Address/addressModify_ok" );
        return model;
    }
	
	@RequestMapping(value = "/addressModifyLevel.do")
    public ModelAndView addressModifyLevel(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "addressModifyLevel 컨트롤러 호출" );
		ModelAndView model = new ModelAndView();
		UserDAO userdao = new UserDAO();
		ArrayList<String> deptList = userdao.deptList();
		ArrayList<UserTO> addressList = userdao.addressListModifyLevel();
		
		HttpSession session = request.getSession();
        String eno = (String) session.getAttribute("eno");
		
        model.addObject("eno", eno);
		model.addObject("deptList", deptList);
		model.addObject("addressList", addressList);
    	model.setViewName( "Address/addressModifyLevel" );
        return model;
    }
	
	@RequestMapping(value = "/addressModifyLevel_ok.do")
    public ModelAndView addressModifyLevel_ok(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "addressModifyLevel_ok 컨트롤러 호출" );
    	ModelAndView model = new ModelAndView();
		UserDAO userdao = new UserDAO();
		System.out.println(request.getParameter("level"));
		int flag = userdao.AddressModifyLevel_ok(request.getParameter("eno"), request.getParameter("level"));

		model.addObject("flag", flag);
    	model.setViewName( "Address/addressModifyLevel_ok" );
        return model;
    }
}
