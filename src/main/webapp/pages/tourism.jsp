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
    <script src="../resource/angularjs/controller/busresult.js"></script>
	<script src="../resource/angularjs/services/BusService.js"></script>

     
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

<body ng-controller="tourismController" ng-cloak >

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


    <section class="officeimg">
    	<div class="wrap">
    		<img src="../resource/img/ne1.jpg">
    	</div>
    </section>

    <section class="aboutus">
    	<div class="wrap">
    		<h1 class="headerarrow" style="color:black">The Last Frontier</h1>
    		<h2><font color="black">Tailor-made Holidays & Group tours to Bhutan, Northeast India and 
Myanmar</h2><br>
<h2><a href="../resource/img/NetworkTravel.pdf" style="color : #a94442;">Download our E-Brouchure </a></h2>
    	
    	  <div class="container">
    
          
            <div class="gap">
                <div class="row row-wrap">
                    <div class="col-md-3">
                        <div class="thumb">
                            <header class="thumb-header">
                                <a class="hover-img curved" href="#">
                                    <img src="../resource/img/bhutan.jpg" alt="Image Alternative text" title="Upper Lake in New York Central Park" /><i class="fa fa-plus box-icon-white box-icon-border hover-icon-top-right round"></i>
                                </a>
                            </header>
                            <div class="thumb-caption">
                                <h4 class="thumb-title">Bhutan</h4>
                               <p style="margin-left: 0px;margin-right :0px;">Those fortunate enough to visit
Bhutan describe it as a unique, deeply
spiritual and mystical experience. <a href="../resource/img/NetworkTravel.pdf" style="color : #a94442;">Know More...</a> </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="thumb">
                            <header class="thumb-header">
                                <a class="hover-img curved" href="#">
                                    <img src="../resource/img/myanmar.jpg" alt="Image Alternative text" title="lack of blue depresses me" /><i class="fa fa-plus box-icon-white box-icon-border hover-icon-top-right round"></i>
                                </a>
                            </header>
                            <div class="thumb-caption">
                                <h4 class="thumb-title">Myanmar</h4>
                                <p style="margin-left: 0px;margin-right :0px;">It's a country that fuels your emotions,
stimulates your senses and stays in your soul. <a href="../resource/img/NetworkTravel.pdf" style="color : #a94442;">Know More...</a> </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="thumb">
                            <header class="thumb-header">
                                <a class="hover-img curved" href="#">
                                    <img src="../resource/img/ne.jpg" alt="Image Alternative text" title="people on the beach" /><i class="fa fa-plus box-icon-white box-icon-border hover-icon-top-right round"></i>
                                </a>
                            </header>
                            <div class="thumb-caption">
                                <h4 class="thumb-title">North-East India</h4>
                             <p style="margin-left: 0px;margin-right :0px;">Fresh mountain air, charming people, Buddhist
monasteries and prayer flags dot the pristine
landscape and home of Khangchendzonga
- the world's third highest mountain <a href="../resource/img/NetworkTravel.pdf" style="color : #a94442;">Know More...</a> </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="thumb">
                            <header class="thumb-header">
                                <a class="hover-img curved" href="#">
                                    <img src="../resource/img/Brahmaputra1.jpg" alt="Image Alternative text" title="the journey home" /><i class="fa fa-plus box-icon-white box-icon-border hover-icon-top-right round"></i>
                                </a>
                            </header>
                            <div class="thumb-caption">
                                <h4 class="thumb-title">Custom
Itineraries </h4>
                               <p style="margin-left: 0px;margin-right :0px;">  We pride ourselves in providing custom itineraries for all! <a href="../resource/img/NetworkTravel.pdf" style="color : #a94442;">Know More...</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    	
    	
    	
    	</div></font>
    	
    	<div class="container">
    	<h2>Free travel plan suggestions</h2>
    	  <form id="main-contact-form">
                                <div class="form-group">
                                    <label><font color="#B22222"><b>------  HOW SHALL WE CALL YOU ? ------</b></label>
                                    <input type="text" ng-model="name" class="form-control" placeholder="Type your name here" required="">
                                </div>
                                <div class="form-group">
                                    <label><b>------  SHARE YOUR EMAIL  ------</b></label>
                                    <input type="email" ng-model="email" class="form-control" placeholder="We will keep it safe. We promise!" required="">
                                </div>
                                 <div class="form-group">
                                    <label><b>------ SHARE YOUR CONTACT NUMBER ------</b></label>
                                    <input type="text" ng-model="ph" class="form-control" placeholder="This will also be safe. We promise!" required="">
                                </div>
                                <div class="form-group">
                                    <label><b>------ The holiday ------</b></label>
                                    <input type="text" ng-model="date" class="form-control" placeholder="your tentative journey date" required="">
                                </div>
                                <div class="form-group">
                                    <label><b>------ WE ARE ALL EARS! ------</b></label>
                                    <textarea ng-model="message" class="form-control" rows="4" placeholder="Share with us your travel requirements that might help us to respond to your request." required=""></textarea>
                                </div></font>
                                <button type="button" class="btn btn-danger" ng-click="sendQuery()">Send Message</button>
                                
                                <span ng-if="showSuccess">We have recieved your request. One of our associates will revert shortly!!</span>
    	
    	</form><br>
    	<h2>--- OR--- </h2><br>
    	<p>Call us at 9435154638, 9434506446 <br>
or send us an email to NetworkTravelsIndia@gmail.com<br>
17 Paltan Bazar, G S Road, Guwahati 781 008, Assam, India</p>
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