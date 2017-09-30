<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app ="network">
 <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Network Travels</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <link rel="stylesheet" href="../../resource/Admin/bootstrap/css/bootstrap.min.css">
 
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  
    <link rel="stylesheet" href="../../resource/Admin/dist/css/AdminLTE.min.css">

	<link rel="stylesheet" href="../../resource/Admin/dist/css/skins/skin-black-light.min.css">

    <link rel="stylesheet" href="../../resource/Admin/plugins/iCheck/flat/blue.css">
 
    <link rel="stylesheet" href="../../resource/Admin/plugins/morris/morris.css">
  
    <link rel="stylesheet" href="../../resource/Admin/plugins/jvectormap/jquery-jvectormap-1.2.2.css">

    <link rel="stylesheet" href="../../resource/Admin/plugins/datepicker/datepicker3.css">

    <link rel="stylesheet" href="../../resource/Admin/plugins/daterangepicker/daterangepicker-bs3.css">
    <link rel="stylesheet" href="../../resource/Admin/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
    <link rel="shortcut icon" href="../../resource/Admin/dist/img/favicon.ico" type="image/x-icon" />

	 <script src="../../resource/js/angular.js"></script>
    <script src="../../resource/js/ui-bootstrap.js"></script>
    <script src="../../resource/js/angular-local-storage.js"></script>
    <script src="../../resource/angularjs/controller/admincontroller.js"></script>
      <script src="../../resource/angularjs/services/AdminService.js"></script>

  </head>

<body data-ng-controller="adminCancel" id="body" class="hold-transition layout-boxed sidebar-collapse skin-black-light sidebar-mini" style="color : RGBA(40, 62, 60, 0.67);font-size : 12px;">
    <div class="wrapper">

      <header class="main-header">
        <!-- Logo -->
        <a href="#" class="logo">

          <span class="logo-mini"><b>NWT</span>
 
          <span class="logo-lg"><b>Network</span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
          </a>
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">

              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <img src="../../resource/Admin/dist/img/user2-160x160.jpg" class="user-image" alt="User Image">
                  <span class="hidden-xs">{{user.userName}}</span>
                </a>
                <ul class="dropdown-menu">
                  <!-- User image -->
                  
                  <!-- Menu Body -->
                
                  <!-- Menu Footer-->
                  <li class="user-footer">
                 <div class="pull-right">
                      <a ng-click="logout()" class="btn btn-default btn-flat">Sign out</a>
                    </div>
                  </li>
                </ul>
              </li>
              <!-- Control Sidebar Toggle Button -->
              <li>
                <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
              </li>
            </ul>
          </div>
        </nav>
      </header>
      
      
      <!-- Left side column. contains the logo and sidebar -->
      <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar" style="background-color:#bdc3c7;">
          <!-- Sidebar user panel -->
          <div class="user-panel">
            <div class="pull-left image">
              <img src="../../resource/Admin/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
              <p>{{user.userName}}</p>
             
            </div>
          </div>
  
          <!-- /.search form -->
          <!-- sidebar menu: : style can be found in sidebar.less -->
          <ul class="sidebar-menu">
          
            <li class="active">
              <a href="#">
                <i class="fa fa-gg"></i> <span>Dashboard</span> 
              </a>
            </li>
             <li class="active">
              <a href="ManageBuses.jsp">
                <i class="fa fa-bell"></i> <span>Manage Buses</span> 
              </a>
            </li>
             <li class="active">
              <a href="ManageAgents.jsp">
                <i class="fa fa-bullseye"></i> <span>Manage Agents</span> 
              </a>
            </li>
              <li class="active">
              <a href="ManageCities.jsp">
                <i class="fa fa-pie-chart"></i> <span>Manage Cities</span> 
              </a>
            </li>
          
           
          
          </ul>
        </section>
        <!-- /.sidebar -->
      </aside>

      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
      
        <!-- Main content -->
        <section class="content">
        	
        	
        	<form style="width:90%;margin-left:10%;">
        	
        		
        		<div class="col-md-4" >
        			
        		 <div class="form-group">
                     <label>Journey Date</label>
                       
                       	 <input class="date-pick form-control" id="journeyDate123"  data-date-format="M d, yyyy" type="text"/>
                       
                      </div>
                    
        		</div>
        	<br>
        		<a ng-click="viewCancelledTickets()" style="margin-top:1%;"><button class="btn btn-block btn-primary" style="width:16%;">View Cancelled Ticket</button></a>
        			
        	</form>
        
        
        <div ng-if="TicketView" style="margin-top:10%; width : 70%;margin-left:20%;" id="printableArea">
        <input type="button" onclick="printDiv('printableArea')" value="PRINT" />
        	
        <div class="row">
           <div class="col-xs-12">
              <div class="box">
                <div class="box-header">
                  <h3 class="box-title">Passenger List</h3>
                </div><!-- /.box-header -->
                <div class="box-body">
                  <table id="example2" class="table table-bordered table-hover" >
                  	<thead>
                      <tr>
                      	<th>Cancel ID</th>
                        <th>PNR Number</th>
                        <th>Mobile</th>
                        <th>Refund Amt</th>
                        <th>Name</th>
                     	<th>Bank</th>
                       	<th>IFSC</th>
                       	<th>Account No</th>
                      </tr>
                    </thead>
                    	
                    	<tr ng-repeat="n in cancelTicket">
                    		<td>{{n.cancelId}}</td>
                    		<td>{{n.booking.pnrNumber}}</td>
                    		<td>{{n.booking.mobile}}</td>
                    		<td>{{n.refundAmount}}</td>
                    		<td>{{n.namePerbank}}</td>
                    		<td>{{n.bank}}</td>
                    		<td>{{n.ifsc}}</td>
                    		<td>{{n.accountNumber}}</td>
                    	</tr>
                    	
                    <tbody>
                    
                    </tbody>
                    
                   </table>
                  </div>
                 </div>
                </div>
               </div>
                    
                    
        	
        </div>
        
        
        
        
        </section>
        
        
        
        
        
      </div><!-- /.content-wrapper -->
      <footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Version</b> 2.3.0
        </div>
        <strong>Makers &copy; 2016-2017 <a href="http://techvariabe.com">TechVariable</a>.</strong> 
      </footer>

   
      <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div><!-- ./wrapper -->

    <!-- jQuery 2.1.4 -->
    <script src="../../resource/Admin/plugins/jQuery/jQuery-2.1.4.min.js"></script>
 
   
    <!-- jQuery UI 1.11.4 -->
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
      $.widget.bridge('uibutton', $.ui.button);
    </script>
    <!-- Bootstrap 3.3.5 -->
    <script src="../../resource/Admin/bootstrap/js/bootstrap.min.js"></script>
    <!-- Morris.js charts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
    <script src="../../resource/Admin/plugins/morris/morris.min.js"></script>
    <!-- Sparkline -->
    <script src="../../resource/Admin/plugins/sparkline/jquery.sparkline.min.js"></script>
    <!-- jvectormap -->
    <script src="../../resource/Admin/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
    <script src="../../resource/Admin/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
    <!-- jQuery Knob Chart -->
    <script src="../../resource/Admin/plugins/knob/jquery.knob.js"></script>
    <!-- daterangepicker -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
    <script src="../../resource/Admin/plugins/daterangepicker/daterangepicker.js"></script>
    <!-- datepicker -->
    <script src="../../resource/Admin/plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- Bootstrap WYSIHTML5 -->
    <script src="../../resource/Admin/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
    <!-- Slimscroll -->
    <script src="../../resource/Admin/plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="../../resource/Admin/plugins/fastclick/fastclick.min.js"></script>
    <!-- AdminLTE App -->
    <script src="../../resource/Admin/dist/js/app.min.js"></script>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
    <script src="../../resource/Admin/dist/js/pages/dashboard.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="../../resource/Admin/dist/js/demo.js"></script>
    <script src="../../resource/js/bootstrap-datepicker.js"></script>
  
  <script>
  
	$('input.date-pick, .input-daterange, .date-pick-inline').datepicker({
		    todayHighlight: true,
		    autoclose : true,
		   
		});


	  
  		$("input.date-pick").change(function(){
	  		
 			var scope =angular.element($("#body")).scope();
 		
 			scope.$apply(function() {
 		        scope.journeyDate = $("input.date-pick").val();
 			
 		    });
 		
 		}); 

</script>

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