package com.riseon.chitfund.dao;

import java.math.BigInteger;
import java.net.Inet4Address;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.riseon.chitfund.dto.CreateChitGroupBean;
import com.riseon.chitfund.services.ConnectionProvider;

public class CreateGroupDao 
{
	Connection con=ConnectionProvider.getObj().getCon();  //make connection using services.
	PreparedStatement psmt=null;
	Statement stmt=null;
	
	int status;       //global
	String agentId;
	int chitAvailability;
	public static String groupId;
	
	public int createGroup(CreateChitGroupBean bean)
	{
		try
		{
			stmt= con.createStatement();	 //common statement.
			agentId=bean.getAgentId();
			String query2="select *from agent_details where AgtID='"+agentId+"'";
			ResultSet res=stmt.executeQuery(query2);
			
			if(res.next())  	//check whether Chit slot are available or not.
			{
				chitAvailability=res.getInt("AgtChitAvailable");
				
				if(chitAvailability!=0)   	//if Chit slots are available.
				{
					status=addGroup(bean); 	 //create group by calling addGroup mtd().
					System.out.println("status after compl 2nd mtd :"+ status);
				}
				else     	//if Chit slots are not available.
				{
					status=3; 
				}	
			}	
		} 
		catch (Exception e) 
		{
			status=5;    	//if any exception.
			System.out.println(e.getMessage());
		}
		return status;     	 //return.
	}
	
	public static String randomId()   	//mtd to create random alphanumeric.
	{
		SecureRandom random = new SecureRandom();
		return new BigInteger(32, random).toString(32);
	}
	
	public int addGroup(CreateChitGroupBean bean)   //adding Member function.
	{
		String query="insert into group_details(agentid,groupid,groupname,chitamount,duration,AvailablememberSlots,TotalmemberSlots,premium,agentComPer,totalAuctions,remainingAuctions,grpcredate,grpcretime,grpStatus,grpsys_ip)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try
		{
			psmt=con.prepareStatement(query);
		
			agentId=bean.getAgentId();        	//get the values from bean.
			String groupName=bean.getGroupName();
			double chitAmount=bean.getChitAmount();
			double chitDuration=bean.getDuration();
			int totalMembers=bean.getTotalMembers();
			double monthlyPremium=bean.getPremium();
			double agentPer=bean.getAgentPer();
			int availableMemerberSlots=totalMembers;
			double totalAuctions=chitDuration;
			double remainingAuctionss=chitDuration;
			
			Date sysDateTime = new java.util.Date();
			SimpleDateFormat stf =  new SimpleDateFormat("HH:mm:ss");			//Make simple time Format according to Sql Format.
			SimpleDateFormat sdft =  new SimpleDateFormat("yyyy-MM-dd");		//Make simple date Format according to Sql Format.
			String time = stf.format(sysDateTime); 			//Pass the Date& Time object in Your Format.
			String date= sdft.format(sysDateTime);
			
			String sys_Ip=Inet4Address.getLocalHost().getHostAddress();
			
			String s1="RCF_";        	//generate random groupId.
		  	String s2=s1.concat(randomId());
			String grpID=s2.concat("_GRP");
			
			groupId=grpID;  //static same groupId used while adding members.
			
			psmt.setString(1, agentId);
			psmt.setString(2, grpID);
			psmt.setString(3, groupName);
			psmt.setDouble(4, chitAmount);
			psmt.setDouble(5, chitDuration);
			psmt.setInt(6, availableMemerberSlots);
			psmt.setInt(7,totalMembers );
			psmt.setDouble(8, monthlyPremium);
			psmt.setDouble(9, agentPer);
			psmt.setDouble(10, totalAuctions);
			psmt.setDouble(11, remainingAuctionss);
			psmt.setString(12, date);
			psmt.setString(13, time);
			psmt.setString(14, "VALID");
			psmt.setString(15, sys_Ip);
			
			status=psmt.executeUpdate();   	//execute the query.
			if(status>0)
			{
				System.out.println("Available Schemes:" + chitAvailability); 	//just to verify.
				int chitSlotCurrentStatus=chitAvailability-status;  	// decrement one Scheme slot after creating one group. 
			
				String query2="update agent_details set AgtChitAvailable='"+chitSlotCurrentStatus+"' where AgtID='"+agentId+"'";   //update slot.
				int res=stmt.executeUpdate(query2);
			}
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			status=5;  	//if any exception.
		}
		return status;  	//return status.
	}
}
