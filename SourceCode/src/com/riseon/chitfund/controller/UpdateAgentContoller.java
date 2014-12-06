package com.riseon.chitfund.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.riseon.chitfund.dao.UpdateAgentDao;
import com.riseon.chitfund.dto.AddAgentBean;

import com.riseon.chitfund.dto.UpdateAgentBeans;

public class UpdateAgentContoller extends HttpServlet
{
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{	 
		String agentId=null;
		try
		{
			HttpSession ses= req.getSession(false);
			agentId=(String)ses.getAttribute("agentId");	//session object.

			String newAgtPassword=req.getParameter("newPwd").trim();	//get the values from browser.
			String currPassword=req.getParameter("currPwd").trim();
			String newAgtEmail=req.getParameter("newEmail").toUpperCase().trim();

			UpdateAgentBeans changebean= new UpdateAgentBeans();	//set to beans.
			changebean.setAgentId(agentId);
			changebean.setAgentPassword(currPassword);
			changebean.setNewAgtPassword(newAgtPassword);
			changebean.setNewAgtEmail(newAgtEmail);
			
			UpdateAgentDao  upAgtDoa= new UpdateAgentDao();   	//pass to DAO.
			int status=upAgtDoa.updateAgtValues(changebean);   
			
			System.out.println("status.."+ status);
			if(status==0)
			{
				req.setAttribute("status", "fail");  // not updated.
			}
			else if(status==1)
			{
				req.setAttribute("status", "updated");   // if updated.
			}
			else if(status==3)
			{
				req.setAttribute("status", "wrongPassword"); //current and new password are not same.
			}
			else
			{
				RequestDispatcher rd=req.getRequestDispatcher("error.jsp");   //if exception rises in DAO.
				rd.forward(req, resp);
				return;
			}
			RequestDispatcher rd= req.getRequestDispatcher("agent_home.jsp");	
			rd.forward(req, resp);
			return;

		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			if(agentId==null)
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
		doPost(req, resp); //vise versa.
	}
}
