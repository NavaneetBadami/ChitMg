<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
import="java.lang.*,java.util.*,java.io.*,java.sql.*,java.sql.Statement,java.io.*,javax.servlet.RequestDispatcher.*,java.util.ArrayList"
import="com.riseon.chitfund.services.ConnectionProvider"
import="com.riseon.chitfund.dto.AddSchemeBean" 
import="com.riseon.chitfund.dao.AddAgentDao"
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
	<link rel="stylesheet" type="text/css" href="css/forward.css" />
     
<style>
	.input-medium 
		{
		height:25px !important;
		border-color: solid black;
		}

</style>
<script>				//allows only numbers in mobileno field.
		function isNumberKey(evt)
		{
			var charCode = (evt.which) ? evt.which : event.keyCode
			if (charCode > 31 && (charCode < 48 || charCode > 57))
				return false;
				return true;
			}
</script>
<script type="text/javascript">
 function price()
 {
		 var SchemePrice=document.getElementById('schPrice').value;
		 document.getElementById('ChitPrice').innerHTML = parseInt(SchemePrice);
 }

</script>
   <style>
	#nnavbar{position:absolute; right: 0px}
	</style>
</head>

<%

	HttpSession ses=request.getSession(false);
	String adminId = (String)ses.getAttribute("adminId");
	if(adminId == null){
	response.sendRedirect("main-index.jsp");
	} 	
%>

<body>
     
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
	

<div id="main-wrapper"> <!-- Main wrapper -->


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
                        <a  href="AddAgent.jsp" class="active-menu"  ><i class="fa fa-user fa-3x"></i>Add New Agent</a>
                    </li>
                    <li>
                        <a  href="ViewAgents.jsp"><i class="fa fa-toggle-right fa-3x"></i>View Agents</a>
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


				<%
						String resp=(String)request.getAttribute("status");		//get the response from AddAgent Controller servlet.
						
						if(resp!=null && resp.equalsIgnoreCase("fail"))
						{%>
							<script type="text/javascript">
								alert("please insert all values...!");
							</script>
						<%}
				%>	
	

        	<div id="page-wrapper">  <!--  page Wrapper -->
           <div id="page-inner"> <!--  page inner-->	
                     <h4><font face="Verdana, Geneva, sans-serif" color="#408080">New Agent Registraction</font></h4>   
                  		<hr/>		
				

            <form id="Single_Form" action="addAgent"  method="post" enctype="multipart/form-data" onsubmit="return validateForm();"> <!-- Single Form -->

			<fieldset class="sectionwrap">			<!-- First page -->
					<h5>Basic Information</h5>
					<hr/>
						 <table>
						<tr>
							<td>Agent Name</td>
							<td> <input type="text" class="input-medium span3" id="FirstName" name="txtAgtFirstName" maxlength="16" placeholder="First Name"/></td>
							<td> Last Name</td>
							<td> <input type="text" class="input-medium span3" id="LastName" name="txtAgtLastName" maxlength="16" placeholder="Last Name"/></td>

						</tr>
						
						<tr>
							<td>  <label>Email *</label></td>
							<td> <input type="text" class="input-medium span3" id="Email" name="mailAgtEmail" maxlength="30" placeholder="Email"></td>
							<td> <label>Mobile No *</label></td>
							<td><input type="text" class="input-medium span3" id="MobileNo" name="txtAgtContactno" maxlength="10" placeholder="Mobile Number" onkeypress='return isNumberKey(event)'/></td>
						</tr>
						<tr>
							
						</tr>
						<tr>
							<td> <label>Adress</label></td>
							<td><textarea class="span4" id="Address" name="txtAgtAddress" rows="4" placeholder="Address"></textarea></td>
						</tr>
						<tr>
							<td> <label>State *</label></td>
							<td><input type="text"  id="State" class="input-medium span3" name="txtAgtState" maxlength="25" placeholder="State" autocomplete="off"/></td>
							<td><label>City *</label></td>
							<td><input type="text" id="City" class="input-medium span3" name="txtAgtCity" maxlength="25" placeholder="City"/></td>
						</tr>
						<tr>
							<td><label>PIN code</label></td>
							<td><input type="text" id="PinCode" class="input-medium span3" name="AgtPINCode" maxlength="6" placeholder="PIN" onkeypress='return isNumberKey(event)'/></td>
							<td>   <label>Pan Number</label></td>
							<td> <input type="text" id="PanNumber" class="input-medium span3" name="txtAgtPanNo" placeholder="Pan Number"/></td>
						</tr>
						<tr>
							<td> <label>DOB *</label></td>
							<td> <input type="text" id="DOB" class="input-medium span3" name="AgtDOB" maxlength="16" placeholder="DD-MM-YYYY"/></td>
							<td> <label>Gender *</label></td>
							<td> <select id="Gender" name="AgtGender">
								<option value="Male">Male</option>
								<option value="Female">Female</option>
								</select>
							</td>
						</tr>
						
						</table>
			</fieldset>
							
			<fieldset class="sectionwrap">			<!-- Second page -->
					<h5>Nommine Information</h5>
					<hr/>
							<table>
							<tr>
								<td><label>First Name*</label></td>
								<td>  <input type="text" id="Nominee_FirstName"  class="input-medium span3" name="txtAgtNomineeName" maxlength="16" placeholder="Nominee Name"/></td>
								<td> <label>Relation ship *</label></td>
								<td><input type="text" id="Nominee_Relationship" class="input-medium span3" name="txtAgtRelationship" maxlength="16" placeholder="Relationship"/></td>
							</tr>
						
							<tr>
								<td> <label>Email * </label></td>
								<td> <input type="text" id="Nominee_Email" class="input-medium span3" name="txtAgtNomEmail" maxlength="30" placeholder="Email"></td>
								<td> <label>Mobile No *</label></td>
								<td> <input type="text" id="Nominee_MobileNo" class="input-medium span3" name="txtAgtNomContactno" maxlength="10" placeholder="Mobile Number" onkeypress='return isNumberKey(event)'/></td>
							</tr>
							
							<tr>
								<td> <label>Adress</label></td>
								<td><textarea class="span4" id="Nominee_Address" name="txtAgtNomAdderss" rows="4" placeholder="Address"></textarea></td>
							</tr>
							<tr>
								<td> <label>State *</label></td>
								<td> <input type="text" id="Nominee_State" class="input-medium span3" name="txtAgtNomState" maxlength="20" placeholder="State" autocomplete="off"/></td>
								<td> <label>City*</label></td>
								<td>  <input type="text" id="Nominee_City" class="input-medium span3" name="AgtNomCity" maxlength="20" placeholder="City"/></td>
							</tr>
							<tr>
								<td> <label>Pin Code *</label></td>
								<td><input type="text"  id="Nominee_PinCode" class="input-medium span3"name="txtAgtNomPinCode" maxlength="6" placeholder="Pincode" onkeypress='return isNumberKey(event)'/></td>
							</tr>
						
						</table>
			</fieldset>
						

			<fieldset class="sectionwrap">		<!-- Third page -->
					<h5>Choose Scheme</h5>	
					<hr/>
						<table class="table table-bordered table-hover">
						<tr>
										<th>Select</th>
										<th>Max Group</th>
										<th>Chit price</th>
										<th>Chit Validity(Years)</th>
									</tr>
					<%
						int schType=0;					//To display available schemes. 
						double schPrice=0;
						double schValidity=0;
						String sqlQuery="select *from scheme_type";
						ArrayList<AddSchemeBean> agentList=CommonDao.schemeList(sqlQuery);  // Call static method(),get list.
							Iterator<AddSchemeBean> list=agentList.iterator();
								
								while(list.hasNext())
								{ 
									AddSchemeBean ViewAgentsBeans=list.next(); //Downcasting.
									
									schType=ViewAgentsBeans.getSchemeType();
									schPrice=ViewAgentsBeans.getSchemePrice();
									schValidity=ViewAgentsBeans.getSchemeValidity();
								%>
									
									<tr>
										<th><input type="radio" id="Select_Scheme" name="selectedSch" value="<%=schType%>"></th>
										<th><%=schType%></th>
										<th id="schPrice"><%=schPrice%></th>
										<th><%=schValidity%></th>
									</tr>
								
							<%}%>
							</table>
			</fieldset>

			<fieldset class="sectionwrap">		<!-- Fourth page -->
					<h5>Upload Photos</h5>	
					<hr/>
					<table>
					<tr>
						<th>Upload Passport Size Photo *</th>
						<td><input type="file" name="AgtImage"/></td>
						<th> Upload Id Proof:</th>
						<td><input type="file" name="AgtIdImage"/></td>
					</tr>
				</table>
						<p align="center">
							</strong>Upload PAN:</strong>
							<input type="file" name="AgtPanImage"/>
						</p>
			</fieldset>					
			

			<fieldset class="sectionwrap">		<!-- Fifth page -->
					<h5>Payment</h5>	
					<hr/>
					<table>
					<tr>
						<th>Mode Of Payment</th>
						<td><input type="text" type="text" id="ChitPrice" placeholder="price"></input></td>
                        <td><select class="input-large" name="AgtPayMode">
                        	<option value="Cash">Cash</option>
                        	<option value="Cheque">Cheque</option>
                            <option value="online">online</option>
                            </select>
                        </td>
					</tr>
					</table>
                    <hr>
                    <h4>online Payment</h4>

    <div class="row">		<!-- Main online pay row -->
		<div class="span6">		<!-- Main span6 -->
			<form class="form-horizontal span6">	<!--Form-->
				<fieldset>	<!-- Fieldset---->

					<div class="control-group">
						<label class="control-label">Card Holder's Name</label>
							<div class="controls">
								<input class="input-block-level" required type="text" required="" title="Fill your first and last name" pattern="\w+ \w+.*">
							</div>
					</div>

					<div class="control-group">
						<label class="control-label">Card Number</label>
							<div class="controls">
								<div class="row-fluid">
									<div class="span3">
										<input class="input-block-level" type="text" required title="First four digits" pattern="\d{4}" maxlength="4" autocomplete="off">
									</div>
									<div class="span3">
										<input class="input-block-level" type="text" required title="Second four digits" pattern="\d{4}" maxlength="4" autocomplete="off">
									</div>
									<div class="span3">
										<input class="input-block-level" type="text" required title="Third four digits" pattern="\d{4}" maxlength="4" autocomplete="off">
									</div>
									<div class="span3">
										<input class="input-block-level" type="text" required title="Fourth four digits" pattern="\d{4}" maxlength="4" autocomplete="off">
									</div>
								</div>
							</div>
					</div>

					<div class="control-group">
						<label class="control-label">Card Expiry Date</label>
							<div class="controls">
								<div class="row-fluid">
									<div class="span9">
										<select class="input-block-level">
											<option>January</option>
											<option>...</option>
											<option>December</option>
										</select>
									</div>
									<div class="span3">
										<select class="input-block-level">
											<option>2013</option>
											<option>...</option>
											<option>2015</option>
											</select>
									</div>
								</div>
							</div>
					</div>

					<div class="control-group">
						<label class="control-label">Card CVV</label>
							<div class="controls">
								<div class="row-fluid">
									<div class="span3">
										<input class="input-block-level" type="text" required title="Three digits at back of your card" pattern="\d{3}" maxlength="3" autocomplete="off">
									</div>
									<div class="span8"> 
									</div>
								</div>
							</div>
					</div>


					<div class="form-actions">
						<button class="btn btn-primary" type="submit">Submit</button>
						<button class="btn" type="button">Cancel</button>
					</div>

				</fieldset>	<!-- end Of Fieldset---->
			</form>	<!-- end Of Form-->
		</div>	<!-- end Main span6 -->
	</div>		<!--END of Main online pay row -->
             
					<hr><br>
						<p align="center">
							<input type="submit" class="btn btn-primary btn-large" value="Register" >	<!-- Submit whole form. -->
						 </p>				
			</fieldset>			

				</form> <!-- Single Form Closed -->				
             </div><!--  page inner  -->
	  </div><!--end of page wrapper --> 
    </div><!--end of main wrapper --> 
      
         
		<footer class="chitFooter navbar-static-bottom">			<!-- Footer -->
		<center><font color="black" size="1px">Copyright @ 2014 Werise Foundation. www.WeriseFoundation.org. All Rights Reserved.</font><br>
		<a href="about.jsp"><font color="black" size="2px">About Us</font></a>|
		<a href="enquiry.jsp"><font color="black" size="2px">Contact Us</font></a>
		</center>
		</footer>

   

	<!-- <script src="./js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="js/raphael-2.1.0.min.js"></script>
    <script src="js/morris.js"></script>  -->
   
    <script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.metisMenu.js"></script>
	<script src="js/custom.js"></script>
	<script src="js/forward.js" type="text/javascript"></script>
	<script src="./js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="js/bootstrap-typeahead.js" type="text/javascript"></script>


	<script type="text/javascript">
		var myform3=new formtowizard({
		formid: 'Single_Form',
		validate: ['FirstName', 'LastName', 'Email','MobileNo', 'Address', 'State','City', 'PinCode', 'PanNumber','DOB', 'Gender','Nominee_FirstName','Nominee_Relationship',  'Nominee_Email','Nominee_MobileNo', 'Nominee_Address', 'Nominee_State','Nominee_City', 'Nominee_PinCode','Select_Scheme'],
		revealfx: ['slide', 500] //<--no comma after last setting
		});
</script>

 <script>	 // typeahead for states field
		 jQuery( document ).ready( 
		$('#State').typeahead ({
			
        source: [
		    { id: 1, name: 'KARNATAKA' },
		    { id: 2, name: 'ASSAM' },
		    { id: 3, name: 'ANDHARAPRADESH' },
		    { id: 4, name: 'ARUNACHALPRADESH' },
		    { id: 5, name: 'ASSAM' },
		    { id: 6, name: 'BIHAR' },
		    { id: 7, name: 'CHHATTISGARH' },
		    { id: 8, name: 'DELHI' },
		    { id: 9, name: 'GOA' },
		    { id: 10, name: 'GUJRAT'},
			{ id: 11, name: 'HARAYANA' },
		    { id: 12, name: 'JAMMU-KASHMIR' },
		    { id: 13, name: 'JARKHAND' },
		    { id: 14, name: 'KERLA' },
		    { id: 15, name: 'MADHYAPRADESH' },
		    { id: 16, name: 'MAHARASHTRA' },
		    { id: 17, name: 'MIZORAM' },
		    { id: 18, name: 'MEGALAYA' },
		    { id: 19, name: 'MANIPUR' },
		    { id: 20, name: 'NAGALAND' },
			{ id: 21, name: 'ORRISA' },
		    { id: 22, name: 'PANJAB' },
		    { id: 23, name: 'RAJASHTAN' },
		    { id: 24, name: 'SAKKIM' },
		    { id: 25, name: 'TRIPURA' },
		    { id: 26, name: 'UTTARPRADESH' },
		    { id: 27, name: 'UTTARKHAND' },
		    { id: 28, name: 'WESTBENGAL' },
	    ],
    //    itemSelected: displayResult
    }));
</script>
 <script>	 // typeahead for states field
		 jQuery( document ).ready( 
		$('#Nominee_State').typeahead ({
			
        source: [
		    { id: 1, name: 'KARNATAKA' },
		    { id: 2, name: 'ASSAM' },
		    { id: 3, name: 'ANDHARAPRADESH' },
		    { id: 4, name: 'ARUNACHALPRADESH' },
		    { id: 5, name: 'ASSAM' },
		    { id: 6, name: 'BIHAR' },
		    { id: 7, name: 'CHHATTISGARH' },
		    { id: 8, name: 'DELHI' },
		    { id: 9, name: 'GOA' },
		    { id: 10, name: 'GUJRAT'},
			{ id: 11, name: 'HARAYANA' },
		    { id: 12, name: 'JAMMU-KASHMIR' },
		    { id: 13, name: 'JARKHAND' },
		    { id: 14, name: 'KERLA' },
		    { id: 15, name: 'MADHYAPRADESH' },
		    { id: 16, name: 'MAHARASHTRA' },
		    { id: 17, name: 'MIZORAM' },
		    { id: 18, name: 'MEGALAYA' },
		    { id: 19, name: 'MANIPUR' },
		    { id: 20, name: 'NAGALAND' },
			{ id: 21, name: 'ORRISA' },
		    { id: 22, name: 'PANJAB' },
		    { id: 23, name: 'RAJASHTAN' },
		    { id: 24, name: 'SAKKIM' },
		    { id: 25, name: 'TRIPURA' },
		    { id: 26, name: 'UTTARPRADESH' },
		    { id: 27, name: 'UTTARKHAND' },
		    { id: 28, name: 'WESTBENGAL' },
	    ],
    //    itemSelected: displayResult
    }));
</script>

	

</body>
</html>
