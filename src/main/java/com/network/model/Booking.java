package com.network.model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.TimeZone;

public class Booking implements Comparable {
	
	private String pnrNumber;
	private int busId;
	private ArrayList passengerList;
	private String email;
	private long mobile;
	private double totdalFare;
	private int noOfSeat;
	private String journeyDate;
	private String paymentStatus;
	private String toCity;
	private String fromCity;
	private String startTime;
	private String reportingTime;
	private int midId;
	private double agentFare;
	private String transId;
	private String boardingPoint;
	private User user;
	private String errorMsg;
	
	
	
	
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getBoardingPoint() {
		return boardingPoint;
	}
	public void setBoardingPoint(String boardingPoint) {
		this.boardingPoint = boardingPoint;
	}
	public String getTransId() {
		return transId;
	}
	public void setTransId(String transId) {
		this.transId = transId;
	}
	public double getAgentFare() {
		return agentFare;
	}
	public void setAgentFare(double agentFare) {
		this.agentFare = agentFare;
	}
	public int getMidId() {
		return midId;
	}
	public void setMidId(int midId) {
		this.midId = midId;
	}
	public int getBusId() {
		return busId;
	}
	public void setBusId(int busId) {
		this.busId = busId;
	}
	public String getPnrNumber() {
		return pnrNumber;
	}
	public void setPnrNumber(String pnrNumber) {
		this.pnrNumber = pnrNumber;
	}
	public ArrayList getPassengerList() {
		return passengerList;
	}
	public void setPassengerList(ArrayList passengerList) {
		this.passengerList = passengerList;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public long getMobile() {
		return mobile;
	}
	public void setMobile(long mobile) {
		this.mobile = mobile;
	}
	public double getTotdalFare() {
		return totdalFare;
	}
	public void setTotdalFare(double totdalFare) {
		this.totdalFare = totdalFare;
	}
	public int getNoOfSeat() {
		return noOfSeat;
	}
	public void setNoOfSeat(int noOfSeat) {
		this.noOfSeat = noOfSeat;
	}
	public String getJourneyDate() {
		return journeyDate;
	}
	public void setJourneyDate(String journeyDate) {
		this.journeyDate = journeyDate;
	}
	public String getPaymentStatus() {
		return paymentStatus;
	}
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
	public String getToCity() {
		return toCity;
	}
	public void setToCity(String toCity) {
		this.toCity = toCity;
	}
	public String getFromCity() {
		return fromCity;
	}
	public void setFromCity(String fromCity) {
		this.fromCity = fromCity;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getReportingTime() {
		return reportingTime;
	}
	public void setReportingTime(String reportingTime) {
		this.reportingTime = reportingTime;
	}
	
	
	@Override
	public int compareTo(Object o) {
		
		System.out.println("here ");
		
		try{
		Booking b = (Booking)o;
		System.out.println("144");
		
		SimpleDateFormat sd = new SimpleDateFormat(
	              "MMM d, yyyy");
		
		System.out.println("this "+this.getJourneyDate());
	  
	    // String thisDate = sd.format("Nov 14, 2016");
	    // System.out.println("thisDAte "+thisDate);
	//	String objDate = sd.format(b.getJourneyDate());
		
		//System.out.println("thisDate : "+thisDate+" pdate : "+objDate);
		
		Date dThis = sd.parse(this.getJourneyDate());
		Date oDate = sd.parse(b.getJourneyDate());
		
		if(dThis.after(oDate)){
			return -1;
		}else if(oDate.after(dThis)){
			return 1;
		}else{
			return 0;
		}
			
		}catch(Exception e){
			System.out.println("ex : [compareTo] "+e.toString());
		} 
		return 0;
		
	}
	
	

}
