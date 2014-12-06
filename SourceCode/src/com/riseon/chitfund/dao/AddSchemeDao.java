package com.riseon.chitfund.dao;

import java.math.BigInteger;
import java.net.Inet4Address;
import java.net.UnknownHostException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import com.riseon.chitfund.dto.AddSchemeBean;
import com.riseon.chitfund.services.ConnectionProvider;

public class AddSchemeDao 
{
	public int storeScheme(AddSchemeBean SchemeBean)
	{
		int status=0;
		try 
		{
			Connection con=ConnectionProvider.getObj().getCon(); //Making Connection from service.ConnectionProvider.
			String query="insert into scheme_type(admid,schmemeid,schemetype,amount,validity,schemeStatus,schCredate,schCreTime,schCre_SysIp)values(?,?,?,?,?,?,?,?,?)";
			PreparedStatement pstm=null;
			
			pstm=con.prepareStatement(query);
			String adminId=SchemeBean.getAdminId();
			
			int schType=SchemeBean.getSchemeType();     //get the values from beans.
			double schPrice=SchemeBean.getSchemePrice();
			double schValidity=SchemeBean.getSchemeValidity();
			
				String id="RCF_";
			  	String schId=id.concat(randomId());
			  
			  	Date sysDateTime = new java.util.Date();
			    SimpleDateFormat stf =  new SimpleDateFormat("HH:mm:ss");		//Make simple time Format according to Sql Format.
			    SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");		//Make simple date Format according to Sql Format.
			    String time = stf.format(sysDateTime); 		//Pass the Date& Time object in Your Format.
			    String date= sdf.format(sysDateTime);
			    
				String System_ip_address=Inet4Address.getLocalHost().getHostAddress(); //Get Account Created system IP Address.
			  	
			pstm.setString(1, adminId);	  //set the values.
			pstm.setString(2, schId);
			pstm.setInt(3, schType);
			pstm.setDouble(4, schPrice);
			pstm.setDouble(5, schValidity);
			pstm.setString(6, "VISIBLE");
			pstm.setString(7, date);
			pstm.setString(8, time);
			pstm.setString(9, System_ip_address);
			
			status=pstm.executeUpdate();  //execute the query.
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			status=5;
		}
		return status;
	}
		
	  public static String randomId()   //mtd to create random alphanumeric.
	  {
		  SecureRandom random = new SecureRandom();
		  return new BigInteger(32, random).toString(32);
	  }
}
