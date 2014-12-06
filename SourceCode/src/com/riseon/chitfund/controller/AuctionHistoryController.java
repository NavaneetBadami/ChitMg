package com.riseon.chitfund.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.riseon.chitfund.dao.AuctionHistoryDao;
import com.riseon.chitfund.dto.AuctionHistoryBeans;

public class AuctionHistoryController extends HttpServlet 
{
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException
	{
		String agentId=null;
		try
		{
			HttpSession ses= req.getSession(false);			//Session object.
			agentId=(String)ses.getAttribute("agentId");		//GroupID from browser.
			String groupId=req.getParameter("groupId");			

			AuctionHistoryBeans grpBeans=new AuctionHistoryBeans(); 	//set the values to beans.
			grpBeans.setMemAgtId(agentId);
			grpBeans.setMemGrpId(groupId);
			
			AuctionHistoryDao dao= new AuctionHistoryDao();
			ArrayList<AuctionHistoryBeans> auctionHistoryDetails=dao.getHistory(grpBeans);	//pass bean object to DAO.

			if(auctionHistoryDetails.size()!=0)	//if list has at least one element in it. I.e Auction history is available.
			{
				System.out.println("list Status.."+auctionHistoryDetails.size());
				req.setAttribute("historyDetailsList", auctionHistoryDetails);
			}
			else if(auctionHistoryDetails.size()==0)	//if not,
			{
				System.out.println("list Status.."+auctionHistoryDetails.size());
				req.setAttribute("historyStatus", "noAuctionYet");
			}
			RequestDispatcher rd=req.getRequestDispatcher("AuctionHistory.jsp");   
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
			return;
		}
	}
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		doPost(req, resp);
	}

}
