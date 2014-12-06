package com.riseon.chitfund.dao;

import java.net.Inet4Address;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.riseon.chitfund.dto.AddSchemeBean;
import com.riseon.chitfund.services.ConnectionProvider;

public class SchemeStatusDao 
{
	public int changeSchemeStatus(AddSchemeBean schemeBean)
	{
		int status=0;
		try 
		{
			Connection con=ConnectionProvider.getObj().getCon(); //Making Connection from service.ConnectionProvider.
			String query="update scheme_type set schemeStatus=? where schmemeid=? AND admid=?";
			PreparedStatement pstm=null;
			pstm=con.prepareStatement(query);
			
			String adminId=schemeBean.getAdminId();
			String schId=schemeBean.getSchemeId();
			String schemeStatus=schemeBean.getSchemeStatus();
			
			if(schemeStatus.equalsIgnoreCase("visible"))	//if its visible set schemeStatus=visible.
			{
				pstm.setString(1,"VISIBLE");				
			}
			else if(schemeStatus.equalsIgnoreCase("hide")) //if its hide set schemeStatus=hide.
			{
				pstm.setString(1,"HIDE");	  
			}
			
			pstm.setString(2, schId);
			pstm.setString(3,adminId);
			
			status=pstm.executeUpdate();  //execute the query.
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			status=5;
		}
		return status;
	}
}
