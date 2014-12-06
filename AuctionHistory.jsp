<%@page import="com.riseon.chitfund.dto.AuctionHistoryBeans"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" 
import="java.lang.*,java.util.*,java.io.*,java.sql.*,java.sql.Statement,java.io.*,javax.servlet.RequestDispatcher.*,java.util.ArrayList"
import="com.riseon.chitfund.services.ConnectionProvider"
import="com.riseon.chitfund.controller.AgentLoginController"
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
      <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
   <title>WeRise Chits</title>
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
	<link rel="stylesheet" type="text/css" href="css/forward.css" />

	<link rel="stylesheet" type="text/css" href="./css/autoComplete.css" /> 
	<script type="text/javascript" src="js/jquery-1.4.2.min.js"> </script>  <!-- Conflit of two queries jq-1.10 and jq 1.4  08-08-2014-->
	<script type='text/javascript'>
		 var $auotComplete = jQuery.noConflict(); 
		 jQuery( document ).ready( 
		 function($auotComplete){ 
				 $auotComplete("#groupsId").autocomplete("GroupsList.jsp");  //auto complete list.
			 });
	</script>  
	<script src="js/jquery.autocomplete.js"> </script>
     
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
	String agentId = (String)ses.getAttribute("agentId");
	if(agentId == null)
	{
		response.sendRedirect("main-index.jsp");
	}	

	String agentName=AgentLoginController.agentName.get(agentId);	//map(k,v)
%>

<%
	String historyStatus=null;
	historyStatus=(String)request.getAttribute("historyStatus");		//from AuctionHistoryController
	if(historyStatus!=null && historyStatus.equals("noAuctionYet"))
    {%>
    		
    			  <div class="modal">
								<a href="AuctionHistory.jsp" class="close" data-dismiss="modal"><b id="x">X&nbsp;</b></a>
								<div class="modal-header alert-error">
									<h4>Sorry...!No Auction History Available.</h4>
								</div>
													
						</div><!-- Endo of Modal -->
						<div class="modal-backdrop fade in"></div>
    <%}
%> 
<%
	String auctionStatus=null;
	auctionStatus=(String)request.getAttribute("auctionStatus");		//from AuctionHistoryController
	if(auctionStatus!=null && auctionStatus.equals("Success"))
    {%>
    		
    					 <div class="modal">
								<a href="AuctionHistory.jsp" class="close" data-dismiss="modal"><b id="x">X&nbsp;</b></a>
								<div class="modal-header ">
									<h4>Congrats, process has been successfully completed</h4>
								</div>
								<div class="modal-body  alert alert-success">
									<h5>Hello,<br><p>One Auction process has completed, you can view regarding auction details in Auctio History tab.</p><br>Thanks.</h5>
								</div>						
						</div><!-- Endo of chitFundModal -->
						<div class="modal-backdrop fade in"></div>
    <%}
%> 
  <div class="navbar navbar-static-top">   <!--Top nav Bar -->
    <div class="navbar-inner">
		<ul class="nav navbar-nav navbar-right">
			<li><a href="agent_home.jsp" title="HOME" class="tip"><IMG SRC="images/Logo2.jpg" width=150/></a></h1></li>
		</ul>
		<div id="nnavbar"  role="navigation"> <!-- elements on right side 20-10-2014 -->
          <ul class="nav navbar-nav navbar-left ">
               <li><a href="agent_home.jsp" class="tip" title="DashBoard"><i class="fa fa-user fa-2x"></i><%=agentName%></a></li>
                <!-- <li><a href="about.jsp">About Us</a></li>
                <li><a href="#">Join US</a></li>
                <li><a href="features.jsp">Features</a></li>
                <li><a href="enquiry.jsp">Enquiry</a></li> -->


				<li class="dropdown"><!-- Elements on settings -->
							<a href="#" class="dropdown-toggle tip" data-toggle="dropdown" title="Settings"><i class="fa fa-caret-down fa-2x"></i></a>
							<ul class="dropdown-menu pull-right">
						
								<li><a href="logout.jsp">Logout</a></li>
								<li class="divider"></li>
						
								<li class="dropdown-submenu"><!-- Sub Menu li-->
								<a tabindex="-1" href="#">Account Settings</a>
								<ul class="dropdown-menu">
									<li><a href="#updateModel" data-toggle="modal" class="tip" title="Change Password and Email">Update Account</a></li>
									<li class="divider"></li>
								</ul><!-- end dropMenu ul  -->

								<li><a href="#">Help</a></li>
								</li><!-- end Sub Menu li-->

					 </li><!-- elements li -->
          </ul>
        </div>
      </div>
	 </div>
	

	<!-- Change password model -->
					<div id="updateModel" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><div id="x">X</div></button>
								<h4 id="myModalLabel">Update Details</h4>
							</div>


							<div class="modal-body alert-danger">
								<p>
								<form action="AgtUpdateUrl" class="alert alert-danger"  method="post">
								<table align="center">
									<tr>
										<th>Current Password</th>
										<td> <input type="password" required class="input-medium span3" name="currPwd"  maxlength="16" placeholder="Enter Current Password" /></td>
									</tr>
									<tr>
										<th>New Password</th>
										<td> <input type="password" required class="input-medium span3" name="newPwd" maxlength="16" placeholder="Enter New Password" /></td>
									</tr>
									<tr>
										<th>New Email</th>
										<td> <input type="text" required class="input-medium span3" name="newEmail"  maxlength="35" placeholder="Enter New Email" /></td>
									</tr>
								</table>
								</p>
							</div>
							<div class="modal-footer">
								<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
								<input type="submit" class="btn btn-primary " value="Update" >
								</form>
							</div>
					</div>	<!-- End Change password model -->

<div id="main-wrapper"> <!-- Main wrapper -->


          <nav class=" navbar-side" role="navigation">			<!-- left Side wrapper -->
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
				<li class="text-center">
                    <img src="img/find_user.png" class="user-image img-responsive"/>
					</li>
                    <li>
                        <a  href="agent_home.jsp" ><i class="fa fa-dashboard fa-3x"></i> Dashboard</a>
                    </li>
                     <li>
                        <a href="#"><i class="fa fa-qrcode fa-3x"></i>Chit Group<span class="fa arrow"></span></a>
						<ul class="nav-second-level">
                            <li>
                                <a href="CreateChitGroup.jsp">New Chit Group</a>
                            </li>
                            <li>
                                <a href="ExpiredGroups.jsp">View Expired Groups</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a  href="ViewGroups.jsp"><i class="fa fa-sitemap fa-3x"></i>View Current Groups</a>
                    </li>
					<li>
                        <a href="#"  class="active-menu" ><i class="fa fa-gavel fa-3x"></i>Auction<span class="fa arrow"></span></a>
                        <ul class="nav-second-level">
                            <li>
                                <a href="AuctionGroupVal.jsp">Next Auction</a>
                            </li>
                            <li>
                                <a href="AuctionHistory.jsp">Auction History</a>
                            </li>
                        </ul>
                      </li>  
                      <li  >
                        <a href="#"><i class="fa fa-tablet fa-3x"></i>Communication<span class="fa arrow"></span></a>
                        <ul class="nav-second-level">
                            <li>
                                <a href="#">Send Message</a>
                            </li>
                            <li>
                                <a href="#">Send Email</a>
                            </li>
                        </ul>
                    </li>
                  <li  >
                        <a  href="AgentBlank.jsp"><i class="fa fa-square-o fa-3x"></i> Blank Page</a>
                    </li>	
                </ul>   
            </div>
		</nav> 			<!-- Side wrapper close -->


       <div id="page-wrapper">  <!--  page Wrapper -->
          <div id="page-inner"> <!--  page inner-->	
                     	
						<h4 class="alert alert-info"><font face="Verdana, Geneva, sans-serif" color="#408080">Auction History</font></h4>   
                  		<hr/>		

		<div class="row">		<!-- main row -->
			<div class="span12">		<!-- Span12 -->
			
				<fieldset class="sectionwrap alert-error">	
				
				<form name="single_for" action="auctionHistoryUrl"  method="post">
				<h5>Enter Group Id</h5>
				<p align="center"><br>	
					<input type="text"  class="input-medium span5" id="groupsId" name="groupId" placeholder="Enter min 3 letter."/><br>
					<input type="submit" class="btn btn-primary btn-large" value="Details"/>	
				</p>	
				</form>
				</fieldset>
			</div>		<!-- span12 -->					
		</div><!-- end of span4 -->	
       
				<%
					Object historyList=(Object)request.getAttribute("historyDetailsList");		//from AuctionHistoryController
					if(historyList!=null)
				    {%>
						<h4><font color="#006600" face="Verdana, Geneva, sans-serif">Auction Details</font></h4>
						 <hr>
					<%

				    	ArrayList<AuctionHistoryBeans> list=(ArrayList<AuctionHistoryBeans>) historyList;	
				    	Iterator<AuctionHistoryBeans> it= list.iterator();
				    	while(it.hasNext())
				    	{
				    		AuctionHistoryBeans bean=it.next();
				    		
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
											
											<div id=<%=auctionID%> class="accordion-body collapse">
                                            
										<div class="accordion-inner">
												<div class="row">		<!-- main row -->
                                                    <div class="span12">		<!-- Span12 -->
                                            
															<div class="span4 ">
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
                                            </div><!--  end main row -->
											
                                          </div> <!--  accordion-inner" -->
                                                
											</div>
                                        </div>
									</div>		<!-- End Of Whole Collaps Trigger option. -->
				    <%}	//end of while.
						
					}	//end of if.
				%> 	
		</div>  <!-- end main row -->
				
            
           </div><!--  page inner  -->
	  </div><!--end of page wrapper --> 
    </div><!--end of main wrapper --> 
      
         
		<footer class="chitFooter navbar-static-bottom">			<!-- Footer -->
		<center><font color="black" size="1px">Copyright @ 2014 Werise Foundation. www.WeriseFoundation.org. All Rights Reserved.</font><br>
		<a href="about.jsp"><font color="black" size="2px">About Us</font></a>|
		<a href="enquiry.jsp"><font color="black" size="2px">Contact Us</font></a>
		</center>
		</footer>

		
		
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
