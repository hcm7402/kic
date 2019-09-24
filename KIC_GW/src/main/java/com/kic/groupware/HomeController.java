package com.kic.groupware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@RequestMapping(value = "/main.do")
	public ModelAndView main2( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "main 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "Main/main" );
		
		return model;
	}
	
}
