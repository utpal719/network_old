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
<body data-ng-controller="bookingControllerprocess" ng-cloak id="body">
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
                           
                            </ul>
                        </li>
                       
                     
                    </ul>
                </div>
            </div>
        </header>

        <div class="container">     
        <%
			String secret_key = "68f265fb4144913a9b4d5356bc8894a071ba8ac1";
             String data="";
             String txnId=request.getParameter("TxId");
             String txnStatus=request.getParameter("TxStatus"); 
             String amount=request.getParameter("amount"); 
             String pgTxnId=request.getParameter("pgTxnNo");
             String issuerRefNo=request.getParameter("issuerRefNo"); 
             String authIdCode=request.getParameter("authIdCode");
             String firstName=request.getParameter("firstName");
             String lastName=request.getParameter("lastName");
             String pgRespCode=request.getParameter("pgRespCode");
             String zipCode=request.getParameter("addressZip");
             String resSignature=request.getParameter("signature");
             
             //Binding all required parameters in one string (i.e. data)
             if (txnId != null) {
                 data += txnId;
             }
             if (txnStatus != null) {
                 data += txnStatus;
             }
             if (amount != null) {
                 data += amount;
             }
             if (pgTxnId != null) {
                 data += pgTxnId;
             }
             if (issuerRefNo != null) {
                 data += issuerRefNo;
             }
             if (authIdCode != null) {
                 data += authIdCode;
             }
             if (firstName != null) {
                 data += firstName;
             }
             if (lastName != null) {
                 data += lastName;
             }
             if (pgRespCode != null) {
                 data += pgRespCode;
             }
             if (zipCode != null) {
                 data += zipCode;
             }
             
             javax.crypto.Mac mac = javax.crypto.Mac.getInstance("HmacSHA1");
             mac.init(new javax.crypto.spec.SecretKeySpec(secret_key.getBytes(), "HmacSHA1"));
             byte[] hexBytes = new org.apache.commons.codec.binary.Hex().encode(mac.doFinal(data.getBytes()));
             String signature = new String(hexBytes, "UTF-8");
             boolean flag = true;
             if (resSignature !=null && !resSignature.equalsIgnoreCase("") 
                 && !signature.equalsIgnoreCase(resSignature)) {
                 flag = false;
             }
             if (flag) {
            	 
     
         %>
     
         
               <input type="text" ng-model="trans.uid" id="uid" ng-init="trans.uid = '<%= txnId %>'" style="display: none;"> 
               <input type="text"  ng-model="trans.ust" id="ust" ng-init="trans.ust = '<%= txnStatus %>'" style="display: none;"> 
              
         <% } else { %>
                       Error in processing your payment. Please contact administrator. 
         <% } %>
        
            <div class="gap">
            <span style="color : #a45151;margin-left : 20%;">Please wait while we process your payment ... </span>
            </div>
        </div>
  
   

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
        
       <!--  <script src="../resource/js/custom.js"></script> -->
    </div>
    
    
    <script>
   			
    $(document).ready(function(){
    	
    		
    	var scope =angular.element($("#body")).scope();
			var id=$("#uid").val();
	
    	scope.$apply(function() {
		        scope.trans.uid = $("#uid").val();
		        scope.trans.ust = $("#ust").val();
		    }); 
    	
    });
    
    </script>
</body>
</html>