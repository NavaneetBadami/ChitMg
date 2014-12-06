package com.riseon.chitfund.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.riseon.chitfund.dto.UpdateAgentBeans;
import com.riseon.chitfund.services.ConnectionProvider;

public class UpdateAgentDao 
{
	private static Connection con=ConnectionProvider.getObj().getCon();  // Make a connection using Services.
	private static PreparedStatement pstm=null;
	
	public int updateAgtValues(UpdateAgentBeans changebean)
	{
		int status=0;
		try 
		{	
			String agentId=changebean.getAgentId(); 	//get the values.
			String oldPassword=changebean.getAgentPassword();
			String newAgtPassword=changebean.getNewAgtPassword();
			String newAgtEmail=changebean.getNewAgtEmail();
			
			String query2="select AgtID,AgtPassword from agent_details where AgtID=?";
			pstm=con.prepareStatement(query2);
			pstm.setString(1, agentId);
			ResultSet res= pstm.executeQuery();
			
			if(res.next())
			{
				String currentPassword=res.getString("AgtPassword");
				if(oldPassword.equals(currentPassword))		//both must be same.
				{
					status=changeValues(agentId, newAgtPassword, newAgtEmail);	//update method.
				}
				else
				{
					status=3;	//both are not matching.
				}
			}
		}
		catch(Exception e)
		{
			status=5;
			System.out.println(e.getMessage());
		}
		return status;
	}
	
	private static int changeValues(String agentId,String newAgtPassword,String newAgtEmail)throws Exception
	{
		int status=0;
		String query="update agent_details set AgtPassword=? , AgtEmail= ? where AgtID=?"; 
		pstm=con.prepareStatement(query);
		
		pstm.setString(1, newAgtPassword);
		pstm.setString(2, newAgtEmail);
		pstm.setString(3, agentId);
		
		status= pstm.executeUpdate();   //execute the query.
		System.out.println("NO OF ROW UPDATED " + status);
		if(status>0)
		{
			status=1;	//if values are updated.
		}
		else
		{
			status=0;	//if not
		}
		return status;
	}
}
