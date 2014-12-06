package com.riseon.chitfund.controller;

import java.io.IOException;
import java.text.BreakIterator;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.riseon.chitfund.dao.AuctionProcessDao;
import com.riseon.chitfund.dto.AuctionProcessBeans;
import com.riseon.chitfund.dto.CreateChitGroupBean;

public class AuctionProcessController extends HttpServlet
{
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		String agentId=null;
		try
		{
			HttpSession ses= req.getSession(false);        //session object.
			agentId=(String)ses.getAttribute("agentId");

			String memGrpId=req.getParameter("groupId").trim();		//get the values from browser.
			String memAgtId=agentId;
			String memId=req.getParameter("memberId").trim();
			double memBidPer=Double.parseDouble(req.getParameter("bidPer").trim());

			AuctionProcessBeans aucBean= new AuctionProcessBeans();	// set the values to beans.
			aucBean.setMemGrpId(memGrpId);
			aucBean.setMemAgtId(memAgtId);
			aucBean.setMemId(memId);
			aucBean.setMemBidPer(memBidPer);

			AuctionProcessDao dao=new AuctionProcessDao();		//pass bean object to DAO.
			int auctionStatus=dao.auctionOperation(aucBean);

			if(auctionStatus==1)		//if member has all ready taken his amount.
			{
				System.out.println("member All ready Bidden.."+ auctionStatus);
				req.setAttribute("auctionStatus", "Bidden");
			}
			else if(auctionStatus==2)		//if member or group not found.
			{
				System.out.println("Member Not Found..."+ auctionStatus);
				req.setAttribute("auctionStatus", "NotFound");
			}
			else if(auctionStatus==3)		//if member or group not found.
			{
				System.out.println("Group Not found.."+ auctionStatus);
				req.setAttribute("auctionStatus", "NotFound");
			}
			else if(auctionStatus==4)		//if AUCTION process completed successfully.
			{
				System.out.println("Congrats Auction Done.."+ auctionStatus);
				req.setAttribute("auctionStatus", "Success");
				RequestDispatcher rd=req.getRequestDispatcher("AuctionHistory.jsp");   	
				rd.forward(req, resp);
				return;
			}
			else
			{
				System.out.println("Exception in Whole Auction process..."+ auctionStatus);		//if Exception occurs in DAO.
				RequestDispatcher rd=req.getRequestDispatcher("error.jsp");   	
				rd.forward(req, resp);
				return;
			}
			RequestDispatcher rd=req.getRequestDispatcher("AuctionGroupVal.jsp");		//pass the values to VIEW.
			rd.forward(req, resp);
			return;
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			if(agentId==null)
			{
				resp.sendRedirect("main-index.jsp");  	//if session time out.
				return;
			}
			System.out.println(e.getMessage());
			RequestDispatcher rd=req.getRequestDispatcher("error.jsp");   	//if exception rises.
			rd.forward(req, resp);
		}
	}
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		doPost(req, resp);
	}
}
