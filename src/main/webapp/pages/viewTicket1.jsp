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
<body data-ng-controller="bookingController" ng-cloak>

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
                           
                            </ul>
                        </li>

                    </ul>
                </div>
            </div>
        </header>

        <div class="container">     
        
			<%
			
			System.out.println("agent FAre ; "+request.getParameter("agentFare")+" totalFare : "+request.getParameter("totalFare"));
			 //Need to replace the last part of URL("your-vanityUrlPart") with your Testing/Live URL
		    String formPostUrl = "https://checkout.citruspay.com/ssl/checkout/n3wuuih2ub";
		    //Need to change with your Secret Key
		    String secret_key = "68f265fb4144913a9b4d5356bc8894a071ba8ac1";
		   //Need to change with your Vanity URL Key from the citrus panel
		    String vanityUrl = "n3wuuih2ub";
		   //Should be unique for every transaction
		   // String merchantTxnId = String.valueOf(System.currentTimeMillis());
		   //Need to change with your Order Amount
		//    String orderAmount = "1.00";
		   String currency = "INR";
	/* 		 String data=vanityUrl+orderAmount+merchantTxnId+currency;
		   
		    javax.crypto.Mac mac = javax.crypto.Mac.getInstance("HmacSHA1");
		    mac.init(new javax.crypto.spec.SecretKeySpec(secret_key.getBytes(), "HmacSHA1"));
		    byte[] hexBytes = new org.apache.commons.codec.binary.Hex().encode(mac.doFinal(data.getBytes()));
		    String securitySignature = new String(hexBytes, "UTF-8");
		    
		    System.out.println("Security signature is : "+securitySignature);  */
			%>		
        	
        
            <div class="gap">
            <span style="color : #a45151;margin-left : 20%;"><b>Please wait for <span id="count" style="color: #0a0a0a;" ><b>4</b></span> seconds while we initiate your payment process... </b></span>
            </div>
        </div>


	<form align="center" id="form" method="post" action="<%=formPostUrl%>">
       <input type="hidden" id="merchantTxnId" name="merchantTxnId" ng-value="marchantId" />
       <input type="hidden" id="orderAmount" name="orderAmount" ng-value="collection"/> 
       <input type="hidden" id="currency" name="currency" value="<%=currency%>" />
       <input type="hidden" id="email" name="email" ng-value="email" />
       <input type="hidden" id="phoneNumber" name="phoneNumber" ng-value="mobile" />        
       <input type="hidden" name="returnUrl" value="https://nwt-techv.rhcloud.com/pages/viewTicket2.jsp" />
       <input type="hidden" id="notifyUrl" name="notifyUrl" value="" />
       <input type="hidden" id="secSignature" name="secSignature" ng-value="securitySignaure" />
  			
     	</form> 

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
        
        <script>
        window.onload = function(){

        	(function(){
        	  var counter = 3;

        	  setInterval(function() {
        	    counter--;
        	    if (counter >= 0) {
        	      span = document.getElementById("count");
        	      span.innerHTML = counter;
        	    }
        	    // Display 'counter' wherever you want to display it.
        	    if (counter === 0) {
        	    	$("#form").submit();
        	        clearInterval(counter);
		      	    }

        	  }, 1000);

        	})();

        	}
        </script>
        
        <script>
	/* $(document).ready(function(){
		console.log("inside ready");
		setTimeout(
				  function() 
				  {
					  $("#form").submit();
				  }, 4000);
		//
	}); */
    
    </script>
       <!--  <script src="../resource/js/custom.js"></script> -->
    </div>
    
    
   
</body>
</html>