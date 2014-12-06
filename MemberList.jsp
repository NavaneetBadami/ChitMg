<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" 
import="java.lang.*,java.util.*,java.io.*,java.sql.*,java.sql.Statement,java.io.*,javax.servlet.RequestDispatcher.*,java.util.ArrayList"
import="com.riseon.chitfund.services.ConnectionProvider"
import="com.riseon.chitfund.dto.AddMemberBeans"
import="com.riseon.chitfund.supports.CommonDao"
%>

 <% 

		HttpSession ses=request.getSession(false);
		String agentId = (String)ses.getAttribute("agentId");
		if(agentId == null)
			{
				response.sendRedirect("main-index.jsp");
			}
		String[] memberList=null; //String Array[].
		int i = 0;

		String sqlQuery="select *from members_details where agentId='"+agentId+"'"; //call the static totalMembers mtd() and get the ArrayList.
			ArrayList<AddMemberBeans> memList=CommonDao.groupDetails(sqlQuery);  
					Iterator<AddMemberBeans> listIt=memList.iterator();
					
						memberList = new String[memList.size()];	// String array[] with size of ArrayList.

						while(listIt.hasNext())
						{ 
							AddMemberBeans memBean=listIt.next(); 
							String memberId=memBean.getMemId();
							
							memberList[i] = memberId; // store mamber name into array.
							i++;
						}

			//jQuery related start		
				String query = (String)request.getParameter("q");
				
				int cnt=1;
				for(int j=0;j<memberList.length;j++)
				{
					if(memberList[j].toUpperCase().startsWith(query.toUpperCase()))
					{
						out.print(memberList[j]+"\n");
						if(cnt>=5)
							break;
						cnt++;
					}
				}
			//jQuery related end.
 %>