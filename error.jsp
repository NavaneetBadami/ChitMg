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
	<link href="css/morris-0.4.3.min.css" rel="stylesheet" />
	<link href="css/font-awesome.css" rel="stylesheet" />
	<link href="css/custom.css" rel="stylesheet" />

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


  
<div class="row">	<!-- Main row -->
			<div class="span12">
            	<div class="span4"></div>
            	<div class="span5">
				<div class=" panel-primary text-center no-boder bg-color-red">
					<div class="panel-body">
						<i class="fa fa-smile-o fa-5x"></i>
                        <h4>Sorry..! Something went wrong try again..</h4>
					</div>
                    <div class="panel-footer back-footer-mehindi tip">
                   		<a href="main-index.jsp" class=" btn btn-inverse">Login again</a>
                    </div>
				</div>
             </div>   
          </div>
			                
</div>	<!-- End of Main row -->

	<footer class="navbar-fixed-bottom">			<!-- Footer -->
		<center><font color="black" size="1px">Copyright @ 2014 Werise Foundation. www.WeriseFoundation.org. All Rights Reserved.</font><br>
		<a href="about.jsp"><font color="black" size="2px">About Us</font></a>|
		<a href="enquiry.jsp"><font color="black" size="2px">Contact Us</font></a>
		</center>
   </footer>

 <!-- The JavaScript -->

	<script src="js/jquery-1.10.2.js"></script>
    <script src="js/bootstrap.min.js"></script>
	<script src="./js/script.js"></script>	
</body>
</html>