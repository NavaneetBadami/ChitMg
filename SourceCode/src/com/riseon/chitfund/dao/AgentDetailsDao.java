package com.riseon.chitfund.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.riseon.chitfund.dto.AddAgentBean;
import com.riseon.chitfund.dto.ViewAgentsBeans;
import com.riseon.chitfund.services.ConnectionProvider;

public class AgentDetailsDao
{
	public  ArrayList<ViewAgentsBeans> agentDetails(ViewAgentsBeans viewAgentsBeans)
	{
		Connection con=ConnectionProvider.getObj().getCon(); //Making Connection from service.ConnectionProvider.
		String query="select *from agent_details where AgtFirstName=? AND AgtID=?";
		PreparedStatement pstm= null;
		
		String agFirstName=viewAgentsBeans.getAgFirstName();  //get the FName,Id.
		String agID=viewAgentsBeans.getAgId();
		
		ArrayList<ViewAgentsBeans> detailsList= new ArrayList<ViewAgentsBeans>();
		try 
		{
			pstm=con.prepareStatement(query);
			pstm.setString(1,agFirstName);
			pstm.setString(2,agID);
			
			ResultSet res=pstm.executeQuery();
			while(res.next())
			{
				System.out.println("in dao..." + res.getString("AgtFirstName"));
				ViewAgentsBeans agentBeans= new ViewAgentsBeans(); 	//Create a beans object.
				
				agentBeans.setAgFirstName(res.getString("AgtFirstName"));  //get the values from DB assign it to beans.
				agentBeans.setAgLastName(res.getString("AgtLastName"));
				agentBeans.setAgId(res.getString("AgtID"));
				agentBeans.setAgEmail(res.getString("AgtEmail"));
				
					java.sql.Date sqlDate=res.getDate("AgtDOB");  //converting SQl Date To String.
					java.util.Date udd=(Date)sqlDate;
					SimpleDateFormat sdf= new SimpleDateFormat("dd-MMM-yyyy");
					String dob=sdf.format(udd);
		
				agentBeans.setAgDob(dob);
				agentBeans.setAgAddress(res.getString("AgtAddress"));
				agentBeans.setAgState(res.getString("AgtState"));
				agentBeans.setAgCity(res.getString("AgtCity"));
				agentBeans.setAgPinCode(res.getInt("AgtPINCode"));
				agentBeans.setAgMobileNo(res.getLong("AgtContactno"));
				agentBeans.setAgGender(res.getString("AgtGender"));
				agentBeans.setNomFirstName(res.getString("AgtNomineeName"));
				agentBeans.setNomRelationship(res.getString("AgtRelationship"));
				agentBeans.setNomMobileNo(res.getLong("AgtNomContactno"));
				agentBeans.setNomAddress(res.getString("AgtNomAdderss"));
				agentBeans.setNomState(res.getString("AgtNomState"));
				agentBeans.setNomCity(res.getString("AgtNomCity"));
				agentBeans.setNomPinCode(res.getInt("AgtNomPINCode"));
				agentBeans.setNomEmail(res.getString("AgtNomEmail"));
				agentBeans.setAgPanNO(res.getString("AgtPANno"));
				agentBeans.setNomPinCode(res.getInt("AgtNomPINCode"));
				agentBeans.setAgtChatPlan(res.getString("AgtChitPlan"));
				
				detailsList.add(agentBeans); //pass beans to array list...
			}
		} 
		catch (SQLException e) 
		{
			
			System.out.println(e.getMessage());
		}
		
		return detailsList;
	}
}
