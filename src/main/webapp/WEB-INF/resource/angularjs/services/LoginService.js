var app=angular.module('network');

app.service('LoginService', function($http,$q) {
	 var deferred = $q.defer();
	 return {
		
		authenticate:function(username,pwd){
			var promise=$http({
				method : 'POST',
				url : 'LoginService/authenticate',
				data: $.param({
		            username: username,
		           password: pwd
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
				deferred.resolve(data);
			});
			return promise;
		},
		
		checkUserAvailability : function(username){
			
			var promise=$http({
				method : 'POST',
				url : 'LoginService/checkUserAvailable',
				data: $.param({
		            username: username,
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
				deferred.resolve(data);
			});
			return promise;
			
			
			
		},
		
		checkEmailAvailability : function(email){
			
			var promise=$http({
				method : 'POST',
				url : 'busService/validateEmail',
				data: $.param({
		            email: email
		            
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
				deferred.resolve(data);
			});
			
			return promise;
		},
		
		registerUser : function(fullname,email,mobile,username,password){
			
			var promise=$http({
				method : 'POST',
				url : 'LoginService/registeruser',
				data: $.param({
					name : fullname,
					email: email,
					mobile : mobile,
					username : username,
					password : password
		            
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
				deferred.resolve(data);
			});
			
			return promise;
		},
		
		

	};

});