package com.network.controller;

import java.util.ArrayList;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.network.dbfactory.DBUtil;
import com.network.util.AdminUtil;
import com.network.util.MessageDigestUtil;
import com.network.util.SendMail;
import com.network.util.UserUtil;

@RestController
@RequestMapping("pages/Admin/adminService")
public class AdminController {
	
	AdminUtil admUtil = new AdminUtil();
	
	@RequestMapping(value="/getBuses", method = RequestMethod.GET)
	public ArrayList getAllBuses(){
		
		return admUtil.getAllBuses();
		
	}
	
	@RequestMapping(value="/deletebus" , method= RequestMethod.POST)
	public boolean deleteBus(int busid){
		
	return admUtil.deleteBus(busid);

	}
	
	@RequestMapping(value="/getMiddleDest" , method = RequestMethod.POST)
	public ArrayList getAllMiddleDest(int busid){
		
		return admUtil.getMiddleByBusId(busid);
	}
	
	@RequestMapping(value = "/deleteMidDestination", method =RequestMethod.POST )
	public boolean deleteMidDestination(int midid){
		
		return admUtil.deleteMiddleDest(midid);
		
	}
	
	@RequestMapping(value="/getAllAgents" , method =RequestMethod.GET )
	public ArrayList getAllAgents(){
		
		return admUtil.getAllAgents();
	}

	@RequestMapping(value="/deleteAgent" , method = RequestMethod.POST)
	public boolean deleteAgent(int userid){
		
		return admUtil.deleteAgent(userid);
	}
	
	
	@RequestMapping(value = "/getAllCity" , method =RequestMethod.GET )
	public ArrayList getAllCity(){
		
		return admUtil.getAllCity();
	}
	
	@RequestMapping(value = "/deleteCity" , method =RequestMethod.POST )
	public boolean deleteCity(int cityid){
		
		return admUtil.deleteCity(cityid);
		
	}
	
	@RequestMapping(value ="/addBus",method = RequestMethod.POST)
	public boolean addBus(int fromcityId,int tocityId,String starttime,String endtime,int seatcapacity,String fare){
		
		return admUtil.addBus(fromcityId,tocityId,starttime,endtime,seatcapacity,fare);
			
	}
	
	@RequestMapping(value="/addNewCity",method = RequestMethod.POST )
	public boolean addNewCity(String cityname){
		
		return admUtil.addNewCity(cityname);
	}
	
	
	@RequestMapping(value="/addNewAgent" , method= RequestMethod.POST)
	public boolean addNewAgent(String name,String username,String pwd , double percentage,String address,String email, long mobile){
		
		String encryptPwd = MessageDigestUtil.doMessageDigest(pwd);
		
		return admUtil.addNewAgent(name,username,encryptPwd,percentage,address,email,mobile);
		
	}
	
	@RequestMapping(value = "/getPassengersForABus" , method =RequestMethod.POST )
	public ArrayList getPassengersForABus(int busId, String journeyDate){
		
		ArrayList al= admUtil.getPassengersForABus(busId, journeyDate);
		DBUtil.closeConnection();
		return al;
		
	}
	
	
	
	@RequestMapping(value = "/sendSMStoPassengers" , method =RequestMethod.POST )
	public void sendSMStoPassengers(int busId, String journeyDate , String busNumber){
		
		/*SendMail sm = new SendMail();
		sm.sendEmail("utpal@techvariable.com", "BuSnumber Test", busId+" "+journeyDate+" "+busNumber);*/
		admUtil.sendSMStoPassengers(busId, journeyDate , busNumber);
		DBUtil.closeConnection();
		
	}
	
	@RequestMapping(value="/getTicektReport" , method = RequestMethod.POST)
	public ArrayList getTicketReport(String journeyDate){
		
		return admUtil.getTicketReport(journeyDate);
		
	}
	
	@RequestMapping(value="/sendtechvmail",method=RequestMethod.POST)
	public boolean sendTechVMail(String subject,String message,String email)
	{
		
		return admUtil.sendTechVMail(subject,message,email);
		
	}
	
	
	@RequestMapping(value="/getCancelledTicket" , method =RequestMethod.POST )
	public ArrayList getCancelledTicket(String journeyDate){
		
		return admUtil.getCancelTicketByDate(journeyDate);
		
	}
	
	@RequestMapping(value="cleanupData" , method= RequestMethod.GET)
	public void cleanupData(){
		
		admUtil.cleanupData();
	}
	
	
	@RequestMapping(value="cleanupPassengers" , method= RequestMethod.GET)
	public void cleanupPassengers(){
		admUtil.cleanupPassengers();
	}


	@RequestMapping(value = "recharge" , method = RequestMethod.POST)
	public boolean recharge(int userid , double newAmount){
		
		admUtil.recharge(userid , newAmount);
		
		return true;
	}
	
	
}


