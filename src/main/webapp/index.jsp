<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="network">
<head>  
 <title>Network Travels</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link rel="stylesheet" href="resource/css/bootstrap.css">
    <link rel="stylesheet" href="resource/css/font-awesome.css">
    <link rel="stylesheet" href="resource/css/icomoon.css">
    <link rel="stylesheet" href="resource/css/styles.css">
    <link rel="stylesheet" href="resource/css/mystyles.css">
    <link rel="stylesheet" href="resource/css/typeahead.css">
 
    <script src="resource/js/angular.js"></script>
    <script src="resource/js/ui-bootstrap.js"></script>
    <script src="resource/js/angular-local-storage.js"></script>
    <script src="resource/angularjs/controller/index_cityname.js"></script>
    <script src="resource/angularjs/services/CityService.js"></script>
 
    <!-- validation for city in One Way tab -->
    <script type="text/javascript">
        function updateSelect(changedSelect, selectId) {
        var otherSelect = document.getElementById(selectId);
        for (var i = 0; i < otherSelect.options.length; ++i) {
            otherSelect.options[i].disabled = false;
        }
        if (changedSelect.selectedIndex == 0) {
        return;
        }
        otherSelect.options[changedSelect.selectedIndex].disabled = true;
        }
    </script>

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
<body data-ng-controller="CityController" id="body" ng-cloak>
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
                            <a class="logo" href="index.jsp">
                                <img src="resource/img/logo.jpg"  title="Image Title" />
                            </a>
                        </div>
                <div class="nav">
                    <ul class="slimmenu" id="slimmenu">
                        <li class="active"><a href="index.jsp">Home</a>

                        </li>
                        <li><a target="blank" href="pages/tourism.jsp"> Tourism</a>
                                </li>

                        <li><a href="pages/cancellation.jsp">Cancellation</a>  </li>
                        <li><a href="pages/printsms.jsp">Print / SMS Ticket</a></li>
                        <!--  <li><a href="pages/aboutus.jsp">About Us</a>
                                </li> -->
                        <li><a href="pages/contactus.jsp">Contact Us</a></li>
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
                                <li><a href="pages/viewMyTrips.jsp">My Trips</a>
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
                                <li><a href="pages/viewMyTrips.jsp">My Trips</a>
                                </li>
                                <li><a ng-click="logout()">Logout</a>
                                </li>
                           
                            </ul>
                        </li>
                  	</ul>
                </div>
            </div>
        </header>

        <!-- TOP AREA -->
        <div class="top-area show-onload">
            <div class="bg-holder full">
                <div class="bg-mask"></div>
                <div class="bg-parallax" style="background-image:url(resource/img/n2.jpg);"></div>
                <div class="bg-content">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="search-tabs search-tabs-bg mt50">

                                    <div class="hidden-xs hidden-sm test"  style="color: #fff;">
                           
                                        <div class="tab-content" style="padding: 5%;">
                                            <div class="tab-pane fade in active" id="tab-1">
                                                <span style="color: #fff; font-size: 24px;">Online Bus Tickets Booking</span>
                                                 <form>
                                                    <div class="tabbable">
                                                        <ul class="nav nav-pills nav-sm nav-no-br mb10" id="flightChooseTab">
                                                           <!--  <li class="active" style="background-color: #fff;"><a href="#flight-search-1" data-toggle="tab">Round Trip</a>
                                                            </li> -->
                                                          <!--   <li class="active" style="background-color: #fff;"><a href="#flight-search-2" data-toggle="tab">One Way</a>
                                                            </li> -->
                                                        </ul>
                                                        <div class="tab-content">
                                                          <!--   <div class="tab-pane fade in active" id="flight-search-1">
                                                                <div class="row">
                                                                    <div class="col-md-6">
                                                                        <div class="form-group form-group-lg form-group-icon-left" id=""><i class="fa fa-map-marker input-icon"></i>
                                                                            <label>From</label>

                                                                    <input type="text" data-ng-change="copied=selected" data-ng-model="selected" data-typeahead="cityNames for cityNames in cityNames | filter:$viewValue | limitTo:8" class="form-control" placeholder="Select city name">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="form-group form-group-lg form-group-icon-left" id=""><i class="fa fa-map-marker input-icon"></i>
                                                                            <label>To</label>

                                                                    <input type="text" data-ng-change="copied=selected1" data-ng-model="selected1" data-typeahead="cityNames for cityNames in cityNames | filter:$viewValue | limitTo:8" class="form-control" placeholder="Select city name">


                                                                        

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="input-daterange" data-date-format="M d, D">
                                                                    <div class="row">
                                                                        <div class="col-md-3">
                                                                            <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-calendar input-icon input-icon-highlight"></i>
                                                                                <label>Departing</label>
                                                                                <input class="form-control" name="start" data-ng-model="parent.startdate1" style="border-radius: 5px;"type="text" />
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-calendar input-icon input-icon-highlight"></i>
                                                                                <label>Returning</label>
                                                                                <input class="form-control" name="end1" ng-model="end1" style="border-radius: 5px;" type="text" />
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <div class="form-group form-group-lg form-group-select-plus">
                                                                                <label>Passngers</label>
                                                                                <div class="btn-group btn-group-select-num" data-toggle="buttons">
                                                                                    <label class="btn btn-danger active">
                                                                                        <input type="radio" name="options" />1</label>
                                                                                    <label class="btn btn-danger" style="color: #fff; border: 1px solid #d84e55;">
                                                                                        <input type="radio" name="options" />2</label>
                                                                                    <label class="btn btn-danger" style="color: #fff; border: 1px solid #d84e55;">
                                                                                        <input type="radio" name="options" />3</label>
                                                                                    <label class="btn btn-danger" style="color: #fff; border: 1px solid #d84e55;">
                                                                                        <input type="radio" name="options" />3+</label>
                                                                                </div>
                                                                                <select class="form-control hidden">
                                                                                    <option>1</option>
                                                                                    <option>2</option>
                                                                                    <option>3</option>
                                                                                    <option selected="selected">4</option>
                                                                                    <option>5</option>
                                                                                    <option>6</option>
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
                                                            </div> -->

                                                            <div class="tab-pane fade in active" id="flight-search-1">
                                                                <div class="row">
                                                                    <div class="col-md-6">
                                                                        <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-map-marker input-icon"></i>
                                                                         <label>From</label>

                                                                        <input type="text" data-ng-change="copied=selected" data-ng-model="selected2" data-typeahead="cityNames for cityNames in cityNames | filter:$viewValue:startsWith | limitTo:8" class="form-control" placeholder="Select city name">

                                                                     <!--       <select class="typeahead form-control" id="city1" onchange="updateSelect(this,'city2');" name="">
                                                                                <option value="" selected="selected">Please Select City</option>
                                                                                <option ng-repeat="x in cityname" id="{{x.id}}">
                                                                                  {{x.name}}
                                                                                </option>
                                                                             </select> -->

                                                                         <!-- input class="typeahead form-control" placeholder="City, Airport, U.S. Zip" type="text" -->

                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-map-marker input-icon"></i>
                                                                         <label>To</label>

                                                                         <input type="text" data-ng-change="copied=selected" data-ng-model="selected3" data-typeahead="cityNames for cityNames in cityNames | filter:$viewValue:startsWith | limitTo:8" class="form-control" placeholder="Select city name">


                                                                     <!--       <select class="form-control" id="city2" onchange="updateSelect(this,'city1');" name="">
                                                                                <option value="" selected="selected">Please Select City</option>
                                                                                <option ng-repeat="y in cityname" id="{{y.id}}">
                                                                                  {{y.name}}
                                                                                </option>
                                                                            </select> -->

                                                                        <!-- input class="typeahead form-control" placeholder="City, Airport, U.S. Zip" type="text" / -->

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-md-3">
                                                                        <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-calendar input-icon input-icon-highlight"></i>
                                                                            <label>Departing</label>
                                                                            <input class="date-pick form-control" id="journeyDate123"  data-date-format="M d, yyyy" type="text"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="form-group form-group-lg form-group-select-plus">
                                                                            <label>Passngers</label>
                                                                            <div class="btn-group btn-group-select-num" data-toggle="buttons">
                                                                                <label class="btn btn-primary active">
                                                                                    <input type="radio" name="options" />1</label>
                                                                                <label class="btn btn-primary" style="color: #fff !important; border: 1px solid white !important; ">
                                                                                    <input type="radio" name="options" />2</label>
                                                                                <label class="btn btn-primary" style="color: #fff !important; border: 1px solid white !important; ">
                                                                                    <input type="radio" name="options" />3</label>
                                                                                <label class="btn btn-primary" style="color: #fff; border: 1px solid white;">
                                                                                    <input type="radio" name="options" />3+</label>
                                                                            </div>
                                                                            <select class="form-control hidden">
                                                                                <option>1</option>
                                                                                <option>2</option>
                                                                                <option>3</option>
                                                                                <option selected="selected">4</option>
                                                                                <option>5</option>
                                                                                <option>6</option>
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
                                                    <a href="pages/searchResult.jsp" ng-click="busSearch()" id="submit"><button class="btn btn-danger btn-lg" type="button" style="border:0px;">Search Buses</button></a>
                                                </form>
                                            </div>


                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="loc-info text-right hidden-xs hidden-sm">
                                    <h3 class="loc-info-title"><!-- <img src="img/flags/32/fr.png" alt="Image Alternative text" title="Image Title" /> -->Guwahati</h3>
                                    <p class="loc-info-weather"><span class="loc-info-weather-num">+35</span><i class="im im-sun loc-info-weather-icon"></i>
                                    </p>
                                    <ul class="loc-info-list">
                                        <li><a href="#"><i class="fa fa-building-o"></i> 29 Buses</a>
                                        </li>
                                        <li><a href="#"><i class="fa fa-home"></i> 291 Rentals </a>
                                        </li>
                                        <li><a href="#"><i class="fa fa-car"></i> 244 Cars </a>
                                        </li>

                                        </li>
                                    </ul><!-- <a class="btn btn-white btn-ghost mt10" href="#"><i class="fa fa-angle-right"></i> Explore</a> -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END TOP AREA  -->

        <div class="gap"></div>
        <div class="container">
            <div class="row row-wrap" data-gutter="60">
                <div class="col-md-4" >
                    <div class="thumb">
                        <header class="thumb-header" style="margin-left : 32%;"><img src="resource/img/bus-80.png" style="width:70px;height:70px;">
                        </header>
                        <div class="thumb-caption" style="margin-left : 30%;">
                            <h5 class="thumb-title"><a class="text-darken" href="#">20 Buses</a></h5>
                        </div>
                    </div>
                </div>
                <div class="col-md-4" >
                    <div class="thumb">
                        <header class="thumb-header" style="margin-left : 32%;"><img src="resource/img/bus-81.png" style="width:70px;height:70px;">
                        </header>
                        <div class="thumb-caption" style="margin-left : 20%;">
                            <h5 class="thumb-title"><a class="text-darken" href="#">Best Travel Agents</a></h5>

                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="thumb">
                        <header class="thumb-header" style="margin-left : 34%;"><img src="resource/img/bus-82.png" style="width:70px;height:70px;">
                        </header>
                        <div class="thumb-caption" style="margin-left : 28%;">
                            <h5 class="thumb-title"><a class="text-darken" href="#">Trust & Safety</a></h5>

                        </div>
                    </div>
                </div>
                <p style="margin-left: 10%; margin-right:11%; margin-bottom:0%; font-size:15px;">
                Established in 1992, first Government of India recognized tour operator in Northeast India. Best rates and comprehensive packages for private
                <p style="margin-left: 13%; margin-right:11%; font-size:15px;"> holidays. Tailor-made itineraries for special interest groups - birding, wildlife & nature, tribal culture, tea tourism, river cruise etc.</p>
                </p>
            </div>
            <div class="gap gap-small"></div>
        </div> <!--container end -->
        <div class="bg-holder">
            <div class="bg-mask"></div>
            <div class="bg-parallax" style="background-image:url(resource/img/interior.jpg);"></div>
            <div class="bg-content">
                <div class="container">
                 <div class="col-md-1"></div>
                    <div class="col-md-5">
                        <div class="gap gap-big text-left text-white">

                            <div id="myCarousel" class="carousel fadeout" data-ride="carousel" style="width:190px;height:420px;">
                                <!-- Indicators -->
                                <ol class="carousel-indicators">
                                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                                    <li data-target="#myCarousel" data-slide-to="1"></li>
                                    <li data-target="#myCarousel" data-slide-to="2"></li>
                                    <li data-target="#myCarousel" data-slide-to="3"></li>
                                </ol>

                                <!-- Wrapper for slides -->
                                <div class="carousel-inner" role="listbox" >
                                  <div class="item active" >
                                    <img src="resource/img/A.png" alt="Chania" style="width:190px;height:370px;" >
                                  </div>

                                  <div class="item" >
                                    <img src="resource/img/B.png" alt="Chania" style="width:190px;height:370px;" >
                                  </div>

                                  <div class="item" >
                                    <img src="resource/img/C.png" alt="Chania" style="width:190px;height:370px;" >
                                  </div>

                                  <div class="item" >
                                    <img src="resource/img/B.png" alt="Chania" style="width:190px;height:370px;" >
                                  </div>
                                </div>
                            </div>

                            <div style="height:40px; width: 130px; margin-left:28px;"><a href="#"><img src="resource/img/googleplay.png" ></a></div>
                    </div>
                    </div>

                     <div class="col-md-5">
                        <div class="gap gap-big text-left text-white">
                            <header class="thumb-header">
                             <img src="resource/img/70-2.png" class="roundedImage" style="margin-left : 42%;"><br>
                             <font style="font-size:18px; font-weight:400; margin-left : 41%;"><b>Luxury</b></font><br>
                             <font style="font-size:14px; font-weight:400; margin-left : 12%;">Booking bus tickets will never be a cause of concern!</font><br>
                             <font style="font-size:14px; font-weight:400; margin-left : 16%;"> Hassle-free booking and instant confirmation. </font>
                             <br><br>
                             <img src="resource/img/70-3.png" class="roundedImage" style="margin-left : 42%;"><br>
                             <font style="font-size:18px; font-weight:400; margin-left : 40%;"><b>Essence</b></font><br>
                             <font style="font-size:14px; font-weight:400; margin-left : 6%;">Clean and safe journey with a well trained and reliable crew.</font>
                             <br><br>
                             <img src="resource/img/70-1.png" class="roundedImage" style="margin-left : 42%;"><br>
                             <font style="font-size:18px; font-weight:400; margin-left : 36%;"><b>Transparency</b></font><br>
                             <font style="font-size:14px; font-weight:400; margin-left : 6%;">Transperant transaction with convinient online payment portal.</font>
                          </div>
                    </div>

                    <div class="col-md-1"></div>

                </div>
            </div>
        </div>
        <div class="container">
            <div class="gap"></div>
            <h2 class="text-center">Top Holiday Destinations</h2>
            <div class="gap">
                <div class="row row-wrap">
                    <div class="col-md-3">
                        <div class="thumb">
                            <header class="thumb-header">
                                <a class="hover-img curved" href="#">
                                    <img src="resource/img/bhutan.jpg" alt="Image Alternative text" title="Upper Lake in New York Central Park" /><i class="fa fa-plus box-icon-white box-icon-border hover-icon-top-right round"></i>
                                </a>
                            </header>
                            <div class="thumb-caption">
                                <h4 class="thumb-title">Bhutan</h4>
                                <p class="thumb-desc">Bhutan Tour Itinerary </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="thumb">
                            <header class="thumb-header">
                                <a class="hover-img curved" href="#">
                                    <img src="resource/img/myanmar.jpg" alt="Image Alternative text" title="lack of blue depresses me" /><i class="fa fa-plus box-icon-white box-icon-border hover-icon-top-right round"></i>
                                </a>
                            </header>
                            <div class="thumb-caption">
                                <h4 class="thumb-title">Myanmar</h4>
                                <p class="thumb-desc">Myanmar Itinerary </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="thumb">
                            <header class="thumb-header">
                                <a class="hover-img curved" href="#">
                                    <img src="resource/img/ne.jpg" alt="Image Alternative text" title="people on the beach" /><i class="fa fa-plus box-icon-white box-icon-border hover-icon-top-right round"></i>
                                </a>
                            </header>
                            <div class="thumb-caption">
                                <h4 class="thumb-title">North-East</h4>
                                <p class="thumb-desc">Northeast India Itinerary </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="thumb">
                            <header class="thumb-header">
                                <a class="hover-img curved" href="#">
                                    <img src="resource/img/Brahmaputra1.jpg" alt="Image Alternative text" title="the journey home" /><i class="fa fa-plus box-icon-white box-icon-border hover-icon-top-right round"></i>
                                </a>
                            </header>
                            <div class="thumb-caption">
                                <h4 class="thumb-title">Brahmaputra</h4>
                                <p class="thumb-desc">Brahmaputra Explorer</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>



        <footer id="main-footer">
            <div class="container">
                <div class="row row-wrap">

                    <div class="col-md-3">
                        <a class="logo" href="index.html">
                            <img src="resource/img/foter.jpg" alt="Image Alternative text" title="Image Title" />
                        </a>
                        <p class="mb20">Booking, reviews and advices on bus travel <br>packages, and lots more!</p>
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
                            

                            <li style="margin-top:3%;"><a href="pages/contactus.jsp">Contact Us</a>
                            </li><h>
                            <li style="margin-top:3%;"><a href="pages/aboutus.jsp">About Us</a>
                            </li>

                            <li style="margin-top:3%;"><a href="pages/cancellation.jsp">Cancellation Policy</a>
                            </li>
                            <li style="margin-top:3%;"><a href="pages/printsms.jsp">Print Ticket</a>
                            </li>
                            <li style="margin-top:3%;"><a href="index.jsp">Home</a>
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

        <script src="resource/js/jquery.js"></script>

        <script src="resource/js/bootstrap.js"></script>
          <script src="resource/js/modernizr.js"></script>
        <script src="resource/js/slimmenu.js"></script>
        <script src="resource/js/bootstrap-datepicker.js"></script>
        <script src="resource/js/bootstrap-timepicker.js"></script>
        <script src="resource/js/nicescroll.js"></script>
        <script src="resource/js/dropit.js"></script>
        <script src="resource/js/ionrangeslider.js"></script>
        <script src="resource/js/icheck.js"></script>
        <script src="resource/js/fotorama.js"></script>
        <!--<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>-->
        <script src="resource/js/typeahead.js"></script>
        <script src="resource/js/card-payment.js"></script>
        <script src="resource/js/magnific.js"></script>
        <script src="resource/js/owl-carousel.js"></script>
        <script src="resource/js/fitvids.js"></script>
        <script src="resource/js/tweet.js"></script>
        <script src="resource/js/countdown.js"></script>
        <script src="resource/js/gridrotator.js"></script>
        <script src="resource/js/custom.js"></script>

        <script>

        $(document).ready(function(){
        	
        	
        	setTimeout(function(){
    			$('body').addClass('loaded');
    			
    		}, 2000);
    		

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

/* 
     			$('#the-basics').typeahead({
     				  hint: true,
     				  highlight: true,
     				  minLength: 1
     				},
     				{
     				  name: 'subjects',
     				  source: substringMatcher(states)
     				}); */
     			
     		$("input.date-pick").change(function(){
     		  			
     			var scope =angular.element($("#body")).scope();
     			
     			
     			
     			scope.$apply(function() {
     		        scope.journeyDate = $("input.date-pick").val();
     			
     		    });
     		
     		}); 
     		
     			
     			
        });

        </script>

    </div>
</body>
</html>