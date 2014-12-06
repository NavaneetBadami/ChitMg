package com.riseon.chitfund.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.riseon.chitfund.dto.AddMemberBeans;
import com.riseon.chitfund.services.ConnectionProvider;

public class GroupDetailsDao 
{
	public ArrayList<AddMemberBeans>groupDetails(AddMemberBeans grpMemBeans)
	{
		Connection con= ConnectionProvider.getObj().getCon(); 
		PreparedStatement pstm=null;
		ArrayList<AddMemberBeans> grpDetailsList=new ArrayList<AddMemberBeans>();
		String query="select *from members_details where groupId=?";
		try 
		{
			pstm=con.prepareStatement(query);
			
			String groupId=grpMemBeans.getGroupId();	//get the groupId.
			
			pstm.setString(1,groupId);
			ResultSet res= pstm.executeQuery();
			
			while(res.next())
			{
				AddMemberBeans grpMemDetail= new AddMemberBeans();
				
				grpMemDetail.setMemFirstName(res.getString("membfirstname"));
				grpMemDetail.setMemLastName(res.getString("memblastname"));
				grpMemDetail.setMemId(res.getString("membId"));
				grpMemDetail.setGroupId(res.getString("groupid"));
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
				
				grpDetailsList.add(grpMemDetail);
				
			}
			
		} 
		catch (SQLException e)
		{
			System.out.println(e.getMessage());
			grpDetailsList.add(grpMemBeans);
		}
		
		return grpDetailsList;
	}
}
