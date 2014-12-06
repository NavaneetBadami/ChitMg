<!DOCTYPE html>
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
  <meta charset="utf-8" />
  <!-- Set the viewport width to device width for mobile -->
  <meta name="viewport" content="width=device-width" />

 <title>WeRise Chits</title>
	 <link rel="icon" href="images/Fevicon.ico">
  <!-- Included Bootstrap CSS Files -->
	<link rel="stylesheet" href="css/bootstrap.css" />
	<link rel="stylesheet" href="css/bootstrap.min.css" /> 
	<link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
	
	<!-- Included Bootstrap Customization CSS Files -->	
	<link href="css/Main_chitFund.css" rel="stylesheet" />

	<link href="css/toastr.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="js/jquery-1.10.2.js"></script>
	<script src="js/toastr.js" type="text/javascript"></script>
 
	<style>
	#nnavbar{position:absolute; right: 0px}
	</style>
	<script type="text/javascript">
								toastr.options.closeButton = true;
								toastr.options.positionClass = "Ntoast-top-right";
								toastr.options.newestOnTop = false;
	</script>


</head>

<body>
   <div class="navbar navbar-static-top">   <!--Top nav Bar -->
    <div class="navbar-inner">
		<ul class="nav navbar-nav navbar-right">
			<li><a href="#" title="HOME" class="tip"><IMG SRC="images/Logo2.jpg" width=150/></a></h1></li>
		</ul>
		<div id="nnavbar"  role="navigation">	<!-- elements on right side 20-10-2014 -->
          <ul class="nav navbar-nav navbar-left ">
                <li><a href="main-index.jsp">Home</a></li>
                <li><a href="about.jsp">About Us</a></li>
                <li><a href="#">Join US</a></li>
                <li><a href="features.jsp">Features</a></li>
                <li><a href="enquiry.jsp">Enquiry</a></li>
          </ul>
        </div>
      </div>
	 </div>
				 <!-- End of Top Nav Bar... -->
<%
			String resp=(String)request.getAttribute("status"); //get the response from COntactController servlet.		
			if(resp!=null && resp.equalsIgnoreCase("saved"))
			{%>
				<div class="chitFundModal">
					<a href="enquiry.jsp" class="close" data-dismiss="modal"><b id="x">&times;</b></a>
					<div class="modal-header alert alert-success">
						<h5>Hello,<br><p>We've successfully recevied your message and our customer representative will contact you shortly.</p><br>Thanks.</h5>
					</div>
				</div><!-- Endo of chitFundModal -->
		
			<%}

			if(resp!=null && resp.equalsIgnoreCase("notSaved"))
			{%>

				<div class="chitFundModal">
					<a href="enquiry.jsp" class="close" data-dismiss="modal"><b id="x">&times;</b></a>
					<div class="modal-header alert alert-error">
						<h5>Sorry..! Message has not been set.  </h5>
					</div>
				</div><!-- Endo of chitFundModal -->	
			<%}
%>	

<div class="container">			<!-- main container -->

		<div class="row">		<!-- For Google map -->
			<div class="span12">
				<iframe style="width: 100%; height: 400px; border: none;" src="https://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=Silicon+Valley,+United+States&amp;aq=1&amp;oq=sillicon+valley&amp;sll=31.428663,-100.085449&amp;sspn=5.642034,9.876709&amp;ie=UTF8&amp;hq=&amp;hnear=Silicon+Valley&amp;ll=37.372517,-122.03476&amp;spn=0.020534,0.038581&amp;t=m&amp;z=14&amp;output=embed"></iframe>
			</div>
		</div>

		<div class="row">			<!-- Contact Form. -->
			<div class="span6">
				<h2 align="center">Contact Us</h2>
				<form id="contact-form" class="form-horizontal" action="contactUsUrl" method="post">
					<div class="control-group">
						<label class="control-label" for="name">Name</label>
						<div class="controls">
							<input type="text" required="" class="span4" id="name" name="name">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="email">Email</label>
						<div class="controls">
							<input type="text" required="" class="span4" id="email" name="email">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="phone">Phone</label>
						<div class="controls">
							<input type="text" required="" class="span4" id="mobile" name="mobile">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="city">City</label>
						<div class="controls">
							<input type="text" required="" class="span4" id="city" name="city">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="message">Comment</label>
						<div class="controls">
							<textarea class="span4" required="" id="message" name="message" rows="6"></textarea>
						</div>
					</div>
					<div class="control-group">
						<div class="controls action">
							<button type="submit" class="btn btn-primary btn-block">Send</button>
						</div>
					</div>
				</form>
			</div>		<!-- end of span6 -->

			<div class="span5 offset1">			<!-- Address form -->
				<div class="address">
					<h3>Address</h3>
					<p>
						Werise Foundation, 2nd Floor, XYZ building 
						<br> Bangalore, Karnataka,<br> India Zip Code:560040.
					</p>
					<div class="info">
						<i class="contact phone"></i>
						18001254678
					</div>
					<div class="info">
						<i class="contact email"></i>
						www.WeriseFoundation.org.
					</div>
					<hr>
					<h3>Social media</h3>
					<div class="social">
						<a href="#"><img src="img/socials/facebook.png" alt="" /></a>
						<a href="#"><img src="img/socials/twitter.png" alt="" /></a>
						<a href="#"><img src="img/socials/youtube.png" alt="" /></a>
					</div>
				</div>
			</div>		<!-- end of span5 offset1 -->
		</div>			<!-- end of main Row div -->	


	</div>			<!-- End of Main Container. -->

					<!-- footer -->
<footer class="chitFooter navbar-static-bottom">
		<center><font color="black" size="1px">Copyright @ 2014 Werise Foundation. www.WeriseFoundation.org. All Rights Reserved.</font><br>
		<a href="about.jsp"><font color="black" size="2px">About Us</font></a>|
		</center>
	 </div>
   </footer>
					<!-- Js Files -->
	<script src="js/jquery-1.8.3.min.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
