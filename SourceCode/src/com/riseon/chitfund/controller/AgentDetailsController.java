package com.riseon.chitfund.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.ListIterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.riseon.chitfund.dao.AgentDetailsDao;
import com.riseon.chitfund.dto.ViewAgentsBeans;

public class AgentDetailsController extends HttpServlet
{
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		HttpSession sesssion= req.getSession(false);
		
		String agFirstName=req.getParameter("agentName").toUpperCase().trim();  //Get the Values from ad_view_agent.jsp by URL.
		String agId=req.getParameter("agentId").toUpperCase().trim();
		
		ViewAgentsBeans viewAgentsBeans= new ViewAgentsBeans();  // create a bean obj.
		viewAgentsBeans.setAgFirstName(agFirstName);
		viewAgentsBeans.setAgId(agId);
		
		AgentDetailsDao dao= new AgentDetailsDao();
		ArrayList<ViewAgentsBeans>detailsList=dao.agentDetails(viewAgentsBeans); //pass the bean obj to DAO.
		
		req.setAttribute("list", detailsList);  //set the List to Req obj.
		
		RequestDispatcher rd= req.getRequestDispatcher("ViewAgentDetails.jsp"); //Forward all values to View
	    rd.forward(req, resp);	
	
	}
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		doGet(req, resp);
		
	}
}
