var app=angular.module('network',['LocalStorageModule']);

app.controller('buscontroller', function($scope,$rootScope,localStorageService ,$http,BusService,$window) {

	
	var searchObject={};
		
	searchObject = localStorageService.get("searchObject");
	

	$scope.user = localStorageService.get("user");
	  
	  if($scope.user != null){
		  localStorageService.set("user",$scope.user);
		  $scope.auth = true;
		  
		  if($scope.user.roleid === 1){
			  $scope.adminuser = true;
		  }else if($scope.user.roleid === 2){
			  $scope.agentuser = true;
			  
		  }else if($scope.user.roleid === 3){
			  
			  $scope.extuser = true;
		  }else if($scope.user.roleid === 4){
			  $scope.testuser = true;
		  }
	  }

	$scope.from = searchObject.from;
	$scope.to = searchObject.to;
	$scope.startDate = searchObject.startDate;
	
	
	$scope.busDetails = [];
	
	
	BusService.searchAllBuses( $scope.from,$scope.to,$scope.startDate ).then(function(promise){
			
		$scope.busDetails=promise.data;

		
	});
	
	
	$scope.viewDetails = function(busId,midId){
		
		
		console.log(midId);
		
		localStorageService.set("selectedBusId",busId);
		localStorageService.set("startDate",$scope.startDate);
		localStorageService.set("mid",midId);
	};
	
	  $scope.logout = function(){
	    	 localStorage.clear();
	    	 $window.location.href = 'https://nwt-techv.rhcloud.com';
	    };
	
});

app.controller('selectSeatController', function($scope,$rootScope,$location,localStorageService ,$http,BusService,$timeout,$window) {


	$scope.seat35 = false;
	$scope.seat31 = false;
	$scope.seat40 = false;
	$scope.seat32 = false;
	$scope.seat39 = false;
	$scope.boardingPoint="";
	$scope.noSeatSelected=false;
	$scope.noBoardingPoint=false;
	
	/*var testSeat=localStorageService.get("selectedSeats");
	$scope.seatsDisplay = "";
	for(var k=0;k<testSeat.length;k++){
		if($scope.seatsDisplay == ""){
			$scope.seatsDisplay = testSeat[k];
		}else{
			$scope.seatsDisplay = 	$scope.seatsDisplay +","+testSeat;
		}
	}*/

	
	$scope.nonavailable = {};
	$scope.available= {};
	$scope.pNames = {};
	$scope.genders = {};
	$scope.ages = {};
	$scope.bookinginfo = {};
	
	
	$scope.user = localStorageService.get("user");
	  
	  if($scope.user != null){
		  localStorageService.set("user",$scope.user);
		  $scope.auth = true;
		  
		  if($scope.user.roleid === 1){
			  $scope.adminuser = true;
		  }else if($scope.user.roleid === 2){
			  $scope.agentuser = true;
			  
		  }else if($scope.user.roleid === 3){
			  
			  $scope.extuser = true;
		  }
	  }
	
	
	
	$scope.noOfSelectedSeat = [];
	
	$scope.driver = {
			
		"background-position" : "24px -106px"
	};
	
	
	$scope.nonavailable = {
			
		"background-position" : "0px -40px"
	};

	$scope.available = {
			
		"background-position" : "0px -0px"
	};
	
	
	var selectedBusId = {};
	
	
	selectedBusId = localStorageService.get("selectedBusId");
	
	var mid = localStorageService.get("mid");
	
	$scope.midId = mid;
	
	var searchObject={};
	
	searchObject = localStorageService.get("searchObject");

	$scope.startDate =  localStorageService.get("startDate");
	
	
	$scope.from = searchObject.from;
	$scope.to = searchObject.to;
	
	console.log("start Date : "+$scope.startDate);
	
	
	var journeyDate = $scope.startDate ;//"18/08/2016";
	
	 $scope.busDetail = {};
	
	
	BusService.getBusDetailsByBusId(journeyDate,selectedBusId,mid).then(function(promise){
		
		 $scope.busDetail = promise.data;
		 
		 if($scope.busDetail.bus.seatCapacity == 31){
			 $scope.seat31 = true;
		
		 }else if($scope.busDetail.bus.seatCapacity == 35){
			 
			 $scope.seat35 = true;
		
		 }else if($scope.busDetail.bus.seatCapacity == 39){
			 $scope.seat39 = true;
		
		 }else if($scope.busDetail.bus.seatCapacity == 40){
			 $scope.seat40 = true;
		
		 }else if($scope.busDetail.bus.seatCapacity == 32){
			 $scope.seat32 = true;
					 
		 }

		 
		var points = $scope.busDetail.bus.boardingPoints.split(",");
		
		
		$scope.boardingPoints = points;
		
		 
		 $scope.isAvailableView = function(index){
			 
			 console.log(index);
			 
			 var isGrey = false;
			 var isSelected = false;
			 
			 var selectedSeats = localStorageService.get("selectedSeats");
			 
			 for(var i=0;i<$scope.busDetail.occupiedSeat.length;i++){
				 
				 console.log($scope.busDetail.occupiedSeat[i]);
				
				 if(index == $scope.busDetail.occupiedSeat[i] ){
					
					 isGrey = true;
				 }

			 }
			  
			 
		
			 if(selectedSeats != null){
				 if(selectedSeats.indexOf(index) !== -1){
					 
					 isSelected=true;
				 }
				 $scope.noOfSeat = selectedSeats.length;
				 $scope.totalFare = $scope.noOfSeat* ($scope.busDetail.bus.fare);
			 }else{
				 
				 $scope.totalFare = 0;
			 }

			 if(isGrey){
				 return '0px -40px';
			 }else if(isSelected){
				 
				 return '0px -60px';
			 }else{
					 return '-0px 0px';
			 }
		
	};
	
	
	
	$scope.selected = function(id){
		
		$scope.noBoardingPoint=false;
		$scope.noSeatSelected=false;
		
		var occupiedSeat =$scope.busDetail.occupiedSeat;
		
		if(occupiedSeat.indexOf(id) == -1){
		
			var seats = localStorageService.get("selectedSeats");
			
			console.log(seats);
			
			if(seats == null || seats.length == 0){

				localStorageService.set("selectedSeats",[id]);

				
			}else{
				var selectedSeat=localStorageService.get("selectedSeats");
				
				if(selectedSeat.indexOf(id) !== -1) {
				
					
					var newArray = [];
					
					for(var x=0;x<selectedSeat.length;x++){
						
						if(selectedSeat[x] != id){
							newArray.push(selectedSeat[x]);
						}
					}
					localStorageService.set("selectedSeats",newArray);
					
				}else{
					selectedSeat.push(id);
					localStorageService.set("selectedSeats",selectedSeat);
				}
	
			}	
		
		}
		
	/*	if(testSeat.indexOf(id) == -1){
			testSeat.push(id);
		}else{
			testSeat.pop(id);
		}
		for(var k=0;k<testSeat.length;k++){
			if($scope.seatsDisplay == ""){
				$scope.seatsDisplay = testSeat[k];
			}else{
				$scope.seatsDisplay = 	$scope.seatsDisplay +","+testSeat;
			}
		}


		console.log($scope.seatsDisplay);*/
		
	};
	
	
	$scope.validateSelectedSeat=function(e){
		
		
		
		var selectedSeat=localStorageService.get("selectedSeats");
		
		if(selectedSeat == null){
			$scope.noSeatSelected=true;
			e.preventDefault();
		}else{
		
				if(selectedSeat.length == 0){
					
					$scope.noSeatSelected=true;
					e.preventDefault();
				}else if($scope.boardingPoint == ""){
					$scope.noBoardingPoint=true;
					e.preventDefault();
				}else{
					localStorageService.set("boardingPoint",$scope.boardingPoint);
				}
		}
		
	};
	
	$scope.noOfSelectedSeat = localStorageService.get("selectedSeats");

	if($scope.noOfSelectedSeat != null){
		$scope.numberOfSeat = $scope.noOfSelectedSeat.length;
		
	}

	$scope.totalFare = $scope.numberOfSeat * $scope.busDetail.bus.fare;
	
	
	
	if($scope.totalFare !=0 && $scope.agentuser){
		
	
			
		//get Agent percentage
		BusService.getAgentPercentage($scope.user.userid).then(function(promise){
			
			$scope.agentPercentage = promise.data;
			$scope.agentFare = $scope.totalFare - ($scope.agentPercentage * $scope.totalFare);
			
			
			$scope.agentPer100 = $scope.agentPercentage *100;
		});
		
		
		
		
	};
	
	
	$scope.defaulterName = function(){

		
		for(var k=0;k<$scope.numberOfSeat ; k++){

			if(k !=0){
				
				$scope.pNames[k]=$scope.pNames[0];
				
			}
		}
	};
	
	$scope.defaultage = function(){
		for(var k=0;k<$scope.numberOfSeat ; k++){
		
			if(k !=0){
				
				$scope.ages[k]=$scope.ages[0];
				
			}
		}
		
	};
	
	
	$scope.defaultGender = function(){
		
		for(var k=0;k<$scope.numberOfSeat ; k++){
			
			if(k !=0){
				
				$scope.genders[k]=$scope.genders[0];
				
			}
		}
		
		
	};
	
	
	$scope.proceedCheckout = function(e){
		
		$scope.boardingPoint = localStorageService.get("boardingPoint");

		$scope.noPassangerName = false;
		$scope.noGenderSelected = false;
		$scope.noAge = false;
		
		var isValid = true;
		
		for(var x=0;x<$scope.numberOfSeat ; x++){

			
			if($scope.pNames[x] === undefined || $scope.pNames[x]== ""){			
				$scope.noPassangerName = true;
				
				   $timeout(function () {
					   $scope.noPassangerName = false;
				    }, 2000);
				   isValid = false;   
				   
			}else if($scope.genders[x]=== undefined || $scope.genders[x]=="" ){				
				$scope.noGenderSelected = true;
				 $timeout(function () {
					   $scope.noGenderSelected = false;
				    }, 2000);
				 
				 isValid = false;
				 
			}else if($scope.ages[x] === undefined || $scope.ages[x] == ""){				
				$scope.noAge = true;
				
				 $timeout(function () {
					   $scope.noAge = false;
				    }, 2000);
				   
				 isValid = false;
			}

		}
		
		if($scope.email === undefined){
			isValid = false;
			$scope.noEmail = true;
			 $timeout(function () {
				   $scope.noEmail = false;
			   }, 2000);
			
		}else if($scope.email == ""){
				
			isValid = false;
			$scope.noEmail = true;
			 $timeout(function () {
				   $scope.noEmail = false;
			   }, 2000);
			
			
			
		}else{
			
			BusService.validateEmail($scope.email).then(function(promise){
				
				
				
				var isExist = promise.data;
				
				if(promise.data === "false"){
					
					console.log("display");
					
					isValid = false;
					$scope.noEmail = true;
					 $timeout(function () {
						 $scope.noEmail = false;
					 }, 2000);
					
				}
				
			});
			
		}
		
		//checking mobile number 
		
		if($scope.mobile === undefined || $scope.mobile.length != 10){
			
			isValid = false;
			
		}
	
		if(!isValid){
			e.preventDefault();
		}else{
			
			$scope.loading = true;
			
			
			var arrSelectedSeats = localStorageService.get("selectedSeats");
			
			var strSelectedSeat = "";

			
			for(var ix = 0; ix<arrSelectedSeats.length;ix++){

				if(strSelectedSeat == ""){
					strSelectedSeat = arrSelectedSeats[ix];
				}else{
					strSelectedSeat = strSelectedSeat+","+arrSelectedSeats[ix];
					
				}
						
			}
			
			var passengerNames = "";
			
			console.log($scope.pNames);
			
			for(var xy =0;xy<arrSelectedSeats.length;xy++){
				
				if(passengerNames == ""){
					passengerNames = $scope.pNames[xy];
				}else{
					passengerNames=passengerNames+","+$scope.pNames[xy];
					
				}
				
			}
			
			
		var passengerGenders = "";
			
			for(var xy =0;xy<arrSelectedSeats.length;xy++){
				
				if(passengerGenders == ""){
					passengerGenders = $scope.genders[xy];
				}else{
					passengerGenders=passengerGenders+","+$scope.genders[xy];
					
				}
				
			}
			
			
			var passengerAge = "";
				
				for(var xy =0;xy<arrSelectedSeats.length;xy++){
					
					if(passengerAge == ""){
						passengerAge = $scope.ages[xy];
					}else{
						passengerAge=passengerAge+","+$scope.ages[xy];
						
					}
					
				}
	
			var iSelectedBusId = {};
			
			iSelectedBusId = localStorageService.get("selectedBusId");
			
		
		
			
			//Book the ticket commented for cash colletion
		BusService.bookTicket(iSelectedBusId,$scope.numberOfSeat,$scope.totalFare,strSelectedSeat,passengerNames,passengerGenders,passengerAge,$scope.email,$scope.mobile,$scope.startDate,$scope.from,$scope.to,$scope.midId,$scope.agentFare,$scope.user,$scope.boardingPoint).then(function(promise){
				
				e.preventDefault();
				
				$scope.bookinginfo = promise.data;
				
				console.log("booking donme");
				
					//e.preventDefault();
				
				
					console.log($scope.bookinginfo.pnrNumber);
					$scope.bookinginfo.email = $scope.email;
					$scope.bookinginfo.mobile = $scope.mobile;
					
					localStorageService.set("booking",$scope.bookinginfo);

					$scope.bookinginfo = localStorageService.get("booking");
					//angular.element('#amtform').submit();
					
					$window.location.href = 'https://nwt-techv.rhcloud.com/pages/viewTicket1.jsp';
				
			});
			
			//Added for collecting cash
			/*BusService.bookTicketCash(iSelectedBusId,$scope.numberOfSeat,$scope.totalFare,strSelectedSeat,passengerNames,passengerGenders,passengerAge,$scope.email,$scope.mobile,$scope.startDate,$scope.from,$scope.to,$scope.midId,$scope.agentFare,$scope.user,$scope.boardingPoint).then(function(promise){
				
				e.preventDefault();
				
				$scope.bookinginfo = promise.data;
				
				
				
					//e.preventDefault();
				
				
					console.log($scope.bookinginfo.pnrNumber);
					$scope.bookinginfo.email = $scope.email;
					$scope.bookinginfo.mobile = $scope.mobile;
					
					localStorageService.set("booking",$scope.bookinginfo);

					$scope.bookinginfo = localStorageService.get("booking");
					console.log($scope.bookinginfo);
					localStorageService.set("BookingInfo",$scope.bookinginfo);
					$window.location.href = 'https://nwt-techv.rhcloud.com/pages/viewTicket.jsp';
				
			});	
			*/
			
		}
	};
	
	
	
$scope.collectCash = function(e){
		
		$scope.boardingPoint = localStorageService.get("boardingPoint");
	
		$scope.noPassangerName = false;
		$scope.noGenderSelected = false;
		$scope.noAge = false;
		
		var isValid = true;
		
		for(var x=0;x<$scope.numberOfSeat ; x++){

			
			if($scope.pNames[x] === undefined || $scope.pNames[x]== ""){			
				$scope.noPassangerName = true;
				
				   $timeout(function () {
					   $scope.noPassangerName = false;
				    }, 2000);
				   isValid = false;   
				   
			}else if($scope.genders[x]=== undefined || $scope.genders[x]=="" ){				
				$scope.noGenderSelected = true;
				 $timeout(function () {
					   $scope.noGenderSelected = false;
				    }, 2000);
				 
				 isValid = false;
				 
			}else if($scope.ages[x] === undefined || $scope.ages[x] == ""){				
				$scope.noAge = true;
				
				 $timeout(function () {
					   $scope.noAge = false;
				    }, 2000);
				   
				 isValid = false;
			}

		}
		
		if($scope.email === undefined){
			isValid = false;
			$scope.noEmail = true;
			 $timeout(function () {
				   $scope.noEmail = false;
			   }, 2000);
			
		}else if($scope.email == ""){
				
			isValid = false;
			$scope.noEmail = true;
			 $timeout(function () {
				   $scope.noEmail = false;
			   }, 2000);
		
			
		}else{
			
			BusService.validateEmail($scope.email).then(function(promise){

				var isExist = promise.data;
				
				if(promise.data === "false"){
					
									
					isValid = false;
					$scope.noEmail = true;
					 $timeout(function () {
						 $scope.noEmail = false;
					 }, 2000);
					
				}
				
			});
			
		}
		
		//checking mobile number 
		
		if($scope.mobile === undefined || $scope.mobile.length != 10){
			
			isValid = false;
			
		}
	
		if(!isValid){
			e.preventDefault();
		}else{
			
			$scope.loading = true;
			
			
			var arrSelectedSeats = localStorageService.get("selectedSeats");
			
			var strSelectedSeat = "";

			
			for(var ix = 0; ix<arrSelectedSeats.length;ix++){

				if(strSelectedSeat == ""){
					strSelectedSeat = arrSelectedSeats[ix];
				}else{
					strSelectedSeat = strSelectedSeat+","+arrSelectedSeats[ix];
					
				}
						
			}
			
			var passengerNames = "";
			
			console.log($scope.pNames);
			
			for(var xy =0;xy<arrSelectedSeats.length;xy++){
				
				if(passengerNames == ""){
					passengerNames = $scope.pNames[xy];
				}else{
					passengerNames=passengerNames+","+$scope.pNames[xy];
					
				}
				
			}
			
			
		var passengerGenders = "";
			
			for(var xy =0;xy<arrSelectedSeats.length;xy++){
				
				if(passengerGenders == ""){
					passengerGenders = $scope.genders[xy];
				}else{
					passengerGenders=passengerGenders+","+$scope.genders[xy];
					
				}
				
			}
			
			
			var passengerAge = "";
				
				for(var xy =0;xy<arrSelectedSeats.length;xy++){
					
					if(passengerAge == ""){
						passengerAge = $scope.ages[xy];
					}else{
						passengerAge=passengerAge+","+$scope.ages[xy];
						
					}
					
				}
			
			
			var iSelectedBusId = {};
			
			iSelectedBusId = localStorageService.get("selectedBusId");

			//alert("here");
			
			//Book the ticket
		BusService.bookTicketCash(iSelectedBusId,$scope.numberOfSeat,$scope.totalFare,strSelectedSeat,passengerNames,passengerGenders,passengerAge,$scope.email,$scope.mobile,$scope.startDate,$scope.from,$scope.to,$scope.midId,$scope.agentFare,$scope.user,$scope.boardingPoint).then(function(promise){
				
				e.preventDefault();
				
				$scope.bookinginfo = promise.data;

					//e.preventDefault();
				
				
					$scope.bookinginfo.email = $scope.email;
					$scope.bookinginfo.mobile = $scope.mobile;
					
					localStorageService.set("booking",$scope.bookinginfo);

					$scope.bookinginfo = localStorageService.get("booking");
					console.log(JSON.stringify($scope.bookinginfo));
					localStorageService.set("BookingInfo",$scope.bookinginfo);
					
					
					$window.location.href = 'https://nwt-techv.rhcloud.com/pages/viewTicket.jsp';
				
			});
			
		}
	}

});	
	
	
	  $scope.logout = function(){
	    	 localStorage.clear();
	    	 $window.location.href = 'https://nwt-techv.rhcloud.com';
	    };
    
});	


app.controller('bookingController', function($scope,$rootScope,$location,localStorageService ,$http,BusService,$timeout,$window) {
	
	$scope.bookinginfo = localStorageService.get("booking");
	
	$scope.email = $scope.bookinginfo.email;
	$scope.mobile = $scope.bookinginfo.mobile;
	
	$scope.collection = 0;
	
	if($scope.bookinginfo.agentFare === "Direct Booking"){
		$scope.collection = $scope.bookinginfo.totdalFare;
	}else{
		$scope.collection = $scope.bookinginfo.agentFare;
	}

	var today = new Date();
	$scope.marchantId = today.getMilliseconds();
		//$scope.marchantId = dateFilter(date.getTime(), clockFormat); 
	//	alert("collection s : "+$scope.collection+" $scope.marchantId "+$scope.marchantId);
	
	BusService.getSecuritySignature($scope.collection,$scope.marchantId).then(function(promise){
		$scope.securitySignaure = promise.data;
	//	alert($scope.securitySignaure);
	});
	
	$scope.pnrNumber = $scope.bookinginfo.pnrNumber;
	
	$scope.user = localStorageService.get("user");
	
	localStorage.clear();
	
	localStorageService.set("pnr",$scope.pnrNumber);
	localStorageService.set("collection",$scope.collection);
	  if($scope.user != null){
		  localStorageService.set("user",$scope.user);
		  $scope.auth = true;
		  
		  if($scope.user.roleid === 1){
			  $scope.adminuser = true;
		  }else if($scope.user.roleid === 2){
			  $scope.agentuser = true;
			  
		  }else if($scope.user.roleid === 3){
			  
			  $scope.extuser = true;
		  }
	  }
	  
	 
	  
	
	  $scope.logout = function(){
	    	 localStorage.clear();
	    	 $window.location.href = 'https://nwt-techv.rhcloud.com';
	    };
	
});

app.controller('bookingController1', function($scope,$rootScope,$location,localStorageService ,$http,BusService,$timeout,$window) {
	
	$scope.pnr = localStorageService.get("pnr");
	
	$scope.user = localStorageService.get("user");

	  
	  if($scope.user != null){
		  localStorageService.set("user",$scope.user);
		  $scope.auth = true;
		  
		  if($scope.user.roleid === 1){
			  $scope.adminuser = true;
		  }else if($scope.user.roleid === 2){
			  $scope.agentuser = true;
			  
		  }else if($scope.user.roleid === 3){
			  
			  $scope.extuser = true;
		  }
	  }
	  
	
	  $scope.logout = function(){
	    	 localStorage.clear();
	    	 $window.location.href = 'https://nwt-techv.rhcloud.com';
	    };
	
});


app.controller('bookingControllerprocess', function($scope,$rootScope,$location,localStorageService ,$http,BusService,$timeout,$window) {
	

	$scope.pnr = localStorageService.get("pnr");
	
	$scope.trans = {};

	$scope.user = localStorageService.get("user");


 	angular.element(document).ready(function () {

 		BusService.updatePayBookingByPNR($scope.pnr,$scope.trans.uid,$scope.trans.ust).then(function(promise){
 			
 			localStorageService.set("BookingInfo" ,promise.data );
 			   
 			$window.location.href = 'https://nwt-techv.rhcloud.com/pages/viewTicket.jsp';
 		});	 

 	});



	  
	  if($scope.user != null){
		  localStorageService.set("user",$scope.user);
		  $scope.auth = true;
		  
		  if($scope.user.roleid === 1){
			  $scope.adminuser = true;
		  }else if($scope.user.roleid === 2){
			  $scope.agentuser = true;
			  
		  }else if($scope.user.roleid === 3){
			  
			  $scope.extuser = true;
		  }
	  }
	 
	
	  $scope.logout = function(){
	    	 localStorage.clear();
	    	 $window.location.href = 'https://nwt-techv.rhcloud.com';
	    };
	
	    
});


app.controller('bookingFinal', function($scope,$rootScope,$location,localStorageService ,$http,BusService,$timeout,$window) {

	$scope.bookinginfo = localStorageService.get("BookingInfo");
	
	$scope.disTicket = false;
	$scope.disMsg = false;
	$scope.noCash = false;
	
	if($scope.bookinginfo.paymentStatus === "SUCCESS" || $scope.bookinginfo.paymentStatus === "In Cash"){
		
		$scope.disTicket = true;
	}else{

		if($scope.bookinginfo.errorMsg == "Someone else is trying to book the same ticket."){
			$scope.disMsg = true;
			
		}else if($scope.bookinginfo.errorMsg == "Your account balance is too low to book the tickets!"){		
			
			$scope.noCash = true;
			
		}else{
			
			$scope.disMsg = true;
		}
		
		
	}


	$scope.user = localStorageService.get("user");

	  
	  if($scope.user != null){
		  localStorageService.set("user",$scope.user);
		  $scope.auth = true;
		  
		  if($scope.user.roleid === 1){
			  $scope.adminuser = true;
		  }else if($scope.user.roleid === 2){
			  $scope.agentuser = true;
			  
		  }else if($scope.user.roleid === 3){
			  
			  $scope.extuser = true;
		  }
	  }

	  $scope.logout = function(){
	    	 localStorage.clear();
	    	 $window.location.href = 'https://nwt-techv.rhcloud.com';
	    };
	
});



app.controller('cancelcontroller', function($scope,$rootScope,$location,localStorageService ,$window,$http,BusService,$timeout) {

		
		$scope.booking = {};
		
		console.log($scope.booking);
		
		$scope.varifypnr = function(){
			
			console.log("changed "+$scope.pnrnumber);
			
			BusService.verifyPNR($scope.pnrnumber).then(function(promise){
					
				console.log(promise.data);
				
				if(promise.data === "false"){
					$scope.pnrnotavailable = true;
					$scope.pnravailabe = false;
				}else{
					$scope.pnrnotavailable = false;
					$scope.pnravailabe = true;
					
				}
				
			});
			
		};
		
		$scope.varifyEmail = function(){
	
			
			BusService.validateEmail($scope.emailid).then(function(promise){
					
				console.log(promise.data);
				
				if(promise.data === "false"){
					$scope.emailnotavailable = true;
					$scope.emailavailabe = false;
				}else{
					$scope.emailnotavailable = false;
					$scope.emailavailabe = true;
					
				}
				
			});
			
		};
		
		
		$scope.cancelTKT = function(){
			
			
			//fetch bookings by PNR Number
			BusService.getBookingsPNRNumber($scope.pnrnumber).then(function(promise){
				
				$scope.booking = promise.data;
				
				console.log("here : "+$scope.booking);
				
				localStorageService.set("cancelBooking" , $scope.booking );
				$window.location.href = 'https://nwt-techv.rhcloud.com/pages/viewPassengersCancel.jsp';
			});
			
		};
	
});

app.controller('confirmCancel', function($scope,$rootScope,$location,localStorageService ,$window,$http,BusService,$timeout) {
	
	$scope.user = localStorageService.get("user");

	  
	  if($scope.user != null){
		  localStorageService.set("user",$scope.user);
		  $scope.auth = true;
		  
		  if($scope.user.roleid === 1){
			  $scope.adminuser = true;
		  }else if($scope.user.roleid === 2){
			  $scope.agentuser = true;
			  
		  }else if($scope.user.roleid === 3){
			  
			  $scope.extuser = true;
		  }
	  }
	
	
	$scope.booking = 	localStorageService.get("cancelBooking");
	console.log(JSON.stringify($scope.booking));
	
	$scope.verifyShowOTP = false;
	$scope.pList = true;
	$scope.passengerList = true;
	$scope.cancelclicked = true;
	$scope.isrefundAmt = false;
	
	$scope.checkedPassengers = [];
	$scope.passengers = [];
	
	$scope.confirmCancel = function(e){
		
		
		
		console.log($scope.checkedPassengers.length);
		
		var isChecked = false;

		if($scope.checkedPassengers.length === 0){
			
			$scope.notchecked = true;
			$timeout(function () {
				   $scope.notchecked = false;
			    }, 2000);
		}else{
			
			for(var i=0;i<$scope.booking.passengerList.length ; i++){
				console.log($scope.checkedPassengers[$scope.booking.passengerList[i].passengerId]);
				
				if($scope.checkedPassengers[$scope.booking.passengerList[i].passengerId] == true){
					$scope.passengers.push($scope.booking.passengerList[i].passengerId+"|"+$scope.booking.passengerList[i].seatNumber);
					
				}
			}
		}
		
		console.log($scope.passengers);
		
		if($scope.passengers.length > 0){
			
			
			
			$scope.cancelclicked = false;
			
			
				
			//generate OTP and check verify
			 e.currentTarget.disabled = true;
			 
			 if($scope.user != null){
				 
				 if($scope.user.roleid === 1 || $scope.user.roleid === 2){
					 BusService.cancelBooking($scope.booking.pnrNumber,$scope.passengers).then(function(promise){

							//if(promise.data != 0){
								
								//$window.location.href = 'https://nwt-techv.rhcloud.com/pages/cancelledsuccess1.jsp';
							
								$scope.verifyShowOTP = false;						
								$scope.passengerList = false;
								$scope.pList = false;
								$scope.bankDetails = false;
								$scope.isrefundAmt = true;
								
								//console.log(promise.data);
								if(promise.data === "NaN"){
									$scope.refundAmt = 0;
								}else if(promise.data === 0){
									console.log("returended zero");
									
								}else{
									$scope.refundAmt = promise.data;
								}
							//}
							
							//$window.location.href = 'https://nwt-techv.rhcloud.com/pages/cancelledsuccess.jsp';
						});
					 
					 
					 
				 }else{
					 
					 console.log("here at generate OTP");
				 
					 
					 BusService.generateOTP($scope.booking.pnrNumber).then(function(promise){

							$scope.pin = promise.data;
							
							$scope.verifyShowOTP = true;
					 
					 });
				 } 
			 }else{
				 console.log("User Null");
				 
				 BusService.generateOTP($scope.booking.pnrNumber).then(function(promise){

						$scope.pin = promise.data;
						
						$scope.verifyShowOTP = true;
				 
				 });
				 
			 }
			 
			 
			
			
			/*BusService.generateOTP($scope.booking.pnrNumber).then(function(promise){

				$scope.pin = promise.data;
				
				$scope.verifyShowOTP = true;
				
			});
			*/
		}else{
			
			$scope.notchecked = true;
			$timeout(function () {
				   $scope.notchecked = false;
			    }, 2000);
		}
		
	};
	
	$scope.verifyOTP = function(data){
		
		if(data === undefined || data === ""){
			
			$scope.wrongpass = true;
			
			$timeout(function () {
				   $scope.wrongpass = false;
			    }, 2000);
		}else{
			
		
			
			if(data === $scope.pin){
			
				BusService.cancelBooking($scope.booking.pnrNumber,$scope.passengers).then(function(promise){

					if(promise.data != 0){
						
						//$window.location.href = 'https://nwt-techv.rhcloud.com/pages/cancelledsuccess1.jsp';
					
						$scope.verifyShowOTP = false;						
						$scope.passengerList = false;
						$scope.pList = false;
						$scope.bankDetails = true;
						$scope.isrefundAmt = true;
						$scope.refundAmt = promise.data;
						$scope.id = promise.data;
					}
					
					//$window.location.href = 'https://nwt-techv.rhcloud.com/pages/cancelledsuccess.jsp';
				});
				
			}else{
				
				//cancel it	
				$scope.wrongpass = true;
				$timeout(function () {
					   $scope.wrongpass = false;
				    }, 2000);
				
				
			}
			
		}
	};

	
	$scope.submitBankDetails = function(){
		
		BusService.updateCancelRefund($scope.booking.pnrNumber,$scope.passengers,$scope.nameperbank,$scope.bankname,$scope.ifsc,$scope.acnumber,$scope.id).then(function(promise){
				
			if(promise.data === "true"){
				console.log("Successfully updated ");
				$window.location.href = 'https://nwt-techv.rhcloud.com/pages/cancelledsuccess.jsp';
			}
		
		});
		
		
	};
	
	
});

app.controller('loginController', function($scope,$rootScope,$location,localStorageService ,$window,$http,LoginService,$timeout) {
	
	$scope.authenticate = function(){
		
		console.log("user : "+$scope.username+" pwd : "+$scope.pwd);
		
		if($scope.username === undefined || $scope.pwd === undefined){
			
			$scope.authfail = true;
			$timeout(function () {
				   $scope.authfail = false;
			    }, 2000);
			
		}else{
			
			console.log("here");
			//authenticate
			LoginService.authenticate($scope.username,$scope.pwd).then(function(promise){
				
				console.log("auth");
				$scope.user = promise.data;
				
				console.log($scope.user);
				
				if($scope.user.userid === 0){
					
					$scope.authfail = true;
					$timeout(function () {
						   $scope.authfail = false;
					    }, 2000);
				}else if($scope.user.roleid === 5){
					
					localStorageService.set("user" , $scope.user );
					$window.location.href = 'https://nwt-techv.rhcloud.com/pages/Admin/admincancel.jsp';
					
				}else{
					
					//redirect to homepage
				
					localStorageService.set("user" , $scope.user );
					$window.location.href = 'https://nwt-techv.rhcloud.com';
				}
				
			});
			
			
		}
		
	};
	
	
	$scope.register = function(){
		
		if($scope.fullname === undefined || $scope.fullname === ""){
			$scope.invFullName = true;
			
			$timeout(function () {
				   $scope.invFullName = false;
			    }, 2000);
			
		}else if($scope.email === undefined || $scope.email === ""){
			$scope.invEmail = true;
			$timeout(function () {
				   $scope.invEmail = false;
			    }, 2000);
			
		}else if($scope.mobile === undefined || $scope.mobile === ""){
			
			$scope.invMobile = true;
			$timeout(function () {
				   $scope.invMobile = false;
			    }, 2000);
			
		}else if($scope.uname === undefined || $scope.uname === ""){
			
			$scope.invUser = true;
			
			$timeout(function () {
				   $scope.invUser = false;
			    }, 2000);
		}else if($scope.password === undefined || $scope.password === ""){
			
			$scope.invPassword = true;
			
			$timeout(function () {
				   $scope.invPassword = false;
			    }, 2000);
			
		}else{
			
			//check if the username is available
			var isvalidated = true;
			
			LoginService.checkUserAvailability($scope.uname).then(function(promise){
				
				if(promise.data === "true"){
					
					isvalidated = false;
					
					$scope.invUser = true;
					
					$timeout(function () {
						   $scope.invUser = false;
					    }, 2000);
					
				}
				
			});
			
			
		LoginService.checkEmailAvailability($scope.email).then(function(promise){
					
			if(promise.data === "false"){
				
				isvalidated = false;
				
				$scope.invEmail = true;
				
				$timeout(function () {
					   $scope.invEmail = false;
				    }, 2000);
				
			}
			
				
			});
			
	
		
		        var mobile1=$scope.mobile;
		        var is_mobile = true;
		        if(mobile1.length!=10){
		        	is_mobile = false;

		        }
		        intRegex = /[0-9 -()+]+$/;
		        is_mobile=true;
		        for ( var i=0; i < 10; i++) {
		            if(intRegex.test(mobile1[i]))
		                 { 
		                 continue;
		                 }
		                else{
		                    is_mobile=false;
		                    break;
		                }
		             }
		 
		        if(!is_mobile){
		        	isvalidated = false;
					$scope.invMobile = true;
					$timeout(function () {
						   $scope.invMobile = false;
					    }, 2000);
		        	
		        }

	
			
			///register the user
			
			if(isvalidated){
				 
				
				LoginService.registerUser($scope.fullname,$scope.email,$scope.mobile,$scope.uname,$scope.password).then(function(promise){
					
					localStorageService.set("user" , promise.data );
					$window.location.href = 'https://nwt-techv.rhcloud.com';
				});
				
			}
			
			
		}
		
		
		
	};
	

});


app.controller('ChangeController', function($scope,$rootScope,$location,localStorageService ,$window,$http,LoginService,$timeout) {
	
	$scope.user = localStorageService.get("user");
	  
	  if($scope.user != null){
		  localStorageService.set("user",$scope.user);
		  $scope.auth = true;
		  
		  if($scope.user.roleid === 1){
			  $scope.adminuser = true;
		  }else if($scope.user.roleid === 2){
			  $scope.agentuser = true;
			  
		  }else if($scope.user.roleid === 3){
			  
			  $scope.extuser = true;
		  }
	  }
	
	
	
	$scope.changePWD = function(){
		
		if($scope.oldpwd === undefined || $scope.oldpwd === ""){
			
			
			
		}
		
		
	};

});

app.controller('printcontroller', function($scope,$rootScope,$location,localStorageService,BusService ,$window,$http,$timeout) {
	
	$scope.user = localStorageService.get("user");
	  
	  if($scope.user != null){
		  localStorageService.set("user",$scope.user);
		  $scope.auth = true;
		  
		  if($scope.user.roleid === 1){
			  $scope.adminuser = true;
		  }else if($scope.user.roleid === 2){
			  $scope.agentuser = true;
			  
		  }else if($scope.user.roleid === 3){
			  
			  $scope.extuser = true;
		  }
	  }
	
	$scope.printTkt = function(){

		if($scope.tick === "view"){
			
			BusService.getBookingsPNRNumber($scope.pnr).then(function(promise){
				localStorageService.set("BookingInfo" , promise.data );
				$window.location.href = 'https://nwt-techv.rhcloud.com/pages/viewTicket.jsp';
				
			});
		}else if($scope.tick === "sms"){
			BusService.getBookingsPNRNumberSMS($scope.pnr).then(function(promise){
				localStorageService.set("BookingInfo" , promise.data );
				$window.location.href = 'https://nwt-techv.rhcloud.com/pages/viewTicket.jsp';
				
			});
			
		}else if($scope.tick === "mail"){
			BusService.getBookingsPNRNumberEmail($scope.pnr).then(function(promise){
				localStorageService.set("BookingInfo" , promise.data );
				$window.location.href = 'https://nwt-techv.rhcloud.com/pages/viewTicket.jsp';
				
			});
			
		}
	};
	
});


app.controller('myBalance', function($scope,$rootScope,$location,localStorageService,BusService ,$window,$http,$timeout,$q) {

	$scope.user = localStorageService.get("user");
	  
	  if($scope.user != null){
		  localStorageService.set("user",$scope.user);
		  $scope.auth = true;
		  
		  if($scope.user.roleid === 1){
			  $scope.adminuser = true;
		  }else if($scope.user.roleid === 2){
			  $scope.agentuser = true;
			  
		  }else if($scope.user.roleid === 3){
			  
			  $scope.extuser = true;
		  }
	  }
	  
	  console.log("Userid "+$scope.user.userid);
	  var deferred = $q.defer();	 
	  var promise = $http({
			method : 'POST',
			url : 'busService/getMyBalance',
			data: $.param({

				userid: $scope.user.userid,
	            
	        }),
			dataType : 'json',
			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
			
		}).success(function(data, status, headers, config){

			deferred.resolve(data);
			console.log('success '+data);
			 $scope.balanceIs =data;
			
		}).error(function(data, status, headers, config) {
			deferred.reject(data);
	     
		});
	  
	 /* BusService.getBalanceAmount($scope.user.userid).then(function(promise){*/
		  
		 
	/*  });*/
	  
	
});
app.controller('tourismController', function($scope,$rootScope,$location,localStorageService,BusService ,$window,$http,$timeout,$q) {
	
	$scope.showSuccess = false;
	$scope.sendQuery = function(){
		
		BusService.sendTourismQuery($scope.name,$scope.email , $scope.ph,$scope.date , $scope.message).then(function(promise){
			
			$scope.showSuccess = true;
				
		});
			
	};
	
	
});
