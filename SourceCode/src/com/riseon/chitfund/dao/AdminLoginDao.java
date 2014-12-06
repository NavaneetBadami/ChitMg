package com.riseon.chitfund.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;

import com.riseon.chitfund.dto.AdminBean;
import com.riseon.chitfund.services.ConnectionProvider;

public class AdminLoginDao 
{
	public static String adminFirstname=null;
	
	public int adminLoginValidate(AdminBean bean)
	{
		Connection con=ConnectionProvider.getObj().getCon();  //make connection using services.
		String query="select * from admin_details where AdmId=? and AdmPassword=?";
		int status=0;
		String admId=null;
		String password=null;
		try 
		{
			PreparedStatement pstm=con.prepareStatement(query);
			
			String adminId=bean.getAdmId();         //get the values from bean.
			String adminPassword=bean.getAdmPassword();
			
			pstm.setString(1, adminId);
			pstm.setString(2, adminPassword);
			
			ResultSet rs=pstm.executeQuery();       //execute query.
			
			if(rs.next())	 	
			{
				admId=rs.getString("AdmId");
				password=rs.getString("AdmPassword");
																	//if both values are matched.		
				if(admId!=null && admId.equals(adminId) && password!=null && password.equals(adminPassword))
				{
					status=1;      
					adminFirstname= rs.getString("AdmFirstName");	//get adminName.
					
				}
				else
				{
					status=2;     //if both values are not matched.
				}
			}
			else
			{
				status=2;     //if values not valid Admin.
			}
			
		}
		catch (SQLException e)
		{
			status=5;			//if any exception.
			System.out.println(e.getMessage());
		}
		 return status;     //return the status.
	}	
}
