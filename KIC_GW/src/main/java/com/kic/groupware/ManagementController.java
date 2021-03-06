package com.kic.groupware;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kic.groupware.model1.mypage.ManagementDAO;
import com.kic.groupware.model1.mypage.ManagementTO;
import com.kic.groupware.model1.user.UserDAO;
import com.kic.groupware.model1.user.UserTO;

@Controller
public class ManagementController {
	
	@RequestMapping(value = "/mypage.do")
	public ModelAndView mypage( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "mypage 컨트롤러 호출" );
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "MyPage/mypage" );
		
		return model;
	}
	
	@RequestMapping(value = "/myinfo.do")
	public ModelAndView myinfo( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "myinfo 컨트롤러 호출" );
		
		String eno = request.getParameter("eno");
		
		ManagementDAO dao = new ManagementDAO();
		UserTO to = dao.myinfo(eno);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "MyPage/myinfo" );
		model.addObject("to", to);
		
		return model;
	}
	
	@RequestMapping(value = "/myinfomodify.do")
	public ModelAndView myinfomodify( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "myinfomodify 컨트롤러 호출" );
		
		String eno = request.getParameter("eno");
		
		ManagementDAO dao = new ManagementDAO();
		UserTO to = dao.myinfo(eno);
		UserDAO dao1 = new UserDAO();
		ArrayList<String> deptList = dao1.deptList();
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "MyPage/myinfomodify" );
		model.addObject("to", to);
		model.addObject("deptList",deptList);
		
		return model;
	}
	
	@RequestMapping(value = "/myinfomodify_ok.do")
	public ModelAndView myinfomodify_ok( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "myinfomodify_ok 컨트롤러 호출" );
		
		String eno = request.getParameter("eno");
		String address = request.getParameter("address");
		String deptno = request.getParameter("deptno");
		String email = request.getParameter("email");
		
		ManagementDAO dao = new ManagementDAO();
		int flag = dao.modifyok(eno, address, deptno, email);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "MyPage/myinfomodify_ok" );
		model.addObject("flag", flag);
		
		return model;
	}
	
	@RequestMapping(value = "/password.do")
	public ModelAndView password( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "password 컨트롤러 호출" );
		
		String eno = request.getParameter("eno");
		String password = request.getParameter("password");
		
		ManagementDAO dao = new ManagementDAO();
		int flag = dao.password(eno, password);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "MyPage/password" );
		model.addObject("flag", flag);
		
		return model;
	}
	
	@RequestMapping(value = "/Management.do")
	public ModelAndView management( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "management 컨트롤러 호출" );
		// 여기서 호출
		ModelAndView model = new ModelAndView();
		model.setViewName( "MyPage/Management" );
		
		return model;
	}
	
	@RequestMapping(value = "/checkin.do")
	public ModelAndView checkin( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "checkin 컨트롤러 호출" );
		
		String eno = request.getParameter("eno");
		String date = request.getParameter("date");
		
		ManagementDAO dao = new ManagementDAO();
		int flag = dao.checkin(eno, date);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "MyPage/checkin" );
		model.addObject( "flag", flag );
		
		return model;
	}
	
	@RequestMapping(value = "/checkout.do")
	public ModelAndView checkout( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "checkout 컨트롤러 호출" );
		
		String eno = request.getParameter("eno");
		String date = request.getParameter("date");
		
		ManagementDAO dao = new ManagementDAO();
		int flag = dao.checkout(eno, date);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "MyPage/checkout" );
		model.addObject( "flag", flag );
		
		return model;
	}
	
	// 메인페이지의 출근, 퇴근시간 출력용
	@RequestMapping(value = "/checkinout.do")
	public ModelAndView checkinout( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "checkinout 컨트롤러 호출" );
		
		String eno = request.getParameter("eno");
		
		ManagementDAO dao = new ManagementDAO();
		ManagementTO to = dao.checkinout(eno);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "MyPage/checkinout" );
		model.addObject( "to", to );
		
		return model;
	}
	
	@RequestMapping(value = "/managelist.do")
	public ModelAndView manageList( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "managementList 컨트롤러 호출" );
		
		String eno = request.getParameter("eno");
		System.out.println(eno);
		
		ManagementDAO dao = new ManagementDAO();
		ArrayList<ManagementTO> manageLists = dao.managelist(eno);
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "MyPage/managelist" );
		model.addObject("manageLists", manageLists);
		
		return model;
	}
	
}
