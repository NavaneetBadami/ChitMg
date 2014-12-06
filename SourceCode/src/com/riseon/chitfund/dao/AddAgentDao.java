package com.riseon.chitfund.dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.Inet4Address;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import com.riseon.chitfund.dto.AddAgentBean;
import com.riseon.chitfund.dto.AddAgentBean;
import com.riseon.chitfund.dto.EmailBeans;
import com.riseon.chitfund.services.ConnectionProvider;
import com.riseon.chitfund.utility.EmailUtility;

public class AddAgentDao 
{
	
	public int agentReg(AddAgentBean addAgentbeans, EmailBeans emailBeans)
	{
		Random randomNo = new Random();   // Generate some random no.
		int accNo = randomNo.nextInt(100000000);
		
		Connection con=ConnectionProvider.getObj().getCon(); //Making Connection from service.ConnectionProvider.
		PreparedStatement pstm=null;
		int status=0;
		
		try 
		{
			String qrylimi="set global max_allowed_packet=104857600"; //making sql query to send more then 1mb data.
        	Statement stlim=con.createStatement();
        	stlim.execute(qrylimi);
		
			/*Getting agent basic Values from beans	*/
				
				String agFirstName=addAgentbeans.getAgFirstName(); 
				String agLastName=addAgentbeans.getAgLastName();
				String agAddress=addAgentbeans.getAgAddress();
				String agDob=addAgentbeans.getAgDob();
					 SimpleDateFormat sdfDOB=new SimpleDateFormat("dd-MM-yyyy"); //Convert string Date into SQl DateFormat.
					 java.util.Date uDob=sdfDOB.parse(agDob);
					 java.sql.Date sqlDOB = new java.sql.Date(uDob.getTime());
				String agEmail=addAgentbeans.getAgEmail();
				String agCity=addAgentbeans.getAgCity(); 
				String agState=addAgentbeans.getAgState();
				String agGender=addAgentbeans.getAgGender();
				long agMobileNo=addAgentbeans.getAgMobileNo();
				int agPinCode=addAgentbeans.getAgPinCode();
				int agScheme=addAgentbeans.getAgSchType();
				String agPaymode=addAgentbeans.getAgPaymode();
				
				
				InputStream agImage=addAgentbeans.getAgImage();   //get the image inputStream.
				InputStream agIdImage=addAgentbeans.getAgIDimage();
				InputStream agPanImage=addAgentbeans.getAgPanImage();
		
				String randomStr=agFirstName.toLowerCase();  //get some random code for Password.
				Integer randomNo1= new Integer(accNo);		
				String randomNumber=randomNo1.toString();
				String code1=randomNumber.substring(0,4);
				String code2=randomNumber.substring(4,randomNumber.length());
				String agPassword=code1.concat(randomStr).concat(code2);
				
				
				String randomStr2=agFirstName.toLowerCase();  //get some random code for UserID.
				Integer randomNo2= new Integer(accNo);
				String randomNumber2=randomNo2.toString();
				String agID=randomStr2.concat(randomNumber2);
				
				/*Getting agent Nominee Values from beans	*/
				
				String nomFirstName=addAgentbeans.getNomFirstName();
				String nomRelationship=addAgentbeans.getNomRelationship(); //Getting Set Values from beans.
				String nomState=addAgentbeans.getNomState();
				String nomEmail=addAgentbeans.getNomEmail();
				String nomAddress=addAgentbeans.getNomAddress();
				long nomMobileNo=addAgentbeans.getNomMobileNo();
				int nomPinCode=addAgentbeans.getNomPinCode();
				String agPanNO=addAgentbeans.getAgPanNO();
				String nomCity=addAgentbeans.getNomCity();
				
					Date sysDateTime = new java.util.Date();
				    SimpleDateFormat stf =  new SimpleDateFormat("HH:mm:ss");		//Make simple time Format according to Sql Format.
				    SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");		//Make simple date Format according to Sql Format.
				    String time = stf.format(sysDateTime); 		//Pass the Date& Time object in Your Format.
				    String date= sdf.format(sysDateTime);
				    
				    Date validity = new java.util.Date();		//Agent Validity date.
				    validity.setDate(validity.getDate()+365);
				    SimpleDateFormat sdf2 =  new SimpleDateFormat("yyyy-MM-dd");
				    String validityDate= sdf2.format(validity);
				    
					String System_ip_address=Inet4Address.getLocalHost().getHostAddress(); 	//Get Account Created system IP Address.
	
					Statement stm=con.createStatement();
					String query2="select *from scheme_type where schemetype='"+agScheme+"'";	//get SchemeId from scheme Table to insert in agent Table.
					ResultSet res= stm.executeQuery(query2);
					if(res.next())
					{
						String schId=res.getString("schmemeid");  //get Scheme ID.
					
						String query="insert into agent_details(AgtFirstName,AgtLastName,AgtEmail,AgtDOB,AgtAddress,AgtState,AgtCity,AgtPINCode,AgtContactno,AgtGender,AgtPANno,AgtNomineeName,AgtRelationship,AgtNomContactno,AgtNomAdderss,AgtNomState,AgtNomCity,AgtNomPINCode,AgtNomEmail,AgtAccCreDate,AgtAccCreTime,AgtCreSys_IP,AgtPassword,AgtID,AgtPhoto,AgtIdProof,AgtPanPhoto,AgtChitPlan,AgtChitAvailable,AgtModeOfPayment,AgtSchemeId,AgtValidity) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
						pstm=con.prepareStatement(query);
						
						pstm.setString(1, agFirstName);		//assign.
						pstm.setString(2, agLastName);
						pstm.setString(3, agEmail);
						pstm.setDate(4, sqlDOB);
						pstm.setString(5, agAddress);
						pstm.setString(6, agState);
						pstm.setString(7, agCity);
						pstm.setInt(8, agPinCode);
						pstm.setLong(9, agMobileNo);
						pstm.setString(10, agGender);
						pstm.setString(11, agPanNO);
						pstm.setString(12, nomFirstName);
						pstm.setString(13, nomRelationship);
						pstm.setLong(14, nomMobileNo);
						pstm.setString(15, nomAddress);
						pstm.setString(16, nomState);
						pstm.setString(17,nomCity );
						pstm.setLong(18, nomPinCode);
						pstm.setString(19, nomEmail);
						pstm.setString(20,date);
						pstm.setString(21,time);
						pstm.setString(22,System_ip_address);
						pstm.setString(23,agPassword);
						pstm.setString(24, agID);
						pstm.setBlob(25, agImage);
						pstm.setBlob(26, agIdImage);
						pstm.setBlob(27, agPanImage);
						pstm.setInt(28, agScheme);
						pstm.setInt(29, agScheme);
						pstm.setString(30,agPaymode);
						pstm.setString(31,schId);
						pstm.setString(32,validityDate);
				
						status= pstm.executeUpdate(); //execute the query.
						
					}
					else
					{
						System.out.println("not available at this moment.."); //if any problem in Scheme Table.
						return 2;
					}
					
				if(status>0)	//send userI and Password to agent by mail.
				{
					status=sendEmail(emailBeans, agEmail, agFirstName, agID, agPassword); //call the send email method.
				}
		} 
		catch (Exception e) 
		{
			status=5;			//Exception.
			System.out.println(e.getMessage());
		} 
			finally
			{
				try
				{
					pstm.close();
				} 
				catch (SQLException e)
				{
					System.out.println(e.getMessage());
				}
			}
			return status;	//return.
	}
	
	private static int sendEmail(EmailBeans emailBeans,String agEmail, String agFirstName,String agID,String agPassword)
	{
		int mailstatus;
		try    //THIS BLOCK IS FOR SENDING EMAIL FOR AGENT CONTAINING USERNAME AND PASSWORD.
		{
			String host=emailBeans.getHost();    //Get the SMTP values through beans.
			String port=emailBeans.getPort();
			String adminUser=emailBeans.getAdminUser();
			String adminPass=emailBeans.getAdminPass();
			
			String recipient = agEmail;
			String subject = "WeRiseChit Verification";
			String content = "Hi "+agFirstName+",\n  \n	WelCome to Riseon ChitFunds, thanks for Choosing WeRise ChitFunds. \nPlease use your userID: " +agID+" \n Password: "+agPassword+" \n\nRegards, \nWeRiseChit Fund Team";  // Email Message.
		
			EmailUtility.sendEmail(host, port, adminUser, adminPass, recipient, subject, content); //Call the Static sendEmail method.
			System.out.println("The e-mail was sent successfully");
			mailstatus=1;

		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());	//exception while sending email.
			System.out.println("Sorry...! Email Not sent..");
			mailstatus=3;
		}
		return mailstatus;
	}
}
