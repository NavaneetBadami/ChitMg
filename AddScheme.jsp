<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" 
import="java.lang.*,java.util.*,java.io.*,java.sql.*,java.sql.Statement,java.io.*,javax.servlet.RequestDispatcher.*,java.util.ArrayList"
import="com.riseon.chitfund.services.ConnectionProvider"
import="com.riseon.chitfund.dto.AddSchemeBean" 
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
                        <a  href="ViewAgents.jsp"><i class="fa fa-toggle-right fa-3x"></i>View Agents</a>
                    </li>
					<li>
                        <a href="#"  class="active-menu" ><i class="fa fa-sitemap fa-3x"></i>Schemes<span class="fa arrow"></span></a>
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


	<%
			String resp=(String)request.getAttribute("status"); //get the response from AddSchemeController servlet.		
			if(resp!=null && resp.equalsIgnoreCase("schemeNotAdded"))
			{%>
				<div class="chitFundModal">
					<a href="AddScheme.jsp" class="close" data-dismiss="modal"><b id="x">&times;</b></a>
					<div class="modal-header alert alert-error">
						<h5>Sorry..! Scheme has not been added. Try again. </h5>
					</div>
				</div><!-- Endo of chitFundModal -->
				<div class="modal-backdrop fade in"></div>
			<%}
	%>	


        		<div id="page-wrapper">  <!--  page Wrapper -->
                
                     <h4 class="alert alert-info"><font face="Verdana, Geneva, sans-serif" color="#408080">Schemes</font></h4>   
                  		<hr/>		
				<div id="page-inner"> <!--  page inner-->		

           
		<div class="span12">
        
            <div class="span5">
                <div class=" panel-primary text-center no-boder bg-color-brown">
                        <div class="panel-body">
                           <i class="fa fa-arrow-circle-right fa-5x"></i>
                              <h4>Add Chit Scheme According to User requirement</h4>
                         </div>
                </div>
                <div class=" panel-primary text-center no-boder bg-color-blue">
                        <div class="panel-body">
                           <i class="fa fa-long-arrow-right fa-5x"></i>
                              <h4>Scheme Type Must be at least 5</h4>
                         </div>
                </div>
            </div>
                
            <div class="span5">
			<fieldset class="alert alert-info">
					<form action="addSchemeUrl" class="register" method="post">
                     
						<h3>Add New Chit scheme</h3>
							<p align="center">
								<label>Scheme Type*</label>
								<input type="text" required="" title="Enter min 2 group." pattern="\d{2}" name="txtSchType" maxlength="2" placeholder="No of Groups" onkeypress='return isNumberKey(event)'/>
								<label>Scheme Price*</label>
								<input type="text" required=""  pattern="\d+.*" name="txtSchPrice" maxlength="6" placeholder="Scheme price" onkeypress='return isNumberKey(event)'/>
								<label>Scheme Validity*</label>
								<input type="text" required="" title="Enter Max 1 year." pattern="\d{1}" name="txtSchValidity" maxlength="30" placeholder="Scheme validity" onkeypress='return isNumberKey(event)'><br>
							 
							<input type="submit" class="btn btn-primary btn-block" value="Add"/>
                   		 </p>
					</form>
			</fieldset>
            </div>
            
	</div><!-- end of span 12  -->
            
            
            
             </div><!--  page inner  -->
     
	  </div><!--end of wrapper --> 
      
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
