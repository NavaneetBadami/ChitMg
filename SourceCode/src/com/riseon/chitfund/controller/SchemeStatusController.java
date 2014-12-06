package com.riseon.chitfund.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.riseon.chitfund.dao.SchemeStatusDao;
import com.riseon.chitfund.dto.AddSchemeBean;

public class SchemeStatusController extends HttpServlet
{
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		String  adminId=null;
		try
		{
			HttpSession ses= req.getSession(false);  //create session.
			adminId=(String)ses.getAttribute("adminId");
			
			String schemeId=req.getParameter("schemeId");	//get the schemeId from browser.
			String schemeStatus=req.getParameter("status");
			
			AddSchemeBean scbean=new AddSchemeBean();
			scbean.setAdminId(adminId);
			scbean.setSchemeId(schemeId);
			scbean.setSchemeStatus(schemeStatus);	//using get method from viewSchemes.jsp or schemeshistory.jsp
			
			SchemeStatusDao scStdao=new SchemeStatusDao();   //pass bean object to DAO.
			int result=scStdao.changeSchemeStatus(scbean);

			if(result==1)			//if scheme hidden successfully.
			{
				resp.sendRedirect("ViewScheme.jsp");
				return;
			}
			else					//if new not hidden successfully.
			{
				req.setAttribute("status", "notHidden");
				RequestDispatcher rd=req.getRequestDispatcher("ViewScheme.jsp");
				rd.forward(req, resp);
			}
			
		}
		catch (Exception e) 
		{
			if(adminId==null)
			{
				resp.sendRedirect("main-index.jsp");  //if session time out.
				return;
			}
			System.out.println(e.getMessage());
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
