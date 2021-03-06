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
double duration=0;
int totalmember=0;
double premium=0;
int  freeMemberSlots=0;
%>
 <%
	String auctionStatus=null;
	auctionStatus=(String)request.getAttribute("auctionStatus");		//from AuctionProcessController
	if(auctionStatus!=null && auctionStatus.equalsIgnoreCase("Bidden"))
    	{%>
    		
    		  <div class="modal">
								<a href="AuctionGroupVal.jsp" class="close" data-dismiss="modal"><b id="x">X&nbsp;</b></a>
								<div class="modal-header">
								<h4>Sorry...!Auction process cannot be taken to further Steps.</h4>
								</div>
								<div class="modal-body  alert alert-error">
								<h5>Hello,<br><p>This Member has already been granted his amount, so this member cannot participate in further auction. </p>
								<i>Please check in group details...</i>
								<br>Thanks.</h5>
								</div>						
						</div><!-- Endo of Modal -->
						<div class="modal-backdrop fade in"></div>
    	<%}

	auctionStatus=(String)request.getAttribute("auctionStatus");		//from AuctionProcessController
	if(auctionStatus!=null && auctionStatus.equalsIgnoreCase("NotFound"))
    	{%>
    			<div class="modal">
						<a href="AuctionGroupVal.jsp" class="close" data-dismiss="modal"><b id="x">X&nbsp;</b></a>
    					<div class="modal-body  alert alert-error">
						<p>Member is not associates with this group</p>
						<i>Please check in group details...</i>
						<br>Thanks.</h5>
						</div>
				</div>
				<div class="modal-backdrop fade in"></div>
    	<%}

	auctionStatus=(String)request.getAttribute("auctionStatus");		//from AuctionProcessController
	if(auctionStatus!=null && auctionStatus.equalsIgnoreCase("Success"))
    	{%>
    		
    		<div class="modal">
								<a href="AuctionGroupVal.jsp" class="close" data-dismiss="modal"><b id="x">X&nbsp;</b></a>
								<div class="modal-header">
								<h4>Congrats...!</h4>
								</div>
								<div class="modal-body  alert alert-success">
								<h5>Hello,<br><p>The Auction process has been completed successfully.</p>
								<i>Please check in Auction History for further details..</i>
								<br>Thanks.</h5>
								</div>						
						</div><!-- Endo of Modal -->
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

				<%
						String resp=(String)request.getAttribute("auctionValStatus");		//get the response from  AuctionValController servlet.
						
						if(resp!=null && resp.equalsIgnoreCase("noAuction"))
						{%>
							 <div class="modal">
								<a href="AuctionGroupVal.jsp" class="close" data-dismiss="modal"><b id="x">X&nbsp;</b></a>
								<div class="modal-header">
								<h4>Sorry...!Auction process cannot be taken to further Steps.</h4>
								</div>
								<div class="modal-body  alert alert-error">
								<h5>Hello,<br><p>Please check whether you have added all members into the group Or Check the Auction history for respective auctions.  </p><br>Thanks.</h5>
								</div>						
						</div><!-- Endo of Modal -->
						<div class="modal-backdrop fade in"></div>
						<%}
				%>	
	
       <div id="page-wrapper">  <!--  page Wrapper -->
          <div id="page-inner"> <!--  page inner-->	
                     	
						<h4 class="alert alert-info"><font face="Verdana, Geneva, sans-serif" color="#408080">Auction Validation</font></h4>   
                  		<hr/>		
				<fieldset class="sectionwrap alert-info">	
				
				<form name="single_for" action="auctionValidateUrl" method="post">
				<h5>Enter Group Id</h5>
				<p class="alert-info" align="center"><br>	
					<input type="text"  class="input-medium span5" id="groupsId" name="groupId"  autocomplete="off"  placeholder="Enter min 3 letter."/><br>
					<input type="submit" class="btn btn-primary btn-large" value="Next"/>	
				</p>
				</form>
				</fieldset>
				

			

            
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
