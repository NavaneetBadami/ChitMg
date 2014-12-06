<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" 
import="java.lang.*,java.util.*,java.io.*,java.sql.*,java.sql.Statement,java.io.*,javax.servlet.RequestDispatcher.*,java.util.ArrayList"
import="com.riseon.chitfund.services.ConnectionProvider"
import="com.riseon.chitfund.dto.CreateChitGroupBean "
import="com.riseon.chitfund.supports.CommonDao"
%>

 <% 

		HttpSession ses=request.getSession(false);
		String agentId = (String)ses.getAttribute("agentId");
		if(agentId == null){
		response.sendRedirect("main-index.jsp");
		}
		String[] groupIdList=null; //String Array[].
		int i = 0;

		String sqlQuery="select *from group_details where agentid='"+agentId+"' AND grpStatus='VALID'"; //call the static totalMembers mtd() and get the ArrayList.
			ArrayList<CreateChitGroupBean> groupList=CommonDao.groupList(sqlQuery);  
					Iterator<CreateChitGroupBean> listIt=groupList.iterator();
					
					 groupIdList = new String[groupList.size()];	// String array[] with size of ArrayList.
						while(listIt.hasNext())
						{ 
							CreateChitGroupBean crtChitGroupBean=(CreateChitGroupBean)listIt.next(); //Downcasting.
							String  groupId=crtChitGroupBean.getGroupId();
							int totalAuctions=crtChitGroupBean.getTotalAuctions();
							int remainingAuctions=crtChitGroupBean.getRemainingAuctions();
							
			//				if(remainingAuctions>0)
			//				{
			//					System.out.println("Total Auction" + totalAuctions);
			///					System.out.println("remaning" + remainingAuctions);
			//					System.out.println("Groups in Ajax" + groupId);

			//					friendList[i] = groupId; // store mamber name into array.
			//					i++;

							groupIdList[i] = groupId; // store mamber name into array.
							i++;
					//		}
							
						}

			//jQuery related start		
				String query = (String)request.getParameter("q");
				
				int cnt=1;
				for(int j=0;j<groupIdList.length;j++)
				{
					if(groupIdList[j].toUpperCase().startsWith(query.toUpperCase()))
					{
						out.print(groupIdList[j]+"\n");
						if(cnt>=5)
							break;
						cnt++;
					}
				}
			//jQuery related end.
 %>