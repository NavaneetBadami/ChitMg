package com.riseon.chitfund.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.riseon.chitfund.dao.MemberLoginDao;
import com.riseon.chitfund.dto.AddMemberBeans;;

public class MemberLoginController extends HttpServlet
{
public static HashMap<String, String> memberFname = new HashMap<String, String>();
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException
	{
		try
		{
			String memberId=req.getParameter("memberId").toUpperCase().trim(); 	 //get the values from browser.
			

			AddMemberBeans bean=new AddMemberBeans();  	 //set the values to bean.
			bean.setMemId(memberId);
			
			MemberLoginDao dao=new MemberLoginDao();   	//pass that bean object to DAO.
		    int status=dao.memberLoginValidate(bean);
		  
	       if(status==1)         			//if valid Member.
	       {
	    	   HttpSession ses=req.getSession(true);  	//create SESSION object.
	    	   ses.setAttribute("memberId",memberId);
	    	   
	    	   memberFname.put(memberId, MemberLoginDao.membfirstname); //member firstName for whole adminPage. map<k,v>
	    	   
	    	   req.setAttribute("valid", "valid");
	    	   RequestDispatcher rd=req.getRequestDispatcher("member_home.jsp");
	    	   rd.forward(req, resp);
	    	   return;
	       }
	       else if(status==2)            //if not valid member.
	       {
	    	   req.setAttribute("status", "invalidMember");
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
