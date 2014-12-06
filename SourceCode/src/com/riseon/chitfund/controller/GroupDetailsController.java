package com.riseon.chitfund.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.riseon.chitfund.dao.GroupDetailsDao;
import com.riseon.chitfund.dto.AddMemberBeans;

public class GroupDetailsController extends HttpServlet
{
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException
	{
		String agentId=null;
		try
		{
			HttpSession ses= req.getSession(false);
			agentId=(String)ses.getAttribute("agentId");
			
			String groupId=req.getParameter("groupId");	//get groupId from ViewGroups.jsp or UpdateGroupCpntroller.
			
			AddMemberBeans grpMemBeans=new AddMemberBeans(); //using AddMember Beans.
			grpMemBeans.setGroupId(groupId);
	
			GroupDetailsDao dao= new GroupDetailsDao();
			ArrayList<AddMemberBeans> grpDetailsList=dao.groupDetails(grpMemBeans);
			if(grpDetailsList.size()!=0)
			{
				req.setAttribute("grpDetailsList", grpDetailsList);
				RequestDispatcher rd=req.getRequestDispatcher("ViewGroupMembers.jsp");
				rd.forward(req, resp);				
			}
			else
			{
				RequestDispatcher rd=req.getRequestDispatcher("error.jsp");   //if exception rises.
				rd.forward(req, resp);
			}
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
		doPost(req, resp);
	}
}
