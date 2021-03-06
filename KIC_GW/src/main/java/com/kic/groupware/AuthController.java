package com.kic.groupware;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kic.groupware.model1.auth.AuthDAO;
import com.kic.groupware.model1.auth.AuthTO;
import com.kic.groupware.model1.auth.AuthbusitripTO;
import com.kic.groupware.model1.auth.AuthtransportationTO;
import com.kic.groupware.model1.auth.AuthvacationTO;

@Controller 
public class AuthController {

    static final Logger LOGGER = LoggerFactory.getLogger(AuthController.class);
    
    /**
     * 리스트.
     */
    		 
    @RequestMapping(value = "/authpage.do")
   	public ModelAndView authpage( HttpServletRequest request, HttpServletResponse response) {
   		System.out.println( "authpage 컨트롤러 호출" );
   		
   		ModelAndView model = new ModelAndView();
   		model.setViewName( "Auth/authpage" );
   		
   		return model;
   	}
    
    @RequestMapping(value = "/authlist.do")
	public ModelAndView authlist( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "authlist 컨트롤러 호출" );
		
		String eno = request.getParameter("eno");
		
		AuthDAO dao1 = new AuthDAO();
		ArrayList<AuthvacationTO> authVLists1 = dao1.authVList1(eno);
		AuthDAO dao2 = new AuthDAO();
		ArrayList<AuthbusitripTO> authVLists2 = dao2.authVList2(eno);
		AuthDAO dao3 = new AuthDAO();
		ArrayList<AuthtransportationTO> authVLists3 = dao3.authVList3(eno);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "Auth/authlist" );
		modelAndView.addObject("authVLists1", authVLists1);
		modelAndView.addObject("authVLists2", authVLists2);
		modelAndView.addObject("authVLists3", authVLists3);

		return modelAndView;
	}
	
	@RequestMapping(value = "/busitrip.do")
	public ModelAndView busitrip( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "busitrip 컨트롤러 호출" );

		AuthTO to = new AuthTO();
		to.setEno( request.getParameter( "eno" ) );
		
		AuthDAO dao = new AuthDAO();
		to = dao.authEmp( to );

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("Auth/busitrip");
		modelAndView.addObject("to", to);
		return modelAndView;
	}
	@RequestMapping(value = "/busitrip_ok.do")
	public ModelAndView busitrip_ok( HttpServletRequest request, HttpServletResponse response) {
		int count = 0;
		int flag = 2;
		
		AuthbusitripTO to = new AuthbusitripTO();	
		to.setAuthno(request.getParameter("auth"));
		to.setEno(request.getParameter("eno"));
		to.setBno(request.getParameter("bno"));
		to.setBinsertdate(request.getParameter("binsertdate"));
		to.setDeptno(request.getParameter("deptno"));
		to.setEname(request.getParameter("ename"));
		to.setBspot(request.getParameter("bspot"));
		to.setBpurpose(request.getParameter("bpurpose"));
		to.setAuthstate(request.getParameter("authstate"));

		AuthDAO dao = new AuthDAO();
		
		if(request.getParameter("sdate1") != null) count = 1; 
		else if(request.getParameter("sdate2") != null) count = 2;
		else if(request.getParameter("sdate3") != null) count = 3;

		if(count == 1) {
			System.out.println(count);
			to.setBtno(request.getParameter("bno"));
			to.setScheno(request.getParameter("scheno"));
			to.setSdate(request.getParameter("sdate1"));
			to.setSstart(request.getParameter("sstart1"));
			to.setSstarttime(request.getParameter("sstarttime1"));
			to.setSend(request.getParameter("send1"));
			to.setSendtime(request.getParameter("sendtime1"));
			to.setTransport(request.getParameter("transport1"));
			to.setBtinn(request.getParameter("btinn1"));

			flag = dao.busitripin(to, 1);
		}
		else if(count == 2) {
			to.setBtno(request.getParameter("bno"));
			to.setScheno(request.getParameter("scheno"));
			to.setSdate(request.getParameter("sdate1"));
			to.setSstart(request.getParameter("sstart1"));
			to.setSstarttime(request.getParameter("sstarttime1"));
			to.setSend(request.getParameter("send1"));
			to.setSendtime(request.getParameter("sendtime1"));
			to.setTransport(request.getParameter("transport1"));
			to.setBtinn(request.getParameter("btinn1"));

			dao.busitripin(to, 1);
			
			to.setBtno(request.getParameter("bno"));
			to.setScheno(request.getParameter("scheno"));
			to.setSdate(request.getParameter("sdate2"));
			to.setSstart(request.getParameter("sstart2"));
			to.setSstarttime(request.getParameter("sstarttime2"));
			to.setSend(request.getParameter("send2"));
			to.setSendtime(request.getParameter("sendtime2"));
			to.setTransport(request.getParameter("transport2"));
			to.setBtinn(request.getParameter("btinn2"));
			
			flag = dao.busitripin(to, 2);
		}
		else if(count == 3) {
			to.setBtno(request.getParameter("bno"));
			to.setScheno(request.getParameter("scheno"));
			to.setSdate(request.getParameter("sdate1"));
			to.setSstart(request.getParameter("sstart1"));
			to.setSstarttime(request.getParameter("sstarttime1"));
			to.setSend(request.getParameter("send1"));
			to.setSendtime(request.getParameter("sendtime1"));
			to.setTransport(request.getParameter("transport1"));
			to.setBtinn(request.getParameter("btinn1"));

			dao.busitripin(to, 1);
			
			to.setBtno(request.getParameter("bno"));
			to.setScheno(request.getParameter("scheno"));
			to.setSdate(request.getParameter("sdate2"));
			to.setSstart(request.getParameter("sstart2"));
			to.setSstarttime(request.getParameter("sstarttime2"));
			to.setSend(request.getParameter("send2"));
			to.setSendtime(request.getParameter("sendtime2"));
			to.setTransport(request.getParameter("transport2"));
			to.setBtinn(request.getParameter("btinn2"));
			
			dao.busitripin(to, 2);
			
			to.setBtno(request.getParameter("bno"));
			to.setScheno(request.getParameter("scheno"));
			to.setSdate(request.getParameter("sdate3"));
			to.setSstart(request.getParameter("sstart3"));
			to.setSstarttime(request.getParameter("sstarttime3"));
			to.setSend(request.getParameter("send3"));
			to.setSendtime(request.getParameter("sendtime3"));
			to.setTransport(request.getParameter("transport3"));
			to.setBtinn(request.getParameter("btinn3"));
			
			flag = dao.busitripin(to, 3);
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "Auth/busitrip_ok" );
		modelAndView.addObject( "flag", flag );
		
		return modelAndView;
	}
	@RequestMapping(value = "/vacation.do")
	public ModelAndView vacation( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "vacation 컨트롤러 호출" );

		AuthTO to = new AuthTO();
		to.setEno( request.getParameter( "eno" ) );
		AuthDAO dao1 = new AuthDAO();
		to = dao1.authEmp( to );
		
		AuthvacationTO to1 = new AuthvacationTO();
		to1.setVno( request.getParameter( "vno" ) );
		AuthDAO dao2 = new AuthDAO();
		to1 = dao2.vacationview( to1 );

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("Auth/vacation");
		modelAndView.addObject("to", to);
		modelAndView.addObject("to1", to1);
		return modelAndView;
	}
	@RequestMapping(value = "/vacationview.do")
	public ModelAndView vacationview( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "vacationview 컨트롤러 호출" );

		AuthTO to = new AuthTO();
		to.setEno( request.getParameter( "eno" ) );
		AuthDAO dao1 = new AuthDAO();
		to = dao1.authEmp( to );
		System.out.println(request.getParameter( "eno" ));
		AuthvacationTO to1 = new AuthvacationTO();
		to1.setVno( request.getParameter( "vno" ) );
		AuthDAO dao2 = new AuthDAO();
		to1 = dao2.vacationview( to1 );

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("Auth/vacationview");
		modelAndView.addObject("to", to);
		modelAndView.addObject("to1", to1);
		return modelAndView;
	}
	
	@RequestMapping(value = "/vacation_ok.do")
	public ModelAndView vacation_ok( HttpServletRequest request, HttpServletResponse response) {
		
		AuthDAO dao = new AuthDAO();
		
		AuthvacationTO to = new AuthvacationTO();	
		to.setVno(request.getParameter("vno"));
		to.setEno(request.getParameter( "eno" ));
		to.setAuthno(request.getParameter("authno"));
		to.setEname(request.getParameter( "ename" ));
		to.setDeptno(request.getParameter( "deptno" ));
		to.setVdate(request.getParameter("vdate"));
		to.setJob(request.getParameter( "job" ));
		to.setVtype(request.getParameter("vtype"));
		to.setVstart(request.getParameter("vstart"));
		to.setVend(request.getParameter("vend"));
		to.setVreason(request.getParameter("vreason"));
		to.setAuthstate(request.getParameter("authstate"));

		int flag = dao.vacationin(to);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "Auth/vacation_ok" );
		modelAndView.addObject( "flag", flag );
		
		return modelAndView;
	}
	
	@RequestMapping(value = "/transportation.do")
	public ModelAndView transportation( HttpServletRequest request, HttpServletResponse response) {
		System.out.println( "transportation 컨트롤러 호출" );
		
		AuthTO to = new AuthTO();
		to.setEno( request.getParameter( "eno" ) );
		
		AuthDAO dao = new AuthDAO();
		to = dao.authEmp( to );

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("Auth/transportation");
		modelAndView.addObject("to", to);
		return modelAndView;
	}
	
	@RequestMapping(value = "/transportation_ok.do")
	public ModelAndView transportation_ok( HttpServletRequest request, HttpServletResponse response) {
		int count = 0;
		int flag = 2;
		AuthtransportationTO to = new AuthtransportationTO();	
		to.setAtno(request.getParameter("atno"));
		to.setEno(request.getParameter("eno"));
		to.setAuthno(request.getParameter("authno"));
		to.setAtdate(request.getParameter("atdate"));
		to.setDeptno(request.getParameter("deptno"));
		to.setJob(request.getParameter("job"));
		to.setEname(request.getParameter("ename"));
		to.setAuthstate(request.getParameter("authstate"));

		AuthDAO dao = new AuthDAO();
		
		if(request.getParameter("atcdate1") != null) count = 1; 
		else if(request.getParameter("atcdate2") != null) count = 2;
		else if(request.getParameter("atcdate3") != null) count = 3;
	
		if(count == 1) {
			to.setAtcno(request.getParameter("atcno1"));
			to.setAtno(request.getParameter("atno1"));
			to.setAtcdate(request.getParameter("atcdate1"));
			to.setAtstart(request.getParameter("atstart1"));
			to.setAtend(request.getParameter("atend1"));
			to.setAtreason(request.getParameter("atreason1"));
			to.setAtcharge(request.getParameter("atcharge1"));

			flag = dao.transportationin(to, 1);
		}
		else if(count == 2) {
			to.setAtcno(request.getParameter("atcno1"));
			to.setAtno(request.getParameter("atno1"));
			to.setAtcdate(request.getParameter("atcdate1"));
			to.setAtstart(request.getParameter("atstart1"));
			to.setAtend(request.getParameter("atend1"));
			to.setAtreason(request.getParameter("atreason1"));
			to.setAtcharge(request.getParameter("atcharge1"));
			
			dao.transportationin(to, 1);
			
			to.setAtcno(request.getParameter("atcno2"));
			to.setAtno(request.getParameter("atno2"));
			to.setAtcdate(request.getParameter("atcdate2"));
			to.setAtstart(request.getParameter("atstart2"));
			to.setAtend(request.getParameter("atend2"));
			to.setAtreason(request.getParameter("atreason2"));
			to.setAtcharge(request.getParameter("atcharge2"));

			flag = dao.transportationin(to, 2);
		}
		else if(count == 3) {
			to.setAtcno(request.getParameter("atcno1"));
			to.setAtno(request.getParameter("atno1"));
			to.setAtcdate(request.getParameter("atcdate1"));
			to.setAtstart(request.getParameter("atstart1"));
			to.setAtend(request.getParameter("atend1"));
			to.setAtreason(request.getParameter("atreason1"));
			to.setAtcharge(request.getParameter("atcharge1"));
			
			dao.transportationin(to, 1);
			
			to.setAtcno(request.getParameter("atcno2"));
			to.setAtno(request.getParameter("atno2"));
			to.setAtcdate(request.getParameter("atcdate2"));
			to.setAtstart(request.getParameter("atstart2"));
			to.setAtend(request.getParameter("atend2"));
			to.setAtreason(request.getParameter("atreason2"));
			to.setAtcharge(request.getParameter("atcharge2"));

			dao.transportationin(to, 2);
			
			to.setAtcno(request.getParameter("atcno3"));
			to.setAtno(request.getParameter("atno3"));
			to.setAtcdate(request.getParameter("atcdate3"));
			to.setAtstart(request.getParameter("atstart3"));
			to.setAtend(request.getParameter("atend3"));
			to.setAtreason(request.getParameter("atreason3"));
			to.setAtcharge(request.getParameter("atcharge3"));

			flag = dao.transportationin(to, 3);
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "Auth/transportation_ok" );
		modelAndView.addObject( "flag", flag );
		
		return modelAndView;
	}
}
