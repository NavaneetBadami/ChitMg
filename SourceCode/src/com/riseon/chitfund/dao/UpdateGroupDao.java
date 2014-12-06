package com.riseon.chitfund.dao;

import java.io.InputStream;
import java.net.Inet4Address;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import com.riseon.chitfund.dto.AddMemberBeans;
import com.riseon.chitfund.services.ConnectionProvider;

public class UpdateGroupDao
{
	static Statement stmt=null;

	public int addMember(AddMemberBeans addMemberBeans)
	{
		Random randomNo = new Random();   // Generate some random no.
		int accNo = randomNo.nextInt(100000000);
		int status=0;

		Connection con=ConnectionProvider.getObj().getCon(); //make connection using Services.
		PreparedStatement pstm=null;
		try
		{
			String qrylimi="set global max_allowed_packet=104857600"; //making sql query to send more then 1mb data.
			Statement stlim=con.createStatement();
			stlim.execute(qrylimi);

			String agentId=addMemberBeans.getAgentId();			 //get the values from bean.
			String gropuId=addMemberBeans.getGroupId();
			String memFirstName=addMemberBeans.getMemFirstName();    
			String memLastName=addMemberBeans.getMemLastName();
			String memAddress=addMemberBeans.getMemAddress();
			long memMobileNo=addMemberBeans.getMemMobileNo();
			int memPinCode=addMemberBeans.getMemPinCode();
			String memSuretyType=addMemberBeans.getMemSuretyType();
			String memGender=addMemberBeans.getMemGender();

			String memNomFName=addMemberBeans.getMemNomFName();
			String memNomRelationship=addMemberBeans.getMemNomRelationship();
			String memNomAddress=addMemberBeans.getMemNomAddress();
			long memNomMobileNo=addMemberBeans.getMemNomMobileNo();
			int memNomPinCode=addMemberBeans.getMemNomPinCode();

			InputStream memImagee=addMemberBeans.getMemImage();   //get the image inputStream.
			InputStream memSuretyImage=addMemberBeans.getMemSurety();

			Date sysDateTime = new java.util.Date();
			SimpleDateFormat stf =  new SimpleDateFormat("HH:mm:ss");		//Make simple time Format according to Sql Format.
			SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");		//Make simple date Format according to Sql Format.
			String time = stf.format(sysDateTime); 		//Pass the Date& Time object in Your Format.
			String date= sdf.format(sysDateTime);

			String System_ip_address=Inet4Address.getLocalHost().getHostAddress(); //Get Account Created system IP Address.

			String randomStr=memFirstName.toLowerCase();  //get some random code for Password.
			Integer randomNo1= new Integer(accNo);		
			String randomNumber=randomNo1.toString();
			String code1=randomNumber.substring(0,4);
			String code2=randomNumber.substring(4,randomNumber.length());
			String memPassword=code1.concat(randomStr).concat(code2);


			String randomStr2=memFirstName.toLowerCase();  //get some random code for UserID.
			Integer randomNo2= new Integer(accNo);
			String randomNumber2=randomNo2.toString();
			String memId=randomStr2.concat(randomNumber2);

			stmt=con.createStatement();		//checking for current available free member slots.
			String selectQuery="select *from group_details where groupid='"+gropuId+"'";
			ResultSet res=stmt.executeQuery(selectQuery);
			int memberSlots=0;

			if(res.next())
			{
				memberSlots=res.getInt("AvailablememberSlots"); //get the current available member slots.
				if(memberSlots!=0)   //if member slots available.
				{		
					String insertQuery="insert into members_details(groupid,agentId,membfirstname,membId,memblastname,membpassword,membgender,membcontactno,membaddress,membpincode,membphoto,membnomname,membnomaddress,membnompincode,membnomcontactno,membsuretytype,membsuretyphoto,membcredate,membcretime,membIP_addreess,membnomrelation,membidden)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					pstm=con.prepareStatement(insertQuery);

					pstm.setString(1, gropuId);   //set the values.
					pstm.setString(2, agentId);
					pstm.setString(3, memFirstName);
					pstm.setString(4, memId);
					pstm.setString(5, memLastName);
					pstm.setString(6, memPassword);
					pstm.setString(7, memGender);
					pstm.setLong(8, memMobileNo);
					pstm.setString(9, memAddress);
					pstm.setInt(10, memPinCode);
					pstm.setBlob(11, memImagee);
					pstm.setString(12,memNomFName);
					pstm.setString(13, memNomAddress);
					pstm.setInt(14, memNomPinCode);
					pstm.setLong(15, memNomMobileNo);
					pstm.setString(16, memSuretyType);
					pstm.setBlob(17,memSuretyImage);
					pstm.setString(18, date);
					pstm.setString(19, time);
					pstm.setString(20,System_ip_address);
					pstm.setString(21,memNomRelationship);
					pstm.setString(22,"NO");

					status= pstm.executeUpdate(); //execute the query.

					if(status>0) //if table updated successfully.
					{
						memberSlots=memberSlots-status;     //reduce one member.

						stmt=con.createStatement();
						if(memberSlots==0)  // if member column becomes empty.
						{
							String updateQuery="update group_details set AvailablememberSlots='"+memberSlots+"' where groupid='"+gropuId+"'"; //update member column to 0.
							stmt.executeUpdate(updateQuery);  //Execute query.
							status=2;
						}
						else  //if not becomes empty
						{
							String updateQuery="update group_details set AvailablememberSlots='"+memberSlots+"' where groupid='"+gropuId+"'"; //keep updating member column.
							stmt.executeUpdate(updateQuery);  //Execute query.
						}
					}
					else
					{
						status=5; //if table not updated.or exception.
					}
				}
				else
				{
					status=3; //if member slots are not available.
				}
			}		
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage()); //Exception
			status=5;
		}
		return status;   //return status.
	}
}
