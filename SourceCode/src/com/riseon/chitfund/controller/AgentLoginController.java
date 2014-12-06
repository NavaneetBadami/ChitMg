package com.riseon.chitfund.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.riseon.chitfund.dao.AgentLoginDao;
import com.riseon.chitfund.dto.AddAgentBean;

public class AgentLoginController extends HttpServlet
{
	public static HashMap<String, String> agentName= new HashMap<String, String>();	//static agentName.
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		try
		{
			String agentId=req.getParameter("txtAgentID").trim();   //get the values from browser.
			String agentPassword=req.getParameter("password").trim();

			AddAgentBean bean=new AddAgentBean();  	 	//assign values to bean.
			bean.setAgId(agentId);
			bean.setAgPassword(agentPassword);

			AgentLoginDao agentLoginDao=new AgentLoginDao();    	//pass bean object to DAO.
			int status=agentLoginDao.agentLoginValidate(bean);

			if(status==1)     //if valid agent.
			{
				HttpSession ses=req.getSession(true);    //create SESSION OBJECT.
				ses.setAttribute("agentId", agentId);
				
				agentName.put(agentId, agentLoginDao.agentName); //agent Name map<k,v>.
				
				req.setAttribute("valid", "valid");
				RequestDispatcher rd=req.getRequestDispatcher("agent_home.jsp");
				rd.forward(req, resp);
				return;
			}
			else if(status==2)     	//if Not a valid agent.
			{
				req.setAttribute("status", "invalid");
				RequestDispatcher rd=req.getRequestDispatcher("main-index.jsp");
				rd.forward(req, resp);
				return;
			}
			else if(status==3)     	//if validity over.
			{
				req.setAttribute("status", "validityOver");
				RequestDispatcher rd=req.getRequestDispatcher("main-index.jsp");
				rd.forward(req, resp);
				return;
			}
			else if(status==5)		//if any exception occurs in DAO.
			{
				RequestDispatcher rd=req.getRequestDispatcher("error.jsp");   	//if exception rises.
				rd.forward(req, resp);
				return;
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			resp.sendRedirect("main-index.jsp");  //if session time out.
			return;
		}
	}

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException
	{
		doPost(req, resp);
	}
}
