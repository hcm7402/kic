package com.kic.groupware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kic.groupware.model1.mypage.ManagementDAO;

@Controller
public class ManagementController {
	
	@RequestMapping(value = "/main2.do")
	public ModelAndView main2( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "management 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "main2" );
		
		return model;
	}
	
	@RequestMapping(value = "/Management.do")
	public ModelAndView management( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "management 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Management" );
		
		return model;
	}
	
	@RequestMapping(value = "/checkin.do")
	public ModelAndView checkin( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "checkin 컨트롤러 호출" );
		
		String date = request.getParameter("date");
		
		ManagementDAO dao = new ManagementDAO();
		int flag = dao.checkin(date);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "checkin" );
		model.addObject( "flag", flag );
		
		return model;
	}
	
	@RequestMapping(value = "/checkout.do")
	public ModelAndView checkout( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "checkout 컨트롤러 호출" );
		
		String date = request.getParameter("date");
		
		ManagementDAO dao = new ManagementDAO();
		int flag = dao.checkout(date);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "checkout" );
		model.addObject( "flag", flag );
		
		return model;
	}
	
}