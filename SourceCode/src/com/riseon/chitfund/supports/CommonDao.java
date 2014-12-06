package com.riseon.chitfund.supports;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.riseon.chitfund.dto.AddMemberBeans;
import com.riseon.chitfund.dto.AddSchemeBean;
import com.riseon.chitfund.dto.AuctionHistoryBeans;
import com.riseon.chitfund.dto.ContactBeans;
import com.riseon.chitfund.dto.CreateChitGroupBean;
import com.riseon.chitfund.dto.ViewAgentsBeans;
import com.riseon.chitfund.services.ConnectionProvider;
public class CommonDao 
{
	private static Connection con=ConnectionProvider.getObj().getCon(); //Make the connection using service.
	private static Statement stm=null;
	
																			//Using in ViewAgents.jsp.
	public static ArrayList<ViewAgentsBeans> allAgents(String sqlQuery)		//No of Agents. 
	{
		ArrayList<ViewAgentsBeans> agentList= new ArrayList<>();
		try 
		{
			stm=con.createStatement();
			ResultSet res=stm.executeQuery(sqlQuery);
			while(res.next())
			{
				ViewAgentsBeans viewAgentsBeans= new ViewAgentsBeans(); 	//Create a beans object.
				
				viewAgentsBeans.setAgFirstName(res.getString("AgtFirstName"));  //get the values from DB assign it to beans.
				viewAgentsBeans.setAgLastName(res.getString("AgtLastName"));
				viewAgentsBeans.setAgId(res.getString("AgtID"));
				viewAgentsBeans.setAgEmail(res.getString("AgtEmail"));
				
					java.sql.Date sqlDate=res.getDate("AgtDOB");  //converting SQl Date To String.
					java.util.Date udd=(Date)sqlDate;
					SimpleDateFormat sdf= new SimpleDateFormat("dd-MMM-yyyy");
					String dob=sdf.format(udd);
				viewAgentsBeans.setAgDob(dob);
				
				viewAgentsBeans.setAgAddress(res.getString("AgtAddress"));
				viewAgentsBeans.setAgState(res.getString("AgtState"));
				viewAgentsBeans.setAgCity(res.getString("AgtCity"));
				viewAgentsBeans.setAgPinCode(res.getInt("AgtPINCode"));
				viewAgentsBeans.setAgMobileNo(res.getLong("AgtContactno"));
				viewAgentsBeans.setAgGender(res.getString("AgtGender"));
				viewAgentsBeans.setNomFirstName(res.getString("AgtNomineeName"));
				viewAgentsBeans.setNomRelationship(res.getString("AgtRelationship"));
				viewAgentsBeans.setNomMobileNo(res.getLong("AgtNomContactno"));
				viewAgentsBeans.setNomAddress(res.getString("AgtNomAdderss"));
				viewAgentsBeans.setNomState(res.getString("AgtNomState"));
				viewAgentsBeans.setNomCity(res.getString("AgtNomCity"));
				viewAgentsBeans.setNomEmail(res.getString("AgtNomEmail"));
				viewAgentsBeans.setAgPanNO(res.getString("AgtPANno"));
				viewAgentsBeans.setNomPinCode(res.getInt("AgtNomPINCode"));
				viewAgentsBeans.setAgtChatPlan(res.getString("AgtChitPlan"));
				viewAgentsBeans.setAgPaymode(res.getString("AgtModeOfPayment"));

					java.sql.Date pDate= res.getDate("AgtAccCreDate");
					Date prDate=(Date)pDate;
					SimpleDateFormat pDateFormat= new SimpleDateFormat("dd-MMM-yyyy");
					String purchasedDate=pDateFormat.format(prDate);
				viewAgentsBeans.setPurchasedDate(purchasedDate);
				
					java.sql.Date vDate=res.getDate("AgtValidity");
					Date vlDate=(Date)vDate;
					SimpleDateFormat vDateFormat= new SimpleDateFormat("dd-MMM-yyyy");
					String validityDate=vDateFormat.format(vlDate);
				viewAgentsBeans.setValidityDate(validityDate);
					
				agentList.add(viewAgentsBeans);   //add the bean object to array list.
			}
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
		}
		return agentList;  //return the list.
	}
	
																			//Using in AddMember.jsp.
	public static ArrayList<AddMemberBeans>groupDetails(String query)		//No Of members in the one particular group.
	{
		ArrayList<AddMemberBeans> grpDetailsList=new ArrayList<AddMemberBeans>();
		
		AddMemberBeans grpMemBeans= new AddMemberBeans();  //bean object.
		try 
		{
			stm=con.createStatement();				//query from browser.
			ResultSet res= stm.executeQuery(query);	//execute the query.
			while(res.next())
			{
				AddMemberBeans grpMemDetail= new AddMemberBeans();		//set the values to beans
				
				grpMemDetail.setAgentId(res.getString("agentId"));
				grpMemDetail.setGroupId(res.getString("groupid"));
				grpMemDetail.setMemFirstName(res.getString("membfirstname"));
				grpMemDetail.setMemLastName(res.getString("memblastname"));
				grpMemDetail.setMemId(res.getString("membId"));
				grpMemDetail.setMemAddress(res.getString("membaddress"));
				grpMemDetail.setMemMobileNo(res.getLong("membcontactno"));
				grpMemDetail.setMemGender(res.getString("membgender"));
				grpMemDetail.setMemPinCode(res.getInt("membpincode"));
			//	grpMemDetail.setMemPanNO(res.getString("membpincode"));
				grpMemDetail.setMemSuretyType(res.getString("membsuretytype"));
				grpMemDetail.setMembidden(res.getString("membidden"));
				
				grpMemDetail.setMemNomFName(res.getString("membnomname"));
				grpMemDetail.setMemNomRelationship(res.getString("membnomrelation"));
				grpMemDetail.setMemNomAddress(res.getString("membnomaddress"));
				grpMemDetail.setMemNomPinCode(res.getInt("membnompincode"));
				grpMemDetail.setMemNomMobileNo(res.getLong("membnomcontactno"));
				
				grpDetailsList.add(grpMemDetail);	//add bean object to list.
				
			}
			
		} 
		catch (SQLException e)
		{
			System.out.println(e.getMessage());		//if exception.
			grpDetailsList.add(grpMemBeans);
		}
		return grpDetailsList;		//pass the list.
	}
	
																				//Using in ViewGroups.jsp, GroupsList.jsp
	public static ArrayList<CreateChitGroupBean> groupList(String sqlQuery)		//No of groups belongs to one agent.
	{
		ArrayList<CreateChitGroupBean> groupList= new ArrayList<>();
		try 
		{
			stm=con.createStatement();
			ResultSet res=stm.executeQuery(sqlQuery);
			while(res.next())
			{
				CreateChitGroupBean groupBean= new CreateChitGroupBean(); 	//Create a beans object.
				groupBean.setAgentName(res.getString("agentname"));
				groupBean.setGroupId(res.getString("groupid"));
				groupBean.setGroupName(res.getString("groupname"));
				groupBean.setChitAmount(res.getDouble("chitamount"));
				groupBean.setDuration(res.getDouble("duration"));
				groupBean.setTotalAuctions(res.getInt("totalAuctions"));
				groupBean.setRemainingAuctions(res.getInt("remainingAuctions"));
				groupBean.setAvailableMemberSlots(res.getInt("AvailablememberSlots"));
				groupBean.setTotalMemberSlots(res.getInt("TotalmemberSlots"));
				groupBean.setPremium(res.getDouble("premium"));
				groupBean.setGrpStatus(res.getString("grpStatus"));
				groupBean.setAgentPer(res.getDouble("agentComPer"));
				
					java.sql.Date sqlDate=res.getDate("grpcredate");
					Date udate=(Date)sqlDate;
					SimpleDateFormat sdf= new SimpleDateFormat("dd-MMM-yyyy");
					String grpCreDate=sdf.format(udate);
				
				groupBean.setGrpcredate(grpCreDate);
				groupBean.setGrpcretime(res.getString("grpcretime"));
				
				groupList.add(groupBean);   //add the bean object to array list.
			}
		
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
		}
		return groupList;
	}
	
																			//Using in ViewScheme.jsp.
	public static ArrayList<AddSchemeBean> schemeList(String sqlQuery)		//No of Schemes or list of schemes. 
	{
		ArrayList<AddSchemeBean> schemeList= new ArrayList<>();
		try 
		{
			stm=con.createStatement();
			ResultSet res=stm.executeQuery(sqlQuery);
			while(res.next())
			{
				AddSchemeBean schemeBean= new AddSchemeBean(); 	//Create a beans object.
				schemeBean.setSchemeId(res.getString("schmemeid"));
				schemeBean.setSchemeType(res.getInt("schemetype"));
				schemeBean.setSchemePrice(res.getDouble("amount"));
				schemeBean.setSchemeValidity(res.getDouble("validity"));
				
				schemeList.add(schemeBean);   //add the bean object to array list.
			}
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
		}
		return schemeList;
	}
																				//Using in EnqMessages.jsp.
	public static ArrayList<ContactBeans> enquirersMsgs(String sqlQuery)		//Display enquirers messages.  
	{
		ArrayList<ContactBeans> enqMsgList= new ArrayList<>();
		try 
		{
			stm=con.createStatement();
			ResultSet res=stm.executeQuery(sqlQuery);
			while(res.next())
			{
				ContactBeans enquiryBeans= new ContactBeans(); 	//Create a beans object.
				
				enquiryBeans.setId(res.getInt("id"));
				enquiryBeans.setName(res.getString("name"));
				enquiryBeans.setEmail(res.getString("email"));
				enquiryBeans.setMobile(res.getLong("contact"));
				enquiryBeans.setCity(res.getString("city"));
				enquiryBeans.setMessage(res.getString("message"));
				
				java.sql.Date sqlDate=res.getDate("contactedDate");  //converting SQl Date To String.
				java.util.Date udd=(Date)sqlDate;
				SimpleDateFormat sdf= new SimpleDateFormat("dd-MMM-yyyy");
				String date=sdf.format(udd);
				enquiryBeans.setDate(date);
				
				enquiryBeans.setTime(res.getString("contactedTime"));
			
				enqMsgList.add(enquiryBeans);   //add the bean object to array list.
			}
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
		}
		
		return enqMsgList;
	}
																						//Using in member_home.jsp.				
	public static ArrayList<AuctionHistoryBeans> auctionHistory(String sqlQuery)		//Auction belongs one group.
	{
		ArrayList<AuctionHistoryBeans> auctionHistoryList= new ArrayList<>();
		try 
		{
			stm=con.createStatement();
			ResultSet res=stm.executeQuery(sqlQuery);
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
				
				auctionHistoryList.add(historyBean);
			}
		
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
		}
		return auctionHistoryList;
	}
	
}
