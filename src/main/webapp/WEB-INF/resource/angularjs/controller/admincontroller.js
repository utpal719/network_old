var app=angular.module('network', ['ui.bootstrap','LocalStorageModule']);

  app.controller('admincontroller', function($scope,$rootScope,$http,localStorageService,$window,AdminService , $filter) {

	  console.log("adminController");
	  
	  $scope.TicketView = false;
	  $scope.winnerView = false;
	  
	  $scope.user = localStorageService.get("user");
	  
	  
    $scope.logout = function(){
    	 localStorage.clear();
    	 $window.location.href = 'http://network-network.b9ad.pro-us-east-1.openshiftapps.com';
    };
  
    //getAllBuses
    
    AdminService.getAllBuses().then(function(promise){
		
		$scope.adminbuses = $filter('orderBy')(promise.data, 'fromCity') ; 
	
		for(var i=0;i<$scope.adminbuses.length;i++){
			$scope.adminbuses[i].label=$scope.adminbuses[i].fromCity +" - "+$scope.adminbuses[i].toCity +" : "+$scope.adminbuses[i].startTime;
			
		}
		
	});
    
    
    $scope.viewTickets = function(){
    	
    	console.log($scope.journeyDate);
    	
    	AdminService.getPassengerByBus($scope.journeyDate,$scope.busid).then(function(promise){
    		
    		$scope.passengerList = promise.data;
    		
    		$scope.lebeldis = "";

    		if($scope.passengerList.length > 0){
    			
    			for(var x = 0;x<$scope.adminbuses.length ; x++){
    				
    				if($scope.busid === $scope.adminbuses[x].busId){
    					$scope.lebeldis = $scope.adminbuses[x].fromCity +" TO "+$scope.adminbuses[x].toCity +" : "+$scope.adminbuses[x].startTime +" ("+$scope.journeyDate+")";
    				}
    			}
    			
    			$scope.TicketView = true;
    		}
    		
    	});
    };
    
    
    $scope.SendSMS = function(){
    	
   	
    	if($scope.busnumber1 === undefined){
    		
    		alert("Bus Number is empty");
    	}else if($scope.busid === undefined){
    		
    		alert("Select a Bus");
    	}else{
 
    		AdminService.SendSMSByBus($scope.journeyDate,$scope.busid , $scope.busnumber1).then(function(promise){
        		
        		alert("SMS sent successfully!!");
        		
        	});
    	}
    	
    	
    	
    };
    
    
    
    $scope.lottery = function(){
    	
    	console.log("clicked lottery");
    	 $scope.winnerView = true;
    	
      var lotteryData = 
    	  [
    		  {
    		  "PNR" : "PNR-1074443",
    		  "Journeydate" : "Jun 18, 2019",
    		  "email" : "suraj34271@gmail.com",
    		  "mobile" : "9383033793"
    		  },
    		  {
    		  "PNR" : "PNR-1078799",
    		  "Journeydate" : "Jun 11, 2019",
    		  "email" : "antaragogoi03@gmail.com",
    		  "mobile" : "8638801996"
    		  },
    		  {
    		  "PNR" : "PNR-1115152",
    		  "Journeydate" : "Jun 25, 2019",
    		  "email" : "dipankardas028@gmail.com",
    		  "mobile" : "9101315406"
    		  },
    		  {
    		  "PNR" : "PNR-1111825",
    		  "Journeydate" : "Jun 23, 2019",
    		  "email" : "aditibhattacharyya20@gmail.com",
    		  "mobile" : "7086970435"
    		  },
    		  {
    		  "PNR" : "PNR-1102867",
    		  "Journeydate" : "Jun 19, 2019",
    		  "email" : "pinku.bhatta26@gmail.com",
    		  "mobile" : "7002973234"
    		  },
    		  {
    		  "PNR" : "PNR-1128729",
    		  "Journeydate" : "Jun 30, 2019",
    		  "email" : "debajanidulia1@gmail.com",
    		  "mobile" : "9954881404"
    		  },
    		  {
    		  "PNR" : "PNR-1098271",
    		  "Journeydate" : "Jun 17, 2019",
    		  "email" : "meghna29baruah@gmail.com",
    		  "mobile" : "9678314464"
    		  },
    		  {
    		  "PNR" : "PNR-1123363",
    		  "Journeydate" : "Jun 29, 2019",
    		  "email" : "talukdarnaba0@gmail.com",
    		  "mobile" : "9435134702"
    		  },
    		  {
    		  "PNR" : "PNR-1060134",
    		  "Journeydate" : "Jun 3, 2019",
    		  "email" : "anuragp787@gmail.com",
    		  "mobile" : "8486649049"
    		  },
    		  {
    		  "PNR" : "PNR-1082927",
    		  "Journeydate" : "Jun 12, 2019",
    		  "email" : "tarunboruah0009@gmail.com",
    		  "mobile" : "6002465451"
    		  },
    		  {
    		  "PNR" : "PNR-1118264",
    		  "Journeydate" : "Jun 26, 2019",
    		  "email" : "pulaksarma1978@gmail.com",
    		  "mobile" : "9508566759"
    		  },
    		  {
    		  "PNR" : "PNR-1068605",
    		  "Journeydate" : "Jun 5, 2019",
    		  "email" : "borpatra.grindra@gmail.com",
    		  "mobile" : "9854036162"
    		  },
    		  {
    		  "PNR" : "PNR-1125701",
    		  "Journeydate" : "Jun 29, 2019",
    		  "email" : "sushmitasonowal70@gmail.com",
    		  "mobile" : "8399865387"
    		  },
    		  {
    		  "PNR" : "PNR-1096521",
    		  "Journeydate" : "Jun 17, 2019",
    		  "email" : "avinavsharma1995@gmail.com",
    		  "mobile" : "9706599752"
    		  },
    		  {
    		  "PNR" : "PNR-1104202",
    		  "Journeydate" : "Jun 20, 2019",
    		  "email" : "gauravbrh00@gmail.com",
    		  "mobile" : "9101773817"
    		  },
    		  {
        		  "PNR" : "PNR-1093978",
        		  "Journeydate" : "Jun 16, 2019",
        		  "email" : "chinmoydutta2002@gmail.com",
        		  "mobile" : "8787551746"
        	 }

    		  ]

      
      
      
      var number = Math.floor(Math.random()*lotteryData.length);
      $scope.winner = lotteryData[number];
      
      
    	
    };
    
    
    
    $scope.cleanupData = function(){
    	
    	
    	AdminService.cleanupData().then(function(promise){
    		
    
    	});
    };
    
    
    $scope.cleanupPassengers = function(){
    	
    	AdminService.cleanupPassengers().then(function(promise){
    		
    	    
    	});
    };
    
    
 });
 
 
 
 app.controller('reportcontroller', function($scope,$rootScope,$http,localStorageService,$window,AdminService) {
	 $scope.user = localStorageService.get("user");
	  
	 $scope.reportView = false;
	 $scope.viewReport = function(){
		console.log("journey Date : "+$scope.journeyDate); 
		 
	 };
	 $scope.viewReport = function(){
		 
		 AdminService.getTicektReport($scope.journeyDate).then(function(promise){
		 		
			 $scope.adminreport = promise.data; 
	 		
			 $scope.reportView = true;
	 	});
	 };

	  
	    $scope.logout = function(){
	    	 localStorage.clear();
	    	 $window.location.href = 'http://network-network.b9ad.pro-us-east-1.openshiftapps.com';
	    };
 }); 
 
 
 app.controller('adminCancel', function($scope,$rootScope,$http,localStorageService,$window,AdminService) {
	 
	 $scope.TicketView = false;
	 
	 $scope.user = localStorageService.get("user");
	 $scope.logout = function(){
    	 localStorage.clear();
    	 $window.location.href = 'http://network-network.b9ad.pro-us-east-1.openshiftapps.com';
    };
    
    $scope.viewCancelledTickets = function(){
    		
    	console.log("Date : "+$scope.journeyDate);
    	
    	AdminService.viewCancelTickets($scope.journeyDate).then(function(promise){
    		
    		$scope.cancelTicket = promise.data;
    		$scope.TicketView = true;
    	});
    	
    };    
	   
 });
  
  app.controller('adminBusController', function($scope,$rootScope,$http,localStorageService,$window,AdminService) {

	  
	  $scope.user = localStorageService.get("user");
	  
	  
    $scope.logout = function(){
    	 localStorage.clear();
    	 $window.location.href = 'http://network-network.b9ad.pro-us-east-1.openshiftapps.com';
    };
    
    	
    	AdminService.getAllBuses().then(function(promise){
    		
    		$scope.adminbuses = promise.data; 
    		
    	});
    	
    	
    	$scope.deleteBus = function(busid){

    		if(confirm("Are you sure you want to delete the bus?")){
    			
    			AdminService.deleteBus(busid).then(function(promise){
    				
    				AdminService.getAllBuses().then(function(promise){
    		    		
    		    		$scope.adminbuses = promise.data; 
    		    		
    		    	});
    				
    			});
    			
    		};
    		
    	};
    	
    	$scope.viewMiddleDest = function(busid){

    		
    		AdminService.getMiddleDestination(busid).then(function(promise){
    			
        		localStorageService.set("middleDest",promise.data);	
        		$window.location.href = 'http://nwt-techv.rhcloud.com/pages/Admin/AdminMiddleDest.jsp';
    			
    		});
    		
    	};
    
 });
  
  
  app.controller('adminMiddleController', function($scope,$rootScope,$http,localStorageService,$window,AdminService) {
	  
	  $scope.user = localStorageService.get("user");
	  	  
	    $scope.logout = function(){
	    	 localStorage.clear();
	    	 $window.location.href = 'http://network-network.b9ad.pro-us-east-1.openshiftapps.com';
	    };
	  
	  $scope.middleList = localStorageService.get("middleDest");
	  
	  $scope.deleteMidDest = function(midid){
		  
		  if(confirm("Are you sure you want to delete this destination?")){
			  
			  AdminService.deleteMidDest(midid).then(function(promise){
				  
				  $window.location.href = "http://network-network.b9ad.pro-us-east-1.openshiftapps.com/pages/Admin/ManageBuses.jsp";
				  
			  });
		  };
		  
	  };
	  
  });
  
  
  
  app.controller('adminAgentcontroller', function($scope,$rootScope,$http,localStorageService,$window,AdminService) {
	  
	  $scope.user = localStorageService.get("user");
  	  
	    $scope.logout = function(){
	    	 localStorage.clear();
	    	 $window.location.href = 'http://network-network.b9ad.pro-us-east-1.openshiftapps.com';
	    };
	    
	    
	    	AdminService.getAllAgents().then(function(promise){
			  
	    		$scope.Agents = promise.data;
			  
		  });
	    
	    $scope.deleteAgent = function(userid){
	    	

	    	AdminService.deleteAgent(userid).then(function(promise){
			  
	    		AdminService.getAllAgents().then(function(promise){
	  			  
		    		$scope.Agents = promise.data;
				  
			  });
			  
		  });
	    	
	    	
	    };	
	  
  });
  
  
  
  app.controller('adminCitycontroller', function($scope,$rootScope,$http,localStorageService,$window,AdminService) {
	  
	  $scope.user = localStorageService.get("user");
  	  
	    $scope.logout = function(){
	    	 localStorage.clear();
	    	 $window.location.href = 'http://network-network.b9ad.pro-us-east-1.openshiftapps.com';
	    };
	    
	    AdminService.getAllCity().then(function(promise){
	    	
	    	$scope.cityList = promise.data;
	    	
	    });
	  
	    $scope.deleteCity = function(cityId){
	    	
	    	if(confirm("Are you sure you want to delete this city?")){
	    		AdminService.deleteCity(cityId).then(function(promise){
	    	    	
	    			 AdminService.getAllCity().then(function(promise){
	    			    	
	    			    	$scope.cityList = promise.data;
	    			    	
	    			    });
	    	    	
	    	    });
	    		
	    	};
	    	
	    };
	    
  });
  
  
  
  app.controller('adminaddBuscontroller', function($scope,$rootScope,$http,localStorageService,$window,AdminService,$timeout) {
	  
	  AdminService.getAllCity().then(function(promise){
	    	
	    	$scope.cityList = promise.data;
	    	
	    });
	  
	 $scope.addBus = function(){
		 
		 console.log($scope.fromcity);
		 
		 if($scope.fromcity === undefined){
			 
			 $scope.invalidfromcity = true;
			 $timeout(function () {
				   $scope.invalidfromcity = false;
			    }, 2000);
			 
		 }else if($scope.tocity === undefined){
			 
			 $scope.tocity = true;
			 $timeout(function () {
				   $scope.tocity = false;
			    }, 2000);
			 
		 }else if($scope.starttime === undefined){
			 
			 $scope.invalidstarttime = true;
			 $timeout(function () {
				   $scope.invalidstarttime = false;
			    }, 2000);
			 
		 }else if($scope.endtime === undefined){
			 
			 $scope.invalidendtime = true;
			 $timeout(function () {
				   $scope.invalidendtime = false;
			    }, 2000);
			 
		 }else if($scope.seatCapacity === undefined){
			 
			 $scope.invalidseat = true;
			 $timeout(function () {
				   $scope.invalidseat = false;
			    }, 2000);
			 
			 
			 
		 }else if($scope.fare === undefined){
			 
			 $scope.invalidfare = true;
			 $timeout(function () {
				   $scope.invalidfare = false;
			    }, 2000);
			 
		 }else{
			 
			 //proceed to add the bus
			 
			 AdminService.addBus($scope.fromcity,$scope.tocity,$scope.starttime,$scope.endtime,$scope.seatCapacity,$scope.fare).then(function(promise){
				 
				 $window.location.href = "http://network-network.b9ad.pro-us-east-1.openshiftapps.com/pages/Admin/ManageBuses.jsp";
			 });
			 
		 }
		 
	 } ;
	  
  });
  
  
  app.controller('adminAddCitycontroller', function($scope,$rootScope,$http,localStorageService,$window,AdminService,$timeout) {
	  
	  	$scope.addNewCity = function(){
	  		
	  		if($scope.cityName === undefined){
	  			
	  			$scope.invalidcityName = false;
	  			$timeout(function () {
					   $scope.invalidcityName = false;
				    }, 2000);
	  		}else{
	  			
	  			AdminService.addNewCity($scope.cityName).then(function(promise){
	  				
	  				$window.location.href = 'http://network-network.b9ad.pro-us-east-1.openshiftapps.com/pages/Admin/ManageCities.jsp';
	  				
	  			});
	  		}
	  		
	  	};

  });
  
  
  
  
  app.controller('adminAddAgentcontroller', function($scope,$rootScope,$http,localStorageService,$window,AdminService,$timeout) {
	  
	  
	  $scope.addAgent = function(){
		  
		  if($scope.name === undefined){
			  
			  $scope.invalidName  = true;
			  $timeout(function () {
				   $scope.invalidName = false;
			    }, 2000);
		  }else if($scope.username === undefined){
			  
			  $scope.invalidUserName = true;
			  
			  $timeout(function () {
				   $scope.invalidUserName = false;
			    }, 2000);
			  
		  }else if($scope.pwd === undefined){
			  	$scope.invalidPassword = true;
			  
			  $timeout(function () {
				   $scope.invalidPassword = false;
			    }, 2000);
			  
			  
		  }else if($scope.percentage === undefined){
			  
			  $scope.invalidpercentage = true;
			  
			  $timeout(function () {
				   $scope.invalidpercentage = false;
			    }, 2000);
			  
		  }else if($scope.percentage === 0){
			  $scope.percentage = 0;
			  
		  }else if($scope.address === undefined){
			  	$scope.invalidAddress = true;
			  
			  $timeout(function () {
				   $scope.invalidAddress = false;
			    }, 2000);
			  
		  }else if($scope.email === undefined){
			  
			  
			  $scope.invalidemail = true;
			  
			  $timeout(function () {
				   $scope.invalidemail = false;
			    }, 2000);
			  
		  }else if($scope.mobile === undefined){
			  
			  $scope.invalidMobile = true;
			  
			  $timeout(function () {
				   $scope.invalidMobile = false;
			    }, 2000);
		  }
		  
		  else {
			  
			  
			  //Proceed to add
			  
			  AdminService.addAgent($scope.name,$scope.username,$scope.pwd,$scope.percentage,$scope.address,$scope.email,$scope.mobile).then(function(promise){
				  
				  $window.location.href = 'http://network-network.b9ad.pro-us-east-1.openshiftapps.com/pages/Admin/ManageAgents.jsp';
				  
			  });
			  
		  }
		  	
		  
	  };
	  
	  
  });
  
  
  app.controller('rechargeController', function($scope,$rootScope,$http,localStorageService,$window,AdminService,$timeout) {
	  
	  
	  $scope.isClicked = true;
	  
	  
	  AdminService.getAllAgents().then(function(promise){
		  
		  $scope.agentslist = promise.data;
		  
		  
	  });
	  
	  $scope.rechargeNow = function(){
		
		  
		  if($scope.accessKey == undefined || $scope.accessKey == ""){
			  alert("Please enter access Key!");
		  }else if($scope.accessKey != "SARAD$!"){
			  alert("Acess Key Is Wrong!");
		  }else{
			  
			  if($scope.selectedagent === undefined){
				  
				  alert("Please select a agent");
			  }else if($scope.newAmount === undefined || $scope.newAmount === ""){
				  alert("Please enter a amount");
				  
			  }
			  else{
				  $scope.isClicked = false;
				  
				  AdminService.recharge($scope.selectedagent.userid , $scope.newAmount).then(function(promise){
					  
					  alert("Recharge Successfull!");
					  $window.location.reload();
					  
				  });
			  }
			  
		  }
		  
	  };
	  
  });