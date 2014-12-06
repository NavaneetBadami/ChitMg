package com.riseon.chitfund.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;


import com.riseon.chitfund.dao.AddAgentDao;
import com.riseon.chitfund.dto.AddAgentBean;
import com.riseon.chitfund.dto.EmailBeans;
@MultipartConfig(maxFileSize = 20177215)    // upload file's size up to 20MB

public class AddAgentController extends HttpServlet
{
	private String host;
	private String port;
	private String adminUser;
	private String adminPass;
	
	EmailBeans emailBeans=null;
	
	public void init() 
	{
		// reads SMTP server setting from web.xml file
		ServletContext context = getServletContext();
		host=context.getInitParameter("host");;
		port= context.getInitParameter("port");
		adminUser = context.getInitParameter("user");
		adminPass = context.getInitParameter("pass");
		
		emailBeans = new EmailBeans();  //set SMTP values to beans.
		emailBeans.setHost(host);
		emailBeans.setPort(port);
		emailBeans.setAdminUser(adminUser);
		emailBeans.setAdminPass(adminPass);
		
	}
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		String  adminID=null;
		
		try
		{
			HttpSession ses= req.getSession(false);
			adminID=(String)ses.getAttribute("adminId"); 	 //get the session object.
			System.out.println("session working "+ adminID );
			
			/* get the Agent Basic details.*/
			
			String agFirstName=req.getParameter("txtAgtFirstName").toUpperCase().trim();
			String agLastName=req.getParameter("txtAgtLastName").toUpperCase().trim();
			String agDob=req.getParameter("AgtDOB").toUpperCase().trim();
			String agEmail=req.getParameter("mailAgtEmail").toUpperCase().trim();
			String agMobNo=req.getParameter("txtAgtContactno").trim();
			long agMobileNo=Long.parseLong(agMobNo);
			String agAddress=req.getParameter("txtAgtAddress").toUpperCase().trim();
			String agState=req.getParameter("txtAgtState").toUpperCase().trim();
			String agCity=req.getParameter("txtAgtCity").toUpperCase().trim();
			String agGender=req.getParameter("AgtGender");
			String agPin=req.getParameter("AgtPINCode").trim();
			int agPinCode=Integer.parseInt(agPin);
			String agPanNo=req.getParameter("txtAgtPanNo").toUpperCase().trim();
			int agScheme=Integer.parseInt(req.getParameter("selectedSch").trim());
			String agPaymode=req.getParameter("AgtPayMode").toUpperCase().trim();
			
			
				/* get the Agent images. INPUT STREAM*/
			
			 InputStream ISagImage = null; 			
			 Part filePart1 = req.getPart("AgtImage");
			 ISagImage = filePart1.getInputStream();
			 
			 InputStream ISagIDimage = null; 		
			 Part filePart2 = req.getPart("AgtIdImage");
			 ISagIDimage = filePart2.getInputStream();
			
			 InputStream ISagPanImage = null; 		
			 Part filePart3 = req.getPart("AgtPanImage");
			 ISagPanImage = filePart3.getInputStream();
			 
			 	/* get the Agent nominee details.*/
			 
			String nomFirstName=req.getParameter("txtAgtNomineeName").toUpperCase().trim();
			String nomRelationship=req.getParameter("txtAgtRelationship").toUpperCase().trim();
			String nomState=req.getParameter("txtAgtNomState").toUpperCase().trim();
			String nomEmail=req.getParameter("txtAgtNomEmail").toUpperCase().trim();
			String nomMobNo=req.getParameter("txtAgtNomContactno").trim();
			long nomMobileNo=Long.parseLong(nomMobNo);
			String nomAddress=req.getParameter("txtAgtNomAdderss").toUpperCase().trim();
			String AgtNomPinCode=req.getParameter("txtAgtNomPinCode").toUpperCase().trim();
			int nomPinCode=Integer.parseInt(AgtNomPinCode);  
			String nomCity=req.getParameter("AgtNomCity").toUpperCase().trim();
			
			
				/* Assign Agent basic values to beans.*/
			
			AddAgentBean addAgentbeans=new AddAgentBean();   //Create A Bean Object.
			
			addAgentbeans.setAgFirstName(agFirstName);
			addAgentbeans.setAgLastName(agLastName);
			addAgentbeans.setAgDob(agDob);
			addAgentbeans.setAgEmail(agEmail);
			addAgentbeans.setAgMobileNo(agMobileNo);
			addAgentbeans.setAgAddress(agAddress);
			addAgentbeans.setAgState(agState);
			addAgentbeans.setAgCity(agCity);
			addAgentbeans.setAgGender(agGender);
			addAgentbeans.setAgPinCode(agPinCode);
			addAgentbeans.setAgPanNO(agPanNo);
			addAgentbeans.setAgGender(agGender);
			addAgentbeans.setAgSchType(agScheme);
			addAgentbeans.setAgPaymode(agPaymode);
			addAgentbeans.setAgImage(ISagImage);
			addAgentbeans.setAgIDimage(ISagIDimage);
			addAgentbeans.setAgPanImage(ISagPanImage);
	
				/* Assign Nominee basic values to beans.*/
			
			addAgentbeans.setNomFirstName(nomFirstName); 
			addAgentbeans.setNomRelationship(nomRelationship);
			addAgentbeans.setNomEmail(nomEmail);
			addAgentbeans.setNomAddress(nomAddress);
			addAgentbeans.setNomState(nomState);
			addAgentbeans.setNomMobileNo(nomMobileNo);
			addAgentbeans.setNomPinCode(nomPinCode);
			addAgentbeans.setNomCity(nomCity);
			
			AddAgentDao AddAgentDao= new AddAgentDao();
			int status=AddAgentDao.agentReg(addAgentbeans,emailBeans);  //Pass the Bean object to DAO and get integer as Return type.
			
			if(status==1)		//if values Successfully.
			{
				req.setAttribute("Agtadded", "mailSent");

			}
			else if(status==3)	//if values Successfully but email not sent.
			{
				req.setAttribute("Agtadded", "mailNotSent");
			}
			else if(status==5)
			{
				RequestDispatcher rd=req.getRequestDispatcher("error.jsp");   //if exception occurs in DAO.
				rd.forward(req, resp);
				return;
			}
			else
			{
				req.setAttribute("status", "fail");		//if any values messing.
				RequestDispatcher rd= req.getRequestDispatcher("AddAgent.jsp");
				rd.forward(req,resp);
				return;
			}
			
			RequestDispatcher rd=req.getRequestDispatcher("ViewAgents.jsp");   //response to Browser.
			rd.forward(req, resp);
			
		}
		catch(Exception e)
		{
			if(adminID==null)
			{
				resp.sendRedirect("main-index.jsp");  //if session time out.
				return;
			}
			System.out.println("exception  "+e.getMessage());
			RequestDispatcher rd=req.getRequestDispatcher("error.jsp");   //if exception rises.
			rd.forward(req, resp);
		}
 	}
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		doPost(req, resp);
	}
}
