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


[ng-cloak],
[data-ng-cloak],
[x-ng-cloak],
.ng-cloak,
.x-ng-cloak {
   display: none !important; 
}



#loader-wrapper {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 1000;
}
#loader {
    display: block;
    position: relative;
    left: 50%;
    top: 50%;
    width: 150px;
    height: 150px;
    margin: -75px 0 0 -75px;
    border-radius: 50%;
    border: 3px solid transparent;
    border-top-color: #3498db;

    -webkit-animation: spin 2s linear infinite; /* Chrome, Opera 15+, Safari 5+ */
    animation: spin 2s linear infinite; /* Chrome, Firefox 16+, IE 10+, Opera */

    z-index: 1001;
}

    #loader:before {
        content: "";
        position: absolute;
        top: 5px;
        left: 5px;
        right: 5px;
        bottom: 5px;
        border-radius: 50%;
        border: 3px solid transparent;
        border-top-color: #e74c3c;

        -webkit-animation: spin 3s linear infinite; /* Chrome, Opera 15+, Safari 5+ */
        animation: spin 3s linear infinite; /* Chrome, Firefox 16+, IE 10+, Opera */
    }

    #loader:after {
        content: "";
        position: absolute;
        top: 15px;
        left: 15px;
        right: 15px;
        bottom: 15px;
        border-radius: 50%;
        border: 3px solid transparent;
        border-top-color: #f9c922;

        -webkit-animation: spin 1.5s linear infinite; /* Chrome, Opera 15+, Safari 5+ */
          animation: spin 1.5s linear infinite; /* Chrome, Firefox 16+, IE 10+, Opera */
    }

    @-webkit-keyframes spin {
        0%   { 
            -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(0deg);  /* IE 9 */
            transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */
        }
        100% {
            -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(360deg);  /* IE 9 */
            transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */
        }
    }
    @keyframes spin {
        0%   { 
            -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(0deg);  /* IE 9 */
            transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */
        }
        100% {
            -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(360deg);  /* IE 9 */
            transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */
        }
    }

    #loader-wrapper .loader-section {
        position: fixed;
        top: 0;
        width: 51%;
        height: 100%;
        background: #222222;
        z-index: 1000;
        -webkit-transform: translateX(0);  /* Chrome, Opera 15+, Safari 3.1+ */
        -ms-transform: translateX(0);  /* IE 9 */
        transform: translateX(0);  /* Firefox 16+, IE 10+, Opera */
    }

    #loader-wrapper .loader-section.section-left {
        left: 0;
    }

    #loader-wrapper .loader-section.section-right {
        right: 0;
    }

    /* Loaded */
    .loaded #loader-wrapper .loader-section.section-left {
        -webkit-transform: translateX(-100%);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: translateX(-100%);  /* IE 9 */
                transform: translateX(-100%);  /* Firefox 16+, IE 10+, Opera */

        -webkit-transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000);  
                transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000);
    }

    .loaded #loader-wrapper .loader-section.section-right {
        -webkit-transform: translateX(100%);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: translateX(100%);  /* IE 9 */
                transform: translateX(100%);  /* Firefox 16+, IE 10+, Opera */

-webkit-transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000);  
        transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000);
    }
    
    .loaded #loader {
        opacity: 0;
        -webkit-transition: all 0.3s ease-out;  
                transition: all 0.3s ease-out;
    }
    .loaded #loader-wrapper {
        visibility: hidden;

        -webkit-transform: translateY(-100%);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: translateY(-100%);  /* IE 9 */
                transform: translateY(-100%);  /* Firefox 16+, IE 10+, Opera */

        -webkit-transition: all 0.3s 1s ease-out;  
                transition: all 0.3s 1s ease-out;
    }
    



/* ==========================================================================
   Helper classes
   ========================================================================== */

/*
 * Image replacement
 */

.ir {
    background-color: transparent;
    border: 0;
    overflow: hidden;
    /* IE 6/7 fallback */
    *text-indent: -9999px;
}

.ir:before {
    content: "";
    display: block;
    width: 0;
    height: 150%;
}

/*
 * Hide from both screenreaders and browsers: h5bp.com/u
 */

.hidden {
    display: none !important;
    visibility: hidden;
}

/*
 * Hide only visually, but have it available for screenreaders: h5bp.com/v
 */

.visuallyhidden {
    border: 0;
    clip: rect(0 0 0 0);
    height: 1px;
    margin: -1px;
    overflow: hidden;
    padding: 0;
    position: absolute;
    width: 1px;
}

/*
 * Extends the .visuallyhidden class to allow the element to be focusable
 * when navigated to via the keyboard: h5bp.com/p
 */

.visuallyhidden.focusable:active,
.visuallyhidden.focusable:focus {
    clip: auto;
    height: auto;
    margin: 0;
    overflow: visible;
    position: static;
    width: auto;
}

/*
 * Hide visually and from screenreaders, but maintain layout
 */

.invisible {
    visibility: hidden;
}

/*
 * Clearfix: contain floats
 *
 * For modern browsers
 * 1. The space content is one way to avoid an Opera bug when the
 *    `contenteditable` attribute is included anywhere else in the document.
 *    Otherwise it causes space to appear at the top and bottom of elements
 *    that receive the `clearfix` class.
 * 2. The use of `table` rather than `block` is only necessary if using
 *    `:before` to contain the top-margins of child elements.
 */

.clearfix:before,
.clearfix:after {
    content: " "; /* 1 */
    display: table; /* 2 */
}

.clearfix:after {
    clear: both;
}

/*
 * For IE 6/7 only
 * Include this rule to trigger hasLayout and contain floats.
 */

.clearfix {
    *zoom: 1;
}

/* ==========================================================================
   EXAMPLE Media Queries for Responsive Design.
   These examples override the primary ('mobile first') styles.
   Modify as content requires.
   ========================================================================== */

@media only screen and (min-width: 35em) {
    /* Style adjustments for viewports that meet the condition */
}

@media print,
       (-o-min-device-pixel-ratio: 5/4),
       (-webkit-min-device-pixel-ratio: 1.25),
       (min-resolution: 120dpi) {
    /* Style adjustments for high resolution devices */
}

/* ==========================================================================
   Print styles.
   Inlined to avoid required HTTP connection: h5bp.com/r
   ========================================================================== */

@media print {
    * {
        background: transparent !important;
        color: #000 !important; /* Black prints faster: h5bp.com/s */
        box-shadow: none !important;
        text-shadow: none !important;
    }

    a,
    a:visited {
        text-decoration: underline;
    }

    a[href]:after {
        content: " (" attr(href) ")";
    }

    abbr[title]:after {
        content: " (" attr(title) ")";
    }

    /*
     * Don't show links for images, or javascript/internal links
     */

    .ir a:after,
    a[href^="javascript:"]:after,
    a[href^="#"]:after {
        content: "";
    }

    pre,
    blockquote {
        border: 1px solid #999;
        page-break-inside: avoid;
    }

    thead {
        display: table-header-group; /* h5bp.com/t */
    }

    tr,
    img {
        page-break-inside: avoid;
    }

    img {
        max-width: 100% !important;
    }

    @page {
        margin: 0.5cm;
    }

}



</style>

</head>
<body data-ng-controller="selectSeatController" ng-cloak>


    <!-- FACEBOOK WIDGET -->
    <div id="fb-root"></div>
   
    
    
    <div id="loader-wrapper">
			<div id="loader"></div>

			<div class="loader-section section-left"></div>
            <div class="loader-section section-right"></div>

		</div>

    
    
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
        
        		 <div class="mfp-with-anim mfp-hide mfp-dialog mfp-search-dialog" id="search-dialog">
                <h3>Search for Bus</h3>
                <form>
                    <div class="tabbable">
                        <ul class="nav nav-pills nav-sm nav-no-br mb10" id="flightChooseTab">
                            <li class="active"><a href="#flight-search-1" data-toggle="tab">Round Trip</a>
                            </li>
                            <li><a href="#flight-search-2" data-toggle="tab">One Way</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane fade in active" id="flight-search-1">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-map-marker input-icon input-icon-highlight"></i>
                                            <label>From</label>
                                             <input class="typeahead form-control" placeholder="City" value="" type="text" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-map-marker input-icon input-icon-highlight"></i>
                                            <label>To</label>
                                            <input class="typeahead form-control" placeholder="City" value="" type="text" />
                                        </div>
                                    </div>
                                </div>
                                <div class="input-daterange" data-date-format="MM d, D">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-calendar input-icon input-icon-highlight"></i>
                                                <label>Departing</label>
                                                <input class="form-control" name="start" type="text" />
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-calendar input-icon input-icon-highlight"></i>
                                                <label>Returning</label>
                                                <input class="form-control" name="end" type="text" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-group-lg form-group-select-plus">
                                                <label>Passengers</label>
                                                <div class="btn-group btn-group-select-num" data-toggle="buttons">
                                                    <label class="btn btn-primary active">
                                                        <input type="radio" name="options" />1</label>
                                                    <label class="btn btn-primary">
                                                        <input type="radio" name="options" />2</label>
                                                    <label class="btn btn-primary">
                                                        <input type="radio" name="options" />3</label>
                                                    <label class="btn btn-primary">
                                                        <input type="radio" name="options" />4</label>
                                                    <label class="btn btn-primary">
                                                        <input type="radio" name="options" />5</label>
                                                    <label class="btn btn-primary">
                                                        <input type="radio" name="options" />5+</label>
                                                </div>
                                                <select class="form-control hidden">
                                                    <option>1</option>
                                                    <option>2</option>
                                                    <option>3</option>
                                                    <option>4</option>
                                                    <option>5</option>
                                                    <option selected="selected">6</option>
                                                    <option>7</option>
                                                    <option>8</option>
                                                    <option>9</option>
                                                    <option>10</option>
                                                    <option>11</option>
                                                    <option>12</option>
                                                    <option>13</option>
                                                    <option>14</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="flight-search-2">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-map-marker input-icon input-icon-highlight"></i>
                                            <label>From</label>
                                            <input class="typeahead form-control" placeholder="City" type="text" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-map-marker input-icon input-icon-highlight"></i>
                                            <label>To</label>
                                            <input class="typeahead form-control" placeholder="City" type="text" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-calendar input-icon input-icon-hightlight"></i>
                                            <label>Departing</label>
                                            <input class="date-pick form-control" data-date-format="MM d, D" type="text" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group form-group-lg form-group-select-plus">
                                            <label>Passengers</label>
                                            <div class="btn-group btn-group-select-num" data-toggle="buttons">
                                                <label class="btn btn-primary active">
                                                    <input type="radio" name="options" />1</label>
                                                <label class="btn btn-primary">
                                                    <input type="radio" name="options" />2</label>
                                                <label class="btn btn-primary">
                                                    <input type="radio" name="options" />3</label>
                                                <label class="btn btn-primary">
                                                    <input type="radio" name="options" />4</label>
                                                <label class="btn btn-primary">
                                                    <input type="radio" name="options" />5</label>
                                                <label class="btn btn-primary">
                                                    <input type="radio" name="options" />5+</label>
                                            </div>
                                            <select class="form-control hidden">
                                                <option>1</option>
                                                <option>2</option>
                                                <option>3</option>
                                                <option>4</option>
                                                <option>5</option>
                                                <option selected="selected">6</option>
                                                <option>7</option>
                                                <option>8</option>
                                                <option>9</option>
                                                <option>10</option>
                                                <option>11</option>
                                                <option>12</option>
                                                <option>13</option>
                                                <option>14</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button class="btn btn-primary btn-lg" type="submit">Search Buses</button>
                </form>
            </div>
        </div>
        
        <div class="container">
        
        		 <div class="mfp-with-anim mfp-hide mfp-dialog mfp-search-dialog" style=" max-height: calc(100vh - 210px);overflow-y: auto; border-radius : 10px;" id="ratings-dialog">
                <h4 style="color : rgb(228, 123, 123);">Ratings And Reviews</h4>
                <div class="row">
                <div class="col-md-6">
                
                <span>Netework Tarvels</span><br>
                <span>Guwahati To Jorhat</span><br>
                <span>10:00 PM to 06:30 AM</span>
                
                </div>
                
                <div class="col-md-6">
                <div class="pull-right">
                <span>Overall Ratings : <b>4.5</b></span><br>
                <span>Punctuality : <b>4.2</b></span><br>
                <span>Staff Behavior : <b>4.7</b></span>
                
                </div>
                </div>
                
                </div>
                <hr>
                
                <span><b> 12 Customers have rated this service.</b>
                </span>
                <hr>
                
                <div class="row">
                <div class="col-md-9">
                <b>Nilotpal Boruah</b><br>
                <p><font style="font-size: 10px;">Travelled with Network Travels on 21st May, 2016</font></p>
                <span>Staffs behaved well and listen to the passenger. overall nice and comfort journey </span>
                
                </div>
                <div class="col-md-3">
                 <div class="pull-right">
                <span>Overall Ratings : <b>4.5</b></span><br>
                <span>Punctuality : <b>4.2</b></span><br>
                <span>Staff Behavior : <b>4.7</b></span>
                
                </div>
                </div>
                
                </div>
                
                
                <hr>
                
                 <div class="row">
                <div class="col-md-9">
                <b>Nilotpal Boruah</b><br>
                <p><font style="font-size: 10px;">Travelled with Network Travels on 21st Oct, 2016</font></p>
                <span>Staffs behaved well and listen to the passenger. overall nice and comfort journey </span>
                
                </div>
                <div class="col-md-3">
                 <div class="pull-right">
                <span>Overall Ratings : <b>4.5</b></span><br>
                <span>Punctuality : <b>4.2</b></span><br>
                <span>Staff Behavior : <b>4.7</b></span>
                
                </div>
                </div>
                
                </div>
                
                   <hr>
                
                 <div class="row" style="margin-bottom: 5%;">
                <div class="col-md-9">
                <b>Nilotpal Boruah</b><br>
                <p><font style="font-size: 10px;">Travelled with Network Travels on 21st May, 2016</font></p>
                <span>Staffs behaved well and listen to the passenger. overall nice and comfort journey </span>
                
                </div>
                <div class="col-md-3">
                 <div class="pull-right">
                <span>Overall Ratings : <b>4.5</b></span><br>
                <span>Punctuality : <b>4.2</b></span><br>
                <span>Staff Behavior : <b>4.7</b></span>
                
                </div>
                </div>
                
                </div>
            
            </div>
        </div>
        
        

		<div class="container">

		<form class="booking-item-dates-change mb30" style="margin-top: 3%;">
                <div class="row">
                    <div class="col-md-2">
                        <div class="booking-item-airline-logo">
                           <img src="../resource/img/n1.png" alt="Image Alternative text" title="Image Title" />
                                      <p>Network Travels</p>
                                               
                                            </div>
                    </div>
                    <div class="col-md-4">
                        <i class="fa fa-clock-o fa-3x  pull-left"></i>
                        <div class="col-md-4">{{busDetail.bus.fromCity}} <br> {{busDetail.bus.startTime}}
                        </div>
                        <div class="col-md-4">	
                          {{busDetail.bus.toCity}}<br> {{busDetail.bus.endtime}}</div>
                        
                    </div>
                    <div class="col-md-2">
                        <div class="booking-item-airline-logo">
                                                <img src="../resource/img/seat.png" alt="Image Alternative text" title="Image Title" />
                                                <p>{{busDetail.bus.seatCapacity}} Seats</p>
                                               
                                            </div>
                    </div>
                    
                     <div class="col-md-2">
                        <div class="booking-item-airline-logo">
                                                <div style="background-image: url(../resource/img/icons.png);background-position: -181px 0; width : 60px; height: 11px;">
                                                <div style="background-image: url(../resource/img/icons.png);background-position: -181px -11px; width : 88%; height: 11px;"></div>
                                                </div>
                                                <p><a class="popup-text" href="#ratings-dialog" data-effect="mfp-zoom-out">Ratings</a></p>
                                               
                                            </div>
                    </div>
                    
                     <div class="col-md-2">
                        <div class="booking-item-airline-logo">
                                              
                                               <b> Rs : {{busDetail.bus.fare}}/person</b> <br>
                                                <a class="btn btn-primary"  ng-click="validateSelectedSeat($event)">Book</a>
                                            </div>
                    </div>
                   
                </div>
            </form>

		</div>
		
		<div class="container">

		<form class="booking-item-dates-change mb30" style="margin-top: 3%;background-color: #eee">
               
               <span ng-if="noSeatSelected" style="margin-left:20%;margin-bottom:5%;color:rgba(218, 29, 29, 0.9);">*Please select atleast one seat!</span>
                <div class="row">
               	
               	<div ng-if="seat40">

               		<div class="col-md-4" style="background-color: #fff; border:1px solid #ccc ;border-radius : 10px;margin-left: 10%;">
               		
               		<div style="height: 126px;width: 364px">
    
    				<div style="margin-top : 5%;">
    				
    				<div class="col-md-1" style="left: 0px;">
	               		<a href="#" style="height: 20px;width: 20px; display: block;background-position: -24px -106px;;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"></a>
	               	</div>
	               	
	              
	              <div class="col-md-1">
		               	<div style="left: 264px; top: 72px;">
		       
		               		<a ng-click="selected(2)"  ng-style="{'background-position' :  + (isAvailableView(2))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">2</font></a>
		               	</div>
		               	<div style="left: 264px; top: 24px;">
		               		<a ng-click="selected(1)" ng-style="{'background-position' :  + (isAvailableView(1))}"  style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">1</font></a>
		               	</div>
		               		<br>
		               		
		               	<div style="left: 264px; top: 24px;">
		               		<a ng-click="selected(40)" ng-style="{'background-position' :  + (isAvailableView(40))}"  style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">40</font></a>
		               	</div>		
		            
		               		
	               	</div>
	               	
	              <div class="col-md-1" ng-repeat = "seat in [1,2,3,4,5,6,7,8]">
	               		<div style="left: 264px; top: 72px;">
	       
	               		<a ng-click="selected((2+(4*($index+1))))"  ng-style="{'background-position' :  + (isAvailableView(2+(4*($index+1))))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">{{2+(4*($index+1))}}</font></a>
	             	  	</div>
	               	
	               		<div style="left: 264px; top: 24px;">
	               		<a ng-click="selected((1+(4*($index+1))))" ng-style="{'background-position' :  + (isAvailableView(1+(4*($index+1))))}"  style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">{{1+(4*($index+1))}}</font></a>
	               		</div>
	               		<br>
	               		
	               		<div style="left: 264px; top: 0px;">
	               		<a ng-click="selected((0+(4*($index+1))))" ng-style="{'background-position' :  + (isAvailableView(0+(4*($index+1))))}" style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">{{0+(4*($index+1))}}</font></a>
	               		</div> 
	               		<div style="left: 264px; top: 0px;">
	               		<a ng-click="selected((-1+(4*($index+1))))" ng-style="{'background-position' :  + (isAvailableView(-1+(4*($index+1))))}" style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">{{-1+(4*($index+1))}}</font></a>
	               		</div>
	               	</div>
	               	
	               	
	               	<div class="col-md-1">
	               		<div style="left: 264px; top: 72px;">
	               		<a href="#" ng-click="selected(39)" ng-style="{'background-position' : +(isAvailableView(39))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">39</a>
	               		</div>
	               			<div style="left: 264px; top: 24px;">
	               		<a href="#" ng-click="selected(38)" ng-style="{'background-position' : +(isAvailableView(38))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">38</a>
	               		</div>
	               		<div style="left: 264px; top: 0px;">
	               		<a href="#" ng-click="selected(37)" ng-style="{'background-position' : +(isAvailableView(37))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">37</a>
	               		</div>
	               		
	               		<div style="left: 264px; top: 0px;">
	               		<a href="#" ng-click="selected(36)" ng-style="{'background-position' : +(isAvailableView(36))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">36</a>
	               		</div>
	               		<div style="left: 264px; top: 0px;">
	               		<a href="#" ng-click="selected(35)" ng-style="{'background-position' : +(isAvailableView(35))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">35</a>
	               		</div>
	               	</div>	
	        
	            	</div>
	               	
	               </div>
               		
               	 </div>
               		
               </div>

               	
               	
               	<div ng-if="seat39">

               		<div class="col-md-4" style="background-color: #fff; border:1px solid #ccc ;border-radius : 10px;margin-left: 10%;">
               		
               		<div style="height: 126px;width: 364px">
    
    				<div style="margin-top : 5%;">
    				
    				<div class="col-md-1" style="left: 0px;">
	               		<a href="#" style="height: 20px;width: 20px; display: block;background-position: -24px -106px;;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"></a>
	               	</div>
	               
	              <div class="col-md-1">
		               	<div style="left: 264px; top: 72px;">
		       
		               		<a ng-click="selected(2)"  ng-style="{'background-position' :  + (isAvailableView(2))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">2</font></a>
		               	</div>
		               	<div style="left: 264px; top: 24px;">
		               		<a ng-click="selected(1)" ng-style="{'background-position' :  + (isAvailableView(1))}"  style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">1</font></a>
		               	</div>
		               		<br>
		               		
		               		
		            
		               		
	               	</div>
	               	
	              <div class="col-md-1" ng-repeat = "seat in [1,2,3,4,5,6,7,8]">
	               		<div style="left: 264px; top: 72px;">
	       
	               		<a ng-click="selected((2+(4*($index+1))))"  ng-style="{'background-position' :  + (isAvailableView(2+(4*($index+1))))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">{{2+(4*($index+1))}}</font></a>
	             	  	</div>
	               	
	               		<div style="left: 264px; top: 24px;">
	               		<a ng-click="selected((1+(4*($index+1))))" ng-style="{'background-position' :  + (isAvailableView(1+(4*($index+1))))}"  style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">{{1+(4*($index+1))}}</font></a>
	               		</div>
	               		<br>
	               		
	               		<div style="left: 264px; top: 0px;">
	               		<a ng-click="selected((0+(4*($index+1))))" ng-style="{'background-position' :  + (isAvailableView(0+(4*($index+1))))}" style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">{{0+(4*($index+1))}}</font></a>
	               		</div> 
	               		<div style="left: 264px; top: 0px;">
	               		<a ng-click="selected((-1+(4*($index+1))))" ng-style="{'background-position' :  + (isAvailableView(-1+(4*($index+1))))}" style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">{{-1+(4*($index+1))}}</font></a>
	               		</div>
	               	</div>
	               	
	               	
	               	<div class="col-md-1">
	               		<div style="left: 264px; top: 72px;">
	               		<a href="#" ng-click="selected(39)" ng-style="{'background-position' : +(isAvailableView(39))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">39</a>
	               		</div>
	               			<div style="left: 264px; top: 24px;">
	               		<a href="#" ng-click="selected(38)" ng-style="{'background-position' : +(isAvailableView(38))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">38</a>
	               		</div>
	               		<div style="left: 264px; top: 0px;">
	               		<a href="#" ng-click="selected(37)" ng-style="{'background-position' : +(isAvailableView(37))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">37</a>
	               		</div>
	               		
	               		<div style="left: 264px; top: 0px;">
	               		<a href="#" ng-click="selected(36)" ng-style="{'background-position' : +(isAvailableView(36))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">36</a>
	               		</div>
	               		<div style="left: 264px; top: 0px;">
	               		<a href="#" ng-click="selected(35)" ng-style="{'background-position' : +(isAvailableView(35))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">35</a>
	               		</div>
	               	</div>	
	        
	            	</div>
	               	
	               </div>
               		
               	 </div>
               		
               </div>
               
               	<div ng-if="seat35">

               		<div class="col-md-4" style="background-color: #fff; border:1px solid #ccc ;border-radius : 10px;margin-left: 10%;">
               		
               		<div style="height: 126px;width: 364px">
    
    				<div style="margin-top : 5%;">
    				
    				<div class="col-md-1" style="left: 0px;">
	               		<a href="#" style="height: 20px;width: 20px; display: block;background-position: -24px -106px;;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"></a>
	               	</div>
	             	<div class="col-md-1">
		               	<div style="left: 264px; top: 72px;">
		       
		               		<a ng-click="selected(2)"  ng-style="{'background-position' :  + (isAvailableView(2))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">2</font></a>
		               	</div>
		               	<div style="left: 264px; top: 24px;">
		               		<a ng-click="selected(1)" ng-style="{'background-position' :  + (isAvailableView(1))}"  style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">1</font></a>
		               	</div>
		               		<br>
		            
		               		
	               	</div>
	            
	               	
	               <div class="col-md-1" ng-repeat = "seat in [1,2,3,4,5,6,7]">
	               		<div style="left: 264px; top: 72px;">
	       
	               		<a ng-click="selected((2+(4*($index+1))))"  ng-style="{'background-position' :  + (isAvailableView(2+(4*($index+1))))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">{{2+(4*($index+1))}}</font></a>
	             	  	</div>
	               	
	               		<div style="left: 264px; top: 24px;">
	               		<a ng-click="selected((1+(4*($index+1))))" ng-style="{'background-position' :  + (isAvailableView(1+(4*($index+1))))}"  style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">{{1+(4*($index+1))}}</font></a>
	               		</div>
	               		<br>
	               		
	               		<div style="left: 264px; top: 0px;">
	               		<a ng-click="selected((0+(4*($index+1))))" ng-style="{'background-position' :  + (isAvailableView(0+(4*($index+1))))}" style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">{{0+(4*($index+1))}}</font></a>
	               		</div> 
	               		<div style="left: 264px; top: 0px;">
	               		<a ng-click="selected((-1+(4*($index+1))))" ng-style="{'background-position' :  + (isAvailableView(-1+(4*($index+1))))}" style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"><font style="padding-left:10%;color :#968181cc;font-size: 12px;">{{-1+(4*($index+1))}}</font></a>
	               		</div>
	               	</div>
	               	
	               	
	               	<div class="col-md-1">
	               		<div style="left: 264px; top: 72px;">
	               		<a href="#" ng-click="selected(35)" ng-style="{'background-position' : +(isAvailableView(35))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">35</a>
	               		</div>
	               			<div style="left: 264px; top: 24px;">
	               		<a href="#" ng-click="selected(34)" ng-style="{'background-position' : +(isAvailableView(34))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">34</a>
	               		</div>
	               		<div style="left: 264px; top: 0px;">
	               		<a href="#" ng-click="selected(33)" ng-style="{'background-position' : +(isAvailableView(33))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">33</a>
	               		</div>
	               		
	               		<div style="left: 264px; top: 0px;">
	               		<a href="#" ng-click="selected(32)" ng-style="{'background-position' : +(isAvailableView(32))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">32</a>
	               		</div>
	               		<div style="left: 264px; top: 0px;">
	               		<a href="#" ng-click="selected(31)" ng-style="{'background-position' : +(isAvailableView(31))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">31</a>
	               		</div>
	               	</div>	
	               	
	        
	            	</div>
	               	
	               </div>
               		
               	 </div>
               		
               </div>
               	
               	
               	<div ng-if="seat31">
               	
               			<div class="col-md-4" style="background-color: #fff; border:1px solid #ccc ;border-radius : 10px;margin-left: 10%;">
               		
               		<div style="height: 96px;width: 364px">
               		
               		<div style="margin-top: 5%;">
               		<div class="col-md-1" style="left: 0px;">
	               		<a href="#" style="height: 20px;width: 20px; display: block;background-position: -24px -106px;;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"></a>
	               	</div>

					<div  style="margin-left: 4%;">
	               	<div class="col-md-1" ng-repeat = "seat in [1,2,3,4,5,6,7,8,9]">
	               	<div style="left: 264px; top: 72px;">
	       
	               		<a ng-click="selected((3+(3*$index)))"  ng-style="{'background-position' :  + (isAvailableView(3+(3*$index)))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">{{3+3*$index}}</a>
	               	</div>
	               	
	               	<div style="left: 264px; top: 24px;">
	               		<a ng-click="selected((2+(3*$index)))" ng-style="{'background-position' :  + (isAvailableView(2+(3*$index)))}"  style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">{{2+(3*$index)}}</a>
	               		</div>
	               		<br>
	               		
	               		<!-- <div style="left: 264px; top: 0px;">
	               		<a href="#"  style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"></a>
	               		</div> -->
	               		<div style="left: 264px; top: 0px;">
	               		<a ng-click="selected((1+(3*$index)))" ng-style="{'background-position' :  + (isAvailableView(1+(3*$index)))}" style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">{{1+(3*$index)}}</a>
	               		</div>
	               	</div>
	               	</div>
	      
	           		<!-- Herer enter -->
	           
	               		
	               	<div class="col-md-1">
	               		<div style="left: 264px; top: 72px;">
	               		<a href="#" ng-click="selected(31)" ng-style="{'background-position' : +(isAvailableView(31))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">31</a>
	               		</div>
	               			<div style="left: 264px; top: 24px;">
	               		<a href="#" ng-click="selected(30)" ng-style="{'background-position' : +(isAvailableView(30))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">30</a>
	               		</div>
	               		<!-- <div style="left: 264px; top: 24px;">
	               		<a href="#" style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"></a>
	               		</div> -->
	               		
	               		<div style="left: 264px; top: 0px;">
	               		<a href="#" ng-click="selected(29)" ng-style="{'background-position' : +(isAvailableView(29))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">29</a>
	               		</div>
	               		<div style="left: 264px; top: 0px;">
	               		<a href="#" ng-click="selected(28)" ng-style="{'background-position' : +(isAvailableView(28))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">28</a>
	               		</div>
	               	</div>	
	               	
	               	</div>
               		
               		</div>
               		
               		</div>
               
               	</div>
               	
               	
               		<div ng-if="seat32">
               	
               			<div class="col-md-4" style="background-color: #fff; border:1px solid #ccc ;border-radius : 10px;margin-left: 10%;">
               		
               		<div style="height: 116px;width: 364px">
               		
               		<div style="margin-top: 5%;">
               		<div class="col-md-1" style="left: 0px;">
	               		<a href="#" style="height: 20px;width: 20px; display: block;background-position: -24px -106px;;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"></a>
	               	</div>

					<div  style="margin-left: 4%;">
	               	<div class="col-md-1" ng-repeat = "seat in [1,2,3,4,5,6,7,8,9]">
	               	<div style="left: 264px; top: 72px;">
	       
	               		<a ng-click="selected((3+(3*$index)))"  ng-style="{'background-position' :  + (isAvailableView(3+(3*$index)))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">{{3+(3*$index)}}</a>
	               	</div>
	               	
	               	<div style="left: 264px; top: 24px;">
	               		<a ng-click="selected((2+(3*$index)))" ng-style="{'background-position' :  + (isAvailableView(2+(3*$index)))}"  style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">{{2+(3*$index)}}</a>
	               		</div>
	               		<br><br>
	               		
	               		<!-- <div style="left: 264px; top: 0px;">
	               		<a href="#"  style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"></a>
	               		</div> -->
	               		<div style="left: 264px; top: 0px;">
	               		<a ng-click="selected((1+(3*$index)))" ng-style="{'background-position' :  + (isAvailableView(1+(3*$index)))}" style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">{{1+(3*$index)}}</a>
	               		</div>
	               	</div>
	               	</div>
	      
	           		<!-- Herer enter -->
	           
	               		
	               	<div class="col-md-1">
	               		<div style="left: 264px; top: 72px;">
	               		<a  ng-click="selected(32)" ng-style="{'background-position' : +(isAvailableView(32))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">32</a>
	               		</div>
	               			<div style="left: 264px; top: 24px;">
	               		<a ng-click="selected(31)" ng-style="{'background-position' : +(isAvailableView(31))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">31</a>
	               		</div>
	               		<div style="left: 264px; top: 24px;">
	               		<a  ng-click="selected(30)" ng-style="{'background-position' : +(isAvailableView(30))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">30</a>
	               		</div>
	               		
	               		<div style="left: 264px; top: 0px;">
	               		<a  ng-click="selected(29)" ng-style="{'background-position' : +(isAvailableView(29))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">29</a>
	               		</div>
	               		<div style="left: 264px; top: 0px;">
	               		<a  ng-click="selected(28)" ng-style="{'background-position' : +(isAvailableView(28))}" style="height: 20px;width: 20px; display: block;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;">28</a>
	               		</div>
	               	</div>	
	               	
	               	</div>
               		
               		</div>
               		
               		</div>
               
               	</div>
               	
		
               		<div class="col-md-4" style="margin-left: 15%;">
               			
	               		<div class="col-md-1">
		               		<span style="height: 20px;width: 20px; display: block;background-position: 0 0;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"></span>
		               	</div>	
		               	<div class="col-md-6" >	
		               		<span>Available Seat</span>
		               	</div>	
	               	<br>
		               	<div class="col-md-1">
		               		<span style="height: 20px;width: 20px; display: block;background-position: 0 -60px;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"></span>
		               	</div>	
		               	<div class="col-md-6" >	
		               		<span>Selected Seat</span>
		               	</div>	
		               <br>
		               
		               		<div class="col-md-1">
		               		<span style="height: 20px;width: 20px; display: block;background-position: 0 -40px;background-image: url(../resource/img/Seatlayout1.png);background-repeat: no-repeat;"></span>
		               	</div>	
		               	<div class="col-md-6" >	
		               		<span>Booked Seat</span>
		               	</div>
		               <br><br>
		               
		               <span >Travel Date : {{startDate}}</span>	
	               	
	               	<div style="margin-top : 10%;">
	               		<span>Seat(s): </span><br>
						<span>Total Fare : {{totalFare}} </span>
	               	</div>
               		</div>

                </div> <!-- End Of Row1 -->
                	
                
                <div class="row">
                		
                		 <div class="col-md-4" style="margin-left: 10%; margin-top: 5%;">
                              <div class="form-group form-group-lg form-group-icon-left" id=""><i class="fa fa-map-marker input-icon"></i>
                                  <label>Choose boarding point </label>
                                   <select class="form-control" ng-model="boardingPoint" id="sel1" ng-change="noBoardingPoint=false">
                                   			<option value="">--Boarding Points-- </option>
										    <option ng-repeat="n in boardingPoints" value="{{n}}">{{n}}</option>
										
  								</select>
  								<br>
  								 <span ng-if="noBoardingPoint" style="margin-left:5%;color:rgba(218, 29, 29, 0.9);">*Please select a boarding point!</span>
                              </div>
                          </div>
                          
                          <div class="col-md-4" style=" margin-top: 8%;">
                          
                          <a class="btn btn-primary" ng-href="confirmBooking.jsp" ng-click="validateSelectedSeat($event)" >Continue</a>
                          
                          </div>
                          
                           
                
                
                </div>
                <div class="row">
                <div style="margin-left: 15%;">
			<p class="">Not what you're looking for? <a class="popup-text" href="#search-dialog" data-effect="mfp-zoom-out">Try your search again</a>
			</div>
                </div>
               
                
            </form>

			

		</div>
		


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
        
        <script>
        
        $(document).ready(function(){
        	
        	setTimeout(function(){
    			$('body').addClass('loaded');
    			
    		}, 1000);
        	
        	
        	$('#backtotop').click(function() {
        		$('html, body').animate({
        			scrollTop: 0
        		}, 700);
        		return false;
        	});
        	
        	
        	
        	 
             
             var substringMatcher = function(strs) {
            	 
            	
            	 
     			  return function findMatches(q, cb) {
     			    var matches, substringRegex;

     			    // an array that will be populated with substring matches
     			    matches = [];

     			    // regex used to determine if a string contains the substring `q`
     			    substrRegex = new RegExp(q, 'i');

     			    // iterate through the pool of strings and for any string that
     			    // contains the substring `q`, add it to the `matches` array
     			    $.each(strs, function(i, str) {
     			      if (substrRegex.test(str)) {
     			        matches.push(str);
     			      }
     			    });

     			    cb(matches);
     			  };
     			};
     				
     		
     			$('#the-basics').typeahead({
     				  hint: true,
     				  highlight: true,
     				  minLength: 1
     				},
     				{
     				  name: 'subjects',
     				  source: substringMatcher(states)
     				});
        });
        
        </script>
        
        
        <script>
        
       
        
        </script>
        
    </div>
</body>
</html>