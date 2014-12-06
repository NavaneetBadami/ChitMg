<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" 
import="java.lang.*,java.util.*,java.io.*,java.sql.*,java.sql.Statement,java.io.*,javax.servlet.RequestDispatcher.*,java.util.ArrayList"
import="com.riseon.chitfund.services.ConnectionProvider"
import="com.riseon.chitfund.dto.CreateChitGroupBean "
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
	.input-medium 
		{
		height:25px !important;
		border-color: solid black;
		}

</style>

<link rel="stylesheet" type="text/css" href="./css/autoComplete.css" /> 
<script type="text/javascript" src="js/jquery-1.4.2.min.js"> </script>  <!-- Conflit of two queries jq-1.10 and jq 1.4  -->
 <script type='text/javascript'>
	 var $auotComplete = jQuery.noConflict(); 
	 jQuery( document ).ready( 
	 function($auotComplete){ 
			 $auotComplete("#memberId").autocomplete("MemberList.jsp");  //auto complete list.
		 });
</script>  
<script src="js/jquery.autocomplete.js"> </script>


 <script type="text/javascript">			//Auction Logic only for display.
          function calculate()
          {
			 var memberId=document.getElementById('memberId').value;	//get the values from textBoxes.
             var totalChitAmount = document.getElementById('chitAmt').value;
             var bidPer = document.getElementById('bidPer').value;
			 var agentComPer=document.getElementById('agtPer').value;
			 var members=document.getElementById('members').value;
			 var premium=document.getElementById('premium').value;
			
             var bidAmt = parseInt(totalChitAmount) * parseInt(bidPer)/100;		//perform Auction calculation.
			 var memAmt= parseInt(totalChitAmount) - parseInt(bidAmt);
			 var agentCom=parseInt(bidAmt) * parseInt(agentComPer)/100;	
			 var remainingAmt=parseInt(bidAmt) - parseInt(agentCom);
			 var reducedPremium=parseInt(remainingAmt) / parseInt(members-1);
			 var mamberTOPay=parseInt(premium)-parseInt(reducedPremium);

			 document.getElementById('bidAmt').value = bidAmt;			//print values in to text Boxes.
			 document.getElementById('memAmt').value = memAmt;

			
			document.getElementById('remFund').value = bidAmt;
			document.getElementById('agtComPer').value = agentComPer;
			document.getElementById('agtAmt').value = agentCom;
			document.getElementById('remAmt').value = remainingAmt;
			document.getElementById('prmReduced').value = parseInt(reducedPremium);
			document.getElementById('memTopay').value = mamberTOPay;

			 document.getElementById('bidMemId').value = memberId;
			 document.getElementById('bidMemPer').value = bidPer;
			 document.getElementById('bidMemAmt').value = bidAmt;
			 document.getElementById('totalMemAmt').value = memAmt;

	
	//		$('#discount').html('Hello World!');
			document.getElementById('dispSavedPrm').innerHTML = parseInt(reducedPremium);	//print values into html tag like div, h1....
			document.getElementById('dispMemAmt').innerHTML = memAmt;
          }
        </script>

		<script>				//allows only numbers in mobileno field.
		function isNumberKey(evt)
		{
			var charCode = (evt.which) ? evt.which : event.keyCode
			if (charCode > 31 && (charCode < 48 || charCode > 57))
				return false;
				return true;
			}
</script>
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
int duration=0;
double chitAmt=0;
int totalmember=0;
int freeMemberSlots=0;
long premium=0;
int totalAuctions=0;
int remainingAuctions=0;
double agentPer=0;
%>

<%
		ArrayList auctionDetailsLst=(ArrayList)request.getAttribute("auctionDetails");   //from AuctionValController.
		if(auctionDetailsLst.size()!=0)
		{
			Iterator<CreateChitGroupBean> list=auctionDetailsLst.iterator();
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
				 premium=(long)crtChitGroupBean.getPremium();
				 totalAuctions=crtChitGroupBean.getTotalAuctions();
				 remainingAuctions=crtChitGroupBean.getRemainingAuctions();
				 agentPer=crtChitGroupBean.getAgentPer();
				
			}
		}
			
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
                     	
						<h4><font face="Verdana, Geneva, sans-serif" color="#408080"><%=groupName%> Auction Menu</font></h4>   
                  		<hr/>		
					
						<table class="table table-bordered alert-success">
								<tr class="alert-info">
									<th>ID:</th>
                                    <th>NAME:</th>
                                    <th>CHIT AMOUNT:</th>
                                    <th>DURATION:</th>
                                    <th>PREMIUM:</th>
									<th>AGENT%</th>
                                    <th>TOTAL MEMBER:</th>
                                    <th>Total Auctions:</th>
                                    <th>Auctions to Come:</th>                                   
                                    <th>DETAILS</th>
								</tr>
								<tr>
									<td><%=groupId%></td>
                                    <td><%=groupName%></td>
									<td><%=chitAmt%></td>
                                    <td><%=duration%></td>
									<td><%=premium%></td>
									<td><%=agentPer%></td>
									<td><%=totalmember%></td>
									<td><%=totalAuctions%></td>
									<td><%=remainingAuctions%></td>								
							<td colspan="2"><a class="btn btn-info tip" title="Click to view group Members" href="grpDetailsUrl?groupId=<%=groupId%>">Details</a></td>
						</tr>
						</table>
                        <hr>
				<fieldset class="sectionwrap">	
						<form name="single_for" action="auctionProcessUrl" method="post">
						<input type="hidden"  id="agtPer" value="<%=agentPer%>"/>	<!-- Hidden fields for only calculation purpose in above script -->
						<input type="hidden"  id="members" value="<%=totalmember%>"/>
						<input type="hidden"  id="premium" value="<%=premium%>"/>
						<h5>Auction  Details.</h5>
							<table class="table table-condensed table-hover table-bordered alert-error">
							<tr>
								<td><label>Group ID*</label></td>
								<td><input type="text"  class="input-medium span3" name="groupId" maxlength="35" value="<%=groupId%>" readonly/></td>
							</tr>
						
							<tr>
								<td> <label>Member ID* </label></td>
								<td> <input type="text" required class="input-medium span3" name="memberId" maxlength="30" placeholder="Member ID"  autocomplete="off" id="memberId" ></td>
							</tr>
							<tr>
								<td> <label>Available Amount</label></td>
								<td><input type="text"  class="input-medium span3" maxlength="20" value="<%=chitAmt%>" id="chitAmt" disabled/></td>
							</tr>
							<tr>
								<td> <label>Bid %*</label></td>
								<td> <input type="text" required class="input-medium span3" name="bidPer" maxlength="20" placeholder="Bid %" id="bidPer" autocomplete="off"  onkeypress='return isNumberKey(event)'/></td>
							</tr>
							<tr> 
								<td> <label>Bid amount *</label></td>
								<td> <input type="text" required class="input-medium span3" maxlength="20" placeholder="Bid amount" id="bidAmt" value="" onClick="calculate()" autocomplete="off"  onkeypress='return isNumberKey(event)' title="Click" readonly/>(*Click)</td>
							</tr>
							
							<tr>
								<td> <label>Total Amount*</label></td>
								<td><input type="text"  class="input-medium span3"  maxlength="20"placeholder="Member Amount" id="memAmt" value="" disabled/></td>
							</tr>

						</table>
								<p align="center">
										<button class="btn btn-primary" data-target="#auctionProcess" data-toggle="modal" class="tip" title="View Auction Details">Next</button>
								</p>
							<!-- Auction Modal -->
								<div id="auctionProcess" class="modalChit hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

									<div class="modal-header alert-error">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><b id="x">X</b></button>
										<h4 id="myModalLabel">Auction Details</h4>
									</div>

											<div class="modal-body">
                                               <div class="span12">
												<div class="span3 ">
													<div class=" panel-primary text-center no-boder bg-color-red">
														<div class="panel-body">
															<i class="fa fa-gavel fa-5x"></i>
															<h4><%=groupId%></h4>
														</div>
													</div>
												   <h6 class="alert alert-success">Chit Amount: <%=chitAmt%> Rs.</h6>
                                                   <h6 class="alert alert-success">Monthly Premium: <%=premium%> Rs.</h6>
												   <h6 class="alert alert-success">Chit Duration: <%=duration%> Months</h6>
                                                   <h6 class="alert alert-success">Premium saved by member:<p id="dispSavedPrm"></p></h6>  
												</div>	
													<div class="span4 ">
															<table class="table" style="color:#387070;font-weight:bold;">
                                                                            <caption><font color="#006600" size="+1" face="Verdana, Geneva, sans-serif">Member Details</font></caption>
                                                                            <tr>
                                                                            	<td>Member Id</td>
                                                                                <td><input type="text"  class="input-medium span3" id="bidMemId" value=""disabled/></td>
                                                                            </tr>
                                                                            <tr>
                                                                            	<td>Bid%</td>
                                                                                <td><input type="text"  class="input-medium span3" id="bidMemPer" value=""disabled/></td>
                                                                            </tr>
																			<tr>
                                                                            	<td>Bid Amount</td>
                                                                                <td><input type="text"  class="input-medium span3" id="bidMemAmt" value=""disabled/></td>
                                                                            </tr>
                                                                            <tr>
                                                                            	<td>Member Amount</td>
                                                                                <td><input type="text"  class="input-medium span3" id="totalMemAmt" value=""disabled/></td>
                                                                            </tr>
                                                                            </table>
                                                             <div class=" panel-primary text-center no-boder bg-color-green">
																<div class="panel-body">
																	<i class="fa fa-rupee fa-5x"></i>
																	<h4 id="dispMemAmt"></h4>
																</div>
															</div>
                                                            
															</div><!-- end of span4 -->	
                                                            
                                                       <div class="span4 ">
																		
                                                                       <table class="table" 
                                                                       style="color:#387070;font-weight:bold;">
                                                                       <caption><font color="#006600" size="+1" face="Verdana, Geneva, sans-serif">Bidden Details</font></caption>
																			<tr>
                                                                            	<td>Remaining Fund</td>
                                                                                <td><input type="text"  class="input-medium span3" id="remFund" value=""disabled/></td>
                                                                            </tr>
                                                                            <tr>
                                                                            	<td>Agent%</td>
                                                                                <td><input type="text"  class="input-medium span3" id="agtComPer" value=""disabled/></td>
                                                                            </tr>
                                                                            <tr>
                                                                            	<td >Agent Amount</td>
                                                                                <td><input type="text"  class="input-medium span3" id="agtAmt" value=""disabled/></td>
                                                                            </tr>
																			 <tr>
                                                                            	<td>Remaining Amount</td>
                                                                                <td><input type="text"  class="input-medium span3" id="remAmt"value=""disabled/></td>
                                                                            </tr>
                                                                            <tr>
                                                                            	<td>Premimun Reduced:</td>
                                                                                <td><input type="text"  class="input-medium span3" id="prmReduced" value=""disabled/></td>
                                                                            </tr>
																			 <tr>
                                                                            	<td>Member to Pay:</td>
                                                                                <td><input type="text"  class="input-medium span3" id="memTopay" value=""disabled/></td>
                                                                            </tr>
                                                                            </table>
																				
															</div><!-- end of span4 -->	
												</div><!-- end of span10 -->	
											</div><!-- end of modal Body -->

										<div class="modal-footer">
											<a href="AuctionGroupVal.jsp" class="btn btn-large btn-danger tip" title="Cancel the auction.">Cancel</a>	
											<input type="submit" class="btn btn-success btn-large tip" title="Click to Auction" value="Auction" >	<!-- Submit whole form. -->
											</form>
										</div>

							</div><!-- End Of Auction modal -->
					</fieldset>	


           </div><!--  page inner  --> 
	  </div><!--end of page wrapper --> 
    </div><!--end of main wrapper --> 
      
       
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
