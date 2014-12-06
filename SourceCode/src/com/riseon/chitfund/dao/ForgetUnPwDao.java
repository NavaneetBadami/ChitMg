package com.riseon.chitfund.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import com.riseon.chitfund.dto.EmailBeans;
import com.riseon.chitfund.services.ConnectionProvider;
import com.riseon.chitfund.utility.EmailUtility;

public class ForgetUnPwDao 
{	
	public int resendUserNamePassword(String agentEmail, EmailBeans emailBeans)
	{
		int status=0;
		try
		{
			Connection con= ConnectionProvider.getObj().getCon();	//get the Connection.
			Statement stm=con.createStatement();

			String query="select AgtFirstName,AgtID,AgtPassword from agent_details where AgtEmail='"+agentEmail+"'";
			ResultSet res=stm.executeQuery(query);	//execute 
			
			if(res.next())	//if email found.
			{
				String agFirstName=res.getString("AgtFirstName");	//get the details.
				String agId=res.getString("AgtID");
				String agPassword=res.getString("AgtPassword");

				String host=emailBeans.getHost();    //Get the SMTP values through beans.
				String port=emailBeans.getPort();
				String adminUser=emailBeans.getAdminUser();
				String adminPass=emailBeans.getAdminPass();

				String recipient = agentEmail;			//send the email with details.
				String subject = "WeRiseChit AgentId,Password";
				String content = "Hello "+agFirstName+",\n  \n	As you had requested for userId and password, so notedown UserId,password and login Again. \nPlease use your userID: " +agId+" \n Password: "+agPassword+" \n\nRegards, \nWeRiseChit Fund Team";  // Email Message.

				EmailUtility.sendEmail(host, port, adminUser, adminPass, recipient, subject, content); //Call the Static sendEmail method.
				System.out.println("The e-mail was sent successfully");
				status=1;
			}
			else		//if mail not found.
			{
				System.out.println("Email not found..");
				status=0;
			}
		}
		catch(Exception e)		//if exception like net connection not available..
		{
			System.out.println("Email not sent..");
			System.out.println(e.getMessage());
			status=5;
		}
		return status;	//return the status.
	}
}
