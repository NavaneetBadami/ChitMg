package com.riseon.chitfund.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.riseon.chitfund.dao.CreateGroupDao;
import com.riseon.chitfund.dto.CreateChitGroupBean;


public class CreateGroupController extends HttpServlet
{
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		String agentId=null;
		try
		{
			HttpSession ses= req.getSession(false);
			agentId=(String)ses.getAttribute("agentId"); 	 //get the session object.
			
			String groupName=req.getParameter("groupName");   	//get the values from browser.
			String chtamt=req.getParameter("chitAmount");
			double chitAmount=Double.parseDouble(chtamt);
			double chitDuration=Double.parseDouble(req.getParameter("duration"));   //parse.
			double chitPremium=Double.parseDouble(req.getParameter("premium"));
			double agentPer=Double.parseDouble(req.getParameter("agentPer"));
			int members=Integer.parseInt(req.getParameter("members"));
			
			CreateChitGroupBean createGrpBean=new CreateChitGroupBean();  	 //Assign values to bean.
			createGrpBean.setAgentId(agentId);
			createGrpBean.setGroupName(groupName);
			createGrpBean.setChitAmount(chitAmount);
			createGrpBean.setDuration(chitDuration);
			createGrpBean.setPremium(chitPremium);
			createGrpBean.setTotalMembers(members);
			createGrpBean.setAgentPer(agentPer);

			CreateGroupDao cgd=new CreateGroupDao();   	 //pass bean obj to DAO and get result.
			int status=cgd.createGroup(createGrpBean);
		
			if(status==1)   	 //if group created successfully. 
			{
				String groupId=CreateGroupDao.groupId; //static Id.
				ServletContext ctx=getServletContext();
				ctx.setAttribute("groupId",groupId); //visible in whole application.
				
				RequestDispatcher rd=req.getRequestDispatcher("AddMember.jsp");
				rd.forward(req, resp);
			}
			else if(status==3)     	//if not slot are available.
			{
				req.setAttribute("noGroupslot","noGroupslot");
				RequestDispatcher rd=req.getRequestDispatcher("CreateChitGroup.jsp");
				rd.forward(req, resp);
			}
			else if(status==5)   	//if exception occurs in DAO.
			{
				RequestDispatcher rd=req.getRequestDispatcher("error.jsp");   
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
