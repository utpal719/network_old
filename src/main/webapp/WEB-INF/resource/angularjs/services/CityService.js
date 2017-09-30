var app=angular.module('network');

app.service('CityService', function($http,$q) {
	 var deferred = $q.defer();
	 return {
		
		getAllCityName:function(){
			var promise=$http({
				method : 'GET',
				url : 'city/getAllCityName',
				dataType : 'json',
				contentType: 'application/json; charset=utf-8',
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
				deferred.resolve(data);
			});
			return promise;
		},
		getMyTrips :function(user){
			
			console.log("hee " +user);
			
			var promise=$http({
				method : 'POST',
				url : 'busService/getMyTrips',
				data: $.param({
					userid : user.userid,
		         
		        }),
		        dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
				deferred.resolve(data);
			});
			return promise;
			
			
		}

	};

});