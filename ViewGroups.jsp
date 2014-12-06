<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" 
import="java.lang.*,java.util.*,java.io.*,java.sql.*,java.sql.Statement,java.io.*,javax.servlet.RequestDispatcher.*,java.util.ArrayList"
import="com.riseon.chitfund.services.ConnectionProvider"
import="com.riseon.chitfund.dto.CreateChitGroupBean "
import="com.riseon.chitfund.supports.CommonDao"
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

String groupId=null; 
String groupName=null; 
double chitAmt=0;
int duration=0;
int totalmember=0;
int freeMemberSlots=0;
double premium=0;
int totalAuctions=0;
int remainingAuctions;
double agentPer;
String grpcredate;
String grpcretime;
String grpStatus;
String grpCreDate;
String grpCreTime;
%>
<%
	String groupStatus=null;
	groupStatus=(String)request.getAttribute("groupStatus");		//from UpdateController
	if(groupStatus!=null && groupStatus.equalsIgnoreCase("AllFilled"))
    	{%>
    		
    		 
    			 <div class="chitFundModal">
					<a href="ViewGroups.jsp" class="close" data-dismiss="modal"><b id="x">X&nbsp;</b></a>
					<div class="modal-header alert alert-success">
                    <h4>Congrats..! </h4>
                    </div>
                    	<div class="modal-body">
                        <h5>Hello,<br><p>All membres have been added int to the group, lets begin auction process.</p><br>Thanks.</h5>
                        </div>						
				</div><!-- Endo of chitFundModal -->
				<div class="modal-backdrop fade in"></div>
    	<%}

	groupStatus=(String)request.getAttribute("groupStatus");		//from UpdateController
	if(groupStatus!=null && groupStatus.equalsIgnoreCase("noSlots"))
    	{%>
    			 
    		 <div class="chitFundModal">
					<a href="ViewGroups.jsp" class="close" data-dismiss="modal"><b id="x">X&nbsp;</b></a>
					<div class="modal-header alert alert-error">
                    <h4>Sorry...!</h4>
                    </div>
                    	<div class="modal-body">
                        <h5>Hello,<br><p>No Members slots are available, you have already added all Members in to the group.</p><br>Thanks.</h5>
                        </div>						
				</div><!-- Endo of chitFundModal -->
				<div class="modal-backdrop fade in"></div>
    	<%}
		

											//......Delete Status....
						
		String deleteStatus=null;
		deleteStatus=(String)request.getAttribute("deleteStatus");		//from DeleteController
		if(deleteStatus!=null && deleteStatus.equalsIgnoreCase("memDeleted"))
    	{%>
    			 
    		 <div class="chitFundModal">
					<a href="ViewGroups.jsp" class="close" data-dismiss="modal"><b id="x">X&nbsp;</b></a>
					<div class="modal-header alert alert-success">
                    <h4>Member Deleted..!</h4>
                    </div>
                    	<div class="modal-body">
                        <h5>Hello,<br><p>One Member has been successfully deleted from the group.</p><br>Thanks.</h5>
                        </div>						
				</div><!-- Endo of chitFundModal -->
				<div class="modal-backdrop fade in"></div>
    	<%}

		deleteStatus=(String)request.getAttribute("deleteStatus");		//from DeleteController
		if(deleteStatus!=null && deleteStatus.equalsIgnoreCase("memNotFound"))
    	{%>
    			 
    		 <div class="chitFundModal">
					<a href="ViewGroups.jsp" class="close" data-dismiss="modal"><b id="x">X&nbsp;</b></a>
					<div class="modal-header alert alert-error">
                    <h4>Member not Found...!</h4>
                    </div>			
				</div><!-- Endo of chitFundModal -->
				<div class="modal-backdrop fade in"></div>
    	<%}

		deleteStatus=(String)request.getAttribute("deleteStatus");		//from DeleteController
		if(deleteStatus!=null && deleteStatus.equalsIgnoreCase("cannotDelete"))
    	{%>
    			 
    		 <div class="chitFundModal">
					<a href="ViewGroups.jsp" class="close" data-dismiss="modal"><b id="x">X&nbsp;</b></a>
					<div class="modal-header alert alert-error">
                    <h4>Sorry...!</h4>
                    </div>
                    	<div class="modal-body">
                        <h5>Hello,<br><p>Member suppose to be deleted before the first auction process.</p><br>Thanks.</h5>
                        </div>						
				</div><!-- Endo of chitFundModal -->
				<div class="modal-backdrop fade in"></div>
    	<%}

		deleteStatus=(String)request.getAttribute("deleteStatus");		//from DeleteController
		if(deleteStatus!=null && deleteStatus.equalsIgnoreCase("memNotDeleted"))
    	{%>
    			 
    		 <div class="chitFundModal">
					<a href="ViewGroups.jsp" class="close" data-dismiss="modal"><b id="x">X&nbsp;</b></a>
					<div class="modal-header alert alert-error">
                    <h4>Sorry...!</h4>
                    </div>
                    	<div class="modal-body">
                        <h5>Hello,<br><p>Member Cannot be deleted at this moment try again..!</p><br>Thanks.</h5>
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
                        <a  href="ViewGroups.jsp"  class="active-menu" ><i class="fa fa-sitemap fa-3x"></i>View Current Groups</a>
                    </li>
					<li>
                        <a href="#"><i class="fa fa-gavel fa-3x"></i>Auction<span class="fa arrow"></span></a>
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
                     	
						<h4><font face="Verdana, Geneva, sans-serif" color="#408080">Existing Chit Groups</font></h4>   
                  		<hr/>		

		<div class="row">		<!-- main row -->
			<div class="span12">		<!-- Span12 -->
				
	<%

		String sqlQuery="select *from group_details where agentid='"+agentId+"' AND grpStatus='VALID'";
		ArrayList<CreateChitGroupBean> groupList=CommonDao.groupList(sqlQuery);  // Call static method(),get groups list.
			Iterator<CreateChitGroupBean> list=groupList.iterator();
		
				while(list.hasNext())
				{ 
					CreateChitGroupBean crtChitGroupBean=(CreateChitGroupBean)list.next(); //Downcasting.
					
				//	String agentName=crtChitGroupBean.getAgentName();
					 groupId=crtChitGroupBean.getGroupId();
					 groupName=crtChitGroupBean.getGroupName();
					 chitAmt=crtChitGroupBean.getChitAmount();
					 duration=(int)crtChitGroupBean.getDuration();
					 freeMemberSlots=crtChitGroupBean.getAvailableMemberSlots();
					 totalmember=crtChitGroupBean.getTotalMemberSlots();
					 premium=crtChitGroupBean.getPremium();
					 totalAuctions=crtChitGroupBean.getTotalAuctions();
					 remainingAuctions=crtChitGroupBean.getRemainingAuctions();
					 grpStatus=crtChitGroupBean.getGrpStatus();
					 agentPer=crtChitGroupBean.getAgentPer();
					 grpCreDate=crtChitGroupBean.getGrpcredate();
					 grpCreTime=crtChitGroupBean.getGrpcretime();
					 
	%>
				<div class="span3">
                   <div class=" panel-primary no-boder bg-color-green">
                       <div class="badge-important">
							<i class="fa fa-xing fa-2x"></i>
                             <strong><%=groupId%></strong>
						</div>
						<div class="panel-body">
							<table class="table">
								<tr><td>GROUP NAME</td><td><%=groupName%></td></tr>
								<tr><td>CHIT AMOUNT</td><td><%=chitAmt%></td></tr>
								<tr><td>DURATION</td><td><%=duration%>&nbsp;(months)</td></tr>
							</table>
						</div>
						<div class="panel-footer  text-center back-footer-mehindi">
							<a class="btn btn-info tip"  title="Member Details and Modify operation" href="grpDetailsUrl?groupId=<%=groupId%>">Modify</a>
							<a class="btn btn-info tip" href="#<%=groupId%>" title="Click to View Details" data-toggle="modal">Details</a>
						</div>
					</div>

				</div><!-- end of span3 -->

					<div id="<%=groupId%>" class="modalChit hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-header alert-success">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><b id="x">X</b></button>
						<h4 id="myModalLabel"><%=groupName%>&nbsp;Group Details.</h4>
					</div>

					<div class="modal-body ">	<!-- MOdel Body  -->
			
							<div class="span12">
                            
                            	<div class="span5">
                                	<h5 class="alert alert-success">Group Details</h5>
									<table class="table table-hover alert-success">
									<tr>
										<th>GROUP NAME</th>
										<td><%=groupName%></td>
									</tr>
									<tr>
										<th>GROUP ID</th>
										<td><%=groupId%></td>
									</tr>
									<tr>
										<th>CHIT AMOUNT</th>
										<td><%=chitAmt%></td>
									</tr>
									<tr>
										<th>DURATION</th>
										<td><%=duration%></td>
									</tr>
									<tr>
										<th>AGENT PER</th>
										<td><%=agentPer%></td>
									</tr>
									<tr>
                                        <th>GROUP STATUS</th>
                                        <td><%=grpStatus%></td>
                                    </tr>
								</table>
							
                                </div>
                               
                            	<div class="span5">
                                	<h5 class="alert alert-success">Other Information</h5>
									<table class="table table-hover table-bordered alert-success">
										<tr>
										<th>MEMBERS</th>
										<td><%=totalmember%></td>
									</tr>
									<tr>
										<th>FREE SOLTS</th>
										<td><%=freeMemberSlots%></td>
									<tr>
										<th>PREMIUM</th>
										<td><%=premium%></td>
									</tr>
									<tr>
										<th>TOTAL AUCTION</th>
										<td><%=totalAuctions%></td>
									</tr>
                                    <tr>
                                        <th>REMAIN AUCTIONS</th>
                                        <td><%=remainingAuctions%></td>
                                    </tr>
                                    <tr>
                                        <th>CREATED DATE</th>
                                        <td><%=grpCreDate%></td>
                                    </tr>
									<tr>
                                        <th>CREATED TIME</th>
                                        <td><%=grpCreTime%></td>
                                    </tr>
									</table>
                                </div>
                               
                            </div> <!-- End Of span12 -->
								
							</div> <!-- End Of modal body -->

								<div class="modal-footer">
									<button type="reset" class="btn btn-medium btn-error" data-dismiss="modal">Close</button>
								</div>
	
			</div><!-- End Of Display modal -->

				
				<%}
			%>

			</div>		<!-- span12 -->
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
