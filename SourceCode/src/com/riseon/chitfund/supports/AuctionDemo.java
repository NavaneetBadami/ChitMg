package com.riseon.chitfund.supports;

import java.math.BigInteger;
import java.net.Inet4Address;
import java.net.UnknownHostException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

import com.riseon.chitfund.services.ConnectionProvider;

public class AuctionDemo
{
	public static void main(String[] args) 
	{
		try 
		{	
			Connection con=ConnectionProvider.getObj().getCon();	//make a connection.

			String query1="select membId,membidden,membfirstname from chitfund.members_details where membId=? AND agtentid=? AND groupid=?";	//query to check the bid status of member. 
			PreparedStatement pstm1=con.prepareStatement(query1);
			pstm1.setString(1, "navaneet35550476");
			pstm1.setString(2, "psm");
			pstm1.setString(3, "RCF_32ohe3b_GRP");
			ResultSet res1=pstm1.executeQuery();

			if(res1.next())			//check member is valid or not.
			{
				String bidMemId=res1.getString("membId");
				String bidMemName=res1.getString("membfirstname");
				String bidStatus=res1.getString("membidden");

				if(bidStatus!=null && bidStatus.equalsIgnoreCase("YES"))	//if member is already bidden.
				{
					System.out.println("member has already bidden..!");
				}
				else if(bidStatus!=null && bidStatus.equalsIgnoreCase("NO"))	//if not, the process for auction process.
				{
					auctionProcess(bidMemId,bidMemName);	//static method.
				}
			}
			else	//if not a valid member.
			{
				System.out.println("member Not Found");
			}
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
		}	
	}	

	private static void auctionProcess(String bidMemId,String bidMemName)throws Exception	//Auction Logic.
	{
		Connection con=ConnectionProvider.getObj().getCon();	//make a connection.
		
		String query="select *from chitfund.group_details where agentid=? and groupid=?";	//get the group details.
		PreparedStatement pstm=con.prepareStatement(query);
		pstm.setString(1, "navaneet59145657");
		pstm.setString(2, "RCF_13h62j8_GRP");
		ResultSet res=pstm.executeQuery();
		
		if(res.next())		//validate group.
		{
			double totalChitAmount=res.getInt("chitamount");		//get the chitAmount.
			int members=res.getInt("TotalmemberSlots");				//total members.
			int remainingAuctions=res.getInt("remainingAuctions");

			Scanner sc= new Scanner(System.in);
			System.out.println("Enter the Bid Percentage:");		//get the bid% from user.
			int bid=sc.nextInt();
			sc.close();
			double bidAmount=(totalChitAmount*bid)/(100);			//total bid amount(remaining amount).
			double premRed=totalChitAmount-bidAmount;				//total amount which bid member get after didection. 
			double ageCom=(bidAmount*5)/(100);						//agent commission.
			double remAmt=(bidAmount-ageCom);
			double indAmt=(bidAmount-ageCom)/(members-1);			//total amount member get after auction from remaining.
			
			storeAuctionDetails(members, totalChitAmount, bidMemName, bid, bidAmount, premRed, ageCom, remAmt, indAmt, remainingAuctions);
			
		}
		else
		{
			System.out.println("Group not found.");
		}
	}

	private static void storeAuctionDetails(int members,double totalChitAmount,String bidMemName,int bid,double bidAmount,double premRed,double ageCom,double remAmt,double indAmt,int remainingAuctions) throws Exception
	{
		Connection con=ConnectionProvider.getObj().getCon();	//make a connection.
		
		Date sysDateTime = new java.util.Date();
		SimpleDateFormat stf =  new SimpleDateFormat("HH:mm:ss");		//Make simple time Format according to Sql Format.
		SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");		//Make simple date Format according to Sql Format.
		String time = stf.format(sysDateTime); 		//Pass the Date& Time object in Your Format.
		String date= sdf.format(sysDateTime);

		String System_ip_address=Inet4Address.getLocalHost().getHostAddress(); //Get Account Created system IP Address.

		String AucId=date+"_";
		String auctionId=AucId.concat(randomId());	//static mtd.

		String query2="insert into auction_details(auctionId,memGrpId,memAgtId,chitAmt,totalMembers,memName,memId,memBidPer,bidAmt,bidMemAmt,agentPer,agentAmt,remaningAmt,perMemAmt,bidDate,bidTime,sys_IPAddress)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement pstm2= con.prepareStatement(query2);	//Store all auction details into database.
		pstm2.setString(1,auctionId);
		pstm2.setString(2,"RCF_32ohe3b_GRP");
		pstm2.setString(3,"navaneet35550476");
		pstm2.setDouble(4,totalChitAmount);
		pstm2.setInt(5,members);
		pstm2.setString(6,bidMemName);
		pstm2.setString(7,"navaneet35550476");
		pstm2.setDouble(8,bid);
		pstm2.setDouble(9,bidAmount);
		pstm2.setDouble(10,premRed);
		pstm2.setDouble(11,5);
		pstm2.setDouble(12,ageCom);
		pstm2.setDouble(13,remAmt);
		pstm2.setDouble(14,indAmt);
		pstm2.setString(15,date);
		pstm2.setString(16,time);
		pstm2.setString(17,System_ip_address);

		int res2=pstm2.executeUpdate();	//execute.
		System.out.println("Auction Done...!"+ res2);	

		if(res2==1)			//process to update relative details.
		{
			updateDetails(remainingAuctions,res2);	//static method.
		}
	}

	private static void updateDetails(int remainingAuctions,int value) throws Exception	//Update Logic.
	{
		Connection con=ConnectionProvider.getObj().getCon();	//make a connection.
		
		String query3="update members_details set membidden=? where membId=?";	//update member memBidden status= YES.
		PreparedStatement pstm3=con.prepareStatement(query3);
		pstm3.setString(1, "YES");
		pstm3.setString(2, "navaneet35550476");
		int res4=pstm3.executeUpdate();
		System.out.println("Member Completed in Auction process: "+ res4);

		if(res4==1)
		{
			int currentAuctions=remainingAuctions-value;		//update remaningAuction after successfully one auction.
			String query4="update group_details set remainingAuctions=? where groupid=?";
			PreparedStatement pstm4=con.prepareStatement(query4);
			pstm4.setInt(1, currentAuctions);
			pstm4.setString(2, "RCF_13h62j8_GRP");
			int res5=pstm4.executeUpdate();
			System.out.println(res5+" No OF Auction remaning." + currentAuctions);
		}
	}

	private static String randomId()   //mtd to create random alphanumeric.
	{
		SecureRandom random = new SecureRandom();
		return new BigInteger(32, random).toString(32);
	}
}
