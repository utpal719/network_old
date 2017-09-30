var app=angular.module('network');

app.service('AdminService', function($http,$q) {
	var deferred = $q.defer();	 
	
	return {
		
		getAllBuses:function(){


			var promise=$http({
				method : 'GET',
				url : 'adminService/getBuses',
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
		
			return promise;
		},
		
		viewCancelTickets : function(journeyDate){
			
			var promise=$http({
				method : 'POST',
				url : 'adminService/getCancelledTicket',
				data: $.param({
					journeyDate: journeyDate,
		           
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
		
			return promise;
			
			
		},
		
		
		getTicektReport : function(journeyDate){
			

			var promise=$http({
				method : 'POST',
				url : 'adminService/getTicektReport',
				data: $.param({
					journeyDate: journeyDate,
		           
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
		
			return promise;
			
		},
		
		deleteBus : function(busid){
			

			var promise=$http({
				method : 'POST',
				url : 'adminService/deletebus',
				data: $.param({
		            busid: busid,
		           
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
		
			return promise;
		},
		
		getMiddleDestination : function(busid){
			
			var promise=$http({
				method : 'POST',
				url : 'adminService/getMiddleDest',
				data: $.param({
		            busid: busid,
		           
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
		
			return promise;
			
			
		},
		deleteMidDest : function(midid){
			
			var promise=$http({
				method : 'POST',
				url : 'adminService/deleteMidDestination',
				data: $.param({
					midid: midid,
		           
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;
			
		},
		getAllAgents : function(){
			
			var promise=$http({
				method : 'GET',
				url : 'adminService/getAllAgents',
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;
			
		},
		deleteAgent : function(userid){
			
			var promise=$http({
				method : 'POST',
				url : 'adminService/deleteAgent',
				data: $.param({
					userid: userid,
		           
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;
			
		},
		getAllCity : function(){
			
			var promise=$http({
				method : 'GET',
				url : 'adminService/getAllCity',
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;
			
		},
		deleteCity : function(cityid){
			
			var promise=$http({
				method : 'POST',
				url : 'adminService/deleteCity',
				data: $.param({
					cityid: cityid,
		           
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;	
		},
		addBus : function(fromcityId,tocityId,starttime,endtime,seatcapacity,fare){
			
			var promise=$http({
				method : 'POST',
				url : 'adminService/addBus',
				data: $.param({
					fromcityId: fromcityId,
					tocityId : tocityId,
					starttime : starttime,
					endtime : endtime,
					seatcapacity: seatcapacity,
					fare: fare
					
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;	
			
		},
		
		addNewCity : function(cityname){
			
			var promise=$http({
				method : 'POST',
				url : 'adminService/addNewCity',
				data: $.param({
					cityname: cityname,
					
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;	
			
		},
		addAgent : function(name,username,pwd,percentage,address,email,mobile){
			
			var promise=$http({
				method : 'POST',
				url : 'adminService/addNewAgent',
				data: $.param({
					name: name,
					username:username,
					pwd : pwd,
					percentage:percentage,
					address: address,
					email : email,
					mobile:mobile
					
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;	
			
		},
		getPassengerByBus : function(journeyDate,busId){
			
			var promise=$http({
				method : 'POST',
				url : 'adminService/getPassengersForABus',
				data: $.param({
					busId: busId,
					journeyDate:journeyDate,
					
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;	
		},
		SendSMSByBus : function(journeyDate, busId , busNumber){
			
			console.log(journeyDate +" "+busId +" "+busNumber);
			
			var promise=$http({
				method : 'POST',
				url : 'adminService/sendSMStoPassengers',
				data: $.param({
					busId: busId,
					journeyDate:journeyDate,
					busNumber : busNumber,
					
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;	
			
		},
		cleanupData : function(){
			
			
			var promise=$http({
				method : 'GET',
				url : 'adminService/cleanupData',
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;
			
		},
		cleanupPassengers : function(){
			
			
			var promise=$http({
				method : 'GET',
				url : 'adminService/cleanupPassengers',
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;
			
		},
		recharge : function(userid , newAmount){
			
			var promise=$http({
				method : 'POST',
				url : 'adminService/recharge',
				data: $.param({
					userid: userid,
					newAmount:newAmount,
					
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;	
			
		},
		
	};
	
});