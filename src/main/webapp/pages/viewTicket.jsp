<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="network">
<head>
 <title>Network Travels</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400italic,400,300,600' rel='stylesheet' type='text/css'>
    <!-- /GOOGLE FONTS -->
    <link rel="stylesheet" href="../resource/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resource/css/bootstrap.css">
    <link rel="stylesheet" href="../resource/css/font-awesome.css">
    <link rel="stylesheet" href="../resource/css/icomoon.css">
    <link rel="stylesheet" href="../resource/css/styles.css">
    <link rel="stylesheet" href="../resource/css/mystyles.css">
    <script src="../resource/js/modernizr.js"></script>

    <script src="../resource/js/angular.js"></script>
    <script src="../resource/js/angular-local-storage.js"></script>
    <script src="../resource/js/dirPagination.js"></script>
    <script src="../resource/angularjs/controller/busresult.js"></script>
	<script src="../resource/angularjs/services/BusService.js"></script>

	
<style>
[ng-cloak],
[data-ng-cloak],
[x-ng-cloak],
.ng-cloak,
.x-ng-cloak {
   display: none !important; 
}
</style>	
	
</head>
<body data-ng-controller="bookingFinal" ng-cloak>
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

        <div class="container">
        <div ng-show="disTicket">     
        <br><br>
         <i class="fa fa-check round box-icon-large box-icon-center box-icon-success mb30"></i>	
        <span style="margin-left:35%;">An E-Ticket has been sent to your email id :<b> {{bookinginfo.email}} </b></span><br>
        <span style="margin-left:35%;">	An M-Ticket has been sent to your mobile number :<b> {{bookinginfo.mobile}}</b>
        </span>   
        <a class="btn btn-warning" style="margin-left:40%;" onclick="printDiv('printableArea')">PRINT</a>
        
        	
        	<table style="margin-top : 5%; margin-left:10%;">
        	
			<tr>
				<td>
					<div id="printableArea">
				<!-- 	<table style="overflow: visible; text-align:left; font-variant: normal; font-weight: normal;font-size: 14px;background-color: fff;line-height: 20px;font-family: Asap, sans-serif;color: #333;padding: 0;font-style: normal; width:100%;">
						<tbody>
							
						
							<tr style="height: 60px;overflow: hidden;margin-top: 20px;padding: 0 0 5px;">
				  			<td colspan="4" style="width:5%;">
				  				
				  					 <img src="../resource/img/logo.jpg"  title="Image Title" />
								
				  			</td>
				  			<td colspan="2" style="width:15%; text-align: right;">
				  				
                                
				  			</td>
						</tr> 
						</tbody>
					</table> -->
					
					<div style="margin-top: 2%;margin-left:5%">
					<table style="overflow: visible; text-align:left; font-variant: normal; font-weight: normal;font-size: 14px;background-color: fff;line-height: 10px;font-family: Asap, sans-serif;color: #333;padding: 0;font-style: normal; width:680px;">
						

					  <tbody>
					  <tr style="height: 60px;overflow: hidden;margin-top: 0px;padding: 0 0 5px;">
				  			<td colspan="4" style="border-bottom:1px solid #FFCC00; width:50%;">
				  				<div style="font-size: 14px; width:200%">
				  					<span style="display:-moz-inline-stack;display:inline-block;zoom:1;*display:inline; margin: 0 0 7px 0; font-weight: bold; padding: 0;"><span id="#">{{bookinginfo.fromCity}}</span></span> 
				  					<span style="display:-moz-inline-stack;display:inline-block;zoom:1;*display:inline; margin-right:10px;margin-left:10px;margin-top:10px;">
										<img src="http://www.techvariable.com/database/arrow.png">
									</span>
				  					<span style="display:-moz-inline-stack;display:inline-block;zoom:1;*display:inline; margin: 0 0 7px 0; font-weight: bold; padding: 0; margin-right: 19px;"><span id="#">{{bookinginfo.toCity}}</span></span>
				  					 <img  src="../resource/img/logo.jpg"  title="Image Title" style="width:10%;margin-left:3%;"/>
</div>
				  			
							
				  			</td>
				  		<!-- 	<td colspan="2" style="border-bottom:1px solid #FFCC00; width:15%; text-align: right;">
				  				<p style="font-size: 12px; font-weight: bold; margin: 0; padding: 0;">PNR NO: <span id="#">{{bookinginfo.pnrNumber}}</span> </p>
				  				
                                
				  			</td> -->
						</tr>
					  
					  	<tr style="margin: 0; padding: 0;">
						<td style="width:35%; font-size: 14px; margin: 0; padding: 0px; border-bottom:1px solid #e0e0e0; vertical-align: middle;">
						  <p style="font-weight: bold; margin: 0 0 5px; padding: 0;text-transform:capitalize;"><span id="#">{{bookinginfo.journeyDate}}
				  					 <span id="#" style="margin-left : 15px;">{{bookinginfo.pnrNumber}}</span></p> 
					
						</td>
						<td style="width:20%; font-size: 14px; margin: 0; padding: 0px; border-bottom:1px solid #e0e0e0; vertical-align: middle;">
							<p style="font-weight: 700; margin: 0 0 5px; padding: 0;"> <span id="#">{{bookinginfo.reportingTime}}</span></p>
							<span style="font-size: 12px; color: #999; margin: 0; padding: 0;">Reporting time</span>  
						</td>
						<td style="width: 25%;font-size: 14px; margin: 0; padding: 0px; border-bottom:1px solid #e0e0e0; vertical-align: middle;">
							<p style="font-weight: 700; margin: 0 0 5px; padding: 0;"><span id="#">{{bookinginfo.startTime}}</span></p>
							<span style="font-size: 12px; color: #999; margin: 0; padding: 0;">Departure time</span>  
						</td>
						<td style=" width:25%;font-size: 14px; margin: 0; padding: 0px; border-bottom:1px solid #e0e0e0; vertical-align: middle;">
							<p style="font-weight: 700; margin: 0 0 5px; padding: 0;"><span id="#">{{bookinginfo.noOfSeat}}</span></p>
							<span style="font-size: 12px; color: #999; margin: 0; padding: 0;">Number of seat</span>  
						</td>
					  </tr>
					  
					 <!--  <tr style="margin: 0; padding: 0;">
						<td style="font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;">
						  <p style="font-weight: 700; margin: 0 0 5px; padding: 0;">Boarding point details</p> 
						</td>
						<td style="font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;">
							<p style="font-weight: 700; margin: 0 0 5px; padding: 0;"><span id="#">ISBT Guwahati</span></p>
							<span style="font-size: 12px; color: #999; margin: 0; padding: 0;">Location</span>  
						</td>
						<td style="font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;">
							<p style="font-weight: 700; margin: 0 0 5px; padding: 0;"><span id="#">ISBT Guwahati</span></p>
							<span style="font-size: 12px; color: #999; margin: 0; padding: 0;">Landmark</span>  
						</td>
						<td style="font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;">
							<p style="font-weight: 700; margin: 0 0 5px; padding: 0;"><span id="#">ISBT Guwahati</span></p>
						</td>
					  </tr> -->
						
                  <!--   <tr><td colspan="4">
                                
                            </td>
                    </tr> -->

						
						
						
						
						
					  </tbody>
					</table>
					
					</div>

                    

					<table style="overflow: visible; text-align:left; font-variant: normal; font-weight: normal;font-size: 14px;background-color: fff;line-height: 20px;font-family: Asap, sans-serif;color: #333;padding: 0;font-style: normal; width:600px;margin-left:5%">
						<tbody>
							<!-- <tr style="margin: 0 0 20px 0; padding: 0; overflow: hidden;">
								<td colspan="6" style="border-bottom:1px solid #e0e0e0">
									<ul style="list-style:none;margin:0; padding:0;">
										
										
										
										
										
									</ul>
								</td>
							</tr>
							 -->
						<span style="display:-moz-inline-stack;display:inline-block;zoom:1;*display:inline; margin: 0 0 7px 5%; font-weight: bold; padding: 0;"><span id="#">Passenger Details:</span></span> 	
							
						<tr ng-if="bookinginfo.passengerList.length > 0" style="margin: 0; padding: 0;">
						<td style="font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;width:50%;">
						  <p style="font-weight: 700; margin: 0 0 5px; padding: 0;">{{bookinginfo.passengerList[0].passengerName}}</p> 
						  <span style="font-size: 12px; color: #999; margin: 0; padding: 0;">{{bookinginfo.passengerList[0].gender}}</span>  
						</td>
						
						<td style="font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;width:50%;">
						  <p style="font-weight: 700; margin: 0 0 5px; padding: 0;">{{bookinginfo.boardingPoint}}</p> 
						  <span style="font-size: 12px; color: #999; margin: 0; padding: 0;">Boarding Point</span>  
						</td>
				
						<td style="font-size: 14px; margin: 0; border-bottom:1px solid #e0e0e0; vertical-align: middle;">
							<p style="font-weight: 700; margin: 0 0 5px; padding: 0;">
							<span id="#" ng-repeat="i in bookinginfo.passengerList"><font ng-if="i.seatNumber > 40">S{{i.seatNumber -40 }}</font>  <font ng-if="i.seatNumber <= 40">{{i.seatNumber}}</font>, </span></p>
							<span style="font-size: 12px; color: #999; margin: 0; padding: 0;">Seat Number</span>  
						</td>
						
					  </tr>
							
							
						
							<tr style=" margin: 0 0 20px; padding: 0;">
								
							
								<td colspan="1" style="margin: 0; padding: 5px; text-align: centre;">
								  <p style="font-size: 12px; font-weight: 700; margin: 0; padding: 0;"><span style="font-size: 12px; margin: 0 10px 0 0; padding: 0;">Total Fare :</span><span id="#">Rs. {{bookinginfo.totdalFare}}</span></p>
								  <p style="font-size: 12px; color: #999; margin: 0; padding: 0;"><span id="#">(Inclusive of all tax)</span></p>
								  
                                  <!-- <p style="font-size: 12px; font-weight: 700; margin: 0; margin-top: 5px;"> -->
                                
                                  </p>
								</td>
								<td>
									 <p style="font-size: 12px; font-weight: 700; margin: 0; padding: 0;"><span style="font-size: 12px; margin: 0 10px 0 0; padding: 0;">PH : </span><span id="#"> 8811079999, 7086093241 <br>
									 	ISBT Guwahati : 7086018977  <br>
									 	Barak Valley : 9854037111,7086054040 </span></p>
								
								  
                                   
                                  </p>
								</td>
							</tr>
                           

						</tbody>
					</table>
					
					</div>
				

                    <table style="width:100%">
                        <tr id="#">
	<td>
                                
                                    <a href="https://techvariable.com" target="_blank">
                                        <img src="http://www.techvariable.com/database/banner.png" width="800">
                                    </a>
                                 </td>
                                 
</tr>

                    </table>

					<table cellspacing="3" style="overflow: visible; text-align:left; font-variant: normal; font-weight: normal;font-size: 14px;background-color: fff;line-height: 20px;font-family: Asap, sans-serif;color: #333;padding: 0;font-style: normal; width:800px;">
						<tbody>
							<tr id="#">
	<td style="width:40%;">
									<hr style="  /*border-top: 3px solid #333;*/ height:3px; background-color: #333;width:103%;">		
								</td>
	<td>
									<div style=" background: #fff; width: 176px; text-align: center; ">
									Cancellation Policy
									</div>
								</td>
	<td style="width:41%;">
									<hr style=" height:3px; background-color: #333; width:103%;">
								</td>
</tr>

						</tbody>
					
					</table>
					
                    
					<table style="overflow: visible; text-align:left; font-variant: normal; font-weight: normal;font-size: 14px;background-color: fff;font-family: Asap, sans-serif;color: #333;padding: 0;font-style: normal; width:800px;">
						<tbody>
							<tr>
								<td colspan="3">
									<span style="font-size: 18px; color: #333; margin: 0; padding: 0;">Whom should i call?</span>
								</td>
							</tr>

							<tr style="margin: 0 0 10px; padding: 0;">
								<td style="border-bottom:1px solid #e0e0e0;  padding-bottom: 10px;">
									<p style="font-size: 12px; font-weight: 700; margin: 0; color: #333; padding: 0;">For boarding point related</p>
									<span style="margin: 0; padding: 0; text-align: right;"><span id="#">02812468022/ 2466424</span></span>
								</td>
								<td style="border-bottom:1px solid #e0e0e0;  padding-bottom: 10px;">
									<p style="font-size: 12px; font-weight: 700; margin: 0; color: #333; padding: 0;">For time related</p>
									<span style="margin: 0; padding: 0; text-align: right;"><span id="#">02812468022/ 2466424</span></span>
								</td>
                                   <td style="border-bottom:1px solid #e0e0e0;  padding-bottom: 10px;">
                                       <p style="font-size: 12px; font-weight: 700; margin: 0; color: #333; padding: 0;">For cancellation and refunds related</p>
                                    <span style="font-size: 12px; color: #333; margin: 0; padding: 0;">Click on this  <a href="#">link</a> for hassle free online cancellation
                                       </span>
                                </td>
								<td style="border-bottom:1px solid #e0e0e0;  padding-bottom: 10px;">
                                    <p style="font-size: 12px; font-weight: 700; margin: 0; color: #333; padding: 0;">For all queries</p>						
									<span style="font-size: 12px; color: #333; margin: 0; padding: 0;">Call 39412345 or <a href="#">write</a> to us</span>
								</td>
							</tr>
                            
						</tbody>
					</table>
                    
				</td>
			</tr>
		</table>
       
       </div>
       
       <div ng-show="disMsg">
       	
       	<span style="color:#a45151;margin: 10%;">Some else is trying to book the same ticket! Please <a href="../index.jsp">click here</a> to reprocess it.</span>
       
       </div> 	
       
        <div ng-show="noCash">
       	
       	<span style="color:#a45151;margin: 10%;">Your account balance is too low to book the tickets! Please recharge.</span>
       
       </div>
        <div ng-show="inactiveaccount">
       	
       	<span style="color:#a45151;margin: 10%;">Your account is inactive. Please contact admin!</span>
       
       </div>
        
            <div class="gap"></div>
        </div>



       <footer id="main-footer">
            <div class="container">
                <div class="row row-wrap">
                    <div class="col-md-3">
                        <a class="logo" href="../index.jsp">
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
                        <h4 class="text-color">8403077666</h4>
                        
                        <p><h5>support@networktravels.com</h5></p>
                    </div>

                </div>
            </div>
        </footer>

        <script src="../resource/js/jquery.js"></script>
        <script src="../resource/js/bootstrap.js"></script>
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
        
        <script src="../resource/js/gridrotator.js"></script>
        <script src="../resource/js/custom.js"></script>
    </div>
    
<script>
function printDiv(divName) {
    var printContents = document.getElementById(divName).innerHTML;
    var originalContents = document.body.innerHTML;

    document.body.innerHTML = printContents;

    window.print();

    document.body.innerHTML = originalContents;
}

</script>

</body>
</html>