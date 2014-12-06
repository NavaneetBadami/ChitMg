package com.riseon.chitfund.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.riseon.chitfund.dao.AuctionValDao;
import com.riseon.chitfund.dao.GroupDetailsDao;
import com.riseon.chitfund.dto.AddMemberBeans;
import com.riseon.chitfund.dto.CreateChitGroupBean;

public class AuctionValController extends HttpServlet
{
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException
	{
		String agentId=null;
		try
		{
			HttpSession ses= req.getSession(false);
			agentId=(String)ses.getAttribute("agentId");		//Session object.

			String groupId=req.getParameter("groupId");			//GroupID from browser.

			CreateChitGroupBean grpBeans=new CreateChitGroupBean(); 	//set the values to beans.
			grpBeans.setAgentId(agentId);
			grpBeans.setGroupId(groupId);

			AuctionValDao dao= new AuctionValDao();
			ArrayList<CreateChitGroupBean> groupStatusLst=dao.validateGroup(grpBeans);	//pass bean object to DAO.

			if(groupStatusLst.size()!=0)	//if list has at least one element in it. I.e Auction slots are available.
			{
				req.setAttribute("auctionDetails", groupStatusLst);
				RequestDispatcher rd=req.getRequestDispatcher("AuctionProcess.jsp");   
				rd.forward(req, resp);
				return;

			}
			else if(groupStatusLst.size()==0)	//if not,
			{
				req.setAttribute("auctionValStatus", "noAuction");
				RequestDispatcher rd=req.getRequestDispatcher("AuctionGroupVal.jsp");   
				rd.forward(req, resp);
				return;
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
			return;
		}
	}
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		doPost(req, resp);
	}
}
