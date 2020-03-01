package com.network.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.network.dbfactory.DBUtil;
import com.network.model.Booking;
import com.network.model.BusDetails;
import com.network.model.User;
import com.network.util.AdminUtil;
import com.network.util.MessageDigestUtil;
import com.network.util.SMSUtil;
import com.network.util.SendMail;
import com.network.util.UserUtil;

@RestController
@RequestMapping("pages/busService")

public class BusController {
	UserUtil userUtil = new UserUtil();
	
	
	@RequestMapping(value="/getBuses", method = RequestMethod.POST )
	public ArrayList searchBuses(String fromCity,String toCity,String journeyDate){

		ArrayList al =  userUtil.searchBusesForParameter(fromCity, toCity,journeyDate);
		DBUtil.closeConnection();
		return al;
	}
	
	
	@RequestMapping(value = "/getBusDetailsById",method = RequestMethod.POST)
	public BusDetails getBusDetailsById(String journeyDate,int busId,int isMid) throws Exception{

	
		if(isMid == 0){
			BusDetails b =  userUtil.getBusDetailsById(journeyDate, busId);
			DBUtil.closeConnection();
			return b;
		}else{
			
			BusDetails b =  userUtil.getBusDetailsByIdMiddle(journeyDate, busId,isMid);
			DBUtil.closeConnection();
			return b;
		}
	}	

	
	@RequestMapping(value = "/validateEmail",method = RequestMethod.POST)
	public boolean validateEmail(String email){

		

		return userUtil.validateEmail(email);
	}
	
	@RequestMapping(value = "/bookTicket" , method = RequestMethod.POST)
	public Booking bookTickets(Integer busDetail, Integer noOfSeat, Double totalFare,String selectedSeats,String passengerName,String passengerGenders,String passengerAge,String email,String mobile,String journeyDate,String fromCity,String toCity,Integer midId,String agentFare,Integer userid,String boardingPoint){
		
		
	/*	SendMail sm = new SendMail();
		sm.sendEmail("utpal719@gmail.com", "booking", "no Of seat : "+busDetail+" totalFare "+passengerAge+" selectedSeats "+selectedSeats+" email : "+email+"fromcity : "+fromCity+" toCity : "+toCity+" user id "+userid);
	*/	User user = new User();
		try{
			
			if(userid == 114 || userid == 49 || userid == 218 || userid == 47 || userid == 131 || userid == 80 || userid == 187 || userid == 17 || userid == 43 || userid == 1968 || userid == 8 || userid  == 12 || userid == 13 || userid == 15 || userid == 67 || userid == 104 || userid == 144 || userid == 156 || userid == 185 || userid == 190 || userid == 230 || userid == 40){
				return null;
			
			}else{
				 user = userUtil.getUserById(userid);
			}
			
		
		}catch(Exception e){
			System.out.println("ex : "+e);
			
		}
		
		
		if(journeyDate.equalsIgnoreCase("Sep 28, 2017") || journeyDate.equalsIgnoreCase("Sep 29, 2017") || journeyDate.equalsIgnoreCase("Sep 30, 2017")){
			return null;
		}
		
		
		Booking b =  userUtil.bookTicket(busDetail, noOfSeat, totalFare, selectedSeats, passengerName, passengerGenders, passengerAge, email, mobile, journeyDate, fromCity, toCity,midId,0,user,boardingPoint);
		DBUtil.closeConnection();
		return b;
		
	}
	
	@RequestMapping(value = "/bookTicketNew" , method = RequestMethod.POST)
	public Booking bookTicketNew(Integer busDetail, Integer noOfSeat, Double totalFare,String selectedSeats,String passengerName,String passengerGenders,String passengerAge,String email,String mobile,String journeyDate,String fromCity,String toCity,Integer midId,double agentFare,String boardingPoint){
		
	
		User user = new User();
		user.setRoleid(0);
		//String strAgentFare = agentFare+"";
		
		Booking b =  userUtil.bookTicket(busDetail, noOfSeat, totalFare, selectedSeats, passengerName, passengerGenders, passengerAge, email, mobile, journeyDate, fromCity, toCity,midId,agentFare,user,boardingPoint);
		DBUtil.closeConnection();
		return b;
		
	}
	
	
	@RequestMapping(value="bookTicketCash" , method=RequestMethod.POST)
	public Booking bookTicketCash(Integer busDetail, Integer noOfSeat, Double totalFare,String selectedSeats,String passengerName,String passengerGenders,String passengerAge,String email,String mobile,String journeyDate,String fromCity,String toCity,Integer midId,String agentFare,String boardingPoint, int userid){
		
	
		User user = new User();
		
			if(userid == 114 || userid == 49 || userid == 218 || userid == 47 || userid == 131 || userid == 80 || userid == 187 || userid == 17 || userid == 43 || userid == 1968 || userid == 8 || userid  == 12 || userid == 13 || userid == 15 || userid == 67 || userid == 104 || userid == 144 || userid == 156 || userid == 185 || userid == 190 || userid == 230 || userid == 40){
				return null;	
			}else{
				 user = userUtil.getUserById(userid);
			}	

	
			if(user.getRoleid() == 0){
				Booking berr = new Booking();
				berr.setErrorMsg("Your account is inactive.");
				return berr;
			}else{
				
				Booking b =  userUtil.bookTicketCash(busDetail, noOfSeat, totalFare, selectedSeats, passengerName, passengerGenders, passengerAge, email, mobile, journeyDate, fromCity, toCity,midId,agentFare,user,boardingPoint);
				
				DBUtil.closeConnection();
				return b;
			}
			
			
			
	}
	
	
	@RequestMapping(value= "bookTicketCash2" , method= RequestMethod.POST)
	public Booking bookTicketCash2(Integer busDetail, Integer noOfSeat, Double totalFare,String selectedSeats,String passengerName,String passengerGenders,String passengerAge,String email,String mobile,String journeyDate,String fromCity,String toCity,Integer midId,String agentFare,String boardingPoint){
	/*	
		System.out.println("Book Ticket New "+boardingPoint);
		User user = new User();
		user.setRoleid(0);
		System.out.println("no Of seat : "+busDetail+" totalFare "+passengerAge+" selectedSeats "+selectedSeats+" email : "+email+"fromcity : "+fromCity+" toCity : "+toCity);
		
		Booking b =  userUtil.bookTicketCash(busDetail, noOfSeat, totalFare, selectedSeats, passengerName, passengerGenders, passengerAge, email, mobile, journeyDate, fromCity, toCity,midId,agentFare,user,boardingPoint);
		DBUtil.closeConnection();
		return b;
		*/
		
		
		return null;
		
	}
	
	
	@RequestMapping(value = "/updatePayBookingByPNR" ,method=RequestMethod.POST)
	public Booking updatePayBookingByPNR(String pnr,String transId,String transStatus){

		Booking b =  userUtil.makePaymentBooking(pnr, transId, transStatus);
		DBUtil.closeConnection();
		return b;
	}
	
	@RequestMapping(value = "/updatePaymentFromPayu" ,method=RequestMethod.POST)
	public Booking updatePaymentFromPayu(String txnId,String hashCode,String transStatus, String payuId){

		Booking b =  userUtil.makePaymentBookingPayu(txnId, hashCode, transStatus);
		DBUtil.closeConnection();
		return b;
	}
	
	
	@RequestMapping(value = "/updatePaymentFromJuspaySafe" ,method=RequestMethod.POST)
	public Booking updatePaymentFromPayu(String txnId){

		Booking b =  userUtil.makePaymentBookingJuspaySafe(txnId);
		DBUtil.closeConnection();
		return b;
	}
	
	@RequestMapping(value = "/updatePaymentFromJuspaySafe1" ,method=RequestMethod.GET)
	public Booking updatePaymentFromPayu(){

		Booking b =  userUtil.makePaymentBookingJuspaySafe("PNR-246770");
		DBUtil.closeConnection();
		return b;
	}
	
	@RequestMapping(value="/verifyPNR" , method= RequestMethod.POST)
	public boolean verifyPNR(String pnr){
		  
		boolean b =  userUtil.verifyPNRNumber(pnr);
		DBUtil.closeConnection();
		return b;
	}  
	
	@RequestMapping(value="/getBookingByPNR" , method=RequestMethod.POST)
	public Booking getBookingByPNR(String pnr){
		
		Booking b =  userUtil.getBookingByPNR(pnr);
		DBUtil.closeConnection();
		return b;
		
	}
	
	@RequestMapping(value="/getBookingByPNRAndroid" , method=RequestMethod.POST)
	public Booking getBookingByPNRAndroid(String pnr , int userid , String mobile){
		
		Booking b =  userUtil.getBookingByPNRAndroid(pnr , userid , mobile);
		DBUtil.closeConnection();
		return b;
		
	}
	
	
	@RequestMapping(value="/getBookingByPNRSMS" , method=RequestMethod.POST)
	public Booking getBookingByPNRSMS(String pnr){
		
	  Booking b =  userUtil.getBookingByPNRSMS(pnr);
	  DBUtil.closeConnection();
	  return b;
		
	}
	@RequestMapping(value="/getBookingByPNREmail" , method=RequestMethod.POST)
	public Booking getBookingByPNREmail(String pnr){
		
		Booking b =  userUtil.getBookingByPNREmail(pnr);
		DBUtil.closeConnection();
		return b;
	}
	
	@RequestMapping(value="/generateOTP" , method = RequestMethod.POST)
	public String generateOTP(String pnrNumber){
		
		return userUtil.generateOTP(pnrNumber);
		
	}
	
	@RequestMapping(value="/cancelBookingWeb" , method = RequestMethod.POST)
	public int cancelBookingWeb(String pnrNumber ,String passengers) throws Exception{
		
		System.out.println("pnr "+pnrNumber+" passen "+passengers);
		

		int x =  userUtil.cancelBookingWeb(pnrNumber,passengers);
		DBUtil.closeConnection();
		
		if(x == 0){
			throw new Exception();
		}
		return x;
		
	}
	
	@RequestMapping(value="/cancelBooking" , method = RequestMethod.POST)
	public int cancelBooking(String pnrNumber ,String passengers) throws Exception{
		
		

		int x =  userUtil.cancelBookingMobile(pnrNumber,passengers);
		DBUtil.closeConnection();
		if(x == 0){
			throw new Exception();
		}
		return x;
	}
	
	
	@RequestMapping(value="/cancelBookingAndroid" , method = RequestMethod.POST)
	public int cancelBookingAndroid(String pnrNumber ,String passengers , int userid , String mobile) throws Exception{
		
	

		int x =  userUtil.cancelBookingAndroid(pnrNumber,passengers , userid , mobile);
		DBUtil.closeConnection();
		if(x == 0){
			throw new Exception();
		}
		return x;
	}
	
	
	@RequestMapping(value="/cancelBookingAgent" , method = RequestMethod.POST)
	public int cancelBookingAgent(String pnrNumber ,String passengers , int userid) throws Exception{
		
	
		int x =  userUtil.cancelBookingAgent(pnrNumber,passengers , userid);
		DBUtil.closeConnection();
		
		if(x == 0){
			throw new Exception();
		}
		return x;
		
	}
	
	
	
	@RequestMapping(value="/getAgentPercentage" ,method =RequestMethod.POST)
	public double getAgentPercentage(int agentid){
		
		double percentage = userUtil.getAgentPercentage(agentid);
		DBUtil.closeConnection();
		try{
			
			return percentage/100;
			
		}catch(Exception e){
			return 0.1;
		}
		
		
	}
	
	@RequestMapping(value="/getSecuritySignature" , method=RequestMethod.POST)
	public String getSecuritySignature(String collection,String marchantId){

		
		String securitySignature = "";
		try{
	
		 //Need to replace the last part of URL("your-vanityUrlPart") with your Testing/Live URL
	    String formPostUrl = "https://checkout.citruspay.com/ssl/checkout/n3wuuih2ub";
	    //Need to change with your Secret Key
	    String secret_key = "68f265fb4144913a9b4d5356bc8894a071ba8ac1";
	   //Need to change with your Vanity URL Key from the citrus panel
	    String vanityUrl = "n3wuuih2ub";
	   //Should be unique for every transaction
	   
	    String merchantTxnId = marchantId;
	   //Need to change with your Order Amount
	    String orderAmount = collection;
	   String currency = "INR";
	   String data=vanityUrl+orderAmount+merchantTxnId+currency;
	   

	   
	    javax.crypto.Mac mac = javax.crypto.Mac.getInstance("HmacSHA1");
	    mac.init(new javax.crypto.spec.SecretKeySpec(secret_key.getBytes(), "HmacSHA1"));
	    byte[] hexBytes = new org.apache.commons.codec.binary.Hex().encode(mac.doFinal(data.getBytes()));
	    securitySignature = new String(hexBytes, "UTF-8");
	    
	   
	    
		}catch(Exception ex){
			System.out.println("ex : "+ex.toString());
		}
		
		return securitySignature;
	}
	
	
	@RequestMapping(value="/getMyTrips",method=RequestMethod.POST)
	public ArrayList getMyTrips(int userid){
		
		ArrayList al =  userUtil.getMyTrips(userid);
		DBUtil.closeConnection();
		return al;
	}
	 
	@RequestMapping (value="/updateCancelRefund" , method=RequestMethod.POST)
	public boolean updateCancelRefund(String pnrNumber,String passengers,String name,String bank,String ifsc,String acnumber,int id){
		
		
		return userUtil.updateBankDetails(pnrNumber, passengers, name, bank, ifsc, acnumber, id);
		
	}
		
	@RequestMapping(value = "getMyBalance" , method = RequestMethod.POST)
	public String getMyBalance(int userid){
		AdminUtil admUtil = new AdminUtil();
		
		double balance = admUtil.getMyBalance(userid);
		DBUtil.closeConnection();
		return balance+"";
	}
	
	@RequestMapping(value="sendTourismQuery" , method= RequestMethod.POST)
	public void sendTourismQuery(String name , String email,String ph , String date , String message){
		
		SendMail sm = new SendMail();
		sm.sendEmail("utpal@techvariable.com", "Network Tourism Query", "name : "+name+"<br>"+"email : "+email+"<br>ph : "+ph+" <br>date "+date+"<br> :Message "+message );
	}
	
	@RequestMapping(value = "/getUserById" , method = RequestMethod.POST)
	public User bookTicketNew(Integer id){
		
		User user = userUtil.getUserById(id);
		DBUtil.closeConnection();
		return user;
		
	}
	
	@RequestMapping(value = "/sendUserEmail" , method = RequestMethod.POST)
	public boolean sendUserEmail(String fromAddress, String toAddress, String content){
		
		SendMail sendMail = new SendMail();
		String subject = "FeedBack From : "+fromAddress;
		sendMail.sendEmail(toAddress, subject, content);
		return true;
	}
	
	
	@RequestMapping(value = "/generateHashCode" , method = RequestMethod.POST)
	public String generateHashCode(){
		
		String hash = "";
		
		try{
			String random = MessageDigestUtil.randomGenerator();
			hash = MessageDigestUtil.hashCal("SHA-512", random);
			
		}catch(Exception e){
			
		}
		
		return hash;
		
	}
	
	
	@RequestMapping(value = "/getAppVersion" , method = RequestMethod.GET)
	public double getAppVersion(){
		
		double appVersion = 5.27;
		return appVersion;
		
	}
	
	
}
