package com.riseon.chitfund.supports;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

import com.riseon.chitfund.services.ConnectionProvider;

public class demo
{
	public static void main(String[] args) 
	{
		//		String st="hello guys";
		//		char ch=st.charAt(0);
		//	
		//		Character a1=ch;
		//		
		//		Character firstleter= Character.toUpperCase(a1);
		//		
		//		String nn= st.substring(1, st.length());
		//		
		//		String firstleterCp=firstleter.toString();
		//		
		//		System.out.println(firstleterCp.concat(nn));
		//		

		//		String s1=new String("Navaneet");
		//		String s2=new String("Navaneet");

		//		int s1=2;
		//		int s2=3;
		//		
		//		System.out.println();

		//		if(s1.equalsIgnoreCase(s2))
		//		{
		//			System.out.println("Same");
		//		}
		//		else
		//		{
		//			System.out.println("not");
		//		}


		/*Connection con=ConnectionProvider.getObj().getCon();	//make a connection.
		try 
		{
			String query1="select membidden from chitfund.members_details where membId=? AND agtentid=? AND groupid=?";	//query to check the bid status of member. 
			PreparedStatement pstm1=con.prepareStatement(query1);
			pstm1.setString(1, "navaneet35550476");
			pstm1.setString(2, "psm");
			pstm1.setString(3, "RCF_32ohe3b_GRP");
			ResultSet res1=pstm1.executeQuery();

			if(res1.next())			//check member is valid or not.
			{
				String bidStatus=res1.getString("membidden");
				if(bidStatus!=null && bidStatus.equalsIgnoreCase("YES"))	//if member is already bidden.
				{
					System.out.println("member has already bidden..!");
				}
				else if(bidStatus!=null && bidStatus.equalsIgnoreCase("NO"))	//if not, the process for auction.
				{
					String query="select *from chitfund.group_details where agentid=? and groupid=?";	//get the group details.
					PreparedStatement pstm=con.prepareStatement(query);
					pstm.setString(1, "navaneet59145657");
					pstm.setString(2, "RCF_13h62j8_GRP");
					ResultSet res=pstm.executeQuery();
					if(res.next())		//validate group.
					{
						int totalChitAmount=res.getInt("chitamount");		//get the chitAmount.
						int members=res.getInt("TotalmemberSlots");			//total members.


						System.out.println("Available Amount: "+ totalChitAmount);
						System.out.println("total Members in Group: "+ members);

						Scanner sc= new Scanner(System.in);
						System.out.println("Enter the Bid Amount:");		//get the bid% from user.
						int bid=sc.nextInt();
						sc.close();
						int bidAmount=(totalChitAmount*bid)/(100);			//total bid amount(remaining amount).
						System.out.println("Bid Amount: "+ bidAmount);
						
						int premRed=totalChitAmount-bidAmount;				//total amount which bid member get after didection. 
						System.out.println("Premimun Reuced: "+ premRed);


						System.out.println("*********Balance Details******");
						System.out.println("Remaining Amount: " + bidAmount);

						int ageCom=(bidAmount*5)/(100);						//agent commission.
						System.out.println("Agent Commession: " + ageCom);

						int indAmt=(bidAmount-ageCom)/(members-1);			//total amount member get after auction from remaining.
						System.out.println("Indiduval Amount: " + indAmt);
					}
					else
					{
						System.out.println("Group not found.");
					}
				}

			}
			else	//if not a valid member.
			{
				System.out.println("member Not Found");
			}

		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
		}	*/
				
				//  DATE METHODS.
		Date totalDate = new Date() ;
		totalDate.setDate(totalDate.getDate() + 365) ;
		System.out.println(totalDate);
		System.out.println(totalDate.getDay());
		System.out.println(totalDate.getHours());
		System.out.println(totalDate.getMinutes());
		
		Date sysDateTime = new java.util.Date();
	    SimpleDateFormat stf =  new SimpleDateFormat("HH:mm:ss");		//Make simple time Format according to Sql Format.
	    SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");		//Make simple date Format according to Sql Format.
	    String time = stf.format(sysDateTime); 		//Pass the Date& Time object in Your Format.
	    String date= sdf.format(sysDateTime);
		
	    Date validityDate = new java.util.Date();
	    validityDate.setDate(validityDate.getDate()+365);
	    SimpleDateFormat sdf2 =  new SimpleDateFormat("yyyy-MM-dd");
	    String date2= sdf2.format(validityDate);
		
		System.out.println("Current Date: "+date+" after One year: "+ date2 );
		
		System.out.println(totalDate.equals(validityDate));
		if(totalDate.equals(validityDate))
		{
			System.out.println("Validity Finish");
		}
		else
		{
			System.out.println("Still in Valid Period");
		}
		
		System.out.println(totalDate.after(validityDate));
		if(totalDate.after(validityDate))
		{
			System.out.println("Validity Finish");
		}
		else
		{
			System.out.println("Still in Valid Period");
		}
	}	
}
