package com.riseon.chitfund.supports;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.riseon.chitfund.dao.AddAgentDao;
@MultipartConfig(maxFileSize = 20177215)    // upload file's size up to 20MB
public class AgentImageUpload  extends HttpServlet
{
//	private final String UPLOAD_DIRECTORY = "C:/apache-tomcat-7.0.27/webapps/CollegeBook/img/upload/Album"; //Path where image is going to store.  
	private final String UPLOAD_DIRECTORY = "D:/"; //Path where image is going to store.  
	
	   @Override
	   public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	   {  
	    HttpSession ses=req.getSession(false);
		String agname="sdsd";
		System.out.println(agname);
		try
		{
			System.out.println("within try..");
		       if(ServletFileUpload.isMultipartContent(req)) //process only if its multiPart content.
		       {
		          try
		          {
		              List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(req); //Get the Image image and parse it to list.
		                																								//These all are builtin Functions();
		              for(FileItem item : multiparts)
		              {
		                  if(!item.isFormField())
		                  {
		      //              String name = new File(item.getName()).getName();    //This is for to Get the default Image Name.	
		                   String imageName=agname+"_AP1"+".jpg";                     //Concat the ".jpg" to store in .jpg Format.and write it i.e load image.
		                   System.out.println("image name "+ imageName);
		                   item.write( new File(UPLOAD_DIRECTORY + File.separator + imageName));                       
		                  }
		              }                         
		          } 
		          catch (Exception ex) 
		          {
		            req.setAttribute("error_AP","sorry image not loaded."); //just a exception when unable to store the image.
		          }                          
		       }       		
		       else  
		       {
		           req.setAttribute("error_AP", "Sorry its not a multipart content."); //if its not a Multipart request.
		       }     
				    RequestDispatcher rd=req.getRequestDispatcher("ad_chit_schemes.jsp"); //Forward all resources to view.
				    rd.forward(req,resp);
		}
		catch(Exception e) // if session expires.
		{
			System.out.println(e.getMessage());
			req.setAttribute("sessionTimeOut", "sessionTimeOut");
			req.getRequestDispatcher("logout.jsp").forward(req, resp);
		}
	   	   
	}
}   
