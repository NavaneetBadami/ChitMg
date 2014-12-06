package com.riseon.chitfund.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.riseon.chitfund.dto.CreateChitGroupBean;
import com.riseon.chitfund.services.ConnectionProvider;

public class AuctionValDao 
{
	public ArrayList<CreateChitGroupBean> validateGroup(CreateChitGroupBean bean)
	{
		Connection con=ConnectionProvider.getObj().getCon();  //make connection using services.
		PreparedStatement psmt=null;
		String query="select * from group_details where agentId=? AND groupid=?";

		ArrayList<CreateChitGroupBean> list= new ArrayList<CreateChitGroupBean>();
		try
		{
			String agentId=bean.getAgentId();		//get the values.
			String groupId=bean.getGroupId();

			psmt=con.prepareStatement(query);	
			psmt.setString(1, agentId);
			psmt.setString(2, groupId);
			ResultSet res= psmt.executeQuery();		// execute

			if(res.next())	//if group found.
			{
				int availablememberSlots=res.getInt("AvailablememberSlots");
				int remaningAuction=res.getInt("remainingAuctions");	//get the remaining auction slots.
				
				if(remaningAuction==0 || availablememberSlots!=0)		//if no auction slots are available or all member must be added into the group before auction.
				{
					System.out.println("in DAO LIST SIZE.. "+ list.size());	// stop the process return.
					return list;
				}
				else		//if available.
				{
					CreateChitGroupBean groupBean= new CreateChitGroupBean(); 	//Create a beans object.

					groupBean.setAgentName(res.getString("agentname"));		//setter.
					groupBean.setGroupId(res.getString("groupid"));
					groupBean.setGroupName(res.getString("groupname"));
					groupBean.setChitAmount(res.getDouble("chitamount"));
					groupBean.setDuration(res.getDouble("duration"));
					groupBean.setTotalAuctions(res.getInt("totalAuctions"));
					groupBean.setRemainingAuctions(res.getInt("remainingAuctions"));
					groupBean.setAvailableMemberSlots(res.getInt("AvailablememberSlots"));
					groupBean.setTotalMemberSlots(res.getInt("TotalmemberSlots"));
					groupBean.setPremium(res.getDouble("premium"));
					groupBean.setAgentPer(res.getDouble("agentComPer"));

					list.add(groupBean);	//add the bean object to list.
				}
			}
			else
			{
				System.out.println("Group NOt found....");
			}
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			return list;
		}
		return list;     	 //return.
	}

}
