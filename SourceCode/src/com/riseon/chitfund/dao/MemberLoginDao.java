package com.riseon.chitfund.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.riseon.chitfund.dto.AddMemberBeans;
import com.riseon.chitfund.services.ConnectionProvider;

public class MemberLoginDao 
{
public static String membfirstname=null;
	
	public int memberLoginValidate(AddMemberBeans bean)
	{
		Connection con=ConnectionProvider.getObj().getCon();  //make connection using services.
		String query="select membId,membfirstname from members_details where membId=?";
		int status=0;
	
		try 
		{
			PreparedStatement pstm=con.prepareStatement(query);
			
			String memberId=bean.getMemId();         //get the values from bean.
			pstm.setString(1, memberId);
		
			ResultSet rs=pstm.executeQuery();       //execute query.
			if(rs.next())
			{
				status=1;      //if valid Member.
				membfirstname= rs.getString("membfirstname");	//get adminName.
			}
			else
			{
				status=2;     //if values not valid Member.
			}
			
		}
		catch (SQLException e)
		{
			status=5;			//if any exception.
			System.out.println(e.getMessage());
		}
		 return status;     //return the status.
	}	
}
