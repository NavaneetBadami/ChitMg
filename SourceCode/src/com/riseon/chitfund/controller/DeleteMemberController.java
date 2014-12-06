package com.riseon.chitfund.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.riseon.chitfund.dao.DeleteMemberDoa;
import com.riseon.chitfund.dto.AddMemberBeans;

public class DeleteMemberController extends HttpServlet
{
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		String agentId=null;
		try
		{
			HttpSession ses= req.getSession(false);        //session object.
			agentId=(String)ses.getAttribute("agentId");
			
			String memberId=req.getParameter("memberId").trim();	//get the memberId from browser.
			
			AddMemberBeans memBean= new AddMemberBeans();	//dto
			memBean.setAgentId(agentId);
			memBean.setMemId(memberId);
			
			DeleteMemberDoa dao= new DeleteMemberDoa();	//pass dto object to dao.
			int status=dao.deleteMember(memBean);
			
			if (status==1)		//if member deleted successfully.
			{
				req.setAttribute("deleteStatus", "memDeleted");
			}
			else if(status==2)	//if member not found.
			{
				req.setAttribute("deleteStatus", "memNotFound");
			}
			else if(status==3)	//cannot delete a member.
			{
				req.setAttribute("deleteStatus", "cannotDelete");
			}
			else if(status==5)
			{
				RequestDispatcher rd=req.getRequestDispatcher("error.jsp");   //if exception occurs in DAO.
				rd.forward(req, resp);
				return;
			}
			else 
			{
				req.setAttribute("deleteStatus", "memNotDeleted");
			}
				
			RequestDispatcher rd= req.getRequestDispatcher("ViewGroups.jsp");	//pass to view.
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
		doPost(req, resp);
	}
}
