var app=angular.module('network', ['ui.bootstrap','LocalStorageModule']);

  app.controller('CityController', function($scope,$rootScope,$http,CityService,localStorageService,$window,$filter) {

	  $scope.user = localStorageService.get("user");
	  
	  console.log($scope.user);
	  try{
		 localStorage.clear();
	  }catch(e){
		  alert("Please Update your browser!!");
	  }
  
	  
	  
	  
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
	  
    $scope.city=[];
    $scope.cityNames=[];
    
    $scope.parent = {journeyDate:''};
    
    
    CityService.getAllCityName().then(function(promise) {
		$scope.city = promise.data;
		for(var i=0;i<$scope.city.length;i++){
	    	$scope.cityNames[i]=$scope.city[i].cityName;
	    }
    });
    

    $scope.startsWith = function(state, viewValue) {

    	  return state.substr(0, viewValue.length).toLowerCase() == viewValue.toLowerCase();
    	}; 
    
    $scope.busSearch=function(){
    	var searchObject = {};
    	
    	
    	
    	if($scope.journeyDate === undefined){

    		$scope.datenew = $filter('date')(new Date(), 'MMM d, y');
    		$scope.journeyDate = $scope.datenew;
    		
    		
    	}

    	//localStorageService
    	searchObject.from=$scope.selected2;
    	searchObject.to = $scope.selected3;
    	searchObject.startDate = $scope.journeyDate;
    	localStorageService.set("searchObject",searchObject);
    };
    
    $scope.logout = function(){
    	 localStorage.clear();
    	 $window.location.href = 'https://nwt-techv.rhcloud.com';
    };
    
    
    
 });
  
  
  app.controller('TripHistoryController', function($scope,$rootScope,$location,localStorageService ,$window,$http,CityService,$timeout) {
		
	  $scope.user = localStorageService.get("user");
	  
	  
	  localStorage.clear();
	  
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
	  
	  console.log($scope.user);

	  CityService.getMyTrips($scope.user).then(function(promise) {
		  
		  $scope.bookings = promise.data;
		
	    });
	    
		
  }); 
  