<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="network">
<head>
 <title>Network Travels</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <!-- GOOGLE FONTS -->
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400italic,400,300,600' rel='stylesheet' type='text/css'>
    <!-- /GOOGLE FONTS -->
    <link rel="stylesheet" href="../resource/css/bootstrap.css">
    <link rel="stylesheet" href="../resource/css/font-awesome.css">
    <link rel="stylesheet" href="../resource/css/icomoon.css">
    <link rel="stylesheet" href="../resource/css/styles.css">
    <link rel="stylesheet" href="../resource/css/mystyles.css">
    <link rel="stylesheet" href="../resource/css/typeahead.css">
     
    <script src="../resource/js/angular.js"></script>
    <script src="../resource/js/angular-local-storage.js"></script>
    <script src="../resource/js/dirPagination.js"></script>
    <script src="../resource/angularjs/controller/busresult.js"></script>
	<script src="../resource/angularjs/services/BusService.js"></script>
     
     
<style>
@font-face {
  font-family: "RobotoLight";
  font-style: normal;
  font-weight: normal;
  src: url("//www.makemytrip.com/new_hlp/fonts/roboto/Roboto-Light-webfont.eot?#iefix") format("embedded-opentype"), url("//www.makemytrip.com/new_hlp/fonts/roboto/Roboto-Light-webfont.woff") format("woff"), url("//www.makemytrip.com/new_hlp/fonts/roboto/Roboto-Light-webfont.ttf") format("truetype"), url("//www.makemytrip.com/new_hlp/fonts/roboto/Roboto-Light-webfont.svg#RobotoLight") format("svg");
}

.html{
	overflow-y: hidden;
}
.body {
	 font-family: "RobotoLight";
	
	 
}.test{
	background-color: rgba(255, 255, 255, 0.2);
	box-sizing : border-box;
	border-radius: 10px;
}.modal {
    display:    none;
    position:   fixed;
    z-index:    1000;
    top:        0;
    left:       0;
    height:     100%;
    width:      100%;
    background: rgba( 255, 255, 255, .8 ) 
                url('http://i.stack.imgur.com/FhHRx.gif') 
                50% 50% 
                no-repeat;
}

body.loading {
    overflow: hidden;   
}

/* Anytime the body has the loading class, our
   modal element will be visible */
body.loading .modal {
    display: block;
}


[ng-cloak],
[data-ng-cloak],
[x-ng-cloak],
.ng-cloak,
.x-ng-cloak {
   display: none !important; 
}

</style>

</head>
<body data-ng-controller="selectSeatController" ng-class="{loading : loading}" ng-cloak>


    <!-- FACEBOOK WIDGET -->
    <div id="fb-root"></div>
    <script>
        (function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s);
            js.id = id;
            js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.0";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
    </script>
   
    <div class="global-wrap">
        <header id="main-header" style="margin-top: 1%;">
         
            <div class="container">
            <div class="col-md-3 pull-left">
                   <a class="logo" href="../index.jsp">
                      <img src="../resource/img/logo.jpg"  title="Image Title" />
                      </a>
                        </div>
                <div class="nav">
                    <ul class="slimmenu" id="slimmenu">
                        <li class="active"><a href="../index.jsp">Home</a>
                            
                        </li>
                         <li><a href="aboutus.jsp">About Us</a>
                         </li>

                       <li><a href="cancellation.jsp">Cancellation</a>  </li>
                       <li><a href="printsms.jsp">Print / SMS Ticket</a></li>
                       <li><a href="contactus.jsp">Contact Us</a></li>
                       <li ng-if="!auth"><a href="pages/login.jsp">Login</a></li>
						
						  <li ng-if="auth && adminuser"><a>{{user.userName}}</a>
                             <ul>
                                <li><a href="pages/Admin/adminhome.jsp">Bus Chart</a>
                                </li>
                                 <li><a href="pages/Admin/report.jsp">Report</a>
                                </li>
                                <li><a ng-click="logout()">Logout</a>
                                </li>
                           
                            </ul>
                        </li>
                         <li ng-if="auth && extuser"><a>{{user.userName}}</a>
                            <ul>
                                <li><a href="#">My Trips</a>
                                </li>
                                <li><a href="#">Feedbacks</a>
                                </li>
                                <li><a ng-click="logout()">Logout</a>
                                </li>
                           
                            </ul>
                        </li>
                          <li ng-if="auth && agentuser"><a >{{user.userName}}</a>
                             <ul>
                           		 <li><a href="pages/Admin/adminhome.jsp">Bus Chart</a>
                                </li>
                                 <li><a href="pages/viewBalance.jsp">My Balance</a>
                                </li>
                                <li><a ng-click="logout()">Logout</a>
                                </li>
                           
                            </ul>
                        </li>
                     
                    </ul>
                </div>
            </div>
        </header>
        
		
		<div class="container" style="margin-top:3%;">
		
		<div class="col-md-8">
		<span style="color:black;margin-left:13%;">Passenger details : </span>
		
		
		<div style="margin:2%;" ng-repeat="n in noOfSelectedSeat">

			<div ng-if="$index ==0">
				<span>Name<font style="color:rgba(248, 43, 43, 0.93);">*</font></span><input type="text" ng-model="pNames[$index]" ng-change="defaulterName()" placeholder="Enter Passenger Name" style="margin-left:5%;" required>
				
				<span style="margin-left:5%;">Gender<font style="color:rgba(248, 43, 43, 0.93);">*</font></span> 
				
				<select ng-model="genders[$index]" ng-change="defaultGender()">
					<option value="">-Select-</option>
					<option value="Male">Male</option>
					<option value="Female">Female</option>
				</select>
				
				<span style="margin-left:5%;">Age<font style="color:rgba(248, 43, 43, 0.93);">*</font></span> <input type="text" ng-model="ages[$index]"  ng-change="defaultage()" placeholder="Age" required>
			</div>	
			
			<div ng-if="$index !=0">
				<span>Name<font style="color:rgba(248, 43, 43, 0.93);">*</font></span><input type="text" ng-model="pNames[$index]" placeholder="Enter Passenger Name"  style="margin-left:5%;" required>
				
				<span style="margin-left:5%;">Gender<font style="color:rgba(248, 43, 43, 0.93);">*</font></span> 
				
				<select ng-model="genders[$index]">
					<option value="">-Select-</option>
					<option value="Male" selected="selected">Male</option>
					<option value="Female">Female</option>
				</select>
				
				<span style="margin-left:5%;">Age<font style="color:rgba(248, 43, 43, 0.93);">*</font></span> <input type="text" ng-model="ages[$index]"  placeholder="Age" required>
			</div>	
		</div>
		
		<div style="margin-left:2%;">
		<span>Email<font style="color:rgba(248, 43, 43, 0.93);">*</font> </span><input style="margin-left:5%;" type="text" ng-model="email" placeholder="E-ticket will be sent here" required>
		
		<span style="margin-left:26%;">Mobile<font style="color:rgba(248, 43, 43, 0.93);">*</font> </span><input type="text" ng-model="mobile" placeholder="SMS will be sent to this no."  required>
		
		</div>
		</div>
			
		<div class="col-md-4">
		<div style="background-color: #F3F3F3;width:70%;padding:5%; ">
			<span style="text-decoration: underline;color:black;"><b>Journey:</b></span>
			<br>
			<span>{{busDetail.bus.fromCity}} To {{busDetail.bus.toCity}}<br>
			{{startDate}}<br>	
			Seat Number : {{numberOfSeat}}
			</span>	
		
				
		</div>
		</div>		

		</div>
		
		<hr>
				
		<span ng-if="noPassangerName" style="margin-left:30%; color:rgba(218, 61, 61, 0.93);">*Please enter all passenger name!</span>
		<span ng-if="noGenderSelected" style="margin-left:30%; color:rgba(218, 61, 61, 0.93);">*Please specify the gender!<br></span>
		<span ng-if="noAge" style="margin-left:30%; color:rgba(218, 61, 61, 0.93);">*Please enter age!<br></span>
		<span ng-if="noEmail" style="margin-left:30%; color:rgba(218, 61, 61, 0.93);">*Please enter a valid Email!<br></span>		
		<span ng-if="noMoblie" style="margin-left:30%; color:rgba(218, 61, 61, 0.93);">*Please enter a valid Mobile number!<br></span>		
				
		<div class="container">
			
			<div class="col-md-4" style="margin-left:30%;">
				<div style="margin-left:3%;">
				<span style="text-decoration:underline;color:black;">Payment Summary</span><br>
				<span>Fare : <b>Rs. {{busDetail.bus.fare}}</b><br>
				Seat : <b>{{numberOfSeat}}</b><br>
				Total : <b>Rs. {{totalFare}}</b>
				
				</span>  
				</div>  
				<hr> 
			<div ng-if="auth && agentuser">
				<span style="color:black;">Agent Payment details  </span><br>
				<span>
				Percentage : <b>{{agentPer100}}%</b><br>
				Total Payable amount :<b>{{agentFare}}</b> 
				</span>
			</div>	
				<form name="amtform" id="amtform" action="viewTicket1.jsp" method="POST" ng-submit=>
			<div style="margin-top:2%;">	
			
	
			
			<a ng-if="auth && adminuser" class="btn btn-info" id="chk" ng-click="collectCash($event)" >Collect Cash</a>
			<a ng-if="auth && agentuser" class="btn btn-info" id="chk" ng-click="collectCash($event)" >Collect Cash</a>
			<a ng-if="auth && testuser" class="btn btn-primary" id="chk" ng-click="proceedCheckout($event)" >Proceed To checkout</a>  	
			<a ng-if="!auth" class="btn btn-primary" id="chk" ng-click="proceedCheckout($event)" >Proceed To checkout</a> 
			</div>	

				<input type="hidden" name="agentFare" ng-value="agentFare">
				<input type="hidden" name="totalFare" ng-value="totalFare">
			</form>	  
				
			</div>
		
		</div>
		
		<div class="modal"><!-- Place at bottom of page --></div>
		
	<br><br>
        <footer id="main-footer">
            <div class="container">
                <div class="row row-wrap">
                    <div class="col-md-3">
                        <a class="logo" href="index.html">
                            <img src="../resource/img/foter.jpg" alt="Image Alternative text" title="Image Title" />
                        </a>
                        <p class="mb20">Booking, reviews and advices on hotels, resorts,vacation rentals, travel packages, and lots more!</p>
                        <ul class="list list-horizontal list-space">
                            <li>
                                <a class="fa fa-facebook box-icon-normal round animate-icon-bottom-to-top" href="#"></a>
                            </li>
                            <li>
                                <a class="fa fa-twitter box-icon-normal round animate-icon-bottom-to-top" href="#"></a>
                            </li>
                            <li>
                                <a class="fa fa-google-plus box-icon-normal round animate-icon-bottom-to-top" href="#"></a>
                            </li>
                            <li>
                                <a class="fa fa-linkedin box-icon-normal round animate-icon-bottom-to-top" href="#"></a>
                            </li>
                            <li>
                                <a class="fa fa-pinterest box-icon-normal round animate-icon-bottom-to-top" href="#"></a>
                            </li>
                        </ul>
                    </div>

                    
                    <div class="col-md-4" style="margin-left: 5%;">
                        <ul class="list list-footer">
                           <li style="margin-top:3%;"><a href="contactus.jsp">Contact Us</a>
                            </li><h>
                            <li style="margin-top:3%;"><a href="aboutus.jsp">About Us</a>
                            </li>

                            <li style="margin-top:3%;"><a href="cancellation.jsp">Cancellation Policy</a>
                            </li>
                            <li style="margin-top:3%;"><a href="printsms.jsp">Print Ticket</a>
                            </li>
                            <li style="margin-top:3%;"><a href="../index.jsp">Home</a>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <h4>Have Questions?</h4>
                        <h4 class="text-color">+1-000-000-0000</h4>
                        
                        <p><h5>support@network.com</h5></p>
                    </div>

                </div>
            </div>
        </footer>


        <script src="../resource/js/jquery.js"></script>  
        <script src="../resource/js/bootstrap.js"></script>
        <script src="../resource/js/modernizr.js"></script>
        <script src="../resource/js/slimmenu.js"></script>
        <script src="../resource/js/bootstrap-datepicker.js"></script>
        <script src="../resource/js/bootstrap-timepicker.js"></script>
        <script src="../resource/js/nicescroll.js"></script>
        <script src="../resource/js/dropit.js"></script>
        <script src="../resource/js/ionrangeslider.js"></script>
        <script src="../resource/js/icheck.js"></script>
        <script src="../resource/js/fotorama.js"></script>
        <script src="../resource/js/typeahead.js"></script>
        <script src="../resource/js/card-payment.js"></script>
        <script src="../resource/js/magnific.js"></script>
        <script src="../resource/js/owl-carousel.js"></script>
        <script src="../resource/js/fitvids.js"></script>
        <script src="../resource/js/tweet.js"></script>
        <script src="../resource/js/countdown.js"></script>
        <script src="../resource/js/gridrotator.js"></script>
        <script src="../resource/js/custom.js"></script>


   
    </div>
    <script>
    	
    </script>
    
</body>
</html>