package com.riseon.chitfund.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.riseon.chitfund.dao.*;
import com.riseon.chitfund.dto.AdminBean;

public class AdminLoginController extends HttpServlet
{
	public static HashMap<String, String> adminFname = new HashMap<String, String>();
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException
	{
		try
		{
			String adminId=req.getParameter("txtAdminID").trim(); 	 //get the values from browser.
			String adminPassword=req.getParameter("txtAdminPwd").trim();  	

			AdminBean bean=new AdminBean();  	 //set the values to bean.
			bean.setAdmId(adminId);
			bean.setAdmPassword(adminPassword);
			
			AdminLoginDao adminLoginDao=new AdminLoginDao();   	//pass that bean object to DAO.
		    int status=adminLoginDao.adminLoginValidate(bean);
		   
	       if(status==1)         			//if valid Admin.
	       {
	    	   HttpSession ses=req.getSession(true);  	//create SESSION object.
	    	   ses.setAttribute("adminId",adminId);
	    	   
	    	   adminFname.put(adminId, AdminLoginDao.adminFirstname); //AdminName for whole adminPage. map<k,v>
	    	   
	    	   req.setAttribute("valid", "valid");
	    	   RequestDispatcher rd=req.getRequestDispatcher("admin_home.jsp");
	    	   rd.forward(req, resp);
	    	   return;
	       }
	       else if(status==2)            //if not valid Admin.
	       {
	    	   req.setAttribute("status", "invalid");
	    	   RequestDispatcher rd=req.getRequestDispatcher("main-index.jsp");
	    	   rd.forward(req, resp);
	    	   return;
	       }
	       else							//if exception In DAO.
	       {
	    	   RequestDispatcher rd=req.getRequestDispatcher("error.jsp");   	
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
