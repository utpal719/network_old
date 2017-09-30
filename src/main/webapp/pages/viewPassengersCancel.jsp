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
.modal {
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

<body data-ng-controller="confirmCancel" ng-cloak>
    
    

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

                        <li class="active"><a href="#">Cancellation</a>  </li>
                        <li><a href="printsms.jsp">Print / SMS Ticket</a></li>
                         <li><a href="contactus.jsp">Contact Us</a></li>
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


    <!--<section class="officeimg">
    	<div class="wrap">
    		<img src="img/about.jpg">
    	</div>
    </section> -->
    <br>
<br><br>
   
   <span ng-if="pList" style="margin-left: 10%;"><b>Passenger List:</b></span>
   <br><br>
     <a  ng-click="confirmCancel($event)" ng-show="cancelclicked" style="margin-left: 10%;"><button class="btn btn-danger btn-md" type="button" style="border:0px; width:10%; font-size:14px;">Cancel</button></a>
     <span ng-if="notchecked" style="margin-left:3%;color:rgb(207, 75, 75);">*Please select atleast one passenger!</span>
    <section>
        <div class="wrap">
            <div style="margin-left:10%; font-size:16px;margin-top : 1%;" ng-if="passengerList">
        	
        		 <table class="table table-bordered table-striped table-booking-history" style="width:70%;">
                        <thead>
                            <tr>
                                <th>Select</th>
                                <th>Name</th>
                                <th>Seat Number</th>
                                <th>Gender</th>
                                <th>Age</th>
                                <th>Journey Date</th>
                            
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="n in booking.passengerList">
                                <td><input type="checkbox" ng-model="checkedPassengers[n.passengerId]"></td>
                                <td class="booking-history-title">{{n.passengerName}}</td>
                                <td>{{n.seatNumber}}</td>
                                <td>{{n.gender}}</td>
                                <td>{{n.age}}</td>
                                <td>{{booking.journeyDate}} </td>            
                            </tr>
                           
                          
                          
                        </tbody>
                    </table>
        	
            </div>
        </div>
    </section>
    
    <section style="margin-left:25%;" ng-if="verifyShowOTP">
    	<span>A OTP has been sent to your email/mobile. Please enter that here</span><br><br>
    	<input type="text" ng-model="userOTP" placeholder="One time Password" style="margin-left:10%;">
    		<span ng-if="wrongpass" style="margin-left:1%; color:color:rgb(207, 75, 75);">*Please enter the correct password!</span>
    	<br><br>
		<a ng-click="verifyOTP(userOTP)" style="margin-left: 15%;"><button class="btn btn-danger btn-md" type="button" style="border:0px; width:10%; font-size:14px;">Verify</button></a>
		    	
	</section>
	
	<section style="margin-left:20%; width:60%;">
		<div ng-show="isrefundAmt">
				<span>Your ticket has been cancelled successfully.</span><br><br>
		</div>
	</section>
	

	<section style="margin-left:20%; width:60%;" >
	<div ng-show="bankDetails">
		<span style="color:#c63636e6;text-transform: uppercase;">Please enter bank details for refund :</span>
		<br><br>
		<form>
			 <div class="form-group form-group-icon-left">
                            <label>Full Name</label>
                            <input type="text" class="form-control" ng-model="nameperbank" placeholder="e.g. ABCD Dutta"  />
                           
              </div>
              
              <div class="form-group form-group-icon-left"><i class="fa fa-user input-icon input-icon-show"></i>
                            <label>Select a Bank</label>
                           
                           <select ng-model="bankname">
                           <option value="select" selected="selected">-SELECT-</option>
                           	<option value="State Bank of India">State Bank of India</option>
    <option value="Allahabad Bank">Allahabad Bank</option>
    <option value="Andhra Bank">Andhra Bank</option>
    <option value="Bank of India">Bank of India</option>
    <option value="Bank of Baroda">Bank of Baroda</option>
    <option value="Bank of Maharashtra"> Bank of Maharashtra</option>
    <option value="Canara Bank">Canara Bank</option>
   <option value="Central Bank of India"> Central Bank of India</option>
   <option value="Corporation Bank">Corporation Bank</option>
    <option value="Dena Bank">Dena Bank</option>
    <option value="Indian Bank">Indian Bank</option>
    <option value="Indian Overseas Bank">Indian Overseas Bank</option>
    <option value="Oriental Bank of Commerce">Oriental Bank of Commerce</option>
    <option value="Punjab & Sindh Bank">Punjab & Sindh Bank</option>
    <option value="Punjab National Bank">Punjab National Bank</option>
    <option value="Syndicate Bank">Syndicate Bank</option>
    <option value="UCO Bank">UCO Bank</option>
    <option value="Union Bank of India">Union Bank of India</option>
    <option value="United Bank of India">United Bank of India</option>
    <option value="Vijaya Bank">Vijaya Bank</option>
    <option value="IDBI Bank">IDBI Bank</option>
    <option value="ICICI Bank">ICICI Bank</option>
    <option value="Axis Bank">Axis Bank</option>
    <option value="Bandhan Bank">Bandhan Bank</option>
    <option value="Catholic Syrian Bank">Catholic Syrian Bank</option>
    <option value="Dhanlaxmi Bank">Dhanlaxmi Bank</option>
    <option value="DCB Bank">DCB Bank</option>
    <option value="HDFC Bank">HDFC Bank</option>
    <option value="IDFC Bank">IDFC Bank</option>
    <option value="Karnataka Bank">Karnataka Bank</option>
    <option value="IndusInd Bank">IndusInd Bank</option>
    <option value="Jammu and Kashmir Bank">Jammu and Kashmir Bank</option>
    <option value="Karur Vysya Bank">Karur Vysya Bank</option>
    <option value="Kotak Mahindra Bank">Kotak Mahindra Bank</option>
    <option value="Lakshmi Vilas Bank">Lakshmi Vilas Bank</option>
    <option value="RBL Bank">RBL Bank</option>
    <option value="South Indian Bank">South Indian Bank</option>
    <option value="Yes Bank">Yes Bank</option>

                           </select>
              </div>
              
              
             <div class="form-group form-group-icon-left"><i class="fa fa-user input-icon input-icon-show"></i>
                            <label>IFSC CODE</label>
                            <input class="form-control" ng-model="ifsc" placeholder="e.g. ICICI1234" type="text" />
                           
              </div>  
              
               <div class="form-group form-group-icon-left"><i class="fa fa-user input-icon input-icon-show"></i>
                            <label>Account Number</label>
                            <input class="form-control" ng-model="acnumber" placeholder="e.g.123456789" type="text" />
                           
              </div>  
              
              <br><br>
		<a ng-click="submitBankDetails()" style="margin-left: 15%;"><button class="btn btn-danger btn-md" type="button" style="border:0px; width:10%; font-size:14px;">Submit</button></a>
		 
		</form>
		
		</div>
	</section>	

    <hr>
    
    
    <div class="modal"><!-- Place at bottom of page --></div>
    
    
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
 
</body>
</html>