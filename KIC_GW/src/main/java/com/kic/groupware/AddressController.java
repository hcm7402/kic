package com.kic.groupware;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kic.groupware.model1.user.UserDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class AddressController {
	
	@RequestMapping(value = "/address.do")
    public ModelAndView addrmenu(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println( "address 컨트롤러 호출" );
		ModelAndView model = new ModelAndView();
		UserDAO userdao = new UserDAO();
		ArrayList<String> deptList = userdao.deptList();
		model.addObject("deptList", deptList);
		
    	model.setViewName( "Address/address" );
        return model;
    }
	
}
