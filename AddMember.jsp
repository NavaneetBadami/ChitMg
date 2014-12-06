<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" 
import="java.lang.*,java.util.*,java.io.*,java.sql.*,java.sql.Statement,java.io.*,javax.servlet.RequestDispatcher.*,java.util.ArrayList"
import="com.riseon.chitfund.services.ConnectionProvider"
import="com.riseon.chitfund.dao.AddMemberDao"
import="com.riseon.chitfund.dto.AddMemberBeans"
import="com.riseon.chitfund.supports.CommonDao"
import="com.riseon.chitfund.controller.AgentLoginController"
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
	.input-medium 
		{
		height:25px !important;
		border-color: solid black;
		}

</style>

<script src="js/jquery-1.10.2.js"></script>
<link rel="stylesheet" type="text/css" href="css/forward.css" />
<script src="js/forward.js" type="text/javascript"/>
</script>
<script type="text/javascript">
		var myform3=new formtowizard({
		formid: 'Single_Form',
		validate: ['FirstName', 'LastName','MobileNo', 'Address', 'PinCode','SuretyType','Nominee_FirstName','Nominee_Relationship', 'Nominee_MobileNo', 'Nominee_Address','Nominee_PinCode'],
		revealfx: ['slide', 500] //<--no comma after last setting
		})
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
	.input-medium 
		{
		height:25px !important;
		border-color: solid black;
		}
	</style>
</head>

<body>

<%
	HttpSession ses=request.getSession(false);
	String agentId = (String)ses.getAttribute("agentId");
	if(agentId == null){
	response.sendRedirect("main-index.jsp");
	} 	

	Integer membersleft=(Integer)request.getAttribute("groupCount"); //get the response from AddMemberController servlet.
	String groupStatus=(String)request.getAttribute("groupStatus");
	
	ServletContext ctx=getServletContext();       //get the groupID from CreateGropuController.
	String groupId=(String)ctx.getAttribute("groupId");

	String agentName=AgentLoginController.agentName.get(agentId);	//map(k,v)
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
                        <a href="#" class="active-menu" ><i class="fa fa-qrcode fa-3x"></i>Chit Group<span class="fa arrow"></span></a>
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
                        <a  href="Blank.jsp"><i class="fa fa-square-o fa-3x"></i> Blank Page</a>
                    </li>	
                </ul>   
            </div>
		</nav> 			<!-- Side wrapper close -->

		
      <div id="page-wrapper">  <!--  page Wrapper -->
           <div id="page-inner"> <!--  page inner-->	
 

 <%
    if(groupStatus!=null && groupStatus.equalsIgnoreCase("AllFilled"))
    	{%>
    		
    		 <div class="chitFundModal">
					<a href="agent_home.jsp" class="close" data-dismiss="modal"><b id="x">X&nbsp;</b></a>
					<div class="modal-header alert alert-success">
                    <h4>Congrats..! </h4>
                    </div>
                    	<div class="modal-body">
                        <h5>Hello,<br><p>All membres have added to group, lets begin auction process.</p><br>Thanks.</h5>
                        </div>						
				</div><!-- Endo of chitFundModal -->
				<div class="modal-backdrop fade in"></div>
    	<%}
      else
      {%>

		<h4><font face="Verdana, Geneva, sans-serif" color="#408080">Add Member</font></h4>   
         <hr/>	
							
		<form action="addMemberUrl" id="Single_Form"  method="post" enctype="multipart/form-data">

			<fieldset class="sectionwrap alert-info">			<!-- First page -->
					<h5>Member Information</h5>
					<hr/>
						 <table>
						<tr>
							<td>First Name</td>
							<td> <input type="text" class="input-medium span3" id="FirstName" name="txtMemFName" maxlength="16" placeholder="First Name"/></td>
							<td> Last Name</td>
							<td> <input type="text" class="input-medium span3" id="LastName"  name="txtMemLName" maxlength="16" placeholder="Last Name"/></td>

						</tr>
						
						<tr>
							<td> <label>Gender *</label></td>
							<td> <select name="memGender">
								<option value="Male">Male</option>
								<option value="Female">Female</option>
								</select>
							</td>
							<td> <label>Mobile No *</label></td>
							<td><input type="text" class="input-medium span3" id="MobileNo" name="memContactno" maxlength="10" placeholder="Mobile Number" onkeypress='return isNumberKey(event)'/></td>

						</tr>
						<tr>
							<td> <label>Adress</label></td>
							<td><textarea class="span4" id="Address"  name="txtmemAddress" rows="4" placeholder="Address"  maxlength="65"></textarea></td>
						</tr>
						
						<tr>
							<td><label>PIN code</label></td>
							<td><input type="text" id="PinCode" class="input-medium span3" name="memPincode" maxlength="6" placeholder="PIN" onkeypress='return isNumberKey(event)'/></td>
						</tr>
						<tr>
								<td> <label>Surety Type *</label></td>
								<td> <input type="text" id="SuretyType" class="input-medium span3" name="memSuretytype" maxlength="20" placeholder="Surety Type"/></td>
							</tr>
						</table>
			</fieldset>
							
			<fieldset class="sectionwrap alert-info">			<!-- Second page -->
					<h5>Nommine Information</h5>
					<hr/>
							<table>
							<tr>
								<td><label>First Name*</label></td>
								<td>  <input type="text"  id="Nominee_FirstName" class="input-medium span3" name="txtnomName" maxlength="16" placeholder="Nominee Name"/></td>
								<td> <label>Relation ship *</label></td>
								<td><input type="text" id="Nominee_Relationship" class="input-medium span3" name="txtnomRelationship" maxlength="16" placeholder="Relationship"/></td>
							</tr>
						
							<tr>
								<td> <label>Mobile No *</label></td>
								<td> <input type="text" id="Nominee_MobileNo" class="input-medium span3" name="txtnomContactno" maxlength="10" placeholder="Mobile Number" onkeypress='return isNumberKey(event)'/></td>
							</tr>
							
							<tr>
								<td> <label>Adress</label></td>
								<td><textarea class="span4" id="Nominee_Address" name="txtnomAddress" rows="4"  maxlength="65" placeholder="Address"></textarea></td>
							</tr>
							
							<tr>
								<td> <label>Pin Code *</label></td>
								<td><input type="text" id="Nominee_PinCode" class="input-medium span3"name="txtnomPincode" maxlength="6"placeholder="Pincode" onkeypress='return isNumberKey(event)'/></td>
							</tr>				
						</table>
			</fieldset>
			<fieldset class="sectionwrap alert-info">		<!-- Fourth page -->
					<h5>Upload Photos</h5>	
					<hr/>
					<table>
					<tr>
						<td>Upload Passport Size Photo *</td>
						<td><input type="file" name="membphoto"/></td>
						<td> Upload Id Proof:</td>
						<td><input type="file" name="membsuretyphoto"/></td>
					</tr>
				</table>
				<hr>
						<p align="center">
							<input type="submit" class="btn btn-primary btn-large" value="Register" >	<!-- Submit whole form. -->
						 </p>	
			</fieldset>					
		
		</form> <!-- Single Form Closed -->				
	<%}      
  %>


					<!-- Display Current Members in Group -->
	  <%
			if(membersleft!=null)	//After adding one member in group.
    		{%>
							<h4 class="alert alert-success">Current Members in List</h4>
    				 		
					<% 
						 String query="select *from members_details where groupId='"+groupId+"'";

						 ArrayList<AddMemberBeans> lst=CommonDao.groupDetails(query);	//Call the Static Method.
						 ListIterator<AddMemberBeans> listed=lst.listIterator();  //Iterate the LIST.
						 
						 while(listed.hasNext())
						{
								AddMemberBeans grpMember=listed.next(); //DownCast the list to Bean.
								
								String memFirstName=grpMember.getMemFirstName();
								String memLastName=grpMember.getMemLastName();
								String memId=grpMember.getMemId();
								String memAddress=grpMember.getMemAddress();
								long memMobileNo=grpMember.getMemMobileNo();
								String memGender=grpMember.getMemGender();
								int memPinCode=grpMember.getMemPinCode();
								String memPanNo=grpMember.getMemPanNO();
								String memSurety=grpMember.getMemSuretyType();
								String nomName=grpMember.getMemNomFName();
								String nomRelation=grpMember.getMemNomRelationship();
								String nomAddress=grpMember.getMemNomAddress();
								int nomPincode=grpMember.getMemNomPinCode();
								long nomMobileno=grpMember.getMemMobileNo();
								
							%>

				
					<ul><li><a href="#<%=memId%>" class="tip" title="Click to View Details" data-toggle="modal"><%=memFirstName%></a></li></ul><!-- trigger -->
				
				<!-- in ChitFund.css 69 -->			<!-- Display Model. -->
				<div id="<%=memId%>" class="modalChit hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-header alert-info">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><b id="x">X</b></button>
						<h4 id="myModalLabel"><%=memFirstName%>&nbsp;Member Details.</h4>
					</div>

					<div class="modal-body ">	<!-- MOdel Body  -->
			
					<div class="span12">
							<div  class="span5">
								<h5 class="alert alert-success">Member Information</h5>
								<table class="table table-hover">
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
								</table>
						
								<table class="table table-hover">
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
							<div  class="span5">			
							<h5 class="alert alert-success">&nbsp;Current Location.</h5>
							<hr/>
								<address>
									<strong><%=memFirstName%>&nbsp;<%=memFirstName%></strong><br>
									<p><i class="icon icon-map-marker"></i>&nbsp;<%=memAddress%><BR>
										&nbsp;-<%=memPinCode%>
									</p><br>
									<h5>Mobile:</abbr> <a href="tel:<%=memMobileNo%>"><%=memMobileNo%></a>
								</address>
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
								</div>
							</div>
							</div> <!-- End Of modal body -->

								<div class="modal-footer">
									<button type="reset" class="btn btn-medium btn-error" data-dismiss="modal">Close</button>
								</div>
			</div><!-- End Of Display modal -->		
			
			<%} //End of If statement.
		%>
						
	<%}		//End of while.

 %>
             </div><!--  page inner  -->
	  </div><!--end of page wrapper --> 
    </div><!--end of main wrapper --> 
      
         
		<footer class="chitFooter navbar-static-bottom">			<!-- Footer -->
		<center><font color="black" size="1px">Copyright @ 2014 Werise Foundation. www.WeriseFoundation.org. All Rights Reserved.</font><br>
		<a href="about.jsp"><font color="black" size="2px">About Us</font></a>|
		<a href="enquiry.jsp"><font color="black" size="2px">Contact Us</font></a>
		</center>
		</footer>

		
		
   
    
   <!-- <script src="js/jquery-1.10.2.js"></script> -->
    <script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.metisMenu.js"></script>
	<script src="js/custom.js"></script>

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
</body>
</html>
