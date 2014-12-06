package com.riseon.chitfund.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.Statement;

import com.riseon.chitfund.dto.AddMemberBeans;
import com.riseon.chitfund.services.ConnectionProvider;

public class DeleteMemberDoa 
{
	private static Connection con=ConnectionProvider.getObj().getCon();	//get the connection object.
	static Statement stmt=null;	

	private static String agentId=null;		//global.
	private static String memberId=null;

	public int deleteMember(AddMemberBeans memBeans)	//main function.
	{
		int status=0;
		agentId=memBeans.getAgentId();
		memberId=memBeans.getMemId();
		
		try 
		{	
			String query="select groupid,membId from members_details where membId='"+memberId+"' AND agentId='"+agentId+"'";
			stmt=con.createStatement();
			ResultSet res= stmt.executeQuery(query);
			
			if(res.next())		//if valid member.
			{
				String memGrpId=res.getString("groupid");
				status=checkGrp(memGrpId);				
			}
			else		//if not,
			{	
				status=2;
			}
		} 
		catch (Exception e) 		//exception in whole DAO process.
		{
			status=5;	
			System.out.println(e.getMessage());
		}
		return status;		//final return.
	}
	private static int checkGrp(String memGrpId)throws Exception	//checking group details.
	{
		int status=0;
		String query="select AvailablememberSlots,totalAuctions,remainingAuctions from group_details where groupid='"+memGrpId+"' AND agentid='"+agentId+"'";
		stmt=con.createStatement();
		ResultSet res=stmt.executeQuery(query);
		
		if(res.next())		//check whether if any auction process taken place or not. 
		{
			int AvailablememberSlots=res.getInt("AvailablememberSlots");
			int totalAuctions=res.getInt("totalAuctions");
			int remainingAuctions=res.getInt("remainingAuctions");
	
			if(totalAuctions!=remainingAuctions)	//if YES, the cannot perform delete operation.
			{
				status=3;	
				return status;
			}		
			else		//if No, process the delete operation.
			{
				status=deleteMem(memGrpId,AvailablememberSlots);
			}
		}
		return status;

	}
	private static int deleteMem(String memGrpId,int AvailablememberSlots) throws Exception		//delete operation.
	{
		int status=0;
		String agtId=agentId;
		String memId=memberId;
		String query="delete from members_details where groupid=? AND agentId=? AND membId=?";

		PreparedStatement pstm=con.prepareStatement(query);
		pstm.setString(1,memGrpId);
		pstm.setString(2, agtId);
		pstm.setString(3, memId);

		int res=pstm.executeUpdate();	//if member deleted successfully.
		if(res==1)
		{
			status=updateGrpDetails(memGrpId, AvailablememberSlots,res);
		}
		return status;
	}
																						//update group details I.e increase member slot by 1.
	private static int updateGrpDetails(String memGrpId,int AvailablememberSlots,int result) throws Exception
	{
		int status=0;
		String agtId=agentId;
		int AvailableMemSlots=AvailablememberSlots+result;	//adding one slot.
		String query="update group_details set AvailablememberSlots=? where groupid=? AND agentid=?";

		PreparedStatement pstm=con.prepareStatement(query);
		pstm.setInt(1, AvailableMemSlots);
		pstm.setString(2, memGrpId);
		pstm.setString(3, agtId);

		int res=pstm.executeUpdate();
		if(res==1)
			status=res;

		return status;
	}

}
