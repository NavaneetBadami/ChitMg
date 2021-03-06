package com.riseon.chitfund.controller;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.riseon.chitfund.dao.AddMemberDao;
import com.riseon.chitfund.dao.UpdateGroupDao;
import com.riseon.chitfund.dto.AddMemberBeans;

@MultipartConfig(maxFileSize = 20177215)    // upload file's size up to 20MB
public class UpdateGroupController extends HttpServlet
{
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		String agentId=null;
		try
		{
			HttpSession ses= req.getSession(false);        //session object.
			agentId=(String)ses.getAttribute("agentId");

			String groupId=req.getParameter("txtGroupId").trim();	//get the values from browser
			String memFirstName=req.getParameter("txtMemFName").trim().toUpperCase(); 
			String memLastName=req.getParameter("txtMemLName").trim().toUpperCase();
			String memAddress=req.getParameter("txtmemAddress").trim().toUpperCase();
			String memMobNo=req.getParameter("memContactno").trim();
			long memMobileNo=Long.parseLong(memMobNo);
			String memPinCod=req.getParameter("memPincode").trim();
			int memPinCode=Integer.parseInt(memPinCod);
			String memSuretyType=req.getParameter("memSuretytype").trim().toUpperCase();
			String memGender=req.getParameter("memGender").trim().toUpperCase();

			InputStream memImage = null; 			// input stream of the upload agent Image
			Part filePart1 = req.getPart("membphoto");
			memImage = filePart1.getInputStream();

			InputStream memSuretyImage = null; 		// input stream of the upload agent ID image
			Part filePart2 = req.getPart("membsuretyphoto");
			memSuretyImage = filePart2.getInputStream();

			String memNomFName=req.getParameter("txtnomName").trim().toUpperCase();
			String memNomRelationship=req.getParameter("txtnomRelationship").trim().toUpperCase();
			String memNomAddress=req.getParameter("txtnomAddress").trim().toUpperCase();
			String memNomMobNo=req.getParameter("txtnomContactno").trim();
			long memNomMobileNo=Long.parseLong(memNomMobNo);
			String memNomPinCod=req.getParameter("txtnomPincode").trim();
			int memNomPinCode=Integer.parseInt(memNomPinCod);


			AddMemberBeans addMemberBeans=new AddMemberBeans(); 	//Assign the values to bean.
			addMemberBeans.setAgentId(agentId);
			addMemberBeans.setGroupId(groupId);
			addMemberBeans.setMemFirstName(memFirstName);   
			addMemberBeans.setMemLastName(memLastName);
			addMemberBeans.setMemAddress(memAddress);
			addMemberBeans.setMemMobileNo(memMobileNo);
			addMemberBeans.setMemPinCode(memPinCode);
			addMemberBeans.setMemGender(memGender);
			addMemberBeans.setMemSuretyType(memSuretyType);
			addMemberBeans.setMemImage(memImage);
			addMemberBeans.setMemSurety(memSuretyImage);

			addMemberBeans.setMemNomFName(memNomFName);
			addMemberBeans.setMemNomRelationship(memNomRelationship);
			addMemberBeans.setMemNomAddress(memNomAddress);
			addMemberBeans.setMemNomMobileNo(memNomMobileNo);
			addMemberBeans.setMemNomPinCode(memNomPinCode);
			
			UpdateGroupDao dao= new UpdateGroupDao();
			int status=dao.addMember(addMemberBeans); //pass bean object to DAO.

			if(status==1)     //after adding one member
			{
				resp.sendRedirect("grpDetailsUrl?groupId="+groupId);	//redirect to same URL to display current members in group.
				return;
			}
			else if(status==2)  //Available slots becomes empty after adding one member.
			{
				req.setAttribute("groupStatus", "AllFilled");
			}
			else if(status==3)  //if no slot are available before adding mamber.
			{
				req.setAttribute("groupStatus", "noSlots");
			}
			else if(status==5)
			{
				RequestDispatcher rd=req.getRequestDispatcher("error.jsp");   //if exception occurs in DAO.
				rd.forward(req, resp);
				return;
			}
			RequestDispatcher rd=req.getRequestDispatcher("ViewGroups.jsp");  //forward.
			rd.forward(req, resp);
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
