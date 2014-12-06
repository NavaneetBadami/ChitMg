<!DOCTYPE html>
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
  <meta charset="utf-8" />
  <!-- Set the viewport width to device width for mobile -->
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <title>WeRise Chits||Chit mangement</title>
 <link rel="icon" href="images/Fevicon.ico">

  <!-- Included Bootstrap CSS Files -->
	<link rel="stylesheet" href="css/bootstrap.css" />
	<link rel="stylesheet" href="css/bootstrap.min.css" />
	<link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
	
	<!-- Included Customization CSS Files -->	
	<link rel="stylesheet" href="css/Main_Login.css" />
 	<link rel="stylesheet" href="css/sliderstyle.css" type="text/css" media="screen"/>


	<style>
	#nnavbar{position:absolute; right: 0px}
	</style>
</head>

<body>
<%
 HttpSession ses=request.getSession(false);
 ses.removeAttribute("adminId");
 ses.removeAttribute("agentId");
 ses.invalidate();
%>
  <div class="navbar navbar-static-top">   <!--Top nav Bar -->
    <div class="navbar-inner">
		<ul class="nav navbar-nav navbar-right">
			<li><a href="main-index.jsp" title="HOME" class="tip"><IMG SRC="images/Logo2.jpg" width=150/></a></h1></li>
		</ul>
		<div id="nnavbar"  role="navigation"> <!-- elements on right side 20-10-2014 -->
          <ul class="nav navbar-nav navbar-left ">
                <li><a href="about.jsp">About Us</a></li>
                <li><a href="#">Join US</a></li>
                <li><a href="features.jsp">Features</a></li>
                <li><a href="enquiry.jsp">Enquiry</a></li>
          </ul>
        </div>
      </div>
	 </div>


<%
String resp=null;
			resp=(String)request.getAttribute("status"); //get the response from ForgetUnPwController servlet.		
			if(resp!=null && resp.equalsIgnoreCase("emailNotFound"))
			{%>
				<div class="chitFundModal">
					<a href="main-index.jsp" class="close" data-dismiss="modal"><b id="x">&times;</b></a>
					<div class="modal-header alert alert-error">
						<h5>Sorry..!Email not found, please enter correct email id.</h5>
					</div>
				</div><!-- Endo of chitFundModal -->
				<div class="modal-backdrop fade in"></div>
			<%}

			if(resp!=null && resp.equalsIgnoreCase("sentSuccess"))
			{%>
				<div class="chitFundModal">
					<a href="main-index.jsp" class="close" data-dismiss="modal"><b id="x">&times;</b></a>
					<div class="modal-header alert alert-success">
						<h5>UserId and Password have been sent to respective email Id.</h5>
						<h6><i>Login again...</i></h6>
					</div>
				</div><!-- Endo of chitFundModal -->
				<div class="modal-backdrop fade in"></div>
			<%}

			if(resp!=null && resp.equalsIgnoreCase("notSent"))
			{%>
				<div class="chitFundModal">
					<a href="main-index.jsp" class="close" data-dismiss="modal"><b id="x">&times;</b></a>
					<div class="modal-header alert alert-error">
						<h5>UserId and Password have not been sent to respective email Id.</h5>
						<h6><i>please try again...</i></h6>
					</div>
				</div><!-- Endo of chitFundModal -->
				<div class="modal-backdrop fade in"></div>
			<%}

			String status2=(String)request.getAttribute("status"); //get the response from LoginController servlet.
			if(status2!=null && status2.equalsIgnoreCase("validityOver"))
			{%>
				<div class="agentValModal">
					<a href="main-index.jsp" class="close" data-dismiss="modal"><b id="x">&times;</b></a>
						<div class="modal-header alert alert-error">
						<h5>Hello Agent,</h5>
						<h4>Your account validity has been expired so contact WeRise ChitFund Customer care:0800000000.</h4>
						<h6>Thanks</h6>
						</div>
					</div><!-- Endo of chitFundModal -->
				<div class="modal-backdrop fade in"></div>
			<%}

	%>	

  
<div class="row">	<!-- Main row -->

<div class="span3"></div>   

<div class="span3"></div>  
	
<div class="span4"> <!-- span4 Login Panel -->
 <div id="login-wraper">		<!-- Login Panel -->
	<h3>Login panel</h3>
			<div class="tabbable ">		
				<ul class="nav nav-tabs">
					<li class="active"><a href="#tab1" data-toggle="tab">Admin Login</a></li>
					<li><a href="#tab2" data-toggle="tab">Agent Login</a></li>
					<li><a href="#tab3" data-toggle="tab">Member Login</a></li>
				</ul>
			</div>

			<div class="tab-content">		<!-- Tab Content -->    

					<div class="tab-pane active alert-success" id="tab1">
					<h5>Admin Login</h5>
					<form class="login-form" action="adminLoginUrl" method="post">
						<input type="text" name="txtAdminID"  required="" title="please insert AdminID" pattern="\w+.*" class="input input-prepend" placeholder="Admin ID"><br>
						<input type="password" name="txtAdminPwd" required title="please insert AdminID" class="input input-prepend" placeholder="Password"><br>
						<button type="submit" class="btn btn-block btn-info">Login</button>	
					</form>
						<A HREF="#forgetAdmin" data-toggle="collapse"><font size=2>Forgetten Username or Password..!</font></A>
							<div id="forgetAdmin" class="accordion-body collapse">
							<div class="accordion-inner">
							<input type="text" required title="please insert AdminID" class="input input-prepend" placeholder="Enter Email Id"name=""/>&nbsp;&nbsp;<button type="submit" class="btn btn-info">Send</button>	
							</div>
							</div> 
					</div>
				
					<div class="tab-pane alert-error" id="tab2">
					<h5>Agent Login</h5>
						<form class="login-form" action="agentloginUrl" method="post">
						<input type="text" name="txtAgentID" required title="please insert AgentID" pattern="\w+.*" class="input input-prepend" placeholder="Agent ID"><br>
						<input type="password" name="password" required title="please insert Password" class="input input-prepend" placeholder="Password"><br>
						<button type="submit" class="btn btn-block btn-info">Login</button>
					</form>
					<A HREF="#forgetAgent" data-toggle="collapse"><font size=2>Forgetten Username or Password..!</font></A>
							<div id="forgetAgent" class="accordion-body collapse">
							<div class="accordion-inner">
								<form action="forgetUnPwUrl" method="post">
								<input type="text" required title="please insert AgentID" class="input input-prepend" placeholder="Enter Email Id" name="reEmail"/>&nbsp;&nbsp;<button type="submit" class="btn btn-info">Send</button>	
							</form>
							</div>
							</div>
					</div>

					<div class="tab-pane alert-info" id="tab3">
					<h5>Member Login</h5>
						<form class="login-form" action="memLoginUrl" method="post">
						<input type="text" class="input input-prepend" name="memberId" placeholder="Member ID"><br>
						<!-- <input type="password" class="input input-prepend" placeholder="Password"><br> -->
						<button type="submit" class="btn btn-block btn-info">Login</button>
						</form>
					</div>

			</div>	<!-- End Of Tab Contnt. -->


					<%
						String status=null;
						status=(String)request.getAttribute("status"); //get the response from LoginController servlet.
						if(status!=null && status.equalsIgnoreCase("invalid"))
						{%>
										<div class="modal-header alert alert-error">
											<h5 id="myModalLabel">Sorry..! Invalid Password or UserName.</h5>
										</div>
						<%}

						status=(String)request.getAttribute("status"); //get the response from LoginController servlet.
						if(status!=null && status.equalsIgnoreCase("invalidMember"))
						{%>
										<div class="modal-header alert alert-error">
											<h5 id="myModalLabel">Sorry..! Invalid Member ID..</h5>
										</div>
						<%}

						
					%>	
			</div>		<!-- End of Login Panel -->
		</div>


</div>	<!-- End of Main row -->

	<footer class="navbar-fixed-bottom">			<!-- Footer -->
		<center><font color="black" size="1px">Copyright @ 2014 Werise Foundation. www.WeriseFoundation.org. All Rights Reserved.</font><br>
		<a href="about.jsp"><font color="black" size="2px">About Us</font></a>|
		<a href="enquiry.jsp"><font color="black" size="2px">Contact Us</font></a>
		</center>
   </footer>

	<script src="js/jquery-1.8.3.min.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/holder.js"></script>
	<script src="js/backstretch.min.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {

			$.backstretch([
		      "images/1.jpg", 
		      "images/4.jpg"
		  	], {duration: 3000, fade: 750});

		});
	</script>
</body>
</html>