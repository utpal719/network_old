package com.network.util;

import java.awt.image.DataBuffer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import com.network.dbfactory.DBUtil;
import com.network.model.AdminBookingView;
import com.network.model.AdminViewPassenger;
import com.network.model.Booking;
import com.network.model.Bus;
import com.network.model.Cancel;
import com.network.model.City;
import com.network.model.MiddleDestination;
import com.network.model.Passenger;
import com.network.model.User;

	public class AdminUtil {
		
		UserUtil userUtil = new UserUtil();

	
		public ArrayList getAllBuses(){
			ArrayList alBuses = new ArrayList();
			Connection conn = null;
			PreparedStatement pstm = null;
			ResultSet rs = null;
			try{
				conn = DBUtil.getConnection();
				pstm = conn.prepareStatement("select * from bus");

				rs = pstm.executeQuery();
				
				while(rs.next()){
					Bus bus = new Bus();
					bus.setBusId(rs.getInt("busid"));
					int fromCityId = rs.getInt("fromcityid");
					String fromCity = userUtil.getCityNameById(fromCityId);
					int toCityId = rs.getInt("tocityid");
					String toCity = userUtil.getCityNameById(toCityId);
					
					bus.setFromCity(fromCity);
					bus.setToCity(toCity);
					bus.setFare(rs.getFloat("fare"));
					bus.setSeatCapacity(rs.getInt("seatcapacity"));
					bus.setStartTime(userUtil.get12HrsTime(rs.getString("starttime")));
					bus.setEndtime(userUtil.get12HrsTime(rs.getString("endtime")));
					
					alBuses.add(bus);
				}
				
				
				
			}catch(Exception ex){
				System.out.println("ex : [getAllBuses] "+ex.toString());
			}
			
			return alBuses;
			
		}
		
		
		public User checkAgentBookingBank(String pnr){
			User user =  new User();
			Connection conn = null;
			PreparedStatement pstm = null;
			ResultSet rs= null;
			System.out.println(pnr);
			
			try{
				conn = DBUtil.getConnection();
				pstm = conn.prepareStatement("select * from agentbooking where pnrnumber = ?");
				pstm.setString(1, pnr);
				
				rs = pstm.executeQuery();
				
				while(rs.next()){
					
				System.out.println("hete at : "+pnr);	
					
				 user = userUtil.getUserById(rs.getInt("agentid"));
					
				}
			}catch(Exception ex){
				System.out.println("ex [checkIfAgentBooking] "+ex.toString());
			}
			
			return user;
		}
		
		
		public ArrayList getTicketReport(String journeydate){
			
			return getBookingsByDate(journeydate);
			
		}
		
		
		
		public ArrayList getBookingsByDate(String journeyDate){
			
			Connection conn = null;
			PreparedStatement pstm = null;
			ResultSet rs = null;
			
			ArrayList alList = new ArrayList();
			
			try{
				conn = DBUtil.getConnection();
				pstm = conn.prepareStatement("select * from bookingDetails where journeydate = ?");
				pstm.setString(1, journeyDate);
				rs = pstm.executeQuery();
				
				while(rs.next()){
					
					String bookingPNR = rs.getString("pnrnumber");
					
					Booking booking = userUtil.getBookingByPNR(bookingPNR);
					
					int passengerSize = booking.getPassengerList().size();
					
					if(passengerSize == 0 ){
						String pnr = booking.getPnrNumber();
						booking.setPnrNumber(pnr+" (Cancelled) ");
					}
					
					AdminBookingView admBooking = new AdminBookingView();
					
					String agentDetails = checkIfAgentBooking(bookingPNR);
					
					if(agentDetails.equalsIgnoreCase("")){
						
						String adminDetails = checkifAdminBooking(bookingPNR);
						if(adminDetails.equalsIgnoreCase("")){
							admBooking.setBookedUser("Admin");
							admBooking.setBooking(booking);
						}else{
							admBooking.setBookedUser(adminDetails);
							admBooking.setBooking(booking);
						}
						
					}else{
						admBooking.setBookedUser(agentDetails);
						admBooking.setBooking(booking);
					}
					
					alList.add(admBooking);
					
				}
				
				
			}catch(Exception ex){
				System.out.println("ex : "+ex.toString());
			}
			
			return alList;
		}
		
		
		public String checkIfAgentBooking(String pnr){
			String agentDetails = "";
			Connection conn = null;
			PreparedStatement pstm = null;
			ResultSet rs= null;
			
			try{
				conn = DBUtil.getConnection();
				pstm = conn.prepareStatement("select * from agentbooking where pnrnumber = ?");
				pstm.setString(1, pnr);
				
				rs = pstm.executeQuery();
				
				while(rs.next()){
					
					User user = userUtil.getUserById(rs.getInt("agentid"));
					agentDetails = user.getUserName()+"("+user.getMobile()+")";
					
				}
			}catch(Exception ex){
				System.out.println("ex [checkIfAgentBooking] "+ex.toString());
			}
			
			return agentDetails;
		}
		
		public String checkifAdminBooking(String pnr){
			String adminDetails = "";
			Connection conn = null;
			PreparedStatement pstm = null;
			ResultSet rs= null;
			
			try{
				conn = DBUtil.getConnection();
				pstm = conn.prepareStatement("select * from adminbooking where pnr = ?");
				pstm.setString(1, pnr);
				
				rs = pstm.executeQuery();
				
				while(rs.next()){
					
					User user = userUtil.getUserById(rs.getInt("adminid"));
					adminDetails = user.getUserName()+"("+user.getMobile()+")";
					
				}
			}catch(Exception ex){
				System.out.println("ex [checkIfAgentBooking] "+ex.toString());
			}
			
			return adminDetails;
		}
		
		
	/*	public String checkIfUserBooking(String pnr){
			String agentDetails = "";
			Connection conn = null;
			PreparedStatement pstm = null;
			ResultSet rs= null;
			
			try{
				conn = DBUtil.getConnection();
				pstm = conn.prepareStatement("select * from agentbooking where pnrnumber = ?");
				pstm.setString(1, pnr);
				
				rs = pstm.executeQuery();
				
				while(rs.next()){
					
					User user = userUtil.getUserById(rs.getInt("agentid"));
					agentDetails = user.getUserName()+" ("+user.getMobile()+")";
					
				}
			}catch(Exception ex){
				System.out.println("ex [checkIfAgentBooking] "+ex.toString());
			}
			
			return agentDetails;
		}
	*/	
		
	public boolean deleteBus(int busId){
		
		boolean isDeleted = false;
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		try{
			
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("delete from bus where busid = ?");
			pstm.setInt(1, busId);
			
			pstm.executeUpdate();
			isDeleted = true;
			
		}catch(Exception ex){
			System.out.println("ex : [deleteBus] "+ex.toString());
		}
		
		return isDeleted;
	}
	
	
	public ArrayList getMiddleByBusId(int busId){
		
		ArrayList alMiddle = new ArrayList();
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs= null;
		try{
			
			
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from middledestination where busid = ?");
			pstm.setInt(1, busId);

			
			rs= pstm.executeQuery();
			
			while(rs.next()){
				
				MiddleDestination mid = new MiddleDestination();
				mid.setMidId(rs.getInt("midid"));
				mid.setBusId(rs.getInt("busid"));

				mid.setFromCity(userUtil.getCityNameById(rs.getInt("fromdestinationid")));
				mid.setToCity(userUtil.getCityNameById(rs.getInt("todestinationid")));
				
				String seats = rs.getString("seatlist"); 
				
				String[] tempSeat = seats.split(",");
				ArrayList alSeats = new ArrayList();
				for(int i=0;i<tempSeat.length;i++){
					
					alSeats.add(Integer.parseInt(tempSeat[i]));
					
				}
				
				mid.setSeatlist(alSeats);
				mid.setFare(rs.getDouble("fare"));
				mid.setStartTime(userUtil.get12HrsTime(rs.getString("starttime")));
				mid.setEndTime(userUtil.get12HrsTime(rs.getString("endtime")));
				
				alMiddle.add(mid);

			}
			
		}catch(Exception ex){
			System.out.println("ex : [getMiddleByBusId] "+ex.toString());
			
		}
		
		return alMiddle;
	}
	
	
	public boolean deleteMiddleDest(int midId){
		
		boolean isDeleted = false;
		Connection conn = null;
		PreparedStatement pstm = null;
		try{
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("delete from middledestination where midid = ?");
			pstm.setInt(1, midId);
			
			pstm.executeUpdate();
			isDeleted = true;
			
		}catch(Exception ex){
			
			System.out.println("ex: [deleteMiddleDest] "+ex.toString());
		}
		
		return isDeleted;
	}
	
	
	public ArrayList getAllAgents(){
		
		ArrayList alUsers  = new ArrayList();
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		try{
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from users where role = ?");
			pstm.setInt(1, 2);
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				User user = new User();
				user.setUserid(rs.getInt("userid"));
				user.setUserName(rs.getString("username"));
				user.setEmail(rs.getString("email"));
				user.setMobile(rs.getLong("mobile"));
				user.setRoleid(2);
				user.setPercentage(rs.getDouble("percentage"));
				user.setBalance(rs.getDouble("balance"));
				
				alUsers.add(user);
			}	
			
		}catch(Exception ex){
			System.out.println("ex : [getAllAgents] "+ex.toString());
			
		}
		
		return alUsers;
		
	}
	
	
	public boolean deleteAgent(int agentId){
		
		boolean isDeleted = false;
		Connection conn = null;
		PreparedStatement pstm = null;
		
		
		try{
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("delete from users where userid = ?");
			pstm.setInt(1, agentId);
			
			pstm.executeUpdate();
			isDeleted = true;
			
		}catch(Exception ex){
			
			System.out.println("ex : [deleteAgent] "+ex.toString());
		}
		
		return isDeleted;
	}	
	
	
	public ArrayList getAllCity(){
		
		ArrayList alCity = new ArrayList();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		try{
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from city");
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				City city = new City();
				city.setCityId(rs.getInt("id"));
				city.setCityName(rs.getString("cityname"));
				alCity.add(city);
			}
			
		}catch(Exception ex){
			
			System.out.println("ex : [getAllCity] "+ex.toString());
		}
		return alCity;
	}
	
	
	public boolean deleteCity(int cityId){
		
		boolean isDeleted = false;
		Connection conn = null;
		PreparedStatement pstm = null;
		
		try{
			
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("delete from city where id = ?");
			pstm.setInt(1, cityId);
			
			pstm.executeUpdate();
			isDeleted = true;
			
		}catch(Exception ex){
			System.out.println("ex : [deleteCity] "+ex.toString());
			
		}
		
		return isDeleted;
	}
	
	public boolean addBus(int fromcityId, int toCityId, String startTime,String endTime, int seatCapacity,String fare){
		
		boolean isAdded = false;
		Connection conn = null;
		PreparedStatement pstm = null;
	
		try{
			double dFare = Double.parseDouble(fare);
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("insert into bus (fromcityid,tocityid,starttime,endtime,seatcapacity,fare) values(?,?,?,?,?,?)");
			pstm.setInt(1, fromcityId);
			pstm.setInt(2, toCityId);
			pstm.setString(3, startTime);
			pstm.setString(4, endTime);
			pstm.setInt(5, seatCapacity);
			pstm.setDouble(6, dFare);
			pstm.executeUpdate();
			
			isAdded = true;
			
		}catch(Exception ex){
			System.out.println("ex : [addBus] "+ex.toString());
		}
		
		return isAdded;
	}
	
	
	public boolean addNewCity(String cityName){
		
		boolean isAdded = false;
		Connection conn = null;
		PreparedStatement pstm = null;
		
		try{
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("insert into city(cityname) values(?)");
			pstm.setString(1, cityName);
			
			pstm.executeUpdate();
			
			isAdded = true;
			
		}catch(Exception ex){
			System.out.println("ex : [addNewCity] "+ex.toString());
		}
		
		return isAdded;
	}
	
	
	public boolean addNewAgent(String name, String userName, String pwd, double percentage, String address, String email, long mobile){
		
		boolean isAdded = false;
		Connection conn = null;
		PreparedStatement pstm = null;
		
		
		try{
			conn =DBUtil.getConnection();
			pstm = conn.prepareStatement("insert into users (username,password,email,mobile,role,percentage,name,address) values(?,?,?,?,?,?,?,?)");
			pstm.setString(1, userName);
			pstm.setString(2, pwd);
			pstm.setString(3, email);
			pstm.setLong(4, mobile);
			pstm.setInt(5, 2);
			pstm.setDouble(6, percentage);
			pstm.setString(7, name);
			pstm.setString(8, address);

			pstm.executeUpdate();
			isAdded = true;
		}catch(Exception ex){
			
			System.out.println("ex : [addNewAgent] "+ex.toString());
		}
		
		return isAdded;
	}

	
	public ArrayList getPassengersForABus(int busId, String journeyDate){
		
		ArrayList alPassengers = new ArrayList();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		ArrayList duplicacy = new ArrayList();
		
		try{
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from bookingDetails where busid = ? and journeydate = ?");		
			pstm.setInt(1, busId);
			pstm.setString(2, journeyDate);
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				
				Booking booking = new Booking();
				booking.setBusId(rs.getInt("busid"));
				booking.setEmail(rs.getString("email"));
				booking.setMobile(rs.getLong("mobile"));
				booking.setJourneyDate(rs.getString("journeydate"));
				booking.setPaymentStatus(rs.getString("paymentstatus"));
				booking.setBoardingPoint(rs.getString("boardingpoint"));
				booking.setToCity(rs.getString("tocity"));
				booking.setUser(userUtil.getUserById(rs.getInt("userid")));
				
				if(booking.getPaymentStatus().equalsIgnoreCase("SUCCESS") || booking.getPaymentStatus().equalsIgnoreCase("In Cash")){
			
				}else{
					continue;
				}
		
				int uuid = rs.getInt("uuid");
							
				booking.setTotdalFare(rs.getDouble("totalfare"));
				booking.setPnrNumber("PNR-"+uuid);
				

				
				//get Passengers
				ArrayList alPassenger = userUtil.getPassengersByPNR(booking.getPnrNumber());
				
				System.out.println("AL P "+alPassenger.size());

			
				booking.setPassengerList(alPassenger);
	
				double eachFare = booking.getTotdalFare() / alPassenger.size();

				
					for(int i = 0; i<alPassenger.size() ; i++){
						AdminViewPassenger adPassenger = new AdminViewPassenger();
						Passenger p = (Passenger)alPassenger.get(i);
						
						System.out.println("Pass  ********  "+p.getSeatNumber());
						
						adPassenger.setPassengerName(p.getPassengerName());
						adPassenger.setPnrNumber(booking.getPnrNumber());
						adPassenger.setSeatNumber(p.getSeatNumber());
						adPassenger.setBoardingPoint(booking.getBoardingPoint());
						adPassenger.setPayment(booking.getPaymentStatus());
						adPassenger.setFare(eachFare+"");
						String dest = booking.getToCity();
						
						if(dest.equalsIgnoreCase("NORTH LAKHIMPUR")){
							dest = "NLP";
						}
						
						adPassenger.setDestination(dest);
						adPassenger.setMobile(booking.getMobile());
						
						User u = booking.getUser();
						
						if(u.getRoleid() == 1){
							adPassenger.setAgentBook(booking.getUser().getUserName()+"("+booking.getUser().getMobile()+")");
						}else{
							adPassenger.setAgentBook("USER");
						}
						
						alPassengers.add(adPassenger);
					}
				

				}
				
			}
			catch(Exception ex){
			
					System.out.println("ex : [getPassengersForABus] "+ex.toString());
				}
	

			Bus b = userUtil.getBusByBusId(busId);
			
			for(int x = 1;x<=b.getSeatCapacity();x++){
	
				if(!CheckIfSeatPresent(alPassengers , x)){
					
					AdminViewPassenger adm = new AdminViewPassenger();
					adm.setSeatNumber(x);
				
					alPassengers.add(adm);
				}
					
			
			}
			
		
		
		Collections.sort(alPassengers, new Comparator<AdminViewPassenger>() {
	        @Override public int compare(AdminViewPassenger p1, AdminViewPassenger p2) {
	            return p1.getSeatNumber() - p2.getSeatNumber(); // Ascending
	        }

	    });

		return alPassengers;
	}
	
	
	
	public void sendSMStoPassengers(int busId , String journeyDate , String busNumber){
		
		
		ArrayList alPassengers = new ArrayList();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		ArrayList duplicacy = new ArrayList();
		SMSUtil sms = new SMSUtil();
		try{
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from bookingDetails where busid = ? and journeydate = ?");		
			pstm.setInt(1, busId);
			pstm.setString(2, journeyDate);
			rs = pstm.executeQuery();
			
			String numbers = "";
		
			
			while(rs.next()){
				
				
				Booking booking = new Booking();
				booking.setBusId(rs.getInt("busid"));
				booking.setEmail(rs.getString("email"));
				booking.setMobile(rs.getLong("mobile"));
				booking.setJourneyDate(rs.getString("journeydate"));
				booking.setPaymentStatus(rs.getString("paymentstatus"));
				booking.setBoardingPoint(rs.getString("boardingpoint"));
				booking.setToCity(rs.getString("tocity"));
				booking.setUser(userUtil.getUserById(rs.getInt("userid")));
				
				if(booking.getPaymentStatus().equalsIgnoreCase("SUCCESS") || booking.getPaymentStatus().equalsIgnoreCase("In Cash")){
			
				}else{
					continue;
				}
		
				int uuid = rs.getInt("uuid");
							
				booking.setTotdalFare(rs.getDouble("totalfare"));
				booking.setPnrNumber("PNR-"+uuid);
				
				if(numbers.equalsIgnoreCase("")){
					numbers = booking.getMobile()+"";
				}else{
					numbers = numbers+","+booking.getMobile();
				}	
				
				
				sms.sendSMS(numbers, "Dear Customer,\r\nYour bus number for PNR : "+booking.getPnrNumber() +" journeydate : "+booking.getJourneyDate()+" is : "+busNumber);
				
				/*	for(int i = 0; i<alPassenger.size() ; i++){
						AdminViewPassenger adPassenger = new AdminViewPassenger();
						Passenger p = (Passenger)alPassenger.get(i);
						
						System.out.println("Pass  ********  "+p.getSeatNumber());
						
						adPassenger.setPassengerName(p.getPassengerName());
						adPassenger.setPnrNumber(booking.getPnrNumber());
						adPassenger.setSeatNumber(p.getSeatNumber());
						adPassenger.setBoardingPoint(booking.getBoardingPoint());
						adPassenger.setPayment(booking.getPaymentStatus());
						adPassenger.setFare(eachFare+"");
						String dest = booking.getToCity();
						
						if(dest.equalsIgnoreCase("NORTH LAKHIMPUR")){
							dest = "NLP";
						}
						
						adPassenger.setDestination(dest);
						adPassenger.setMobile(booking.getMobile());
						
						User u = booking.getUser();
						
						if(u.getRoleid() == 1){
							adPassenger.setAgentBook(booking.getUser().getUserName()+"("+booking.getUser().getMobile()+")");
						}else{
							adPassenger.setAgentBook("USER");
						}
						
						alPassengers.add(adPassenger);
					}*/
				

				}
			
			sms.sendSMS("9004660598"," Bus Number "+busNumber);
			
				
			}
			catch(Exception ex){
			
					System.out.println("ex : [getPassengersForABus] "+ex.toString());
				}
		
	}
	
	
	public boolean CheckIfSeatPresent(ArrayList alPassengers , int x){
		
		boolean isExist = false;
		

		
		for(int i = 0 ; i<alPassengers.size() ; i++){
			
			AdminViewPassenger passenger = (AdminViewPassenger)alPassengers.get(i);
			
		
			
			if(passenger.getSeatNumber() == x){
				
				isExist = true;
				break;
			}
			
			
		}

		return isExist;
	}
	
	
	public ArrayList getSeatListByPNR(String pnrNumber , int busid , String journeyDate){
		
		ArrayList alSeats = new ArrayList();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		try{
			conn =DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from busbooking where pnrnumber = ? AND busid = ? AND journeydate = ?");
			pstm.setString(1, pnrNumber);
			pstm.setInt(2, busid);
			pstm.setString(3, journeyDate);
			
			rs= pstm.executeQuery();
			
			while(rs.next()){
				
				alSeats.add(rs.getInt("seatnumber"));
			}
			
		}catch(Exception ex){
			System.out.println("ex: [getSeatListByPNR] "+ex.toString());
		}
		return alSeats;
	}
	
	
	public boolean sendTechVMail(String subject,String msg,String email){
		
		boolean isSent = false;
		SendMail sm = new SendMail();
		sm.sendTechvMail(subject,msg,email);
		isSent = true;
		
		return isSent;
	}
	
	
	
	public ArrayList getCancelTicketByDate(String date){
		
		ArrayList alCancel = new ArrayList();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try{
			
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from cancel where canceldate = ?");
			pstm.setString(1, date);
			
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				
				String cancelDate = rs.getString("canceldate");
				System.out.println("cancel date : "+cancelDate);
				
				if(cancelDate.equalsIgnoreCase(date)){
					

					Cancel cancel = new Cancel();
					cancel.setId(rs.getInt("id"));
					cancel.setCancelId(rs.getString("cancelid"));
					String pnr = rs.getString("pnrnumber");
					cancel.setBooking(userUtil.getBookingByPNR(pnr));
					cancel.setCancelDate(cancelDate);
					cancel.setRefundAmount(rs.getFloat("refundamount"));
					cancel.setPaymentStatus(rs.getString("payment"));
					cancel.setNamePerbank(rs.getString("nameperbank"));
					cancel.setBank(rs.getString("bank"));
					cancel.setIfsc(rs.getString("ifsc"));
					cancel.setAccountNumber(rs.getString("account"));
					
					if(!checkAdminBooking(pnr)){
					
						User agent = checkAgentBookingBank(pnr);
						try{
							if(agent.getRoleid() == 2){
								agent = getBankDetailsForAgent(agent.getUserid());
								cancel.setNamePerbank(agent.getNamePerBank());
								cancel.setBank(agent.getBank());
								cancel.setIfsc(agent.getIfsc());
								cancel.setAccountNumber(agent.getAccountNumber());
							}
						}catch(Exception ex){
							System.out.println("ex : "+ex.toString());
						}
						
						
						
						alCancel.add(cancel);
					}
				}
				
				
				
			}
			
		}catch(Exception e){
			System.out.println("e ; "+e.toString());
		}
		
		
		System.out.println("here "+alCancel.size());
		
		return alCancel;
		
	}
	
	public boolean checkAdminBooking(String pnr){
		
		if(checkifAdminBooking(pnr).equalsIgnoreCase("") ){
			return false;
		} else{
			return true;
		}
		
	}
	
	public User getBankDetailsForAgent(int userId){
		User u = new User();
		Connection conn  = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		try{
			
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from users where userid = ?");
			pstm.setInt(1, userId);
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				u.setUserid(rs.getInt("userid"));
				u.setUserName(rs.getString("username"));
				u.setEmail(rs.getString("email"));
				u.setMobile(rs.getLong("mobile"));
				u.setRoleid(rs.getInt("role"));
				u.setBank(rs.getString("bank"));
				u.setNamePerBank(rs.getString("nameperbank"));
				u.setIfsc(rs.getString("ifsc"));
				u.setAccountNumber(rs.getString("acc"));
				
			}
			
			
		}catch(Exception ex){
			System.out.println("sx "+ex.toString());
		}
		
		return u;
	}
	
	
	public void cleanupData(){
		
		
		ArrayList pnrList = getPNRForCleaning();
		
		//clean BookingDetails Data 
		
		cleanBookingDetails(pnrList);
		
		cleanUpBusBooking(pnrList);
		
		cleanUpAdminBooking(pnrList);
		 
	}
	
	
	
	
	public void cleanUpAdminBooking(ArrayList alPNR){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		
		try{
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("delete from adminbooking where pnr = ?");
			
			for(int i=0;i<alPNR.size();i++){
				
				String eachPNR = (String)alPNR.get(i);
				pstm.setString(1, eachPNR);
				
				pstm.addBatch();
			}
			
			pstm.executeBatch();
			
			
		}catch(Exception e){
			System.out.println("e : [] "+e.toString());
		}
		
	}
	
	
	public void cleanUpBusBooking(ArrayList alPNR){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		
		try{
			
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("delete from busbooking where pnrnumber = ?");
			
			for(int i=0;i<alPNR.size();i++){
				
				String eachPNR = (String)alPNR.get(i);
				pstm.setString(1, eachPNR);
				
				pstm.addBatch();
			}
			
			pstm.executeBatch();
			
		}catch(Exception e){
			System.out.println("e : [cleanBookingDetails] "+e.toString());
		}
		
	}
	
	
	public void cleanBookingDetails(ArrayList alPNR){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		
		try{
			
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("delete from bookingDetails where pnrnumber = ?");
			
			for(int i=0;i<alPNR.size();i++){
				
				String eachPNR = (String)alPNR.get(i);
				pstm.setString(1, eachPNR);
				
				pstm.addBatch();
			}
			
			pstm.executeBatch();
			
		}catch(Exception e){
			System.out.println("e : [cleanBookingDetails] "+e.toString());
		}
		
	}
	
	public ArrayList getPNRForCleaning(){
		
		ArrayList alPNR =  new ArrayList();
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		try{
			conn  =DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from bookingDetails");
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				String journeyDate = rs.getString("journeydate");
				
				try{
					
					String[] temp = journeyDate.split(" ");
					System.out.println(" journeyDate : "+journeyDate+" month "+temp[0]);
					
					if(temp[0].equalsIgnoreCase("Mar")){
						alPNR.add(rs.getString("pnrnumber"));
					}
					
				}catch(Exception e){
					System.out.println("e : "+e.toString());
				}
				
			}
			

		}catch(Exception e){
			System.out.println("e : [getPNRForCleaning] "+e.toString());
		}
		
		return alPNR;
		
	}
	
	
	public void cleanupPassengers(){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		ArrayList alPassengers = new ArrayList();
		try{
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from passengers");
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				String pnr = rs.getString("pnrnumber");
				String[] temp = pnr.split("-");
				
				if(temp[0].equalsIgnoreCase("NWT") || temp[0].equalsIgnoreCase("BUS")){
					alPassengers.add(pnr);
					
				}
			}
			
		
			deleteByPNRPassengers(alPassengers);
			deleteByPnrBooking(alPassengers);
			
			
		}catch(Exception e){
			System.out.println("e : "+e.toString());
		}
		
	}
	
	
	public void deleteByPNRPassengers(ArrayList alPassengers){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		try{
			conn = DBUtil.getConnection();
			pstm= conn.prepareStatement("delete from passengers where pnrnumber = ?");
			
			for(int i=0;i<alPassengers.size();i++){
				pstm.setString(1, (String)alPassengers.get(i));
				pstm.addBatch();
			}
			
			pstm.executeBatch();
			
		}catch(Exception e){
			System.out.println("e : [deleteByPNR] "+e.toString());
		}
	}
	
	
	public void deleteByPnrBooking(ArrayList alPassengers){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		try{
			conn = DBUtil.getConnection();
			pstm= conn.prepareStatement("delete from busbooking where pnrnumber = ?");
			
			for(int i=0;i<alPassengers.size();i++){
				pstm.setString(1, (String)alPassengers.get(i));
				pstm.addBatch();
			}
			
			pstm.executeBatch();
			
		}catch(Exception e){
			System.out.println("e : [deleteByPNR] "+e.toString());
		}
	}
	
	public void recharge(int userid , double newAmount){
		

		double availableBalance = 0;
		
		try{
			 availableBalance = userUtil.getAvailableBalance(userid);
			
		}catch(Exception e){
			System.out.println("e recharge: "+e.toString());
			
		}
		
		newAmount = availableBalance + newAmount;
		
		try{
			Connection con = DBUtil.getConnection();
			PreparedStatement pstm = con.prepareStatement("update users set balance = ?  where userid = ?");
			pstm.setDouble(1, newAmount);
			pstm.setInt(2, userid);
			
			pstm.executeUpdate();
			
		}catch(Exception e){
			System.out.println("e :recharge "+e.toString());
		}
		
	}
	
	
	public double getMyBalance(int userid){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		Double balance = 0.0;
		
		try{
			conn =DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from users where userid = ? ");
			pstm.setInt(1, userid);
			ResultSet rs = pstm.executeQuery();
			
			while(rs.next()){
				
				balance = rs.getDouble("balance");
			}
			
		}catch(Exception e){
			System.out.println("e :getMyBalance "+e.toString());
		}
		return balance;
	}
}
