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
    <!-- <link href="css/Main_chitFund.css" rel="stylesheet" />  -->
 	<link rel="stylesheet" href="css/sliderstyle.css" type="text/css" media="screen"/>


	<style>
	#nnavbar{position:absolute; right: 0px}
	</style>
</head>

<body>
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

  
<div class="row alert">	<!-- Main row -->

<div class="span9">		<!-- Span8 rotator -->
        <div class="rotator"> <!-- rotator -->
                <ul id="rotmenu">
                   <li>
                       <a href="rot1">About Us</a>
                        	<div style="display:none;">
                           		 <div class="info_image">1.jpg</div>
                            	<div class="info_description">
				Werise Chit Soft is a complete solution for chit fund managing agents. Werise Chit Soft software is designed specifically to meet the unique needs of chit fund and kuries companies by providing an integrated accounting package, subscribers management,auction and prize management...
                                <a href="about.jsp" class="more">Read more</a>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="rot2">Why Werise Chits?</a>
                        <div style="display:none;">
                            <div class="info_image">2.png</div>
                           
                            <div class="info_description">
							not yet added
                                <a href="features.jsp" class="more">Read more</a>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="rot3">View Schemes</a>
                        <div style="display:none;">
                            <div class="info_image">3.png</div>
                            
                            <div class="info_description">
									Choose your right plan which exactly match your requirements...
                                <a href="#" class="more">Read more</a>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="rot4">What is Chit Fund?</a>
                        <div style="display:none;">
                            <div class="info_image">4.jpg</div>
                           
                            <div class="info_description">
								A chit fund is a savings or borrowing scheme, in which a group of people enter into an agreement to contribute fixed amounts periodically, for a specified period of time...
                                <a href="WhatChitFund.jsp" class="more">Read more</a>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="rot5">Request Demo</a>
                        <div style="display:none;">
                            <div class="info_image">5.png</div>
                            <div class="info_heading">Working things</div>
                            <div class="info_description">
                               Are you inrested?????Feel Free to talk with us:<br>
                               <br><font size="20px"color="white";>080 42195341</font>
							</div>
                        </div>
                    </li>
                </ul>
                <div id="rot1">
                  <div class="heading">
                    <h1><img src="" width="800" height="300" class="bg" alt=""/></h1>
                    </div>
                    <div class="description">
                        <p></p>

                    </div>    
                </div>
            </div> <!--end rotator -->
    </div>   <!-- end of Span8 rotator -->


	
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

 <!-- The JavaScript -->

	<script src="js/jquery-1.10.2.js"></script>
    <script src="js/bootstrap.min.js"></script>
	<script src="./js/script.js"></script>	

					<!-- Js For Slider -->
        <script type="text/javascript" src="js/min.js"></script>
        <script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
        <script type="text/javascript">
            $(function() {
                var current = 1;
                
                var iterate		= function(){
                    var i = parseInt(current+1);
                    var lis = $('#rotmenu').children('li').size();
                    if(i>lis) i = 1;
                    display($('#rotmenu li:nth-child('+i+')'));
                }
                display($('#rotmenu li:first'));
                var slidetime = setInterval(iterate,3000);
				
                $('#rotmenu li').bind('click',function(e){
                    clearTimeout(slidetime);
                    display($(this));
                    e.preventDefault();
                });
				
                function display(elem){
                    var $this 	= elem;
                    var repeat 	= false;
                    if(current == parseInt($this.index() + 1))
                        repeat = true;
					
                    if(!repeat)
                        $this.parent().find('li:nth-child('+current+') a').stop(true,true).animate({'marginRight':'-20px'},300,function(){
                            $(this).animate({'opacity':'0.7'},700);
                        });
					
                    current = parseInt($this.index() + 1);
					
                    var elem = $('a',$this);
                    
                        elem.stop(true,true).animate({'marginRight':'0px','opacity':'1.0'},300);
					
                    var info_elem = elem.next();
                    $('#rot1 .heading').animate({'left':'-420px'}, 500,'easeOutCirc',function(){
                        $('h1',$(this)).html(info_elem.find('.info_heading').html());
                        $(this).animate({'left':'0px'},400,'easeInOutQuad');
                    });
					
                    $('#rot1 .description').animate({'bottom':'-270px'},500,'easeOutCirc',function(){
                        $('p',$(this)).html(info_elem.find('.info_description').html());
                        $(this).animate({'bottom':'0px'},400,'easeInOutQuad');
                    })
                    $('#rot1').prepend(
                    $('<img/>',{
                        style	:	'opacity:0',
                        className : 'bg'
                    }).load(
                    function(){
                        $(this).animate({'opacity':'1'},600);
                        $('#rot1 img:first').next().animate({'opacity':'0'},700,function(){
                            $(this).remove();
                        });
                    }
                ).attr('src','images/'+info_elem.find('.info_image').html()).attr('width','850').attr('height','300')
                );
                }
            });
        </script>
</body>
</html>