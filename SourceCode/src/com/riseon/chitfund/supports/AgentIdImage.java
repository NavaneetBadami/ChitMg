package com.riseon.chitfund.supports;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.riseon.chitfund.dao.AddAgentDao;
import com.riseon.chitfund.services.ConnectionProvider;
@MultipartConfig(maxFileSize = 20177215)    // upload file's size up to 16MB
public class AgentIdImage extends HttpServlet
{
Connection con=ConnectionProvider.getObj().getCon(); //Making Connection from service.ConnectionProvider.

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException
	{
		String an= "";//AddAgentDao.aguser;
        InputStream inputStream = null; // input stream of the upload file
        
        Part filePart = request.getPart("IDphoto");
        System.out.println("path:" + filePart);
        if (filePart != null) 
        {
            inputStream = filePart.getInputStream();
        }
         
        String message = null;  // message will be sent back to client
         
        try {
         
            	String qrylimi="set global max_allowed_packet=104857600";
            	Statement stlim=con.createStatement();
            	stlim.execute(qrylimi);
          
            String sql = "update agent_details set AgtIdProof=? where AgtID=?";
            PreparedStatement statement = con.prepareStatement(sql);
            if (inputStream != null) 
            {
                statement.setBlob(1, inputStream);
            }
            statement.setString(2,an);
            int row = statement.executeUpdate();
            if (row > 0) 
            {
                message = "File uploaded and saved into database";
            }
        } 
        catch (SQLException ex) 
        {
            message = "ERROR: " + ex.getMessage();
            ex.printStackTrace();
        }
            request.setAttribute("Message", message);
            getServletContext().getRequestDispatcher("/admin_home2.jsp").forward(request, response);
        }
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		doPost(req, resp);
	}
}
