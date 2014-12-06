package com.riseon.chitfund.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.riseon.chitfund.dto.AuctionHistoryBeans;
import com.riseon.chitfund.services.ConnectionProvider;

public class AuctionHistoryDao 
{
	private static Connection con=ConnectionProvider.getObj().getCon();  //Get the connection using services.
	private static PreparedStatement pstm=null;

	private static String agentId=null;			//global variables.
	private static String groupId=null;
	private static ArrayList<AuctionHistoryBeans> historyList=null;

	public ArrayList<AuctionHistoryBeans> getHistory(AuctionHistoryBeans bean)
	{
		String query="select totalAuctions,remainingAuctions from group_details where agentId=? AND groupid=?";
		historyList= new ArrayList<AuctionHistoryBeans>();

		try
		{
			agentId=bean.getMemAgtId();		//get the values.
			groupId=bean.getMemGrpId();

			pstm=con.prepareStatement(query);	
			pstm.setString(1, agentId);
			pstm.setString(2, groupId);
			ResultSet res= pstm.executeQuery();		// execute

			if(res.next())	//if group found.
			{
				int totalAuctions=res.getInt("totalAuctions");			//get the total auction slots.
				int remaningAuction=res.getInt("remainingAuctions");	//get the remaining auction slots.

				if(totalAuctions==remaningAuction)		//if both are same, i.e Yet single Auction process has not been happened.
				{
					System.out.println("in DAO LIST SIZE.. "+ historyList.size());	// stop the process return.
					return historyList;
				}
				else		//if not same, I.e Auction Histories are available. 
				{	
					historyList=getHistoryDetails();	//call getHistoryDetails mtd to get the Details.
				}
			}
			else
			{
				System.out.println("Group NOt found...."); //it returns size as zero.
				return historyList;
			}
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());	//it returns size as zero.
			return historyList;
		}
		return historyList;     	 //return.
	}

	private static ArrayList<AuctionHistoryBeans> getHistoryDetails()	//method to get the list of auction.
	{
		try
		{
			String query="select *from auction_details where memAgtId=? AND memGrpId=? ORDER BY id DESC"; // in reverse order.
			historyList= new ArrayList<AuctionHistoryBeans>();

			pstm=con.prepareStatement(query);
			pstm.setString(1, agentId);
			pstm.setString(2, groupId);
			ResultSet res= pstm.executeQuery();

			while(res.next())
			{
				AuctionHistoryBeans historyBean= new AuctionHistoryBeans(); 	//Create a beans object.

				historyBean.setAuctionId(res.getString("auctionId"));	//get the values from DB.
				historyBean.setMemGrpName(res.getString("memGrpName"));
				historyBean.setMemGrpId(res.getString("memGrpId"));
				historyBean.setMemAgtId(res.getString("memAgtId"));
				historyBean.setChitAmt(res.getDouble("chitAmt"));
				historyBean.setTotalmembers(res.getInt("totalmembers"));
				historyBean.setMemName(res.getString("memName"));
				historyBean.setMemId(res.getString("memId"));
				historyBean.setMemBidPer(res.getDouble("memBidPer"));
				historyBean.setBidAmt(res.getDouble("bidAmt"));
				historyBean.setBidMemAmt(res.getDouble("bidMemAmt"));
				historyBean.setAgentPer(res.getDouble("agentPer"));
				historyBean.setAgentAmt(res.getDouble("agentAmt"));
				historyBean.setRemaningAmt(res.getDouble("remaningAmt"));
				historyBean.setMonthlypremium(res.getDouble("monthlypremium"));
				historyBean.setPremiumReduced(res.getDouble("premiumReduced"));
				historyBean.setPremiumPaid(res.getDouble("premiumPaid"));
				
				java.sql.Date sqlDate=res.getDate("bidDate");  //converting SQl Date To String.
				java.util.Date udd=(Date)sqlDate;
				SimpleDateFormat sdf= new SimpleDateFormat("dd-MMM-yyyy");
				String bidDate=sdf.format(udd);
				
				historyBean.setBidDate(bidDate);
				historyBean.setBidTime(res.getString("bidTime"));

				historyList.add(historyBean);	//add bean object to list.
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			return historyList; //it returns size as zero.
		}

		return historyList;	//return the list.
	}

}
