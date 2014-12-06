package com.riseon.chitfund.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.riseon.chitfund.dto.AddAgentBean;
import com.riseon.chitfund.services.ConnectionProvider;

public class AgentLoginDao 
{
	Connection con=ConnectionProvider.getObj().getCon();   //Make a connection using Services.
	PreparedStatement psmt=null;
	public static String agentName=null;
	
	public int agentLoginValidate(AddAgentBean bean)
	{
		int status=0;
		String query="select AgtFirstName, AgtID, AgtPassword, AgtValidity from agent_details where AgtID=? and AgtPassword=?";
		try 
		{
			psmt=con.prepareStatement(query);

			String agtId=bean.getAgId();		//get the values through bean.
			String agtPassword=bean.getAgPassword();

			psmt.setString(1, agtId);			//assign.
			psmt.setString(2, agtPassword);
			ResultSet rs=psmt.executeQuery();	//execute the query.

			if(rs.next())		//if valid Agent.
			{
				
				String agentId=rs.getString("AgtID");
				String agentPasword=rs.getString("AgtPassword");
																		//if both values are matched.
				if(agentId!=null && agentId.equals(agtId) && agentPasword!=null && agentPasword.equals(agtPassword))
				{
					Date sysDateTime = new java.util.Date();
				    SimpleDateFormat csdf =  new SimpleDateFormat("yyyy-MM-dd");		//Make simple date Format according to Sql Format.
				    String currentDate= csdf.format(sysDateTime);
		
				    java.sql.Date sqlDate=rs.getDate("AgtValidity");  //converting SQl Date To String.
					java.util.Date udd=(Date)sqlDate;
					SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
					String validityDate=sdf.format(udd);
				
					if(currentDate.equalsIgnoreCase(validityDate))	//if agent validity as been expired, don't allow him to login.
					{
						status=3;
						return status;
					}
					else	//if not, allow him to login.
					{
						agentName=rs.getString("AgtFirstName");	//make it static.
						status=1;
					}
				}
				else 
				{
					status=2;		//if both values are not matched.
				}	
			}
			else
			{
				status=2;		//if not valid agent.
			}
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());		//if any exception.
			status=5;
		}

		return status;		//return status.
	}
}
