var app=angular.module('network');

app.service('BusService', function($http,$q) {
	var deferred = $q.defer();	 
	return {
		
		searchAllBuses:function(from,to,journeyDate){
			
			

			var promise=$http({
				method : 'POST',
				url : 'busService/getBuses',
				data: $.param({
		            fromCity: from,
		           toCity: to,
		           journeyDate : journeyDate
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
		
			return promise;
		},
		
		getSecuritySignature:function(collection,marchantId){
			var promise = $http({
				method : 'POST',
				url : 'busService/getSecuritySignature',
				data: $.param({
					collection:collection,
					marchantId : marchantId
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;
			
		},
		getBusDetailsByBusId : function(journeydate,busId,mid){
			
			console.log('Method ; getBusDetailsByBusId');
			
			var promise = $http({
				method : 'POST',
				url : 'busService/getBusDetailsById',
				data: $.param({
		            journeyDate: journeydate,
		            busId: busId,
		            isMid : mid
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
	
				deferred.resolve(data);
				console.log('success');
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;
			
		},
		
		validateEmail : function(email){
			
			var promise = $http({
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
				console.log('success '+data);
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;			
			
		},
		
		bookTicket : function(busDetail,noOfSeat,totalFare,arrSelectedSeat,arrName , arrGender, arrAge,email,mobile,journeyDate,fromCity,toCity,midId,agentFare,user,boardingPoint){
	
			console.log(boardingPoint +" Logged in user");
			
			if(user === null){
				
				var promise = $http({
					method : 'POST',
					url : 'busService/bookTicketNew',
					data: $.param({
			            busDetail: busDetail,
			            noOfSeat : noOfSeat,
			            totalFare : totalFare,
			            selectedSeats : arrSelectedSeat,
			            passengerName : arrName,
			            passengerGenders : arrGender,
			            passengerAge : arrAge,
			            email : email,
			            mobile : mobile,
			            journeyDate: journeyDate,
			            fromCity : fromCity,
			            toCity : toCity,
			            midId :midId,
			            agentFare : agentFare ,
			            boardingPoint : boardingPoint
			            
			        }),
					dataType : 'json',
					headers: {'Content-Type': 'application/x-www-form-urlencoded'}
					
				}).success(function(data, status, headers, config){
					
					//$scope.city=data;
		
					deferred.resolve(data);
					console.log('success '+data);
					
				}).error(function(data, status, headers, config) {
					deferred.reject(data);
			     
				});
				
				return promise;	
			}else{
			
				console.log("Logged in "+user.userid);
				
				
			var promise = $http({
				method : 'POST',
				url : 'busService/bookTicket',
				data: $.param({
		            busDetail: busDetail,
		            noOfSeat : noOfSeat,
		            totalFare : totalFare,
		            selectedSeats : arrSelectedSeat,
		            passengerName : arrName,
		            passengerGenders : arrGender,
		            passengerAge : arrAge,
		            email : email,
		            mobile : mobile,
		            journeyDate: journeyDate,
		            fromCity : fromCity,
		            toCity : toCity,
		            midId :midId,
		            agentFare : agentFare ,
		            userid: user.userid,
		            boardingPoint : boardingPoint
		            
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
	
				deferred.resolve(data);
				console.log('success '+data);
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;	
			}
			
		},
		
		
		bookTicketCash : function(busDetail,noOfSeat,totalFare,arrSelectedSeat,arrName , arrGender, arrAge,email,mobile,journeyDate,fromCity,toCity,midId,agentFare,user,boardingPoint){
			
			//console.log("user : "+user.userid);
			
			if(user === null){
				
				
				
				var promise = $http({
					method : 'POST',
					url : 'busService/bookTicketCash',
					data: $.param({
					    busDetail: busDetail,
			            noOfSeat : noOfSeat,
			            totalFare : totalFare,
			            selectedSeats : arrSelectedSeat,
			            passengerName : arrName,
			            passengerGenders : arrGender,
			            passengerAge : arrAge,
			            email : email,
			            mobile : mobile,
			            journeyDate: journeyDate,
			            fromCity : fromCity,
			            toCity : toCity,
			            midId :midId,
			            agentFare : agentFare ,
			            boardingPoint : boardingPoint
			            
			        }),
					dataType : 'json',
					headers: {'Content-Type': 'application/x-www-form-urlencoded'}
					
				}).success(function(data, status, headers, config){
					
					//$scope.city=data;
		
					deferred.resolve(data);
					console.log('success '+data);
					
				}).error(function(data, status, headers, config) {
					deferred.reject(data);
			     
				});
				
				return promise;	
			}else{
				
		
			
			var promise = $http({
				method : 'POST',
				url : 'busService/bookTicketCash',
				data: $.param({
		            busDetail: busDetail,
		            noOfSeat : noOfSeat,
		            totalFare : totalFare,
		            selectedSeats : arrSelectedSeat,
		            passengerName : arrName,
		            passengerGenders : arrGender,
		            passengerAge : arrAge,
		            email : email,
		            mobile : mobile,
		            journeyDate: journeyDate,
		            fromCity : fromCity,
		            toCity : toCity,
		            midId :midId,
		            agentFare : agentFare ,
		            userid: user.userid,
		            boardingPoint : boardingPoint
		            
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
	
				deferred.resolve(data);
				console.log('success '+data);
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;	
		}	
			
		},
		updatePayBookingByPNR : function(pnr,transId,transStatus){
			var promise = $http({
				method : 'POST',
				url : 'busService/updatePayBookingByPNR',
				data: $.param({
		            pnr: pnr,
		            transId : transId,
		            transStatus : transStatus
		            
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
	
				deferred.resolve(data);
				console.log('success '+data);
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;	
			
		},
		
		verifyPNR : function(pnr){
			
			var promise = $http({
				method : 'POST',
				url : 'busService/verifyPNR',
				data: $.param({
		            pnr: pnr
		            
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
	
				deferred.resolve(data);
				console.log('success '+data);
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;			
			
		},
		getBookingsPNRNumber : function(pnr){
			
			var promise = $http({
				method : 'POST',
				url : 'busService/getBookingByPNR',
				data: $.param({
		            pnr: pnr
		            
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
	
				deferred.resolve(data);
				console.log('success '+data);
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;			
		
		},
		getBookingsPNRNumberSMS : function(pnr){
			
			var promise = $http({
				method : 'POST',
				url : 'busService/getBookingByPNRSMS',
				data: $.param({
		            pnr: pnr
		            
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
	
				deferred.resolve(data);
				console.log('success '+data);
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;			
		
		},
		getBookingsPNRNumberEmail : function(pnr){
			
			var promise = $http({
				method : 'POST',
				url : 'busService/getBookingByPNREmail',
				data: $.param({
		            pnr: pnr
		            
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
	
				deferred.resolve(data);
				console.log('success '+data);
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;			
		
		},
		generateOTP : function(pnr){
			
			var promise = $http({
				method : 'POST',
				url : 'busService/generateOTP',
				data: $.param({
					pnrNumber: pnr
		            
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
	
				deferred.resolve(data);
				console.log('success '+data);
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;			
		
		},
		
		
		updateCancelRefund : function(pnrNumber,passengers,nameperbank,bankname,ifsc,acnumber,id){
			var strpasengers = "";
			for(var i=0;i<passengers.length;i++){
				if(strpasengers === ""){
					strpasengers = passengers[i];
				}else{
					strpasengers = strpasengers+","+passengers[i];
				}
			}
			
			var promise = $http({
				method : 'POST',
				url : 'busService/updateCancelRefund',
				data: $.param({
					pnrNumber: pnrNumber,
					passengers: strpasengers,
		            name : nameperbank,
		            bank : bankname,
		            ifsc : ifsc,
		            acnumber : acnumber,
		            id : id
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
	
				deferred.resolve(data);
				console.log('success '+data);
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;	
		},
		
		cancelBooking : function(pnrNumber,passengers){
			var strpasengers = "";
			for(var i=0;i<passengers.length;i++){
				if(strpasengers === ""){
					strpasengers = passengers[i];
				}else{
					strpasengers = strpasengers+","+passengers[i];
				}
			}
			
			var promise = $http({
				method : 'POST',
				url : 'busService/cancelBookingWeb',
				data: $.param({
					pnrNumber: pnrNumber,
					passengers: strpasengers
		            
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
	
				deferred.resolve(data);
				console.log('success '+data);
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;	
		},
		cancelBookingAgent : function(pnrNumber,passengers , userId){
			var strpasengers = "";
			for(var i=0;i<passengers.length;i++){
				if(strpasengers === ""){
					strpasengers = passengers[i];
				}else{
					strpasengers = strpasengers+","+passengers[i];
				}
			}
			
			var promise = $http({
				method : 'POST',
				url : 'busService/cancelBookingAgent',
				data: $.param({
					pnrNumber: pnrNumber,
					passengers: strpasengers,
					userid : userId
		            
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
	
				deferred.resolve(data);
				console.log('success '+data);
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;	
		},
		getAgentPercentage : function(agentid){
			
			
			var promise = $http({
				method : 'POST',
				url : 'busService/getAgentPercentage',
				data: $.param({
		            agentid: agentid
		            
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
				
				//$scope.city=data;
	
				deferred.resolve(data);
				console.log('success '+data);
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;		
	
		},
		
		getBalanceAmount : function(agentId){
			
			alert("here");
			
			var promise = $http({
				method : 'POST',
				url : 'busService/getMyBalance',
				data: $.param({

					userid: agentId,
		            
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success '+data);
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;	
		},
		sendTourismQuery : function(name , email , ph , date , message){
			
			alert("here");
			
			var promise = $http({
				method : 'POST',
				url : 'busService/sendTourismQuery',
				data: $.param({

					name: name,
					email : email,
					ph : ph,
					date : date,
					message : message
		            
		        }),
				dataType : 'json',
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				
			}).success(function(data, status, headers, config){
	
				deferred.resolve(data);
				console.log('success '+data);
				
			}).error(function(data, status, headers, config) {
				deferred.reject(data);
		     
			});
			
			return promise;	
		}
		
	};

});