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
    <script src="../resource/js/ui-bootstrap.js"></script>
    <script src="../resource/js/angular-local-storage.js"></script>
    <script src="../resource/angularjs/controller/index_cityname.js"></script>
     <script src="../resource/angularjs/services/CityService.js"></script>

     
<style>
@font-face {
  font-family: "RobotoLight";
  font-style: normal;
  font-weight: normal;
  src: url("//www.makemytrip.com/new_hlp/fonts/roboto/Roboto-Light-webfont.eot?#iefix") format("embedded-opentype"), url("//www.makemytrip.com/new_hlp/fonts/roboto/Roboto-Light-webfont.woff") format("woff"), url("//www.makemytrip.com/new_hlp/fonts/roboto/Roboto-Light-webfont.ttf") format("truetype"), url("//www.makemytrip.com/new_hlp/fonts/roboto/Roboto-Light-webfont.svg#RobotoLight") format("svg");
}

.body {
	 font-family: "RobotoLight";
}.test{
	background-color: rgba(255, 255, 255, 0.2);
	box-sizing : border-box;
	border-radius: 10px;
}


.aboutus h1.headerarrow{text-align: center; margin: 50px 0px; font-size: 30px; }
.aboutus h1.headerarrow::after{content: " "; border: solid 1px #000000; display: block; width: 90px; margin: 10px auto;}
.aboutus{text-align: center;padding: 50px 0px;}
.aboutus {
    text-align: center;
    padding: 50px 0px;
}

section { display: block; }

h1 {
    display: block;
    font-size: 2em;
    -webkit-margin-before: 0.67em;
    -webkit-margin-after: 0.67em;
    -webkit-margin-start: 0px;
    -webkit-margin-end: 0px;
    font-weight: bold;
}

h2 {
    display: block;
    font-size: 1.5em;
    font-weight: bold;
    margin-left: 180px;
    margin-right: 180px;
    margin-bottom: 15px;
}

p {
    display: block;
    margin-left: 180px;
    margin-right: 180px;
    font-size: 15px;
}

html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, font, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, input, textarea {
    font-family: 'Open Sans', Arial, Helvetica, sans-serif;
    font-weight: 400;
    outline: none;
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
<body>

<body data-ng-controller="CityController" ng-cloak>

    <!-- FACEBOOK WIDGET -->
    <div id="fb-root"></div>

    <!-- /FACEBOOK WIDGET -->
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
                        <li><a href="../index.jsp">Home</a>

                        </li>
                        <li class="active"><a href="#">About Us</a>
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
    </div>




    <section class="aboutus">
    	<div class="wrap">
    		<h1 class="headerarrow" style="color:black">Refund Policy</h1>
    		
    		
    	<font>	<div style="width : 80% ; margin-left : 10%;">
    	
    	1) Refunds processed for cancelled tickets are transferred to the passenger's bank account / debit /
credit / net banking that were used while booking the tickets.<br><br>
2) Full amount will be refunded to the passenger if cancellation is done 3 hours before Bus Origin
Start Time, otherwise no amount will be awarded. <br><br>
    		3) All Refunds are processed automatically upon cancellation of tickets. Your bank may take 15-20
days to credit this amount to your account/card. <br><br>
4) In case the refund amount is not credited to your account in 20 days from the date of refund, we
kindly request you to send an email to support@networktravels.com along with the ticket
details/order details. We will provide you the necessary support in crediting back the refund
amount.<br><br>
5) No refund will be processed for Passenger who do not report at the boarding point on time. <br><br>
6) In the event of cancellation of a bus, network travels will assist the passenger in providing an
alternative bus, subject to availability. In case an alternative is not available, then network travels
shall be liable to the passenger only to the extent of refunding the sum paid by the passenger for
the price of the ticket.
    	   	</div></font>
    </section>

    <footer id="main-footer">
        <div class="container">
            <div class="row row-wrap">

                <div class="col-md-3">
                    <a class="logo" href="index.html">
                        <img src="../resource/img/foter.jpg" alt="Image Alternative text" title="Image Title" />
                    </a>
           
                    <ul class="list list-horizontal list-space">
                        <li>
                            <a class="fa fa-facebook box-icon-normal round animate-icon-bottom-to-top" href="#" style="background-color:#B22222;"></a>
                        </li>
                        <li>
                            <a class="fa fa-twitter box-icon-normal round animate-icon-bottom-to-top" href="#" style="background-color:#B22222;"></a>
                        </li>
                        <li>
                            <a class="fa fa-google-plus box-icon-normal round animate-icon-bottom-to-top" href="#" style="background-color:#B22222;"></a>
                        </li>
                        <li>
                            <a class="fa fa-linkedin box-icon-normal round animate-icon-bottom-to-top" href="#" style="background-color:#B22222;"></a>
                        </li>
                        <li>
                            <a class="fa fa-pinterest box-icon-normal round animate-icon-bottom-to-top" href="#" style="background-color:#B22222;"></a>
                        </li>
                    </ul>
                </div>
                <div class="col-md-1"></div>

                 <div class="col-md-3" style="margin-left: 8%;">
                        <ul class="list list-footer" style="margin-top:7px; font-size:12px;">
                           
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
                <div class="col-md-1"></div>
               <div class="col-md-3">
                        <h5>Have Questions?</h5>
                        <h6>Network Travels: 8811079999, 7086093241, 7086018277(ISBT) </h6>
                        <h6>Network Courier : 9435019337</h6>
                        <h6>Network Cargo : 8011667971</h6>
                        <h6>Air Ticket : 0361-2739630 & 03612739631</h6>
                        <h6>Network Tourism : 9435154638, 9434506446</h6>
                    <h6>networktoursindia@gmail.com</h6>
                    <h6>networktravelsindia@gmail.com</h6>
                    <h4></h4>
                    <h6>17 - Paltan Bazar, G.S. Road,<h6>
                    <h6 >Guwahati - 781008</h6>
                    <h6>Assam,India, </h6>
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
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
        <script src="../resource/js/typeahead.js"></script>
        <script src="../resource/js/card-payment.js"></script>
        <script src="../resource/js/magnific.js"></script>
        <script src="../resource/js/owl-carousel.js"></script>
        <script src="../resource/js/fitvids.js"></script>
        <script src="../resource/js/tweet.js"></script>
        <script src="../resource/js/countdown.js"></script>
        <script src="../resource/js/gridrotator.js"></script>
        <script src="../resource/js/custom.js"></script>
        
</body>
</html>