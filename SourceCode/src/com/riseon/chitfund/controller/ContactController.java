package com.riseon.chitfund.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.riseon.chitfund.dao.ContactDao;
import com.riseon.chitfund.dto.ContactBeans;


public class ContactController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			String name=request.getParameter("name");   //get the values from browser.
			String email=request.getParameter("email");
			String mobile=request.getParameter("mobile");
			String city=request.getParameter("city");
			String message=request.getParameter("message");

			ContactBeans contBean=new ContactBeans();   //set the values to bean.
			contBean.setName(name);
			contBean.setEmail(email);
			contBean.setMobile(Long.parseLong(mobile));    //parse
			contBean.setMessage(message);
			contBean.setCity(city);

			ContactDao dao=new ContactDao();   //pass the bean object to DAO.
			int status=dao.contactVal(contBean);

			if(status==1)   //if message stored successfully.
			{
				request.setAttribute("status", "saved");
			}
			else if(status==5)   //if any exception occurs in DAO.  
			{
				RequestDispatcher view = request.getRequestDispatcher("error.jsp");
				view.forward(request, response);
				return;
			}
			else //if message not stored.
			{
				request.setAttribute("status", "notSaved");
			}
			
			RequestDispatcher view = request.getRequestDispatcher("enquiry.jsp");   //pass response to browser.
			view.forward(request, response);
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			RequestDispatcher view = request.getRequestDispatcher("error.jsp");   //if any exception.
			view.forward(request, response);
		}
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doPost(request, response);
	}

}
