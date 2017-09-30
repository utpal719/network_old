<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="network" >
<head>
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
     <script src="../resource/js/modernizr.js"></script>

     
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


</style>

</head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body class="full">

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
    <div class="global-wrap full">

        <div class="full-page">
            <div class="bg-holder full">
                <div class="bg-mask"></div>
                <div class="bg-img" style="background-image:url(../resource/img/1024x487.png);"></div>
                <div class="bg-holder-content full text-white text-center">
                    <a class="logo-holder" href="index.html">
                        <img src="../resource/img/logo-white.png" alt="Image Alternative text" title="Image Title" />
                    </a>
                    <div class="full-center">
                        <div class="container">
                            <div class="spinner-clock">
                                <div class="spinner-clock-hour"></div>
                                <div class="spinner-clock-minute"></div>
                            </div>
                            <h2 class="mb5">Looking for hotels in New York City...</h2>
                            <p class="text-bigger">it will take a couple of seconds</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>



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
    </div>
</body>

</html>