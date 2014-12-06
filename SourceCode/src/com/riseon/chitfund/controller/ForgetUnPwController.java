package com.riseon.chitfund.controller;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.riseon.chitfund.dao.AddAgentDao;
import com.riseon.chitfund.dao.ForgetUnPwDao;
import com.riseon.chitfund.dto.AddAgentBean;
import com.riseon.chitfund.dto.EmailBeans;

public class ForgetUnPwController extends HttpServlet
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
		try
		{
			String agentEmail=req.getParameter("reEmail").toUpperCase().trim();	//get the agent Email.
			
			ForgetUnPwDao dao= new ForgetUnPwDao();
			int status=dao.resendUserNamePassword(agentEmail, emailBeans);	//pass to DAO.
			if(status==0)
			{
				req.setAttribute("status", "emailNotFound");	//if not valid email.
			}
			else if(status==1)
			{
				req.setAttribute("status", "sentSuccess");		//if email sent successfully.
			}
			else if(status==5)
			{
				req.setAttribute("status", "notSent");			//valid email but email not sent due to some technical problems.
			}
			else
			{
				resp.sendRedirect("error.jsp");			//any exception occurs in DAO.
				return;
			}
			RequestDispatcher rd= req.getRequestDispatcher("main-index.jsp");	//pass the response to VIEW.
			rd.forward(req, resp);			
		}
		catch(Exception e)
		{
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
