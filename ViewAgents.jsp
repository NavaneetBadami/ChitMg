<%@ page language="java" import="java.lang.*,java.util.*,java.io.*,java.sql.*,java.sql.Statement,java.util.Date,java.sql.Time" 
import="com.riseon.chitfund.dto.ViewAgentsBeans "
import="com.riseon.chitfund.services.ConnectionProvider"
import="com.riseon.chitfund.supports.CommonDao"
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
     
	
   <style>
		#nnavbar{position:absolute; right: 0px}
	</style>
</head>

<body>
 <%

	HttpSession ses=request.getSession(false);
	String adminId = (String)ses.getAttribute("adminId");
	if(adminId == null){
	response.sendRedirect("main-index.jsp");
	} 		
%>

  <div class="navbar navbar-static-top">   <!--Top nav Bar -->
    <div class="navbar-inner">
		<ul class="nav navbar-nav navbar-right">
			<li><a href="admin_home.jsp" title="HOME" class="tip"><IMG SRC="images/Logo2.jpg" width=150/></a></h1></li>
		</ul>
		<div id="nnavbar"  role="navigation"> <!-- elements on right side 20-10-2014 -->
          <ul class="nav navbar-nav navbar-left ">
                <li><a href="admin_home.jsp" class="tip" title="Home">Home</a></li>
                <li><a href="about.jsp" class="tip" title="About WeRiseChit Fund">About Us</a></li>
                <li><a href="#" class="tip" title="Home">Join US</a></li>
                <li><a href="features.jsp" class="tip" title="Features">Features</a></li>
                <li><a href="enquiry.jsp" class="tip" title="Contact us">Enquiry</a></li>


				<li class="dropdown"><!-- Elements on settings -->
							<a href="#" class="dropdown-toggle tip" data-toggle="dropdown" title="Settings"><i class="icon icon-cog"></i><b class="caret"></b></a>
							<ul class="dropdown-menu pull-right">
						
								<li><a href="logout.jsp">Logout</a></li>
								<li class="divider"></li>
						
								<li class="dropdown-submenu"><!-- Sub Menu li-->
								<a tabindex="-1" href="#">Account Settings</a>
								<ul class="dropdown-menu">
									<li><a href="#">Update Account</a></li>	<!-- 25-Jan-14 -->
									<li class="divider"></li>
								</ul><!-- end dropMenu ul  -->

								<li><a href="#">Help</a></li>
								</li><!-- end Sub Menu li-->

					 </li><!-- elements li -->
          </ul>
        </div>
      </div>
	 </div>
	
		 <div id="main-wrapper"> 

            <nav class=" navbar-side" role="navigation">	<!-- left lide wrapper -->
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
				<li class="text-center">
                     <img src="img/find_user.png" class="user-image img-responsive"/>
					</li>
                    <li>
                        <a href="admin_home.jsp"><i class="fa fa-dashboard fa-3x"></i> Dashboard</a>
                    </li>
                     <li>
                        <a  href="AddAgent.jsp" ><i class="fa fa-user fa-3x"></i>Add New Agent</a>
                    </li>
                    <li>
                        <a  href="ViewAgents.jsp" class="active-menu" ><i class="fa fa-toggle-right fa-3x"></i>View Agents</a>
                    </li>
					<li>
                        <a href="#"><i class="fa fa-sitemap fa-3x"></i>Schemes<span class="fa arrow"></span></a>
                        <ul class="nav-second-level">
                            <li>
                                <a href="ViewScheme.jsp">Available Schemes</a>
                            </li>
                            <li>
                                <a href="AddScheme.jsp">Add New Schemes</a>
                            </li>
                            <li>
                                <a href="SchemesHistory.jsp">Schemes History</a>
                            </li>
                        </ul>
                      </li>  
                      <li  >
                        <a  href="EnqMessages.jsp"><i class="fa fa-table fa-3x"></i> Messages</a>
                    </li>
                  <li  >
                         <a  href="AdminBlank.jsp"><i class="fa fa-square-o fa-3x"></i> Blank Page</a>
                    </li>	
                </ul>   
            </div>
		</nav> 		<!-- End of Left Side Wrapper. -->


        		<div id="page-wrapper">  <!--  page Wrapper -->
              
                    <h4 class="alert alert-info">
                     	<font face="Verdana, Geneva, sans-serif" color="#408080">Agents Details.</font> 
                  </h4>
                   <hr/>	
				<div id="page-inner"> <!--  page inner-->		
            	
				

<%
			String resp=(String)request.getAttribute("Agtadded"); //get the response from COntactController servlet.		
			if(resp!=null && resp.equalsIgnoreCase("mailSent"))
			{%>
				<div class="chitFundModal">
					<a href="ViewAgents.jsp" class="close" data-dismiss="modal"><b id="x">&times;</b></a>
					<div class="modal-header alert alert-success">
						<h5>Hello,<br><p>Agent User Name and password has been sent to their respective Email Id.</p><br>Thanks.</h5>
					</div>
				</div><!-- Endo of chitFundModal -->
				<div class="modal-backdrop fade in"></div>
		
			<%}

			if(resp!=null && resp.equalsIgnoreCase("mailNotSent"))
			{%>

				<div class="chitFundModal">
					<a href="ViewAgents.jsp" class="close" data-dismiss="modal"><b id="x">&times;</b></a>
					<div class="modal-header alert alert-error">
						<h5>Sorry..! Agent User Name and password has not been sent to their respective Email Id. </h5>
					</div>
				</div><!-- Endo of chitFundModal -->	
				<div class="modal-backdrop fade in"></div>
			<%}
%>	

	
		<div class="row">		<!-- main row -->
			<div class="span12">		<!-- Span12 -->
				<div class="row">
				
			
	
		<%
		String sqlQuery="select *from agent_details";
		ArrayList<ViewAgentsBeans> agentList=CommonDao.allAgents(sqlQuery);  // Call static method(),get list.
			Iterator<ViewAgentsBeans> list=agentList.iterator();
				while(list.hasNext())
				{ 
					ViewAgentsBeans viewAgentsBeans=(ViewAgentsBeans)list.next(); //Downcasting.
					
					String agFirstName=viewAgentsBeans.getAgFirstName();
					String agLastName=viewAgentsBeans.getAgLastName();
					String agId=viewAgentsBeans.getAgId();
					long agMobileNO=viewAgentsBeans.getAgMobileNo();
					String agEmail=viewAgentsBeans.getAgEmail();
					String agChitPlan=viewAgentsBeans.getAgtChatPlan();
					String agDob=viewAgentsBeans.getAgDob();
					String agAddress=viewAgentsBeans.getAgAddress();
					String agCity=viewAgentsBeans.getAgCity();
					String agGender=viewAgentsBeans.getAgGender();
					String agPanNo=viewAgentsBeans.getAgPanNO();
					String agState=viewAgentsBeans.getAgState();
					int agPinCode=viewAgentsBeans.getAgPinCode();
					String agPaymode=viewAgentsBeans.getAgPaymode();
					
					String purchasedDate=viewAgentsBeans.getPurchasedDate();
					String validityDate=viewAgentsBeans.getValidityDate();
				
					String nomAddress=viewAgentsBeans.getNomAddress();
					String nomCity=viewAgentsBeans.getNomCity();
					String nomEmail=viewAgentsBeans.getNomEmail();
					String nomFirstName=viewAgentsBeans.getNomFirstName();
					String nomRelationship=viewAgentsBeans.getNomRelationship();
					String nomState=viewAgentsBeans.getNomState();
					long nomMobileno=viewAgentsBeans.getNomMobileNo();
					int nomPinCode=viewAgentsBeans.getNomPinCode();

				%>

<div class="span3">
					<div class=" panel-primary text-center no-boder bg-color-green">
						<div class="panel-body">
							<i class="fa fa-user fa-5x"></i>
							<h4><%=agFirstName%></h4>
							<h5>(<%=agId%>)</h5>
						</div>
						<div class="panel-footer back-footer-mehindi"><a href="#<%=agId%>" class="tip" title="Click to View Details" data-toggle="modal">Details</a> </div>
					</div>
		
					
</div><!-- end of span4 -->
		
												
								<!-- in ChitFund.css 69 -->
			<div id="<%=agId%>" class="modalChit hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

				<div class="modal-header alert-danger">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><b id="x">X</b></button>
					<h4 id="myModalLabel"><%=agFirstName%>&nbsp;Agent Details.</h4>
				</div>

				<div class="modal-body ">
			
							<div class="span12">
								<div class="span5">
								<h5 class="alert alert-success">Agent Information</h5>
								<table class="table table-hover">
									<tr>
										<th>Agent Id</th>
										<td><%=agId%></td>
									</tr>
									<tr>
										<th>First Name:</th>
										<td><%=agFirstName%></td>
									<tr>
										<th>Lastname:</th>
										<td><%=agLastName%></td>
									</tr>
									<tr>
										<th>MobileNo:</th>
										<td><%=agMobileNO%></td>
									</tr>
									<tr>
										<th>Email:</th>
										<td><%=agEmail%></td>
									<tr>
										<th>Chit Plan:</th>
										<td><%=agChitPlan%></td>
									<tr>
									<tr>
										<th>Dob:</th>
										<td><%=agDob%></td>
									</tr>

							</table>
							<h5 class="alert alert-success">Other Information</h5>
								<table class="table table-hover">
								<tr>
									<th>Gender:</th>
									<td><%=agGender%></td>
								</tr>
								<tr>
									<th>PanCard No:</th>
									<td><%=agPanNo%></td>
								<tr>
									<th>Payment Mode:</th>
									<td><%=agPaymode%></td>
								</tr>
								<tr>
									<th>Purchased Date:</th>
									<td><%=purchasedDate%></td>
								</tr>
								<tr>
									<th>Validity till:</th>
									<td><font color="#FF0000" size="+1"><%=validityDate%></font></td>
								</tr>
								</table>
							</div>

					<div class="span5">			
					<h5 class="alert alert-success">&nbsp;Current Location.</h5>
					<hr/>
									<address>
									<strong><%=agFirstName%>&nbsp;<%=agLastName%></strong><br>
									<p><i class="icon icon-map-marker"></i>&nbsp;<%=agAddress%><BR>
									<%=agState%>&nbsp;-<%=agPinCode%>
									</p><br>
									<h5>Mobile:</abbr> <a href="tel:<%=agMobileNO%>"><%=agMobileNO%></a>
									<h5>Email:&nbsp;<%=agEmail%></h5>
									</address>
					</div>
			
				<div class="span5">	
				<h5 class="alert alert-success">Nominee Information</h5>
					<table class="table table-hover table-bordered">
								<tr class="info">
									<th>Nominee Name:</th>
									<td><%=nomFirstName%></td>
								</tr>
								<tr class="info">
									<th>Relationship:</th>
									<td><%=nomRelationship%></td>
								<tr class="info">
									<th>Mobile No</th>
									<td><%=nomMobileno%></td>
								</tr>
								<tr class="info">
									<th>Email</th>
									<td><%=nomEmail%></td>
								</tr>
								<tr class="info">
									<th>Address</th>
									<td><%=nomAddress%></td>
								<tr class="info">
									<th>City</th>
									<td><%=nomCity%></td>
								<tr>
								<tr class="info">
									<th>Pin Code</th>
									<td><%=nomPinCode%></td>
								</tr>
							</table>
					</div>

					</div><!-- End Of Span 12 -->
				</div> <!-- End Of modal body -->

				<div class="modal-footer">
					<button type="reset" class="btn btn-medium btn-error" data-dismiss="modal">Close</button>
				</div>

		</div><!-- End Of Display modal -->

		<%} //End of While.
						
	%>
	</div> <!-- end main in row -->
			</div>		<!-- span12 -->
		</div>  <!-- end main row -->

        </div><!--  page inner  -->
	  </div><!--end of wrapper --> 
    </div>  <!--end of main wrapper --> 
         
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
