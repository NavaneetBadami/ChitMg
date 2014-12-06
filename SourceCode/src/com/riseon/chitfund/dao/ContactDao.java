/**
 * 
 */
package com.riseon.chitfund.dao;

import java.net.Inet4Address;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Date;
import com.riseon.chitfund.dto.ContactBeans;
import com.riseon.chitfund.services.ConnectionProvider;

public class ContactDao 
{
	Connection con=ConnectionProvider.getObj().getCon();   //Make a connection using Services.
	PreparedStatement  pstm=null;
	
	public int contactVal(ContactBeans contBean)
	{
		String sql="insert into contact(Name,Email,Contact,city,message,contactedDate,contactedTime,contactedIP_add) values(?,?,?,?,?,?,?,?)";
		int status=0;
		try
		{
			pstm=con.prepareStatement(sql);
			
			String name=contBean.getName();   //get the values from bean.
			String email=contBean.getEmail();
			long mobile=contBean.getMobile();
			String city=contBean.getCity();
			String message=contBean.getMessage();
			
			
			Date sysDateTime = new java.util.Date();
		    SimpleDateFormat stf =  new SimpleDateFormat("HH:mm:ss");		//Make simple time Format according to Sql Format.
		    SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");		//Make simple date Format according to Sql Format.
		    String time = stf.format(sysDateTime); 		//Pass the Date& Time object in Your Format.
		    String date= sdf.format(sysDateTime);
		    
			String System_ip_address=Inet4Address.getLocalHost().getHostAddress(); //Get Account Created system IP Address.
			
			pstm.setString(1, name);    //assign.
			pstm.setString(2, email);
			pstm.setLong(3, mobile);
			pstm.setString(4, city);
			pstm.setString(5, message);
			pstm.setString(6, date);
			pstm.setString(7, time);
			pstm.setString(8, System_ip_address);
			
			status=pstm.executeUpdate();   //execute the query.
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());  //any exception.
			status=5;
		}
		return status;   //return the status.
	}

}
