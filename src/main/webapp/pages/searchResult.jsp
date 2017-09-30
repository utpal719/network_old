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
<body data-ng-controller="buscontroller" ng-cloak>
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
                        <li><a href="#">About Us</a> </li>

                        <li><a href="#">Cancellation</a>  </li>
                        <li><a href="#">Banches</a>
                         <li><a href="#">Contact Us</a> </li>
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
                                            <input class="typeahead form-control" placeholder="City, Airport or U.S. Zip Code" type="text" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group form-group-lg form-group-icon-left"><i class="fa fa-map-marker input-icon input-icon-highlight"></i>
                                            <label>To</label>
                                            <input class="typeahead form-control" placeholder="City, Airport or U.S. Zip Code" type="text" />
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
            <h3 class="booking-title">{{busDetails.length}} Buses from {{from}} to {{to}} on {{startDate}} for 1 adult <small><a class="popup-text" href="#search-dialog" data-effect="mfp-zoom-out"></a></small></h3>
            <form class="booking-item-dates-change mb30">
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group form-group-icon-left"><i class="fa fa-map-marker input-icon input-icon-hightlight"></i>
                            <label>From</label>
                            <input class="typeahead form-control" value="{{from}}" placeholder="City" type="text" disabled/>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group form-group-icon-left"><i class="fa fa-map-marker input-icon input-icon-hightlight"></i>
                            <label>To</label>
                            <input class="typeahead form-control" value="{{to}}" placeholder="City" type="text" disabled/>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group form-group-icon-left"><i class="fa fa-calendar input-icon input-icon-hightlight"></i>
                            <label>Departing</label>
                            <input class="form-control"  type="text" value="{{startDate}}" disabled/>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group form-group-select-plus">
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
                                    <input type="radio" name="options" />4+</label>
                            </div>
                            <select class="form-control hidden">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option selected="selected">5</option>
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
            </form>
            <div class="row">
                <div class="col-md-3">
                    <aside class="booking-filters text-white">
                        <h3>Filter By:</h3>
                        <ul class="list booking-filters-list">
                            
                           <!--  <li>
                                <h5 class="booking-filters-title">Price </h5>
                                <input type="text" id="price-slider">
                            </li> -->
                            <li>
                                <h5 class="booking-filters-title">Bus Type <small></small></h5>
                                <div class="checkbox">
                                    <label>
                                        <input class="i-check" type="checkbox" />AC
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input class="i-check" type="checkbox" />NON-AC
                                    </label>
                                </div>
                               
                            </li>
                           
                         
                        </ul>
                    </aside>
                </div>
                <div class="col-md-9">
                    <div class="nav-drop booking-sort">
                        <h5 class="booking-sort-title"><a href="#">Sort: Sort: Price (low to high)<i class="fa fa-angle-down"></i><i class="fa fa-angle-up"></i></a></h5>
                        <ul class="nav-drop-menu">
                            <li><a href="#">Price (high to low)</a>
                            </li>
                            <li><a href="#">Duration</a>
                            </li>
                           
                            <li><a href="#">Arrival</a>
                            </li>
                            <li><a href="#">Departure</a>
                            </li>
                        </ul>
                    </div>

                    <!--Bus Details Start -->
                    <ul class="booking-list">
                  	<!--  <li dir-paginate="busDetails in busDetails|orderBy:sortKey:reverse|filter:search|itemsPerPage:5"> -->
                         <li ng-repeat="busdetails in busDetails"> 
                            <div class="booking-item-container">
                                
                                <div class="booking-item">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="booking-item-airline-logo">
                                                <img src="../resource/img/n1.png" alt="Image Alternative text" title="Image Title" />
                                                <p> Network Travels</p>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="booking-item-flight-details">
                                                <div class="booking-item-departure"><i class="im im-bus"></i>
                                                    <h5>{{busdetails.bus.startTime}}</h5>
                                                    
                                                    <p class="booking-item-destination">{{from}}</p>
                                                </div>
                                                <div class="booking-item-arrival"><i class="im im-bus"></i>
                                                    <h5>{{busdetails.bus.endtime}}</h5>
                                                   
                                                    <p class="booking-item-destination">{{to}}</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <h4>{{busdetails.bus.travelTime}}</h4>
                                           
                                        </div>
                                        <div class="col-md-3"><span class="booking-item-price">{{busdetails.bus.fare}}</span><span>/person</span>
                                            <a class="btn btn-primary" ng-click="viewDetails(busdetails.bus.busId,busdetails.midId)" href="SelectSeats.jsp">Select Seat</a><!-- <a class="btn btn-primary" style="margin-left: 2%;" id="viewDetails" >View Details</a> -->
                                        </div>
                                    </div>
                                </div>

                              <!--   <div class="booking-item-details active">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <p>Bus Details{{viewD}}</p>
                                            <h5 class="list-title">Guwahati to Jorhat</h5>
                                            <ul class="list">
                                                <li>Network Travels</li>
                                                <li>E Class (E), AS01-0777</li>
                                                <li>Depart 09:55 Arrive 6:10</li>
                                                <li>Duration: 9h 15m</li>
                                            </ul>
                                            <h5>Stopover: Nogaon</h5>
                                            <h5 class="list-title">Jakhalabondha, Nagaon</h5>
                                          
                                            <p>Total trip time: 10 h 58m</p>
                                        </div>
                                    </div>
                                </div> -->

                            </div>
                        </li>
                        <dir-pagination-controls
                                max-size="5"
                                direction-links="true"
                                boundary-links="true" >
                            </dir-pagination-controls>
                    </ul>
                    <!--Bus Details End -->

                    <p class="text-right">Not what you're looking for? <a class="popup-text" href="#search-dialog" data-effect="mfp-zoom-out">Try your search again</a>
                    </p>
                </div>
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
                        <h4 class="text-color">+1-000-000-0000</h4>
                        
                        <p><h5>support@network.com</h5></p>
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
    
    $(document).ready(function(){
    	
    	
    	setTimeout(function(){
			$('body').addClass('loaded');
			
		}, 2000);
    	
    	$("#viewDetails").click(function(){
    		
    	})
    	
    })
    </script>
</body>
</html>