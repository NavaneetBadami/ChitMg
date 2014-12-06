package com.riseon.chitfund.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.riseon.chitfund.dao.AddSchemeDao;
import com.riseon.chitfund.dto.AddSchemeBean;

public class AddSchemeController extends HttpServlet 
{
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		String  adminId=null;
		try
		{
			HttpSession ses= req.getSession(false);  //create session.
			adminId=(String)ses.getAttribute("adminId");
			
			int schemeType=Integer.parseInt(req.getParameter("txtSchType").trim());   //get values from browser.
			double schPrice=Double.parseDouble(req.getParameter("txtSchPrice").trim());
			double schValidity=Double.parseDouble(req.getParameter("txtSchValidity").trim()); 
						
			AddSchemeBean scbean=new AddSchemeBean();
			
			scbean.setAdminId(adminId);    //set the values to beans.
			scbean.setSchemeType(schemeType);
			scbean.setSchemePrice(schPrice);
			scbean.setSchemeValidity(schValidity);
			
			AddSchemeDao scdao=new AddSchemeDao();   //pass bean obj to DAO.
			int result=scdao.storeScheme(scbean);

			if(result==1)			//if new added successfully.
			{
				req.setAttribute("status", "schemeAdded");
				RequestDispatcher rd=req.getRequestDispatcher("ViewScheme.jsp");
				rd.forward(req, resp);
			}
			else if(result==5)		//exception occur in DAO.
			{
				RequestDispatcher rd=req.getRequestDispatcher("error.jsp");   //if exception occurs in DAO.
				rd.forward(req, resp);
			}
			else					//if new not added successfully.
			{
				req.setAttribute("status", "schemeNotAdded");
				RequestDispatcher rd=req.getRequestDispatcher("AddScheme.jsp");
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
