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
                        <li><a href="aboutus.jsp">About Us</a>
                                </li>

                        <li ><a href="cancellation.jsp">Cancellation</a>  </li>
                        <li><a href="printsms.jsp">Print / SMS Ticket</a></li>
                         <li class="active"><a href="#">Contact Us</a></li>
  						<li ng-if="!auth"><a href="pages/login.jsp">Login</a></li>
						
						  <li ng-if="auth && adminuser"><a>{{user.userName}}</a>
                            <ul>
                                <li><a href="feature-typography.html">Admin Panel</a>
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
                                <li><a ng-click="logout()">Logout</a>
                                </li>
                                 <li><a href="pages/viewBalance.jsp">My Balance</a>
                                </li>
                           
                            </ul>
                        </li>

                    </ul>
                </div>
            </div>
        </header>
    </div>

<br><br>

 <div class="contact-form" >
                
            <h3 style="font-family:'lucida calligraphy'; text-align: center;">We would love to hear from you</h3><br><br>
                         
                         <div class="col-md-2"></div>
                
                            <div class="col-md-4">
                            <form id="main-contact-form" name="contact-form" method="post" action="#">
                                <div class="form-group">
                                    <label><font color="#B22222"><b>------  HOW SHALL WE CALL YOU ? ------</b></label>
                                    <input type="text" name="name" class="form-control" placeholder="Type your name here" required="">
                                </div>
                                <div class="form-group">
                                    <label><b>------  SHARE YOUR EMAIL  ------</b></label>
                                    <input type="email" name="email" class="form-control" placeholder="We will keep it safe. We promise!" required="">
                                </div>
                                 <div class="form-group">
                                    <label><b>------ SHARE YOUR CONTACT NUMBER ------</b></label>
                                    <input type="text" name="ph" class="form-control" placeholder="This will also be safe. We promise!" required="">
                                </div>
                                <div class="form-group">
                                    <label><b>------ WHAT IS IT ALL ABOUT? ------</b></label>
                                    <input type="text" name="subject" class="form-control" placeholder="The subject!" required="">
                                </div>
                                <div class="form-group">
                                    <label><b>------ WE ARE ALL EARS! ------</b></label>
                                    <textarea name="message" class="form-control" rows="4" placeholder="Share with us any information that might help us to respond to your request." required=""></textarea>
                                </div></font>
                                <button type="submit" class="btn btn-danger">Send Message</button>
                            </form>
                            </div>

                                <div class="col-md-1"></div>

                            <div class="col-md-5">
                    <address style="margin-top:6%;">
                        <i class="fa fa-map-marker" style="color: #B22222;"></i>
                        <strong style="margin-left:8px;font-family:gabriola;font-size:25px;"> Network Travels</font></strong><br>
                        <font style="margin-left:22px;font-family: gabriola; font-size:23px;">Mr P. Dutta</font><br>
                        <font style="margin-left:22px;font-family: gabriola; font-size:23px;">17 - Paltan Bazar, G.S. Road,<br> 
                        <font style="margin-left:22px;font-family: gabriola; font-size:23px;">Guwahati - 781008<br></font>
                        <font style="margin-left:22px;font-family: gabriola; font-size:23px;">Assam,India,
                        
                        <br><br>
                        <i class="fa fa-mobile" style="color:#B22222;"></i>
                        <font style="margin-left:12px;font-family: gabriola; font-size:23px;">Network Travels: 8811079999, 7086093241, 7086018977(ISBT)<br></font>
                          <font style="margin-left:12px;font-family: gabriola; font-size:23px;">Network Courier: 9435019337<br></font>
                            <font style="margin-left:12px;font-family: gabriola; font-size:23px;">Network Cargo: 8011667971<br></font>
                             <font style="margin-left:12px;font-family: gabriola; font-size:23px;">Network Tourism: 9435154638, 9434506446<br></font>
                        <font style="margin-left:25px;font-family: gabriola; font-size:23px;">Ph/Fax: 0361 - 2605335<br></font><br>

                        <i class="fa fa-paper-plane" style="color:#B22222;"></i>
                        <font style="margin-left:6px;font-family: gabriola; font-size:23px;">Email : </font><br>
                        <font style="margin-left:30px;font-family: gabriola; font-size:23px;">networktoursindia@gmail.com<br>
                        <font style="margin-left:30px;font-family: gabriola; font-size:23px;">networktravelsindia@gmail.com</font>
                        
                        <!--  <abbr title="Phone">P:</abbr> (123) 456-7890 -->
                    </address>
                </div></div>

                <div class="container" style="margin-top:30px;">
                    
                        <div class="col-md-1"></div>
                        <div class="col-md-11">
                            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3580.549907990999!2d91.74997241468034!3d26.178784083449155!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x375a5a2988c2883b%3A0xba121101c0b11cc0!2sNetwork+Travels!5e0!3m2!1sen!2sin!4v1467902702743" width="85%" height="300px" frameborder="0" style="border:0" allowfullscreen></iframe>
                        </div>

                
                            
                </div>

                <hr>
    
    
    
    
    
     <footer id="main-footer">
            <div class="container">
                <div class="row row-wrap">
                    <div class="col-md-3">
                        <a class="logo" href="../index.jsp">
                            <img src="../resource/img/foter.jpg" alt="Image Alternative text" title="Image Title" />
                        </a>
                     
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