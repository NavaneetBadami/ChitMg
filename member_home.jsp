<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
import="java.lang.*,java.util.*,java.io.*,java.sql.*,java.sql.Statement,java.io.*,javax.servlet.RequestDispatcher.*,java.util.ArrayList"
import="com.riseon.chitfund.supports.CommonDao" 
import="com.riseon.chitfund.controller.MemberLoginController"
import="com.riseon.chitfund.dto.AddMemberBeans"
import="com.riseon.chitfund.dto.AuctionHistoryBeans"
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
      <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
   <title>WeRise Chits||Agent Panel</title>
	 <link rel="icon" href="images/Fevicon.ico">

	<!-- BOOTSTRAP STYLES-->
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
	<link href="css/Main_chitFund.css" rel="stylesheet" />

     <!-- FONTAWESOME STYLES-->
    <link href="css/font-awesome.css" rel="stylesheet" />

     <!-- MORRIS CHART STYLES-->
    <link href="css/morris-0.4.3.min.css" rel="stylesheet" />

        <!-- CUSTOM STYLES-->
    <link href="css/custom.css" rel="stylesheet" />

<style>
	.input-medium 
		{
		height:25px !important;
		border-color: solid black;
		}

</style>
   <style>
	#nnavbar{position:absolute; right: 0px}
	</style>
</head>
<body>

<%
	
	HttpSession ses=request.getSession(false);
	String memberId = (String)ses.getAttribute("memberId");
	if(memberId == null)
	{
	response.sendRedirect("main-index.jsp");
	} 
	String mamberName=MemberLoginController.memberFname.get(memberId);	//map(k,v)

	String valid=(String)request.getAttribute("valid");
	if(valid!=null && valid.equalsIgnoreCase("valid"))
	{
		response.sendRedirect("member_home.jsp");	//just redirecting.
	}
	
		String memFirstName=null;
		String memLastName=null;
		String memId=null;
		String memAddress=null;
		long memMobileNo=0;
		String memGender=null;
		int memPinCode=0;
		String memPanNo=null;
		String memSurety=null;
		String nomName=null;
		String nomRelation=null;
		String nomAddress=null;
		int nomPincode=0;
		long nomMobileno=0;
		String bidSatus=null;
		String agentId=null;
		String groupId=null;


		String query="select *from members_details where membId='"+memberId+"'";	//login member details.
		ArrayList<AddMemberBeans> lst=CommonDao.groupDetails(query);    //Call the Static Method.
		ListIterator<AddMemberBeans> listed=lst.listIterator();  //Iterate the LIST.

		while(listed.hasNext())
		{
			AddMemberBeans grpMember=listed.next(); 
			
			agentId=grpMember.getAgentId();
			groupId=grpMember.getGroupId();
			memFirstName=grpMember.getMemFirstName();
			memLastName=grpMember.getMemLastName();
			memId=grpMember.getMemId();
			memAddress=grpMember.getMemAddress();
			memMobileNo=grpMember.getMemMobileNo();
			memGender=grpMember.getMemGender();
			memPinCode=grpMember.getMemPinCode();
			memPanNo=grpMember.getMemPanNO();
			memSurety=grpMember.getMemSuretyType();
			nomName=grpMember.getMemNomFName();
			nomRelation=grpMember.getMemNomRelationship();
			nomAddress=grpMember.getMemNomAddress();
			nomPincode=grpMember.getMemNomPinCode();
			nomMobileno=grpMember.getMemMobileNo();
			bidSatus=grpMember.getMembidden();

			%>
		<%}
%>

  <div class="navbar navbar-static-top">   <!--Top nav Bar -->
    <div class="navbar-inner">
		<ul class="nav navbar-nav navbar-right">
			<li><a href="agent_home.jsp" title="HOME" class="tip"><IMG SRC="images/Logo2.jpg" width=150/></a></h1></li>
		</ul>
		<div id="nnavbar"  role="navigation"> <!-- elements on right side 20-10-2014 -->
          <ul class="nav navbar-nav navbar-left ">
                <li><a href="about.jsp">About Us</a></li>
                <li><a href="#">Join US</a></li>
                <li><a href="features.jsp">Features</a></li>
                <li><a href="enquiry.jsp">Enquiry</a></li>
				<li><a href="member_home.jsp" title="DashBoard" class="tip"><%=mamberName%></a></li>

				<li class="dropdown"><!-- Elements on settings -->
							<a href="#" class="dropdown-toggle tip" data-toggle="dropdown" title="Settings"><i class="fa fa-caret-down fa-2x"></i></a>
							<ul class="dropdown-menu pull-right">
								<li><a href="logout.jsp">Logout</a></li>
					 </li><!-- elements li -->
          </ul>
        </div>
      </div>
	 </div>
					


 <div class="row"> <!-- Main row  LeftSide Content, RightSide Content-->
 		<div class="row alert">
        	<div class="span6">
            	<div class="span4">
                	<h4>WELCOME <%=mamberName%></h4>
                </div>
            </div>
            <div class="span10">
                <div class="span4">
               		 <h5>Group ID: <%=groupId%></h5>
                </div>
                <div class="span4">
	    			 <h5 align="right">AgentID:<%=agentId%></h5>
                </div> 
        	</div>
		</div>	

													<!-- LeftSide Content -->	


           <div class="span11"> <!-- Span11 mamberInfo ,NomineeInfo, AuctionInfo whole leftside -->
				
					<div class="span12">	<!-- Span 12 mamberInfo ,NomineeInfo -->
							<div  class="span5">
								<h5 class="alert alert-success">Member Information</h5>
								<table class="table table-striped table-bordered">
								<tr>
										<th>Group ID</th>
										<td><%=groupId%></td>
									</tr>
									<tr>
										<th>Member ID</th>
										<td><%=memId%></td>
									</tr>
									<tr>
										<th>First Name:</th>
										<td><%=memFirstName%></td>
									<tr>
										<th>Lastname:</th>
										<td><%=memLastName%></td>
									</tr>
									<tr>
										<th>MobileNo:</th>
										<td><%=memMobileNo%></td>
									</tr>
									<tr>
										<th>Gender:</th>
										<td><%=memGender%></td>
									</tr>
									<tr>
										<th>Pan Card No:</th>
										<td><%=memPanNo%></td>
									<tr>
										<th>Surety:</th>
										<td><%=memSurety%></td>
									</tr>	
								</table>
							</div>

							<div class="span5">		
								<h5 class="alert alert-success">Nominee Information</h5>
									<table class="table table-hover table-bordered">
										<tr class="info">
											<th>Nominee Name:</th>
											<td><%=nomName%></td>
										</tr>
										<tr class="info">
											<th>Relationship:</th>
											<td><%=nomRelation%></td>
										<tr class="info">
											<th>Mobile No</th>
											<td><%=nomMobileno%></td>
										</tr>
										<tr class="info">
											<th>Address</th>
											<td><%=nomAddress%></td>
										<tr class="info">
											<th>Pin Code</th>
											<td><%=nomPincode%></td>
										</tr>
									</table>
                                    		<div class=" panel-default text-center no-boder bg-color-green">
														<div class="panel-body">
															<i class="fa fa-gavel fa-2x"></i>
															<h4><%=memFirstName%></h4>
														</div>
													</div>
								</div>
							</div>	<!-- End Span12 mamberInfo ,NomineeInfo -->
							
				<div class="span11"> <!--Span11 Auction info inside Span11 whole leftside.-->
					<h5 class="alert alert-success">Auction Information</h5>
					<%
						String query3="select *from auction_details where memGrpId='"+groupId+"'";		//auction details.

				    	ArrayList<AuctionHistoryBeans> auctionlist=CommonDao.auctionHistory(query3);	
				    	Iterator<AuctionHistoryBeans> autctionIt= auctionlist.iterator();
				    	while(autctionIt.hasNext())
				    	{
				    		AuctionHistoryBeans bean=autctionIt.next();
				    		
				    		String auctionID=bean.getAuctionId();
							String groupName=bean.getMemGrpName();
				    		String groupID=bean.getMemGrpId();
				    		String agentID=bean.getMemAgtId();
				    		double chitAmount=bean.getChitAmt();
				    		int totalMembers=bean.getTotalmembers();
				    		String memName=bean.getMemName();
				    		String memID=bean.getMemId();
							double memBidPer=bean.getMemBidPer();
				    		double bidAmt=bean.getBidAmt();
				    		double bidMemAmt=bean.getBidMemAmt();
				    		double agentPer=bean.getAgentPer();
				    		double agentAmt=bean.getAgentAmt();
				    		double remaningAmt=bean.getRemaningAmt();
				    		double monthlypremium=bean.getMonthlypremium();
							double premiumReduced=bean.getPremiumReduced();
							double premiumPaid=bean.getPremiumPaid();
				    		String bidTime=bean.getBidTime();
				    		String bidDate=bean.getBidDate();
				    		
						%>
						
							<div class="accordion" id="accordion">  <!-- Collaps Trigger option. -->
										<div class="accordion-group">
											<div class="accordion-heading alert-error">                   
												<center>
												<button type="button" class="btn btn-info" data-toggle="collapse" data-target="#<%=auctionID%>">
												<%=bidDate%>
												</button>
												</center>
											</div>

										<div id=<%=auctionID%> class="accordion-body collapse"> <!-- main onclick whole down fire -->
										<div class="accordion-inner">
												<div class="row">		<!-- main row -->
                                                    <div class="span12">		<!-- Span12 -->
															<div class="span3">
																		<div class="well">
                                                                        	<table class="table table-bordered table-hover ">
                                                                            <caption><font color="#006600" size="+1" face="Verdana, Geneva, sans-serif">Bidden Details</font></caption>
                                                                            <tr>
                                                                            	<td>Bidden Date</td>
                                                                                <td><%=bidDate%></td>
                                                                            </tr>
                                                                            <tr>
                                                                            	<td>Bidden Time</td>
                                                                                <td><%=bidTime%></td>
                                                                            </tr>
                                                                            <tr>
                                                                            	<td >Total Chit Amount</td>
                                                                                <td><%=chitAmount%></td>
                                                                            </tr>
                                                                            <tr>
                                                                            	<td>Total Members</td>
                                                                                <td><%=totalMembers%></td>
                                                                            </tr>
																			<tr>
                                                                            	<td>Monthly Premium</td>
                                                                                <td><%=monthlypremium%></td>
                                                                            </tr>
                                                                            </table>
																		</div>				
															</div><!-- end of span3 -->
                                                            <div class="span4">
																		<div class="well">
																		<table class="table table-bordered">
                                                                            <caption><font color="#006600" size="+1" face="Verdana, Geneva, sans-serif">Member Details</font></caption>
                                                                            <tr>
                                                                            	<td>Member Name</td>
                                                                                <td><%=memName%></td>
                                                                            </tr>
                                                                            <tr>
                                                                            	<td>Member ID</td>
                                                                                <td><%=memID%></td>
                                                                            </tr>
																			 <tr>
                                                                            	<td>Member Bid%</td>
                                                                                <td><%=memBidPer%></td>
                                                                            </tr>
                                                                            <tr>
                                                                            	<td>Member Amount</td>
                                                                                <td><%=bidMemAmt%></td>
                                                                            </tr>
                                                                            </table>
																		</div>				
															</div><!-- end of span3 -->
                                                            <div class="span3">
																		<div class="well">
																		<table class="table table-bordered">
                                                                            <caption><font color="#006600" size="+1" face="Verdana, Geneva, sans-serif">Balance Details</font></caption>
                                                                            <tr>
                                                                            	<td>Agent%</td>
                                                                                <td><%=agentPer%></td>
                                                                            </tr>
                                                                             <tr>
                                                                            	<td>Agent Amount</td>
                                                                                <td><%=agentAmt%></td>
                                                                            </tr>
                                                                            <tr>
                                                                            	<td>Remaining Balance</td>
                                                                                <td><%=remaningAmt%></td>
                                                                            </tr>
																			 <tr>
                                                                            	<td>Premium Reduced</td>
                                                                                <td><%=premiumReduced%></td>
                                                                            </tr>
																			<tr>
                                                                            	<td>Mamber Paid</td>
                                                                                <td><%=premiumPaid%></td>
                                                                            </tr>
                                                                            </table>
																		</div>				
															</div><!-- end of span3 -->
															
											</div><!--end  Span12 -->
                                            </div><!--  end row -->
                                          </div> <!--  accordion-inner" -->
                                         </div><!-- end main onclick whole down fire -->     
										
                                        </div> <!--  accordion-group" -->
									</div>		<!-- End Of Whole Collaps Trigger option. -->
				    <%}	//end of while.
				%>

			</div><!--end of Span11 Auction info inside left whole -->			
       </div> <!-- end of Span11 mamberInfo ,NomineeInfo, AuctionInfo whole leftside-->


						
													<!-- RightSide Content -->


		<div class="span5"><!-- span5 Bidinfo,currLoc,MembersList whole right side. -->

				<div class="span5">	<!-- span5 BidInfo	 -->
								<h5 class="alert alert-success">Bid Information</h5>
									<table class="table table-hover table-bordered">
										<tr class="info">
										<th>Biddden Status:</th>
										<td><%=bidSatus%></td>
									</tr>
									</table>
				</div>	<!-- end span5 BidInfo	 -->

				<div class="span5"><!-- span5 CurrLoc-->
				<h5 class="alert alert-success">&nbsp;Current Location.</h5>
								<address>
									<strong><%=memFirstName%>&nbsp;<%=memFirstName%></strong><br>
									<p><i class="icon icon-map-marker"></i>&nbsp;<%=memAddress%><BR>
										&nbsp;-<%=memPinCode%>
									</p>
									<h5>Mobile:</abbr> <a href="tel:<%=memMobileNo%>"><%=memMobileNo%></a>
								</address>
								<hr>
				</div><!-- end span5 CurrLoc-->

				<div class="span5"><!-- span5 MemList-->
					<h4 class="alert alert-success">Members in Group</h4>	
					<% 
						 String query2="select *from members_details where groupId='"+groupId+"'";	//member details of whole group.

						 ArrayList<AddMemberBeans> arrylst=CommonDao.groupDetails(query2);	//Call the Static Method.
						 ListIterator<AddMemberBeans> listIt=arrylst.listIterator();  //Iterate the LIST.
						 
						 while(listIt.hasNext())
						{
								AddMemberBeans grpMember=listIt.next(); //DownCast the list to Bean.
								
								String memberName=grpMember.getMemFirstName();
								String memberLName=grpMember.getMemLastName();
								String memberID=grpMember.getMemId();
								String memberAddress=grpMember.getMemAddress();
								long memberMobileNo=grpMember.getMemMobileNo();
								String memberGender=grpMember.getMemGender();
								int memberPinCode=grpMember.getMemPinCode();
								String memberPanNo=grpMember.getMemPanNO();
								String memberSurety=grpMember.getMemSuretyType();
								String membernomName=grpMember.getMemNomFName();
								String membernomRelation=grpMember.getMemNomRelationship();
								String membernomAddress=grpMember.getMemNomAddress();
								int membernomPincode=grpMember.getMemNomPinCode();
								long membernomMobileno=grpMember.getMemMobileNo();
								String memberBidSatus=grpMember.getMembidden();
								
							%>
				
				
				<ul class="alert-error"><li><a href="#<%=memberID%>" class="tip" title="Click to View Details" data-toggle="modal"><%=memberName%></a>&nbsp;(<%=memberID%>)</li></ul>
				<div id="<%=memberID%>" class="modalChit hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-header alert-block">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><b id="x">X</b></button>
						<h4 id="myModalLabel"><%=memberName%>&nbsp;Member Details.</h4>
					</div>

					<div class="modal-body ">	<!-- MOdel Body  -->
			
					<div class="span12">
							<div  class="span5">
								<h5 class="alert alert-error">Member Information</h5>
								<table class="table table-hover">
									<tr>
										<th>Member ID</th>
										<td><%=memberID%></td>
									</tr>
									<tr>
										<th>First Name:</th>
										<td><%=memberName%></td>
									<tr>
										<th>Lastname:</th>
										<td><%=memberLName%></td>
									</tr>
									<tr>
										<th>MobileNo:</th>
										<td><%=memberMobileNo%></td>
									</tr>
									<tr>
										<th>Gender:</th>
										<td><%=memberGender%></td>
									</tr>
									<tr>
										<th>Pan Card No:</th>
										<td><%=memberPanNo%></td>
									<tr>
										<th>Surety:</th>
										<td><%=memberSurety%></td>
									</tr>
									<tr>
										<th>Bid Status:</th>
										<td><%=memberBidSatus%></td>
									</tr>
								</table>
							</div>

							<div  class="span5">			
							<h5 class="alert alert-error">&nbsp;Current Location.</h5>
							<hr/>
								<address>
									<strong><%=memberName%>&nbsp;<%=memberName%></strong><br>
									<p><i class="icon icon-map-marker"></i>&nbsp;<%=memberAddress%><BR>
										&nbsp;-<%=memberPinCode%>
									</p><br>
									<h5>Mobile:</abbr> <a href="tel:<%=memberMobileNo%>"><%=memberMobileNo%></a>
								</address>
							</div>

								<div class="span5">		
								<h5 class="alert alert-error">Nominee Information</h5>
									<table class="table table-hover table-bordered">
										<tr class="info">
											<th>Nominee Name:</th>
											<td><%=membernomName%></td>
										</tr>
										<tr class="info">
											<th>Relationship:</th>
											<td><%=membernomRelation%></td>
										<tr class="info">
											<th>Mobile No</th>
											<td><%=membernomMobileno%></td>
										</tr>
										<tr class="info">
											<th>Address</th>
											<td><%=membernomAddress%></td>
										<tr class="info">
											<th>Pin Code</th>
											<td><%=membernomPincode%></td>
										</tr>
									</table>
								</div>

							</div>
							</div> <!-- End Of modal body -->

								<div class="modal-footer">
									<button type="reset" class="btn btn-medium btn-error" data-dismiss="modal">Close</button>
								</div>
			</div><!-- End Of Display modal -->		
						
			<%}		//End of while.
		 %>       
		</div><!-- span5 end MemList-->
	</div><!--end of span5 Bidinfo,currLoc,MembersList whole right side. -->
		


</div><!-- end Main row LeftSide Content, RightSide Content-->
      
         
		

    <script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="./js/script.js"></script>	
	<script src="js/jquery.nicescroll.min.js" type="text/javascript"></script>

	 <script>						
			//scroll bar custom
				jQuery(document).ready(
			  function() {  
				jQuery("html").niceScroll({cursorcolor:"#1f3f3f"});
			  }
			);
		</script>
	<script>						
		//#nwrapper scroll bar custom
		jQuery(document).ready(function(){jQuery("#page-wrapper").niceScroll({cursorcolor:"#3366FF"});});
	</script>
	
	<script src="js/jquery.metisMenu.js"></script>
	<script src="js/custom.js"></script>
   
    <!-- METISMENU SCRIPTS -->
    <!-- <!-- <script src="assets/js/jquery.metisMenu.js"></script>
     <!-- MORRIS CHART SCRIPTS
     <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
    <script src="assets/js/morris/morris.js"></script> -->
 
</body>
</html>
