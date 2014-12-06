package com.riseon.chitfund.dao;

import java.math.BigInteger;
import java.net.Inet4Address;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.riseon.chitfund.dto.AuctionProcessBeans;
import com.riseon.chitfund.services.ConnectionProvider;

public class AuctionProcessDao 
{
	private static String memGrpId;		//static global common variables;
	private static String memAgtId;
	private static String memId;
	private static String memName;
	private static double memBidPer;

	private static PreparedStatement pstm=null;
	private static Connection con=ConnectionProvider.getObj().getCon();		//get a connection.

	public int auctionOperation(AuctionProcessBeans aucBean)	//  Basic Step1.
	{
		int status=0;
		try 
		{		
			memGrpId=aucBean.getMemGrpId();		//get the values from beans and assign them to static variables.
			memAgtId=aucBean.getMemAgtId();
			memId=aucBean.getMemId();
			memBidPer=aucBean.getMemBidPer();

			status=validateMember();	//call validateMember method for verification.

		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());	//if any exception in whole DAO.
			status=5;
		}	
		return status;	//return final status value.
	}

	private static int validateMember() throws Exception	//Step2.
	{
		int status=0;
		String query="select membidden,membfirstname from chitfund.members_details where membId=? AND agentId=? AND groupid=?";	//query to check the bid status of member. 
		pstm=con.prepareStatement(query);
		pstm.setString(1, memId);
		pstm.setString(2, memAgtId);
		pstm.setString(3, memGrpId);
		ResultSet res=pstm.executeQuery();	//execute.

		if(res.next())			//check member is valid or not.
		{
			memName=res.getString("membfirstname");	
			String bidStatus=res.getString("membidden");

			if(bidStatus!=null && bidStatus.equalsIgnoreCase("YES"))	//if member has taken his amount.
			{
				System.out.println("member has already bidden..!");
				status=1;	//return 1;

			}
			else if(bidStatus!=null && bidStatus.equalsIgnoreCase("NO"))	//if not, the process for auction process.
			{
				status=auctionProcess();	//call auctionProcess method for further.
			}
		}
		else	//if not a valid member.
		{
			System.out.println("member Not Found");
			status=2;
		}
		return status;
	}

	private static int auctionProcess()throws Exception		//Auction MAIN Logic.	Step3.
	{
		int status=0;
		String query="select *from chitfund.group_details where agentid=? and groupid=?";	//get the group details.
		pstm=con.prepareStatement(query);
		String memGrpID=memGrpId;
		String memAgtID=memAgtId;

		pstm.setString(1,memAgtID);
		pstm.setString(2, memGrpID);
		ResultSet res=pstm.executeQuery();

		if(res.next())		//validate group.		MAIN AUCTION LOGIC.
		{
			int remainingAuctions=res.getInt("remainingAuctions");	//get remaining auction slots.
			String groupName=res.getString("groupname");			//get the GroupName.
			double totalChitAmount=res.getInt("chitamount");		//get the chitAmount.
			int members=res.getInt("TotalmemberSlots");				//get total members.
			double agentComPer=res.getDouble("agentComPer");		//get agent commission.
			double bidPer=memBidPer;								//assign bid percentage.
			double monthlyPremium=res.getDouble("premium");			//get monthlyPremium.

			double bidAmount=(totalChitAmount*bidPer)/(100);		//total bid amount(remaining amount).
			double memAmount=totalChitAmount-bidAmount;				//total amount which bid member get after didection. 
			double agentCom=(bidAmount*agentComPer)/(100);			//agent commission.
			double remainingAmt=(bidAmount-agentCom);				//remaining fund after bid and agent commission.
			double premiumReduced=(remainingAmt)/(members-1);		//reduced premium in monthly premium, which will discounted to remaining member.
			double premiumToPay=(monthlyPremium-premiumReduced);	//final premium member has to pay.  	
																	//ones Auction process done then store all related values to DB.
			storeAuctionDetails(groupName, members, totalChitAmount, bidPer, bidAmount, memAmount,agentComPer,agentCom, remainingAmt,monthlyPremium, premiumReduced,premiumToPay, remainingAuctions);
			status=4;	//after storing the values in DB return 4;
		}
		else
		{
			System.out.println("Group not found.");
			status=3;
		}
		return status;
	}

	private static void storeAuctionDetails(String groupName,int members,double totalChitAmount,double bidPer,double bidAmount,double memAmount,double agentComPer,double agentCom,double remainingAmt,double monthlyPremium, double premiumReduced,double premiumToPay,int remainingAuctions) throws Exception 	//Step4.
	{
		String query="insert into auction_details(memGrpName,auctionId,memGrpId,memAgtId,chitAmt,totalMembers,memName,memId,memBidPer,bidAmt,bidMemAmt,agentPer,agentAmt,remaningAmt,monthlypremium,premiumReduced,premiumPaid,bidDate,bidTime,sys_IPAddress)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		pstm= con.prepareStatement(query);	//Store all auction details into database.
		String memGrpID=memGrpId;
		String memAgtID=memAgtId;
		String memID=memId;
		String bidMemName=memName;

		Date sysDateTime = new java.util.Date();
		SimpleDateFormat stf =  new SimpleDateFormat("HH:mm:ss");		//Make simple time Format according to Sql Format.
		SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");		//Make simple date Format according to Sql Format.
		String biddenTime = stf.format(sysDateTime); 		//Pass the Date& Time object in Your Format.
		String biddenDate= sdf.format(sysDateTime);

		String System_ip_address=Inet4Address.getLocalHost().getHostAddress(); //Get Account Created system IP Address.

		String AucId=biddenDate+"_";
		String auctionID=AucId.concat(randomId());	//method to create some alphanumeric random string.

		pstm.setString(1,groupName);
		pstm.setString(2,auctionID);
		pstm.setString(3,memGrpID);
		pstm.setString(4,memAgtID);
		pstm.setDouble(5,totalChitAmount);;
		pstm.setInt(6,members);
		pstm.setString(7,bidMemName);
		pstm.setString(8,memID);
		pstm.setDouble(9,bidPer);
		pstm.setDouble(10,bidAmount);
		pstm.setDouble(11,memAmount);
		pstm.setDouble(12,agentComPer);
		pstm.setDouble(13,agentCom);
		pstm.setDouble(14,remainingAmt);
		pstm.setDouble(15,monthlyPremium);
		pstm.setDouble(16,premiumReduced);
		pstm.setDouble(17,premiumToPay);
		pstm.setString(18,biddenDate);
		pstm.setString(19,biddenTime);
		pstm.setString(20,System_ip_address);

		int res=pstm.executeUpdate();		//execute.
		System.out.println("Auction Done...!"+ res);	

		if(res==1)			//process to update some relative details.
		{
			updateDetails(remainingAuctions);	//updateDetails static method.
		}
	}

	private static void updateDetails(int remainingAuctions) throws Exception	//Update Logic. Step5
	{
		String memGrpID=memGrpId;
		String memAgtID=memAgtId;
		String memID=memId;

		String query="update members_details set membidden=? where membId=? AND agentId=?";	//update member memBidden status= YES.
		pstm=con.prepareStatement(query);
		pstm.setString(1, "YES");
		pstm.setString(2, memID);
		pstm.setString(3, memAgtID);
		int res=pstm.executeUpdate();
		System.out.println("Member Completed in Auction process: "+ res);

		if(res==1)
		{
			int value=res;
			int currentAuctions=remainingAuctions-value;		//update remaningAuction column after successfully one auction. Step6
			
			if(currentAuctions==0)		//ones all auction's completed the its better to hide that group.
			{
				String statusQuery="update group_details set grpStatus=? where groupid=?";
				pstm=con.prepareStatement(statusQuery);
				pstm.setString(1,"EXPIRED");
				pstm.setString(2, memGrpID);
				int rs=pstm.executeUpdate();
				System.out.println("One group becomes hidden "+ rs);
			}
			
			String upQuery="update group_details set remainingAuctions=? where groupid=?";
			pstm=con.prepareStatement(upQuery);
			pstm.setInt(1, currentAuctions);
			pstm.setString(2, memGrpID);
			int res5=pstm.executeUpdate();
			System.out.println(res5+" No OF Auction remaning." + currentAuctions);
		}
	}

	private static String randomId()   //mtd to create random alphanumeric.
	{
		SecureRandom random = new SecureRandom();
		return new BigInteger(32, random).toString(32);
	}
}
