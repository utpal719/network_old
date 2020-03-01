package com.network.util;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import javax.mail.internet.InternetAddress;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

import com.network.dbfactory.DBUtil;
import com.network.model.AdminViewPassenger;
import com.network.model.Booking;
import com.network.model.Bus;
import com.network.model.BusDetails;
import com.network.model.BusSearch;
import com.network.model.City;
import com.network.model.MiddleDestination;
import com.network.model.Passenger;
import com.network.model.User;

public class UserUtil {

	public ArrayList getAllCityName(){
		
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

		}catch(Exception e){
			System.out.println("e [getAllCityName] "+e.toString());
		}finally{
			
			try{
				pstm.close();
				conn.close();
				
			}catch(Exception e){
				System.out.println("error in closing connection ");
			}
			
		}
		
		
		return alCity;
	}
	
	
	
	public ArrayList searchBusesForParameter(String fromCity, String toCity,String startDate){
		ArrayList alBusList =  new ArrayList();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		int fromCityId = getIdByCityName(fromCity);
		int toCityId = getIdByCityName(toCity);
		
		boolean middle = false;
		
		
		
		try{
			
			 SimpleDateFormat sd = new SimpleDateFormat(
		              "MMM d, yyyy");
		     Date date = new Date();    
		     sd.setTimeZone(TimeZone.getTimeZone("IST")); 
		     String todayDate = sd.format(date);

			
			conn = DBUtil.getConnection();
		
			
			pstm = conn.prepareStatement("select * from bus where fromcityid = ? AND tocityid = ? ");
			pstm.setInt(1, fromCityId);
			pstm.setInt(2, toCityId);
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				//middle = true;
				
				//check availability
				double oldFare = 0;
				
				try{
					oldFare = rs.getDouble("oldfare");
				}catch(Exception exe){
					
				}
				
				
				BusSearch busResult = new BusSearch();
				Bus b = new Bus();
				b.setBusId(rs.getInt("busid"));
				b.setFromCity(fromCity);
				b.setToCity(toCity);
				b.setFare(rs.getDouble("fare"));
				b.setOldFare(oldFare);
				b.setSleeperFare(rs.getDouble("sleeperfare"));
				
				String strStartTime = (rs.getString("starttime"));
				String strEndTime = (rs.getString("endtime"));
				b.setStartTime(get12HrsTime(strStartTime));
				b.setEndtime(get12HrsTime(strEndTime));
				b.setSeatCapacity(rs.getInt("seatcapacity"));
				b.setBusType(rs.getString("bustype"));
				
				b.setTravelTime(getTravelTime(strStartTime,strEndTime));
				
				busResult.setBus(b);
				busResult.setMidId(0);
				
				String[] stopover = new String[1];
				stopover[0]="Khanapara";
				//stopover[1]="Khanapara";
				busResult.setStopovers(stopover);
				
			
		
			     
			    if(todayDate.equalsIgnoreCase(startDate)){
				
					if(!checkBlocking(busResult)){
					
						alBusList.add(busResult);
					}
				}else{
					alBusList.add(busResult);
				}
				
				
			}
			
			
			
			if(!middle){
				
				//if(alBusList.size() == 0){
					
					//check  in middle destination
					ArrayList alMiddles = getMiddleDestination(fromCityId,toCityId);
					
					if(alMiddles.size()>0){
						
						for(int i=0;i<alMiddles.size();i++){
							MiddleDestination mid = (MiddleDestination)alMiddles.get(i);
							
							double oldFare = 0;
							
							
							
							BusSearch busSearch = new BusSearch();
							Bus b = new Bus();
							b.setBusId(mid.getBusId());
							b.setFromCity(getCityNameById(mid.getFromCityId()));
							b.setToCity(getCityNameById(mid.getToCityId()));
							b.setFare(mid.getFare());
							b.setSleeperFare(mid.getSleeperFare());
							b.setOldFare(mid.getOldFare());
							b.setStartTime(mid.getStartTime());
							b.setEndtime(mid.getEndTime());
							b.setSeatCapacity(getSeatCapacityByBusId(b.getBusId()));
							
							//get Bus Type by bus Id
							b.setBusType(getBusTypeById(b.getBusId()));
							
							b.setTravelTime(getTravelTime(b.getStartTime(), b.getEndtime()));
							
							busSearch.setBus(b);
							busSearch.setMidId(mid.getMidId());
							
							 if(todayDate.equalsIgnoreCase(startDate)){
								if(!checkBlocking(busSearch)){
									alBusList.add(busSearch);
								}
							 }else{
								 alBusList.add(busSearch); 
							 }
						}
						
					}
					
				//}
				
			}
			
			
		}catch(Exception e){
			System.out.println("e : [searchBusesForParameter] "+e.toString());
			
		}finally{
			
			try{
				pstm.close();
				conn.close();
				
			}catch(Exception e){
				System.out.println("error in closing connection ");
			}
			
		}
		

		Collections.sort(alBusList, new Comparator<BusSearch>() {
	        @Override public int compare(BusSearch bs1, BusSearch bs2) {
	        	Bus b1 = bs1.getBus();
	        	Bus b2 = bs2.getBus();
	        	
	        	String _24B1 = get24HrsTime(b1.getStartTime());
	        	String _24B2 = get24HrsTime(b2.getStartTime());
	        	
	        	SimpleDateFormat sd = new SimpleDateFormat(
			              "HH:mm");
			     sd.setTimeZone(TimeZone.getTimeZone("IST")); 
			   
			     long diff =  0 ;
			    
			     try{
			     
			     Date startB1 = sd.parse(_24B1);
			     Date startB2 = sd.parse(_24B2);
			  
			  
			 
			      diff =  startB1.getTime() - startB2.getTime();
			     }catch(Exception e){
			    	 
			     }
 			     
  	        	return (int) diff;
	        }

	    });
		

		return alBusList;
	}
	
	
	
	public String getBusTypeById(int busId){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		String busType = "";
		
		try{
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from bus where busid = ?");
			pstm.setInt(1, busId);
			
			ResultSet rs = pstm.executeQuery();
			
			while(rs.next()){
					
				busType = rs.getString("bustype");
			}
			
			
		}catch(Exception e){
			System.out.println("e : [getBusTypeById] "+e.toString());
		}
		
		return busType;
	}
	
	
	public boolean checkBlocking(BusSearch busSearch){
		
		boolean isBlocked = false;
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		Bus b = busSearch.getBus();
		try{
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from busblock where busid = ?");
			pstm.setInt(1, b.getBusId());
			
			rs = pstm.executeQuery();
			
			String blokingTime = "";
			
			while(rs.next()){
				blokingTime = rs.getString("blocktime");
			}
			SimpleDateFormat parser = new SimpleDateFormat("HH:mm");
			Date blockT = parser.parse(blokingTime);
			Date currentTime = parser.parse(getCurrentTimeIST());
			
			if(currentTime.after(blockT)){
				isBlocked = true;
			}
			
		}catch(Exception ex){
			System.out.println("ex : [] "+ex.toString());
			
		}
		
	
		
		return isBlocked;
	}
	
	
	public String getCurrentTimeIST(){
		
		 SimpleDateFormat sd = new SimpleDateFormat(
		            "HH:mm");
		        Date date = new Date();
		        // TODO: Avoid using the abbreviations when fetching time zones.
		        // Use the full Olson zone ID instead.
		        sd.setTimeZone(TimeZone.getTimeZone("IST"));
		        
		      
		        return sd.format(date);
	}
	
	
	//get seat capacity by busid
	public int getSeatCapacityByBusId(int busId){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		int capacity = 0;
		
		try{
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from bus where busid = ?");
			pstm.setInt(1, busId);
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				capacity = rs.getInt("seatcapacity");
			}
			
		}catch(Exception ex){
			System.out.println("ex : [getSeatCapacityByBusId] "+ex.toString());
		}
		
		return capacity;
	}
	
	
	
	public ArrayList getMiddleDestination(int fromCityId,int toCityId){
		
		ArrayList alMiddleBus = new ArrayList();
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		try{
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from middledestination where fromdestinationid = ? AND todestinationid = ?");
			pstm.setInt(1, fromCityId);
			pstm.setInt(2, toCityId);
			
			rs= pstm.executeQuery();
			
			while(rs.next()){
				
				MiddleDestination mid = new MiddleDestination();
				mid.setMidId(rs.getInt("midid"));
				mid.setBusId(rs.getInt("busid"));
				mid.setFromCityId(fromCityId);
				mid.setToCityId(toCityId);
				
				double oldFare = 0;
				
				try{
					oldFare = rs.getDouble("oldfare");
				}catch(Exception exe){
					
				}
				
				mid.setOldFare(oldFare);
				
				String seats = rs.getString("seatlist"); 
				
				String[] tempSeat = seats.split(",");
				ArrayList alSeats = new ArrayList();
				for(int i=0;i<tempSeat.length;i++){
					
					alSeats.add(Integer.parseInt(tempSeat[i]));
					
				}
				
				mid.setSeatlist(alSeats);
				mid.setFare(rs.getDouble("fare"));
				mid.setSleeperFare(rs.getDouble("sleeperfare"));
				mid.setStartTime(get12HrsTime(rs.getString("starttime")));
				mid.setEndTime(get12HrsTime(rs.getString("endtime")));
				
				
				alMiddleBus.add(mid);
			}
			
		}catch(Exception ex){
			
			System.out.println("ex : [getMiddleDestination] "+ex.toString());
		}
		return alMiddleBus;
		
	}
	
	
	
	
	
	public int getIdByCityName(String cityName){
		int id = 0;
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs  = null;
		try{
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from city where cityname = ?");
			pstm.setString(1, cityName);
			
			rs= pstm.executeQuery();
			
			while(rs.next()){
				
				id = rs.getInt("id");
			}
			
		}catch(Exception e){
			System.out.println("e : [getIdByCityName] "+e.toString());
		}
		
		return id;
	}
	
	
	public String getCityNameById(int cityId){
		String cityName= "";
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs  = null;
		try{
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from city where id = ?");
			pstm.setInt(1, cityId);
			
			rs= pstm.executeQuery();
			
			while(rs.next()){
				
				cityName = rs.getString("cityname");
			}
			
		}catch(Exception e){
			System.out.println("e : [getIdByCityName] "+e.toString());
		}
		
		return cityName;
	}
	
	
	
	
	public String get12HrsTime(String _24HrsTime){
		String _12hrsFormat = "";
		 try{
	         SimpleDateFormat _24HourSDF = new SimpleDateFormat("HH:mm");
	         SimpleDateFormat _12HourSDF = new SimpleDateFormat("hh:mm a");
	         Date _24HourDt = _24HourSDF.parse(_24HrsTime);
	         
	          _12hrsFormat = _12HourSDF.format(_24HourDt);
		 }catch(Exception ex){
			 System.out.println("ex : "+ex.toString());
			 
		 }
		 return _12hrsFormat;
	}
	
	
	public String get24HrsTime(String _12HrsTime){
		String _24hrsFormat = "";
		 try{
	         SimpleDateFormat _24HourSDF = new SimpleDateFormat("HH:mm");
	         SimpleDateFormat _12HourSDF = new SimpleDateFormat("hh:mm a");
	         Date _12HourDt = _12HourSDF.parse(_12HrsTime);
	         
	          _24hrsFormat = _24HourSDF.format(_12HourDt);
		 }catch(Exception ex){
			 System.out.println("ex : "+ex.toString());
			 
		 }
		 return _24hrsFormat;
	}
	
	
	public String getTravelTime(String startTime,String endTime ){
		
		String travelTime = "";
		
		try{
			
			String[] startTemp = startTime.split(":");
			String[] endTemp = endTime.split(":");
			
			int hrsDiff = Math.abs((Integer.parseInt(startTemp[0])) - (Integer.parseInt(endTemp[0])));
			
			int minDiff = Math.abs((Integer.parseInt(startTemp[1])) - (Integer.parseInt(endTemp[1])));
			
			travelTime = hrsDiff+"h:"+minDiff+"m";
			
						
		}catch(Exception e){
			travelTime = "10h:30m";
			System.out.println("e : [getTravelTime] "+e.toString());
		}
		
		return travelTime;
	}
	
	
	public BusDetails getBusDetailsById(String journeyDate,int busId){
		
		BusDetails busDetails = new BusDetails(); 
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		
		try{
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from busbooking where busid = ? AND journeydate = ?");
			pstm.setInt(1, busId);
			pstm.setString(2, journeyDate);
				
			rs = pstm.executeQuery();
			
			
			busDetails.setBus(getBusByBusId(busId));
			
			
			ArrayList alSeats = new ArrayList();
			
			while(rs.next()){
				
				int seat = rs.getInt("seatnumber");
				
				int uuid = rs.getInt("uuid");
				if(checkPaymentForPNR(uuid)){
				  
					alSeats.add(seat);
				}
			}
		
			
			busDetails.setOccupiedSeat(alSeats);
			busDetails.setBusId(busId);
			busDetails.setJourneyDate(journeyDate);
		
			
		}catch(Exception ex){
			System.out.println("ex : "+ex.toString());
		}
	
		return busDetails;
		
	}
	
	
	
	public boolean checkPaymentForPNR(int uuid){
		
		boolean isPaid = false;
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		try{
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from bookingDetails where uuid = ?");
			pstm.setInt(1, uuid);
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				String paymentStatus = rs.getString("paymentstatus");
				if(paymentStatus.equalsIgnoreCase("SUCCESS")){
					isPaid = true;
				}else if(paymentStatus.equalsIgnoreCase("In Cash")){
					isPaid = true;
				}
			}
			
		}catch(Exception ex){
			System.out.println("ex : [checkPaymentForPNR] "+ex.toString());
		}
		
		return isPaid;
	}
	
	
	
	public BusDetails getBusDetailsByIdMiddle(String journeyDate, int busId , int midid) throws Exception{
		
		BusDetails busDetails = new BusDetails(); 
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		
		//try{
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from busbooking where busid = ? AND journeydate = ?");
			pstm.setInt(1, busId);
			pstm.setString(2, journeyDate);
				
			rs = pstm.executeQuery();
			
			
			busDetails.setBus(getBusByBusIdMiddle(busId,midid));
			
			ArrayList alSeats = new ArrayList();
			
			while(rs.next()){
				
				boolean paymentStatus = checkPaymentForPNR(rs.getInt("uuid"));
				
			
				if(paymentStatus){
					
					int seat = rs.getInt("seatnumber");
					

					
					int dbmidId = rs.getInt("midid");
					
			
					
					//if(dbmidId == 0 || dbmidId == midid){
						alSeats.add(seat);
					//}

				}
				
				
			}
		
			if(midid !=0){
				
				ArrayList alDeactiveSeat = getDeactiveSeats(busId,midid);
				
				for(int x=0;x<alDeactiveSeat.size();x++){
					
				
					if(!alSeats.contains((alDeactiveSeat).get(x))){
						alSeats.add(alDeactiveSeat.get(x));
					}
					
				}
			}
			
			busDetails.setOccupiedSeat(alSeats);
			busDetails.setBusId(busId);
			busDetails.setJourneyDate(journeyDate);
		
/*
		}catch(Exception ex){
			
			SendMail smail = new SendMail();
			smail.sendEmail("utpal719@gmail.com", "test2", "In side deactivate seat ex "+ex.toString()+" busdetails "+busDetails.getBusId());
			
			System.out.println("ex : "+ex.toString());
		}*/
	
		return busDetails;
		
	}
	
	
	public Bus getBusByBusIdMiddle(int busId, int midId){
		
		Bus b= new Bus();
		
		try{
			
			b = getBusByBusId(busId);
			MiddleDestination midDest = getMiddleDestById(midId);
			b.setFare(midDest.getFare());
			b.setSleeperFare(midDest.getSleeperFare());
			b.setFromCity(getCityNameById(midDest.getFromCityId()));
			b.setToCity(getCityNameById(midDest.getToCityId()));
			b.setStartTime(get12HrsTime(midDest.getStartTime()));
			b.setEndtime(get12HrsTime(midDest.getEndTime()));
			
		}catch(Exception ex){
			System.out.println("ex : [getBusByBusIdMiddle] "+ex.toString());
		}
		
		
		System.out.println("b : "+b.getFare()+" b "+b.getFromCity());
		
		
		return b;
		
	}
	
	
	public MiddleDestination getMiddleDestById(int  midId){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		MiddleDestination midDest = new MiddleDestination();
		
		try{
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm =conn.prepareStatement("select * from middledestination where midid = ?");
			pstm.setInt(1, midId);

			
			rs= pstm.executeQuery();

			
			while(rs.next()){
				
				midDest.setMidId(midId);			
				midDest.setFare(rs.getDouble("fare"));
				midDest.setSleeperFare(rs.getDouble("sleeperfare"));
				midDest.setStartTime(rs.getString("starttime"));
				midDest.setEndTime(rs.getString("endtime"));
				midDest.setFromCityId(rs.getInt("fromdestinationid"));
				midDest.setToCityId(rs.getInt("todestinationid"));
			}
			
	
			
		}catch(Exception ex){
			System.out.println("ex :[getMiddleDestById] "+ex.toString());
		}
		
		return midDest;
		
	}
	
	
	
	public ArrayList getDeactiveSeats(int busId , int midId){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		
		
		ArrayList alSeats = new ArrayList();
		
		ArrayList alDeactive = new ArrayList();
		
		try{
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm =conn.prepareStatement("select * from middledestination where busid = ? and midid = ?");
			pstm.setInt(1, busId);
			pstm.setInt(2, midId);
			
			rs= pstm.executeQuery();
			
			
			Bus b = getBusByBusId(busId);
			
			while(rs.next()){
				
				String seatList = rs.getString("seatlist");
				
				String[] tempSeat = seatList.split(",");
				
							
				for(int i=0; i <tempSeat.length ; i++){
					
					alSeats.add(Integer.parseInt(tempSeat[i]));
				}
			}
			
			for(int i=1;i<b.getSeatCapacity();i++){
				
			
				
				if(!alSeats.contains(new Integer(i))){
					
					alDeactive.add(i);
				}
				
			}
					
					
			
		}catch(Exception ex){
			System.out.println("ex :[getDeactiveSeats] "+ex.toString());
		}
		return alDeactive;
		
	}
	
	
	
	public Bus getBusByBusId(int busId){
		
		Bus bus = new Bus();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		try{
			
			
			conn = DBUtil.getOPenConnection();
			
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from bus where busid = ?");
			pstm.setInt(1, busId);
			rs = pstm.executeQuery();
		
			while(rs.next()){
				
				bus.setBusId(busId);
				int fromCityId = rs.getInt("fromcityid");
			
				String fromCity = getCityNameById(fromCityId);
				int toCityId = rs.getInt("tocityid");
	
				String toCity = getCityNameById(toCityId);
				
		
				
				bus.setFromCity(fromCity);
				bus.setToCity(toCity);
				bus.setFare(rs.getFloat("fare"));
				bus.setSleeperFare(rs.getDouble("sleeperfare"));
			
				bus.setSeatCapacity(rs.getInt("seatcapacity"));
				//bus.setSeatCapacity(40);
				bus.setStartTime(get12HrsTime(rs.getString("starttime")));
				bus.setEndtime(get12HrsTime(rs.getString("endtime")));
				bus.setBoardingPoints(rs.getString("boardingpoints"));
				
			}
			
		}catch(Exception e){
			
			System.out.println("e : [getBusByBusId] "+e.toString());
		}
		
		
		return bus;
	}
	
	
	public boolean validateEmail(String email){
		boolean isExist = false;
		
		try{
			
			InternetAddress intAddress = new InternetAddress(email);
			intAddress.validate();
			isExist = true;
		}catch(Exception ex){
			System.out.println("ex : "+ex.toString());
		}
		
		return isExist;
	}
	
	
	public synchronized Booking bookTicket(int busId,int noOfSeat,double totalFare,String selectedSeat,String passengerName ,String genders,String ages,String email, String mobile,String journeyDate,String fromCity, String toCity, int midId,double agentfare,User user,String boardingPoint ){
		
		Booking booking = new Booking();
		
		String msg= "Here ";
		
		
		try{
			
		//create passengers
			ArrayList alPassengers = new ArrayList();
			

			
			String[] tempPassengers = selectedSeat.split(",");
			
			String[] tempNames = passengerName.split(",");
			String[] tempAge = ages.split(",");
			String[] tempGenders = genders.split(",");
			
			
			for(int i=0;i<tempPassengers.length;i++){
			
				
				
				Passenger p = new Passenger();
				p.setPassengerName(tempNames[i]);
				p.setAge(Integer.parseInt(tempAge[i]));
				p.setGender(tempGenders[i]);
				p.setSeatNumber(Integer.parseInt(tempPassengers[i]));
				
				alPassengers.add(p);
				

				
			}
			
			
			
			
			
			
			if(alPassengers.size() == 0){
				return booking;
			}
			
			//check if the seats are available 
			
			//if(checkAvailableSeat(busId,journeyDate,tempPassengers)){
			
			if(!checkAvailableSeat(busId, journeyDate, tempPassengers)){
				
				booking.setErrorMsg("Someone else is trying to book the same ticket.");
				
				return booking;
				
			}
			
			
			
			//check Available Balace
			if(!checkAvailableBalanceUser(user , agentfare)){

				booking.setErrorMsg("Your account balance is too low to book the tickets!");
				return booking;
				
			}
			
	
				msg = msg + " seat Avaibale ";
				
				//get the PNR Number
				
				/*String pnrNumber = getSequencePNRNumber();
				
				if(pnrNumber.equalsIgnoreCase("")){
					return booking;
				}*/

				booking.setBusId(busId);
				booking.setEmail(email);
				booking.setMobile(Long.parseLong(mobile));
				booking.setJourneyDate(journeyDate);
				booking.setNoOfSeat(noOfSeat);
				booking.setPassengerList(alPassengers);
				booking.setPaymentStatus("Payment Due");
				booking.setTotdalFare(totalFare);
				booking.setFromCity(fromCity);
				booking.setToCity(toCity);
				booking.setMidId(midId);
				booking.setBoardingPoint(boardingPoint);
				booking.setUser(user);
				
				
				if(user.getRoleid() == 2){
					
					booking.setAgentFare(agentfare);
				}else{
					booking.setAgentFare(0);
				}
				
				msg=msg+"hete AT 659 "+booking.getBoardingPoint();
				
		
				
				//get Start and reporting time
				if(midId == 0){
				
				
					Bus b = getBusByBusId(busId);
			
					
					booking.setStartTime(b.getStartTime());
					booking.setReportingTime(get12HrsTime(getReportingTime(get24HrsTime(b.getStartTime()))));
	
				}else{
					
					MiddleDestination mid = getMiddleDestById(midId);
					booking.setStartTime(get12HrsTime(mid.getStartTime()));
					
					
					booking.setReportingTime(get12HrsTime(getReportingTime(mid.getStartTime())));
				}
				
				//enter the DB

					int pnrid = updateBookingTable(booking);
					
					booking.setPnrNumber("PNR-"+pnrid);
					
					
					if(pnrid != 0){
						
						if(updateBusBooking(booking,pnrid,midId)){
						
							if(!recheckValidBusTicket(booking)){
								Booking booking1 = new Booking();
								booking1.setErrorMsg("Unsuccessful Booking! Please try again");
								return booking1;
							}
							
						}else{
							
							Booking booking1 = new Booking();
							booking1.setErrorMsg("Unsuccessful Booking! Please try again");
							return booking1;
						}
						
						

							
					}else{
						Booking booking1 = new Booking();
						booking1.setErrorMsg("Unsuccessful Booking! Please try again");
						return booking1;
					}
					
	
					//Update balance 
					
					if(user.getRoleid() == 2){
						//updateAccountBalance(user , agentfare);
					}
						
					msg = msg+" userid : "+user.getRoleid();
  
					System.out.println("********** OLD BOOK TICKET ******************* ");


		}catch(Exception e){
			
			msg = msg+" e : "+e.toString();
			System.out.println("e :[bookTicket] "+e.toString());
		}
		
		if(booking.getPnrNumber() == null){
			rollBackBooking(booking);
			return null;
		}
		
		
		try{
			
			booking.setHashParam(MessageDigestUtil.generateHash(booking));
			booking.setWebServiceParam(MessageDigestUtil.generateWebServiceHash(booking));
			booking.setVasForMobileSdkHash(MessageDigestUtil.VasForMobileSdkHash(booking));
			booking.setPaymentRelatedDetailsForMobileSdkHash(MessageDigestUtil.PaymentRelatedDetailsForMobileSdkHash(booking));
			
			
		}catch(Exception e){
			
		}
		
		return booking;
	}
	

	public synchronized Booking bookTicketCash(int busId,int noOfSeat,double totalFare,String selectedSeat,String passengerName ,String genders,String ages,String email, String mobile,String journeyDate,String fromCity, String toCity, int midId,String agentfare,User user,String boardingPoint ){
		
		Booking booking = new Booking();

		
		try{
			
		//create passengers
			ArrayList alPassengers = new ArrayList();
		
			
			String[] tempPassengers = selectedSeat.split(",");
			
			String[] tempNames = passengerName.split(",");
			String[] tempAge = ages.split(",");
			String[] tempGenders = genders.split(",");
			
			
			for(int i=0;i<tempPassengers.length;i++){
				
				
				Passenger p = new Passenger();
				p.setPassengerName(tempNames[i]);
				p.setAge(Integer.parseInt(tempAge[i]));
				p.setGender(tempGenders[i]);
				p.setSeatNumber(Integer.parseInt(tempPassengers[i]));
				
				alPassengers.add(p);

			}
	
			if(alPassengers.size() == 0){
				return booking;
			}
			

			if(!checkAvailableSeat(busId, journeyDate, tempPassengers)){
	
				booking.setErrorMsg("Someone else is trying to book the same ticket.");
				
				return booking;
				
			}
		
			
			//check Available Balace
			
			if(user.getRoleid() == 2){
		
				double fareForAgent = Double.parseDouble(agentfare);
				if(!checkAvailableBalanceUser(user , fareForAgent)){
		
					booking.setErrorMsg("Your account balance is too low to book the tickets!");
					return booking;
					
				}
			}
	
			
				booking.setBusId(busId);
				booking.setEmail(email);
				booking.setMobile(Long.parseLong(mobile));
				booking.setJourneyDate(journeyDate);
				booking.setNoOfSeat(noOfSeat);
				booking.setPassengerList(alPassengers);
				booking.setPaymentStatus("In Cash");
				booking.setTotdalFare(totalFare);
				booking.setFromCity(fromCity);
				booking.setToCity(toCity);
				booking.setMidId(midId);
				booking.setBoardingPoint(boardingPoint);
				booking.setUser(user);
				
				if(user.getRoleid() == 2){
					double fareForAgent = Double.parseDouble(agentfare);
					booking.setAgentFare(fareForAgent);
				}else{
					booking.setAgentFare(0);
				}
				

				
				//get Start and reporting time
				if(midId == 0){
					
					
					Bus b = getBusByBusId(busId);
				
					booking.setStartTime(b.getStartTime());
					booking.setReportingTime(get12HrsTime(getReportingTime(get24HrsTime(b.getStartTime()))));
	
				}else{
					
					MiddleDestination mid = getMiddleDestById(midId);
					booking.setStartTime(get12HrsTime(mid.getStartTime()));
					booking.setReportingTime(get12HrsTime(getReportingTime(mid.getStartTime())));
				}
				
				//enter the DB
				
				//check for start and end time 
				
				if(booking.getStartTime().equals(null) || booking.getStartTime().equalsIgnoreCase("")){
					
					Booking booking1 = new Booking();
					booking1.setErrorMsg("Unsuccessful Booking! Please try again");
					return booking1;
					
				}else{
					
				
					int pnrid = updateBookingTable(booking);
					
					booking.setPnrNumber("PNR-"+pnrid);
					
					if(pnrid != 0){
					
						if(updateBusBooking(booking,pnrid,midId)){
							
							
							//re-check for already booked ticket
					
							if(recheckValidBusTicket(booking)){
								
								SendMail sm = new SendMail();
								sm.sentBookingConfirmation(booking);
								
								SMSUtil sms = new SMSUtil();
								String smsFormat = formatSMS(booking);
								smsFormat = smsFormat + "\r\nDownload app http://tiny.cc/nw2c0y for better experience";
								sms.sendSMS(booking.getMobile()+"", smsFormat);
								sms.sendPromotionalSMS(booking.getMobile()+"");
							}else{
								//delete the PNR
								//SendMail sm = new SendMail();
								//sm.sendEmail("utpal@techvariable.com", "eror", "msg "+booking.getPnrNumber()+" bus "+booking.getBusId()+" journey "+booking.getJourneyDate());
								rollBackBooking(booking);
								
								Booking booking1 = new Booking();
								booking1.setErrorMsg("Unsuccessful Booking! Please try again");
								return booking1;
								
							}
			
						}else{
				
							Booking booking1 = new Booking();
							booking1.setErrorMsg("Unsuccessful Booking! Please try again");
							return booking1;
							
						}
		
					}else{
					
						Booking booking1 = new Booking();
						booking1.setErrorMsg("Unsuccessful Booking! Please try again");
						return booking1;
					}
						
		
					if(user.getRoleid() == 2){
				
						updateAccountBalance(user , agentfare);
					}

				}
			
				
		}catch(Exception e){
			
			System.out.println("e :[bookTicket] "+e.toString());
		}
		
		
		if(booking.getPnrNumber() == null){
			rollBackBooking(booking);
			return null;
		}
		try{
			booking.setHashParam(MessageDigestUtil.generateHash(booking));
		}catch(Exception e){
			
		}
	
		return booking;
	}
	
	
	
	public void rollBackBooking(Booking booking){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		try{
			int uuid = 0;
			
			try{
				uuid = Integer.parseInt(booking.getPnrNumber().substring(4));
				
			}catch(Exception ex){
				
				uuid = Integer.parseInt(booking.getPnrNumber());
			}
			
			
			
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("delete from busbooking where uuid = ?");
			pstm.setInt(1, uuid);
			
			pstm.executeUpdate();
			
			//delete from bookingDetails
			deleteFromBookingDetail(uuid);
			
			
		}catch(Exception e){
			System.out.println("e : [rollBackBooking] "+e.toString());
		}
		
	}
	
	
	public void deleteFromBookingDetail(int uuid){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		try{
			
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("delete from bookingDetails where uuid = ?");
			pstm.setInt(1, uuid);
			
			pstm.executeUpdate();
			
			
		}catch(Exception e){
			System.out.println("e : [deleteFromBookingDetail] "+e.toString());
		}
		
	}
	
	
	public boolean recheckValidBusTicket(Booking booking){
		
		Connection conn = null;
	
		boolean isValid = true;
		
	
		try{
			conn = DBUtil.getConnection();
			
			
			ArrayList passList = booking.getPassengerList();
				
			for(int i=0;i < passList.size();i++){
				Passenger p = (Passenger) passList.get(i);
				
				PreparedStatement pstm = conn.prepareStatement("select * from busbooking where seatnumber = ? AND busid = ? AND journeydate = ?");
				pstm.setInt(1, p.getSeatNumber());
				pstm.setInt(2,booking.getBusId());
				pstm.setString(3, booking.getJourneyDate());
				
				ResultSet rs = pstm.executeQuery();
				
				
				while(rs.next()){
					
					//recheck for Payment Status
					
					int pUuid = rs.getInt("uuid");
					
					//check for uuid
					String dbUuid = "PNR-"+pUuid;
					
					int myUuid = 0;
					
					try{
						myUuid = Integer.parseInt(booking.getPnrNumber().substring(4));
						
					}catch(Exception e){
						
						myUuid = Integer.parseInt(booking.getPnrNumber());
					}
					
					if(dbUuid.equalsIgnoreCase(booking.getPnrNumber())){
						continue;
					}else{
						
						//check for payment status
						
						if(checkPaymentForPNR(pUuid)){
							isValid = false;	
						}else if((myUuid - pUuid) < 25){
							isValid = false;	
						}
						
						
					}
					
				
				
							
				}
				
			}
			
			
		}catch(Exception e){
			System.out.println("e : [recheckValidBusTicket] "+e.toString());
		}
		
		return isValid;
	}
	
	
	
	
	public void updateAccountBalance(User user , String agentfare){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		try{
			
			double avBalance = getAvailableBalance(user.getUserid());
			
			double newBalance = avBalance - (Double.parseDouble(agentfare));
			
		
			
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("update users set balance = ? where userid = ?");
			pstm.setDouble(1, newBalance);
			pstm.setInt(2, user.getUserid());
			
			pstm.executeUpdate();

			
		}catch(Exception e){
			System.out.println("e : [updateAccountBalance] "+e.toString());
		}
		
	}
	
	
	public boolean checkAvailableBalanceUser(User user , double agentFare){
		
		try{
		if(user.getRoleid() == 1 || user.getRoleid() == 3 || user.getRoleid() == 0){
			
			return true;
		}else{
			
			double availableBalance = getAvailableBalance(user.getUserid());
			
			//double agFare = Double.parseDouble(agentFare);
			
			if(availableBalance >= agentFare){
				return true;
			}else{
				return false;
			}
			
		}
		}catch(Exception e){
		e.printStackTrace();
			return true;
		}
		
		
	}
	
	
	
	public double getAvailableBalance(int userid){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		double availableBalance = 0;
		
		try{
			conn =DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from users where userid = ?");
			pstm.setInt(1, userid);
			
			ResultSet rs = pstm.executeQuery();
			while(rs.next()){
				
				availableBalance = rs.getDouble("balance");
			}
			
		}catch(Exception e){
			System.out.println("getAvailableBalance "+e.toString());
		}
		
		return availableBalance;
		
	}
	
	
	public boolean checkifPNRInBusBooking(String pnr){
		Connection conn = null;
		PreparedStatement pstm = null;
		boolean isExist = false;
		try{
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from busbooking where pnrnumber = ?");
			pstm.setString(1, pnr);
			
			ResultSet rs = pstm.executeQuery();
			
			while(rs.next()){
				
				String dbPNR = rs.getString("pnrnumber");
				if(dbPNR.equalsIgnoreCase(pnr)){
					isExist = true;
				}
				
			}
			
		}catch(Exception e){
			System.out.println("e : "+e.toString());
		}
		
		return isExist;
	}
	
	
	public String getPNRForDoubleCheck(int busId , String journeyDate, String selectedSeat, String mobile){
		
		String pnr = "";
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		try{
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from bookingDetails where busid = ? AND journeydate = ? AND mobile = ? ");
			
			pstm.setInt(1, busId);
			pstm.setString(2, journeyDate);
			pstm.setString(3, mobile);
			
			rs= pstm.executeQuery();
			
			String[] arr = selectedSeat.split(",");
			
		
			
			while(rs.next()){
				
				String indPNR = rs.getString("pnrnumber");
				
				Booking booking= getBookingByPNR(indPNR);
				
				ArrayList pl = booking.getPassengerList();
				
				for(int i=0;i<pl.size();i++){
					Passenger p = (Passenger) pl.get(i);
					
					int seat = p.getSeatNumber();
					
					if(selectedSeat.indexOf(new Integer(seat) ) > -1 ){
						pnr = indPNR;
					}
					
				}
				
			}
			
		}catch(Exception ex){
			System.out.println("ex [getPNRForDoubleCheck] "+ex.toString());
		}
		
		return pnr;
	}
	
	
	
	
	public void updateUserBooking(String pnr , User user){
		

		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		try{
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("insert into userbooking(user,pnrnumber) values(?,?)");
			pstm.setInt(1, user.getUserid());
			pstm.setString(2, pnr);
			
			pstm.executeUpdate();
		}catch(Exception ex){
			System.out.println("ex : [UpdateUserBooking] "+ex.toString());
		}
		
	}
	
	
	
	public void updateAgentBooking(String pnr , User user){
		Connection conn = null;
		PreparedStatement pstm = null;
		
		try{
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("insert into agentbooking(agentid,pnrnumber) values(?,?)");
			pstm.setInt(1, user.getUserid());
			pstm.setString(2, pnr);
			
			pstm.executeUpdate();
		}catch(Exception ex){
			System.out.println("ex : [updateAgentBooking] "+ex.toString());
		}
		
	}
	
	
	
	
	public void updateAdminBooking(String pnr , User user){
		Connection conn = null;
		PreparedStatement pstm = null;
		
		try{
			conn= DBUtil.getConnection();
			pstm = conn.prepareStatement("insert into adminbooking(adminid,pnr) values(?,?)");
			pstm.setInt(1, user.getUserid());
			pstm.setString(2, pnr);
			
			pstm.executeUpdate();
		}catch(Exception ex){
			System.out.println("ex : [adminbooking] "+ex.toString());
		}
		
	}
	
	
	
	public String getReportingTime(String startTime){
		
		String strReporting = "";
		
		try{
			
			String [] temp = startTime.split(":");
			if(temp[1].equalsIgnoreCase("00")){
				int newtime = Integer.parseInt(temp[0]) - 1;
				
				strReporting = newtime+":45";
				
			}else{
				int newtime = Integer.parseInt(temp[1]) - 15;
				
				strReporting = temp[0]+":"+newtime;
				
			}
		
		}catch(Exception ex){
			System.out.println("ex : "+ex.toString());
		}
		
		return strReporting;
		
	}
	
	
	public synchronized boolean checkAvailableSeat(int busId,String journeyDate, String[] selectedSeat){
		
		boolean isAvailable = true;
		Connection conn = null;
		PreparedStatement pstm = null;
		
		
		try{
			
			if(journeyDate == ""){
				isAvailable = false;
			}
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from busbooking where busid = ? and journeydate = ? and seatnumber = ?");
			
			for(int i=0;i<selectedSeat.length;i++){
				ResultSet rs = null;
				pstm.setInt(1, busId);
				pstm.setString(2, journeyDate);
				pstm.setInt(3, Integer.parseInt(selectedSeat[i]));
				
				rs = pstm.executeQuery();
				
				while(rs.next()){
					
					int pUuid = rs.getInt("uuid");
					
					boolean isPaid = checkPaymentForPNR(pUuid);
					
					//check payment
					//SendMail sm = new SendMail();
					
					if(isPaid){
						
						isAvailable = false;	
					}
					
					//sm.sendEmail("utpal@techvariable.com",isPaid +"  "+pUuid , "test "+isAvailable);
				}
			}
			
			System.out.println("is "+isAvailable);
			
		}catch(Exception ex){
			System.out.println("ex : [checkAvailableSeat] "+ex.toString());
			
		}
		
		return isAvailable;
	}
	
	
	public synchronized String getSequencePNRNumber(){
		
		String pnrNumber = "";
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		try{
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from bookingDetails");
			rs = pstm.executeQuery();
			String msg = "";
			
			String lastPNR = "";
			
			while(rs.next()){
				
				 lastPNR = rs.getString("pnrnumber");
				/*String oldPNR = rs.getString("pnrnumber");
				msg = oldPNR;
				String[] tempPNR = oldPNR.split("-");
				
				long iPNR = Long.parseLong(tempPNR[1]) + 1;
				
				msg = msg +" ipnr "+iPNR;
				
				pnrNumber = "NWT-"+iPNR;*/

			}
			
			String[] tempPNR = lastPNR.split("-");
			
			long iPNR = Long.parseLong(tempPNR[1]) + 1;
			
			/*if(iPNR == 1000){
				iPNR = 1001;
			}*/
			
			msg = msg +" ipnr "+iPNR;
			
			pnrNumber = "PNR-"+iPNR;
			
			if(checkIfPNRDouble(pnrNumber)){
				
				msg = msg+"PNR exist";
				pnrNumber = "";
			}

			
		/*	SendMail sm = new SendMail();
			sm.sendEmail("utpal719@gmail.com", "PNR in booking", msg+" pnr "+pnrNumber +"  booking return  : ");
		*/
		}catch(Exception ex){
			System.out.println("ex : [getSequencePNRNumber] "+ex.toString());
		}

		return pnrNumber;
	}
	
	
	
	public boolean checkIfPNRDouble(String pnrNumber){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		boolean isExist = false;
		
		try{
			
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from bookingDetails where pnrnumber = ?");
			pstm.setString(1, pnrNumber);
			
			ResultSet rs = pstm.executeQuery();
			
			while(rs.next()){
				isExist =  true;
			}
			
			
		}catch(Exception e){
			System.out.println("e : [checkIfPNRDouble] "+e.toString());
		}
		return isExist;
		
	}
	
	
	public boolean updateBusBooking(Booking booking,int uuid , int midid){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		boolean isEnterted = true;
		
		try{	
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("insert into busbooking (busid,journeydate,seatnumber,uuid,midid,name,gender,age) values(?,?,?,?,?,?,?,?)");
			
			ArrayList alPassengers = booking.getPassengerList();
			
			for(int i=0;i<alPassengers.size();i++){
				
				Passenger p = (Passenger)alPassengers.get(i);
				
				pstm.setInt(1, booking.getBusId());
				pstm.setString(2, booking.getJourneyDate());
				pstm.setInt(3, p.getSeatNumber());
				pstm.setInt(4, uuid);
				pstm.setInt(5, midid);
				pstm.setString(6,p.getPassengerName());
				pstm.setString(7,p.getGender());
				pstm.setInt(8, p.getAge());
				pstm.addBatch();
			}
			
			pstm.executeBatch();
			
		}catch(Exception ex){
			System.out.println("ex  :[updateBusBooking]  "+ex.toString());
			
			isEnterted = false;
		}
		
		return isEnterted;
	}  
	
	
	
	public int updateBookingTable(Booking booking){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		int bookingid= 0;
		
		try{

			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("insert into bookingDetails(busid,journeydate,email,mobile,totalfare,noofseat,paymentstatus,agentfare,tocity,fromcity,starttime,boardingpoint,userid) values(?,?,?,?,?,?,?,?,?,?,?,?,?)", PreparedStatement.RETURN_GENERATED_KEYS);
		
			pstm.setInt(1, booking.getBusId());
			pstm.setString(2, booking.getJourneyDate());
			pstm.setString(3, booking.getEmail());
			pstm.setLong(4, booking.getMobile());
			pstm.setDouble(5,booking.getTotdalFare());
			pstm.setInt(6, booking.getNoOfSeat());
			pstm.setString(7, booking.getPaymentStatus());
			try{
			pstm.setString(8, booking.getAgentFare()+"");
			}catch(Exception e){
				System.out.println("1949 "+e.toString());
				pstm.setString(8,"");
			}
			pstm.setString(9, booking.getToCity());
			pstm.setString(10, booking.getFromCity());
			pstm.setString(11, booking.getStartTime());
			pstm.setString(12, booking.getBoardingPoint());
			pstm.setInt(13, booking.getUser().getUserid());

			pstm.executeUpdate();
			
			rs = pstm.getGeneratedKeys();
			
			while(rs.next()){
				
				
				bookingid = rs.getInt(1);
				
				System.out.println("bookingid "+bookingid);
			}
			
			
		
		}catch(Exception ex){
			System.out.println("ex : [updateBookingTable] "+ex.toString());
			
		}
		
		return bookingid;
	}
	
	
	
	public boolean updatePassengerList(Booking booking){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		boolean isUpdated = true;
		try{
		
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("insert into passengers(name,gender,age,pnrnumber) values(?,?,?,?)");
			
			ArrayList alPassengers = booking.getPassengerList();
			
			for(int i=0;i<alPassengers.size();i++){
				Passenger p = (Passenger)alPassengers.get(i);
				
				pstm.setString(1, p.getPassengerName());
				pstm.setString(2, p.getGender());
				pstm.setInt(3, p.getAge());
				pstm.setString(4, booking.getPnrNumber());
				pstm.addBatch();
			}
			
			pstm.executeBatch();
			
			
		}catch(Exception ex){
			
			System.out.println("ex : [updatePassengerList] "+ex.toString());
			 isUpdated = false;
		}
		
		return isUpdated;
	}
	
	
	public boolean verifyPNRNumber(String pnrNumber){
		
		boolean isPNRExist = false;
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try{
			
			int uuid = 0;
			
			try{
				uuid = Integer.parseInt(pnrNumber.substring(4));
				
			}catch(Exception e){
				
				uuid = Integer.parseInt(pnrNumber);
			}
			
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select* from bookingDetails where uuid = ?");
			pstm.setInt(1, uuid);
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				isPNRExist = true;
			}
			
		}catch(Exception ex){
			System.out.println("ex : [verifyPNRNumber] "+ex.toString());
		}
		
		return isPNRExist;
	}
	
	
	public Booking getBookingByPNRSMS(String pnr){
		
		Booking booking = getBookingByPNR(pnr);
		SMSUtil sm = new SMSUtil();
		sm.sendSMS(booking.getMobile()+"", formatSMS(booking));
		return booking;
	}
	
	public Booking getBookingByPNREmail(String pnr){
		
		Booking booking = getBookingByPNR(pnr);
		SendMail sm = new SendMail();
		sm.sentBookingConfirmation(booking);
		return booking;
	}
	
	
	public Booking getBookingByPNR(String pnrNumber){
		
		Booking booking =  new Booking();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		try{
			
			int uuid =0 ;
			
			try{
				
				uuid = Integer.parseInt(pnrNumber.substring(4));
				
			}catch(Exception e){
				uuid = Integer.parseInt(pnrNumber);
			}
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from bookingDetails where uuid = ?");
			pstm.setInt(1, uuid);
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				booking.setBusId(rs.getInt("busid"));
				booking.setEmail(rs.getString("email"));
				booking.setMobile(rs.getLong("mobile"));
				booking.setJourneyDate(rs.getString("journeydate"));
				booking.setPaymentStatus(rs.getString("paymentstatus"));
		
				booking.setTotdalFare(rs.getDouble("totalfare"));
				booking.setPnrNumber(pnrNumber);
				booking.setFromCity(rs.getString("fromcity"));
				booking.setToCity(rs.getString("tocity"));
				booking.setStartTime(rs.getString("starttime"));
				booking.setBoardingPoint(rs.getString("boardingpoint"));
				booking.setReportingTime(get12HrsTime(getReportingTime(get24HrsTime(booking.getStartTime()))));	
				try{
				booking.setAgentFare(Double.parseDouble(rs.getString("agentfare")));
				}catch(Exception e){
					booking.setAgentFare(0);
				}
				//get Passengers
				ArrayList alPassenger = getPassengersByPNR(pnrNumber);
				booking.setPassengerList(alPassenger);
				booking.setNoOfSeat(alPassenger.size());
				booking.setUser(getUserById(rs.getInt("userid")));
				
				try{
					booking.setTransId(rs.getString("transid")+"");
				}catch(Exception e){
					System.out.println("e "+e.toString());
				}
				
				System.out.println("Email "+booking.getEmail());
			}
			
		}catch(Exception ex){
			System.out.println("ex : [getBookingByPNR] "+ex.toString());
		}
		
		return booking;
	}
	
	
	
	public Booking getBookingByPNRAndroid(String pnrNumber , int userid , String mobile){
		
		Booking booking =  new Booking();
		booking.setErrorMsg("");
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		int counter = 0;
		try{
			
			int uuid =0 ;
			
			try{
				
				uuid = Integer.parseInt(pnrNumber.substring(4));
				
			}catch(Exception e){
				uuid = Integer.parseInt(pnrNumber);
			}
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from bookingDetails where uuid = ?");
			pstm.setInt(1, uuid);
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				counter++;
				int dbUserid = rs.getInt("userid");
				long dbMobile = rs.getLong("mobile");
				
				String strDbMobile = dbMobile+"";
				
				
				if(dbUserid !=0 && userid == 0){
					booking.setErrorMsg("Please login to cancel the ticket!");
					
				}else if(userid !=0 && dbUserid == userid){
					

					booking.setBusId(rs.getInt("busid"));
					booking.setEmail(rs.getString("email"));
					booking.setMobile(dbMobile);
					booking.setJourneyDate(rs.getString("journeydate"));
					booking.setPaymentStatus(rs.getString("paymentstatus"));
			
					booking.setTotdalFare(rs.getDouble("totalfare"));
					booking.setPnrNumber(pnrNumber);
					booking.setFromCity(rs.getString("fromcity"));
					booking.setToCity(rs.getString("tocity"));
					booking.setStartTime(rs.getString("starttime"));
					booking.setBoardingPoint(rs.getString("boardingpoint"));
					booking.setReportingTime(get12HrsTime(getReportingTime(get24HrsTime(booking.getStartTime()))));	
					try{
					booking.setAgentFare(Double.parseDouble(rs.getString("agentfare")));
					}catch(Exception e){
						booking.setAgentFare(0);
					}
					//get Passengers
					ArrayList alPassenger = getPassengersByPNR(pnrNumber);
					booking.setPassengerList(alPassenger);
					booking.setNoOfSeat(alPassenger.size());
					booking.setUser(getUserById(rs.getInt("userid")));
					
					try{
						booking.setTransId(rs.getString("transid")+"");
					}catch(Exception e){
						System.out.println("e "+e.toString());
					}
					
					
					
				}else if(strDbMobile.equalsIgnoreCase(mobile)){

					
					
					booking.setBusId(rs.getInt("busid"));
					booking.setEmail(rs.getString("email"));
					booking.setMobile(dbMobile);
					booking.setJourneyDate(rs.getString("journeydate"));
					booking.setPaymentStatus(rs.getString("paymentstatus"));
			
					booking.setTotdalFare(rs.getDouble("totalfare"));
					booking.setPnrNumber(pnrNumber);
					booking.setFromCity(rs.getString("fromcity"));
					booking.setToCity(rs.getString("tocity"));
					booking.setStartTime(rs.getString("starttime"));
					booking.setBoardingPoint(rs.getString("boardingpoint"));
					booking.setReportingTime(get12HrsTime(getReportingTime(get24HrsTime(booking.getStartTime()))));	
					try{
					booking.setAgentFare(Double.parseDouble(rs.getString("agentfare")));
					}catch(Exception e){
						booking.setAgentFare(0);
					}
					//get Passengers
					ArrayList alPassenger = getPassengersByPNR(pnrNumber);
					booking.setPassengerList(alPassenger);
					booking.setNoOfSeat(alPassenger.size());
					booking.setUser(getUserById(rs.getInt("userid")));
					
					try{
						booking.setTransId(rs.getString("transid")+"");
					}catch(Exception e){
						System.out.println("e "+e.toString());
					}
					
					
					
				}else{
					
					if(userid == 0 ){
						booking.setErrorMsg("Please enter the correct mobile/pnr number");
					}else{
						booking.setErrorMsg("Please enter a correct pnr number.");
					}
					
				}
				
				

				
				
			}
			
		}catch(Exception ex){
			System.out.println("ex : [getBookingByPNR] "+ex.toString());
		}
		
		if(counter == 0){
			booking.setErrorMsg("Please enter a correct pnr number.");
		}
		
		return booking;
	}
	
	
	public ArrayList getPassengersByPNR(String pnrNumber){
		
		ArrayList alPassenger = new ArrayList();
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try{
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			
			int uuid = 0;
			
			try{
				
				String subStr = pnrNumber.substring(4);
				
			
				
				uuid = Integer.parseInt(subStr);
			}catch(Exception e){
				uuid = Integer.parseInt(pnrNumber);
			}
			
			pstm = conn.prepareStatement("select * from busbooking where uuid = ?");
			pstm.setInt(1, uuid);
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
	
				Passenger p = new Passenger();

	                p.setPassengerId(rs.getInt("bookingid"));			
					p.setPassengerName(rs.getString("name"));
					p.setAge(rs.getInt("age"));
					p.setGender(rs.getString("gender"));
				    p.setSeatNumber(rs.getInt("seatnumber"));
					alPassenger.add(p);
			
			}
			
			
			
		}catch(Exception ex){
			System.out.println("ex : [getPassengersByPNR] "+ex.toString());
		}
		
		return alPassenger;
	}
	
	
	
	public ArrayList getSeatNumbersByPNR(String pnrNumber){
		
		ArrayList alSeats = new ArrayList();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try{
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from busbooking where pnrnumber = ?");
			pstm.setString(1, pnrNumber);
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				alSeats.add(new Integer(rs.getInt("seatnumber")));
			}
			
		}catch(Exception ex){
			System.out.println("ex [getSeatNumbersByPNR] "+ex.toString());
		}
		
		
		return alSeats;
	}
	
	public String generateOTP(String pnrNumber){
		
		String pin = "";
		try{
			
			pin = generatePIN();
		
			
			//get email
			Booking b = getBookingByPNR(pnrNumber);
	
			//sent to mail
			
			SendMail sm = new SendMail();
			//sm.sentCancelOTP(pin,b.getEmail(), pnrNumber);
			
			SMSUtil sms = new SMSUtil();
			//sms.sendSMS(b.getMobile()+"", "NetWORK Travels - OTP for canceling PNR : "+pnrNumber+" is  "+pin);
			
			
		}catch(Exception ex){
			
			System.out.println("ex : [generateOTP] "+ex.toString());
		}
		
		return pin;
	}
	
	
	public String generatePIN() 
	{   
	    int x = (int)(Math.random() * 9);
	    x = x + 1;
	    String randomPIN = (x + "") + ( ((int)(Math.random()*1000)) + "" );
	    return randomPIN;
	}
	
	
	public int cancelBooking(String pnrNumber,String passengers){
		
		int refundAmt = 0;
		int id= 0 ;
		boolean isCancelled = false;
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Booking originalBooking = getBookingByPNR(pnrNumber);
		
		try{
			
			//check if a PNR Number is previous date
			
		
			
			//if(!checkIfNotStarted(pnrNumber)){
			
				
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
				pstm = conn.prepareStatement("delete from passengers where passengerid = ? AND pnrnumber = ?");
				String[] tempP = passengers.split(",");
				
				for(int i =0;i<tempP.length;i++){
					pstm.setInt(1, Integer.parseInt(tempP[i]));
					pstm.setString(2, pnrNumber);
					pstm.addBatch();
				}
				
				pstm.executeBatch();

				deleteFromBusBooking(pnrNumber,tempP);
				
				isCancelled = true;
				
				refundAmt = updateCancelTable(pnrNumber,tempP,originalBooking);
				
				Booking booking = getBookingByPNR(pnrNumber);
				
				SMSUtil sms = new SMSUtil();
				sms.sendSMS(booking.getMobile()+"", "Network Travels : \r\nYour booking with PNR : "+pnrNumber+" has been cancelled successfully.");
				
				
		//	}
		}catch(Exception ex){
			System.out.println("ex: [cancelBooking] "+ex.toString());
		}
		return refundAmt;
		
	}
	
	
	public int cancelBookingWeb(String pnrNumber,String passengers){
		
		int refundAmt = 0;
		int id= 0 ;
		boolean isCancelled = false;
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Booking originalBooking = getBookingByPNR(pnrNumber);
		
		try{
			
			
			int uuid = 0;
			
			try{
				
				uuid = Integer.parseInt(pnrNumber.substring(4));
			}catch(Exception e){
				uuid = Integer.parseInt(pnrNumber);
			}
			
			//check if a PNR Number is previous date
			
			System.out.println("*********************88");
			
			
			//check the refund policy
			 SimpleDateFormat sd = new SimpleDateFormat(
		              "HH:mm");
		     Date date = new Date();    
		     sd.setTimeZone(TimeZone.getTimeZone("IST")); 
		     String todayTime = sd.format(date);
		     
		    
	
		     String twntyfourHrsFormatStart = get24HrsTime(originalBooking.getStartTime());
		     
		     
		     
		     Date dDate = sd.parse(todayTime);
		     Date startDate = sd.parse(twntyfourHrsFormatStart);
		     
		     long diff =  startDate.getTime() - dDate.getTime();
		     
		  
		     
				int diffhours = (int) (diff / (60 * 60 * 1000));
				DecimalFormat crunchifyFormatter = new DecimalFormat("###,###");
				
	 
		     
				SimpleDateFormat sdDate = new SimpleDateFormat(
			              "MMM d, yyyy");
			         
			     sdDate.setTimeZone(TimeZone.getTimeZone("IST")); 
			     String todayDate = sdDate.format(date);	
			
			   String journeyDate = originalBooking.getJourneyDate();
			   
		
			     
			   Date toDate = sdDate.parse(todayDate);
			   Date jDate = sdDate.parse(journeyDate);
			   
			 if(todayDate.equalsIgnoreCase(journeyDate)){
				
				 int intDiff = Integer.parseInt(crunchifyFormatter.format(diffhours));

				 if(intDiff <=2){

					 return 0;
				 }
			 }			     
				
		
			 conn = DBUtil.getOPenConnection();
				if(conn == null){
					conn = DBUtil.getConnection();
				}
				pstm = conn.prepareStatement("delete from busbooking where seatnumber = ? AND uuid = ?");
				
				String[] tempP = null;
				ArrayList alPass = new ArrayList();
				
				if(passengers.indexOf(",") > -1){
					
				
			
					tempP = passengers.split(",");
					for(int x=0;x<tempP.length;x++){
						String[] eachP = tempP[x].split("\\|");

						Passenger p = new Passenger();
						p.setPassengerId(Integer.parseInt(eachP[0]));
						p.setSeatNumber(Integer.parseInt(eachP[1]));
						
						alPass.add(p);
						
					}
				}else{
					
			
					
					String[] eachP = passengers.split("\\|");
					
					Passenger p = new Passenger();
					p.setPassengerId(Integer.parseInt(eachP[0]));
					p.setSeatNumber(Integer.parseInt(eachP[1]));
					
					alPass.add(p);
					
					tempP = new String[1];
					tempP[0] = passengers;
				}
				//String[] 

				for(int i =0;i<alPass.size();i++){
					Passenger p = (Passenger)alPass.get(i);
					pstm.setInt(1, p.getSeatNumber());
					pstm.setInt(2, uuid);
					pstm.addBatch();
				}
				
				pstm.executeBatch();

				updateBookingDetailsTable(uuid , alPass);
				
				
				//deleteFromBusBookingWeb(pnrNumber,alPass);
				
				isCancelled = true;
				double newAmount = 0.0;
				
				if(originalBooking.getUser().getRoleid() == 2){
					 newAmount = (originalBooking.getAgentFare() / originalBooking.getNoOfSeat() ) * alPass.size();
					 
					 AdminUtil admutil = new AdminUtil();
						admutil.recharge(originalBooking.getUser().getUserid(), newAmount);
				
					
				}
				
				
				
				
				refundAmt = updateCancelTable(pnrNumber,tempP,originalBooking);

				Booking booking = getBookingByPNR(pnrNumber);
				
				SMSUtil sms = new SMSUtil();
				sms.sendSMS(originalBooking.getMobile()+"", "Network Travels : \r\nYour booking with PNR : "+pnrNumber+" has been cancelled successfully.For tickets booked via online payment, amount will be refunded within 15-20 working days.");
				
				
		//	}
		}catch(Exception ex){
			System.out.println("ex: [cancelBooking] "+ex.toString());
		}
		return refundAmt;
		
	}
	
	
	
public int cancelBookingAgent(String pnrNumber,String passengers , int userid){
		
		int refundAmt = 0;
		int id= 0 ;
		boolean isCancelled = false;
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Booking originalBooking = getBookingByPNR(pnrNumber);
		
		try{
			
			
			int uuid = 0;
			
			try{
				
				uuid = Integer.parseInt(pnrNumber.substring(4));
			}catch(Exception e){
				uuid = Integer.parseInt(pnrNumber);
			}
			
			//check if a PNR Number is previous date
			
			System.out.println("*********************88");
			
			
			//check the refund policy
			 SimpleDateFormat sd = new SimpleDateFormat(
		              "HH:mm");
		     Date date = new Date();    
		     sd.setTimeZone(TimeZone.getTimeZone("IST")); 
		     String todayTime = sd.format(date);
		     
		    
	
		     String twntyfourHrsFormatStart = get24HrsTime(originalBooking.getStartTime());
		     
		     
		     
		     Date dDate = sd.parse(todayTime);
		     Date startDate = sd.parse(twntyfourHrsFormatStart);
		     
		     long diff =  startDate.getTime() - dDate.getTime();
		     
		  
		     
				int diffhours = (int) (diff / (60 * 60 * 1000));
				DecimalFormat crunchifyFormatter = new DecimalFormat("###,###");
				
	 
		     
				SimpleDateFormat sdDate = new SimpleDateFormat(
			              "MMM d, yyyy");
			         
			     sdDate.setTimeZone(TimeZone.getTimeZone("IST")); 
			     String todayDate = sdDate.format(date);	
			
			   String journeyDate = originalBooking.getJourneyDate();
			   
		
			     
			   Date toDate = sdDate.parse(todayDate);
			   Date jDate = sdDate.parse(journeyDate);
			   
			 if(todayDate.equalsIgnoreCase(journeyDate)){
				
				 int intDiff = Integer.parseInt(crunchifyFormatter.format(diffhours));

				 if(intDiff <=2){

					 return 0;
				 }
			 }			     
				
		
			 conn = DBUtil.getOPenConnection();
				if(conn == null){
					conn = DBUtil.getConnection();
				}
				pstm = conn.prepareStatement("delete from busbooking where seatnumber = ? AND uuid = ?");
				
				String[] tempP = null;
				ArrayList alPass = new ArrayList();
				
				if(passengers.indexOf(",") > -1){
					
				
			
					tempP = passengers.split(",");
					for(int x=0;x<tempP.length;x++){
						String[] eachP = tempP[x].split("\\|");

						Passenger p = new Passenger();
						p.setPassengerId(Integer.parseInt(eachP[0]));
						p.setSeatNumber(Integer.parseInt(eachP[1]));
						
						alPass.add(p);
						
					}
				}else{
					
			
					
					String[] eachP = passengers.split("\\|");
					
					Passenger p = new Passenger();
					p.setPassengerId(Integer.parseInt(eachP[0]));
					p.setSeatNumber(Integer.parseInt(eachP[1]));
					
					alPass.add(p);
					
					tempP = new String[1];
					tempP[0] = passengers;
				}
				//String[] 

				for(int i =0;i<alPass.size();i++){
					Passenger p = (Passenger)alPass.get(i);
					pstm.setInt(1, p.getSeatNumber());
					pstm.setInt(2, uuid);
					pstm.addBatch();
				}
				
				pstm.executeBatch();

				updateBookingDetailsTable(uuid , alPass);
				
				
				//deleteFromBusBookingWeb(pnrNumber,alPass);
				
				isCancelled = true;
				double newAmount = 0.0;
				
				if(originalBooking.getUser().getRoleid() == 2){
					 newAmount = (originalBooking.getAgentFare() / originalBooking.getNoOfSeat() ) * alPass.size();
					 
					 AdminUtil admutil = new AdminUtil();
						admutil.recharge(originalBooking.getUser().getUserid(), newAmount);
				
					
				}
				
				
				
				
				refundAmt = updateCancelTableAgent(pnrNumber,tempP,originalBooking , userid);

				Booking booking = getBookingByPNR(pnrNumber);
				
				SMSUtil sms = new SMSUtil();
				sms.sendSMS(originalBooking.getMobile()+"", "Network Travels : \r\nYour booking with PNR : "+pnrNumber+" has been cancelled successfully.For tickets booked via online payment, amount will be refunded within 15-20 working days.");
				
				
		//	}
		}catch(Exception ex){
			System.out.println("ex: [cancelBooking] "+ex.toString());
		}
		return refundAmt;
		
	}
	
	public int cancelBookingMobile(String pnrNumber,String passengers){
		
		int refundAmt = 0;
		int id= 0 ;
		boolean isCancelled = false;
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Booking originalBooking = getBookingByPNR(pnrNumber);
		
		try{
			
			
			int uuid = 0;
			
			try{
				
				uuid = Integer.parseInt(pnrNumber.substring(4));
			}catch(Exception e){
				uuid = Integer.parseInt(pnrNumber);
			}
			
			//check if a PNR Number is previous date
			
		
			
			
			//check the refund policy
			 SimpleDateFormat sd = new SimpleDateFormat(
		              "HH:mm");
		     Date date = new Date();    
		     sd.setTimeZone(TimeZone.getTimeZone("IST")); 
		     String todayTime = sd.format(date);
		     

		     String twntyfourHrsFormatStart = get24HrsTime(originalBooking.getStartTime());
		   
		     Date dDate = sd.parse(todayTime);
		     Date startDate = sd.parse(twntyfourHrsFormatStart);
		     
		     long diff =  startDate.getTime() - dDate.getTime();

		     
				int diffhours = (int) (diff / (60 * 60 * 1000));
				DecimalFormat crunchifyFormatter = new DecimalFormat("###,###");
			
				SimpleDateFormat sdDate = new SimpleDateFormat(
			              "MMM d, yyyy");
			         
			     sdDate.setTimeZone(TimeZone.getTimeZone("IST")); 
			     String todayDate = sdDate.format(date);	
			
			   String journeyDate = originalBooking.getJourneyDate();
			   
		
			   Date toDate = sdDate.parse(todayDate);
			   Date jDate = sdDate.parse(journeyDate);
			   
			 if(todayDate.equalsIgnoreCase(journeyDate)){
				
				 int intDiff = Integer.parseInt(crunchifyFormatter.format(diffhours));

				 if(intDiff <=2){
					 
					 
					 return 0;
				 }
			 }			     
				
		
			 conn = DBUtil.getOPenConnection();
				if(conn == null){
					conn = DBUtil.getConnection();
				}
				pstm = conn.prepareStatement("delete from busbooking where bookingid = ? AND uuid = ?");
				
				String[] tempP = null;
				ArrayList alPass = new ArrayList();
				
				if(passengers.indexOf(",") > -1){
					
				

					tempP = passengers.split(",");
					for(int x=0;x<tempP.length;x++){
						/*String[] eachP = tempP[x].split("\\|");
						
						System.out.println("each P  "+eachP[0]+" seat : "+eachP[1]);*/
						Passenger p = new Passenger();
						p.setPassengerId(Integer.parseInt(tempP[x]));
						//p.setSeatNumber(Integer.parseInt(eachP[1]));
						
						alPass.add(p);
						
					}
				}else{
					
				
					
				//	String[] eachP = passengers.split("\\|");
					
					//System.out.println("each P  "+eachP[0]+" seat : "+eachP[1]);
					Passenger p = new Passenger();
					p.setPassengerId(Integer.parseInt(passengers));
					//p.setSeatNumber(Integer.parseInt(eachP[1]));
					
					alPass.add(p);
					
					tempP = new String[1];
					tempP[0] = passengers;
				}
				//String[] 

				for(int i =0;i<alPass.size();i++){
					Passenger p = (Passenger)alPass.get(i);
					pstm.setInt(1, p.getPassengerId());
					pstm.setInt(2, uuid);
					pstm.addBatch();
				}
				
				pstm.executeBatch();

				updateBookingDetailsTable(uuid , alPass);
				
				
				//deleteFromBusBookingWeb(pnrNumber,alPass);
				
				isCancelled = true;
				double newAmount = 0.0;
				
				if(originalBooking.getUser().getRoleid() == 2){
					 newAmount = (originalBooking.getAgentFare() / originalBooking.getNoOfSeat() ) * alPass.size();
					 
					 AdminUtil admutil = new AdminUtil();
						admutil.recharge(originalBooking.getUser().getUserid(), newAmount);
				
				}
				
				
				
				
				refundAmt = updateCancelTable(pnrNumber,tempP,originalBooking);

				Booking booking = getBookingByPNR(pnrNumber);
				
				SMSUtil sms = new SMSUtil();
				sms.sendSMS(originalBooking.getMobile()+"", "Network Travels : \r\nYour booking with PNR : "+pnrNumber+" has been cancelled successfully. For tickets booked via online payment, amount will be refunded within 15-20 working days.");
				
				
		//	}
		}catch(Exception ex){
			System.out.println("ex: [cancelBooking] "+ex.toString());
		}
		return refundAmt;
		
	}
	
	
	
public int cancelBookingAndroid(String pnrNumber,String passengers , int userid, String mobile){
		
		int refundAmt = 0;
		int id= 0 ;
		boolean isCancelled = false;
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Booking originalBooking = getBookingByPNR(pnrNumber);
		
		try{
			
			
			int uuid = 0;
			
			try{
				
				uuid = Integer.parseInt(pnrNumber.substring(4));
			}catch(Exception e){
				uuid = Integer.parseInt(pnrNumber);
			}
			
			//check if a PNR Number is previous date
			
			//check the refund policy
			 SimpleDateFormat sd = new SimpleDateFormat(
		              "HH:mm");
		     Date date = new Date();    
		     sd.setTimeZone(TimeZone.getTimeZone("IST")); 
		     String todayTime = sd.format(date);
		 
		     String twntyfourHrsFormatStart = get24HrsTime(originalBooking.getStartTime());
		     
		     Date dDate = sd.parse(todayTime);
		     Date startDate = sd.parse(twntyfourHrsFormatStart);
		     
		     long diff =  startDate.getTime() - dDate.getTime();
		     
		
		     
				int diffhours = (int) (diff / (60 * 60 * 1000));
				DecimalFormat crunchifyFormatter = new DecimalFormat("###,###");
				
				SimpleDateFormat sdDate = new SimpleDateFormat(
			              "MMM d, yyyy");
			         
			     sdDate.setTimeZone(TimeZone.getTimeZone("IST")); 
			     String todayDate = sdDate.format(date);	
			
			   String journeyDate = originalBooking.getJourneyDate();
			   
			 
			     
			   Date toDate = sdDate.parse(todayDate);
			   Date jDate = sdDate.parse(journeyDate);
			   
			 if(todayDate.equalsIgnoreCase(journeyDate)){
				
				 int intDiff = Integer.parseInt(crunchifyFormatter.format(diffhours));

				 if(intDiff <=2){
					 
			
					 return 0;
				 }
			 }			     
				
		
			 conn = DBUtil.getOPenConnection();
				if(conn == null){
					conn = DBUtil.getConnection();
				}
				pstm = conn.prepareStatement("delete from busbooking where bookingid = ? AND uuid = ?");
				
				String[] tempP = null;
				ArrayList alPass = new ArrayList();
				
				if(passengers.indexOf(",") > -1){
					
				
					tempP = passengers.split(",");
					for(int x=0;x<tempP.length;x++){
						/*String[] eachP = tempP[x].split("\\|");
						
						System.out.println("each P  "+eachP[0]+" seat : "+eachP[1]);*/
						Passenger p = new Passenger();
						p.setPassengerId(Integer.parseInt(tempP[x]));
						//p.setSeatNumber(Integer.parseInt(eachP[1]));
						
						alPass.add(p);
						
					}
				}else{
					
					
				//	String[] eachP = passengers.split("\\|");
					
					//System.out.println("each P  "+eachP[0]+" seat : "+eachP[1]);
					Passenger p = new Passenger();
					p.setPassengerId(Integer.parseInt(passengers));
					//p.setSeatNumber(Integer.parseInt(eachP[1]));
					
					alPass.add(p);
					
					tempP = new String[1];
					tempP[0] = passengers;
				}
				//String[] 

				for(int i =0;i<alPass.size();i++){
					Passenger p = (Passenger)alPass.get(i);
					pstm.setInt(1, p.getPassengerId());
					pstm.setInt(2, uuid);
					pstm.addBatch();
				}
				
				pstm.executeBatch();

				updateBookingDetailsTable(uuid , alPass);
				
				
				//deleteFromBusBookingWeb(pnrNumber,alPass);
				
				isCancelled = true;
				double newAmount = 0.0;
				
				if(originalBooking.getUser().getRoleid() == 2){
					 newAmount = (originalBooking.getAgentFare() / originalBooking.getNoOfSeat() ) * alPass.size();
					 
					 AdminUtil admutil = new AdminUtil();
					 admutil.recharge(originalBooking.getUser().getUserid(), newAmount);
				
				}
				
				
				refundAmt = updateCancelTableAndroid(pnrNumber,tempP,originalBooking, userid, mobile);

				Booking booking = getBookingByPNR(pnrNumber);
				
				SMSUtil sms = new SMSUtil();
				sms.sendSMS(originalBooking.getMobile()+"", "Network Travels : \r\nYour booking with PNR : "+pnrNumber+" has been cancelled successfully. For tickets booked via online payment, amount will be refunded within 15-20 working days.");
				
				
		//	}
		}catch(Exception ex){
			System.out.println("ex: [cancelBooking] "+ex.toString());
		}
		return refundAmt;
		
	}
	
	
	public void updateBookingDetailsTable(int uuid , ArrayList alPass){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		try{
			
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from bookingDetails where uuid = ?");
			pstm.setInt(1, uuid);
			
			ResultSet rs = pstm.executeQuery();
			
			int totalSeat = 0;
			
			while(rs.next()){
				
				totalSeat = rs.getInt("noofseat");
				
			}
			
			if(totalSeat > alPass.size()){
				
				int newTotal = totalSeat - alPass.size();
				
				PreparedStatement pstm1 = conn.prepareStatement("update bookingDetails set noofseat = ? where uuid = ? ");
				pstm1.setInt(1, newTotal);
				pstm1.setInt(2, uuid);
				
				pstm1.executeUpdate();
				
			}else{
				
				PreparedStatement pstm1 = conn.prepareStatement("delete from bookingDetails where uuid = ?");
				pstm1.setInt(1, uuid);
				
				pstm1.executeUpdate();
			}
			
		}catch(Exception e){
			
			System.out.println("e : [updateBookingDetailsTable] "+e.toString());
		}
		
	}
	
	

	public void deleteFromBusBookingWeb(String pnrNumber,ArrayList alPass){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		try{
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
	
			for(int i=0;i<alPass.size();i++){
				
				Passenger p = (Passenger)alPass.get(i);
				
				
				
				pstm = conn.prepareStatement("delete from busbooking where pnrnumber = '"+pnrNumber+"' and seatnumber = "+p.getSeatNumber()+" limit 1");
	/*			pstm.setString(1, pnrNumber);
				pstm.setInt(2,p.getSeatNumber());*/
				System.out.println("delete from busbooking where pnrnumber = '"+pnrNumber+"' and seatnumber = "+p.getSeatNumber()+" limit 1");
				System.out.println(pstm.executeUpdate());
			}
	
		}catch(Exception ex){
		
			System.out.println("ex : [deleteFromBusBooking] "+ex.toString());
		}
	}

	
	
public boolean updateBankDetails(String pnrNumber,String passengers,String name,String bank,String ifsc,String acnumber,int id){
		
		boolean isUpdated = false;
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		try{	
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
					pstm = conn.prepareStatement("update cancel set payment=?, nameperbank = ? ,bank = ?,ifsc = ? ,account = ? where id= ? ");
					pstm.setString(1, "pending");
					pstm.setString(2, name);
					pstm.setString(3, bank);
					pstm.setString(4, ifsc);
					pstm.setString(5, acnumber);
					pstm.setInt(6, id);
					
					pstm.executeUpdate();
					
					isUpdated = true;
				
		}catch(Exception ex){
			System.out.println("ex: [cancelBooking] "+ex.toString());
		}
		return isUpdated;
		
	}
	

public int  updateCancelTableAndroid(String pnrNumber,String[] temp,Booking originalBooking , int userid , String mobile){
	
	//Newly added for refund amount
	double refundAmount = 0.0;
	
	int id= 0;
	Connection conn = null;
	PreparedStatement pstm = null;
	ResultSet rs= null;
	String cancelid = getSequenceCancelNumber();

	try{
		
		SimpleDateFormat sd = new SimpleDateFormat(
	              "MMM d, yyyy");
	     Date date = new Date();    
	     sd.setTimeZone(TimeZone.getTimeZone("IST")); 
	     String todayDate = sd.format(date);
		
	     Date dDate = sd.parse(todayDate);
	     
	     String curentTime= new SimpleDateFormat("HH:mm").format(date);
	    
	     refundAmount=  calculateRefund(pnrNumber,temp,originalBooking);
	     
	    

	     conn = DBUtil.getOPenConnection();
		
	     if(conn == null){
			conn = DBUtil.getConnection();
	     }
		
		pstm = conn.prepareStatement("insert into cancel(cancelid,pnrnumber,canceldate,canceltime,refundamount,payment ,transid , mobile , email ,journeydate ,busid , canceluserid , cancelmobile) values(?,?,?,?,?,?,?,?,?,?,?,?,?)", PreparedStatement.RETURN_GENERATED_KEYS);
		pstm.setString(1, cancelid);
		pstm.setString(2, pnrNumber);
		pstm.setString(3, todayDate);
		pstm.setString(4, curentTime);
		pstm.setDouble(5, refundAmount);
		pstm.setString(6, "Not Intiated");
		pstm.setString(7, originalBooking.getTransId());
		pstm.setString(8, originalBooking.getMobile()+"");
		pstm.setString(9, originalBooking.getEmail());
		pstm.setString(10, originalBooking.getJourneyDate());
		pstm.setInt(11, originalBooking.getBusId());
		pstm.setInt(12, userid);
		pstm.setString(13, mobile);
		
		
		pstm.executeUpdate();
		rs = pstm.getGeneratedKeys();
		
		while(rs.next()){
			id = rs.getInt(1);
		}
	
			
		}catch(Exception ex){
			System.out.println("ex [updateCancelTable] "+ex.toString());
			
		}
		
		System.out.println("here at id : "+id);
		
		return id;
}



public int  updateCancelTable(String pnrNumber,String[] temp,Booking originalBooking ){
	
	//Newly added for refund amount
	double refundAmount = 0.0;
	
	int id= 0;
	Connection conn = null;
	PreparedStatement pstm = null;
	ResultSet rs= null;
	String cancelid = getSequenceCancelNumber();

	try{
		
		SimpleDateFormat sd = new SimpleDateFormat(
	              "MMM d, yyyy");
	     Date date = new Date();    
	     sd.setTimeZone(TimeZone.getTimeZone("IST")); 
	     String todayDate = sd.format(date);
		
	     Date dDate = sd.parse(todayDate);
	     
	     String curentTime= new SimpleDateFormat("HH:mm").format(date);
	    
	     refundAmount=  calculateRefund(pnrNumber,temp,originalBooking);
	     
	    

	     conn = DBUtil.getOPenConnection();
		
	     if(conn == null){
			conn = DBUtil.getConnection();
	     }
		
	pstm = conn.prepareStatement("insert into cancel(cancelid,pnrnumber,canceldate,canceltime,refundamount,payment ,transid , mobile , email ,journeydate ,busid) values(?,?,?,?,?,?,?,?,?,?,?)", PreparedStatement.RETURN_GENERATED_KEYS);
	pstm.setString(1, cancelid);
	pstm.setString(2, pnrNumber);
	pstm.setString(3, todayDate);
	pstm.setString(4, curentTime);
	pstm.setDouble(5, refundAmount);
	pstm.setString(6, "Not Intiated");
	pstm.setString(7, originalBooking.getTransId());
	pstm.setString(8, originalBooking.getMobile()+"");
	pstm.setString(9, originalBooking.getEmail());
	pstm.setString(10, originalBooking.getJourneyDate());
	pstm.setInt(11, originalBooking.getBusId());
	
	
	pstm.executeUpdate();
	rs = pstm.getGeneratedKeys();
	
	while(rs.next()){
		id = rs.getInt(1);
	}

		
	}catch(Exception ex){
		System.out.println("ex [updateCancelTable] "+ex.toString());
		
	}
	
	System.out.println("here at id : "+id);
	
	return id;
}


	
	
	public int  updateCancelTableAgent(String pnrNumber,String[] temp,Booking originalBooking , int userid ){
		
		//Newly added for refund amount
		double refundAmount = 0.0;
		
		int id= 0;
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs= null;
		String cancelid = getSequenceCancelNumber();

		try{
			
			SimpleDateFormat sd = new SimpleDateFormat(
		              "MMM d, yyyy");
		     Date date = new Date();    
		     sd.setTimeZone(TimeZone.getTimeZone("IST")); 
		     String todayDate = sd.format(date);
			
		     Date dDate = sd.parse(todayDate);
		     
		     String curentTime= new SimpleDateFormat("HH:mm").format(date);
		    
		     refundAmount=  calculateRefund(pnrNumber,temp,originalBooking);
		     
		    

		     conn = DBUtil.getOPenConnection();
			
		     if(conn == null){
				conn = DBUtil.getConnection();
		     }
			
		pstm = conn.prepareStatement("insert into cancel(cancelid,pnrnumber,canceldate,canceltime,refundamount,payment ,transid , mobile , email ,journeydate ,busid , canceluserid) values(?, ?,?,?,?,?,?,?,?,?,?,?)", PreparedStatement.RETURN_GENERATED_KEYS);
		pstm.setString(1, cancelid);
		pstm.setString(2, pnrNumber);
		pstm.setString(3, todayDate);
		pstm.setString(4, curentTime);
		pstm.setDouble(5, refundAmount);
		pstm.setString(6, "Not Intiated");
		pstm.setString(7, originalBooking.getTransId());
		pstm.setString(8, originalBooking.getMobile()+"");
		pstm.setString(9, originalBooking.getEmail());
		pstm.setString(10, originalBooking.getJourneyDate());
		pstm.setInt(11, originalBooking.getBusId());
		pstm.setInt(12, userid);
		
		
		pstm.executeUpdate();
		rs = pstm.getGeneratedKeys();
		
		while(rs.next()){
			id = rs.getInt(1);
		}
	
			
		}catch(Exception ex){
			System.out.println("ex [updateCancelTable] "+ex.toString());
			
		}
		
		System.out.println("here at id : "+id);
		
		return id;
	}
	

	
	
	public double calculateRefund(String pnrNumber, String[] temp, Booking originalBooking){
		
		double refundAmount = 0;
		
		double deduction = 0;
	
		try{
	
			double originalFare = originalBooking.getTotdalFare();
			
			try{
				
				System.out.println(" original are : "+originalBooking.getAgentFare());
				
				/*if(!(originalBooking.getAgentFare().equalsIgnoreCase("Direct Booking")){
					System.out.println("not directr");
					originalFare = Double.parseDouble(originalBooking.getAgentFare());
				}*/
				
			}catch(Exception ex){
			
				
				System.out.println("ex : "+ex.toString());
				originalFare = originalBooking.getTotdalFare();
			}
			
			
			
			double eachPrice = originalFare / originalBooking.getPassengerList().size();
			
			
			
			 SimpleDateFormat sd = new SimpleDateFormat(
		              "MMM d, yyyy");
		     Date date = new Date();    
		     sd.setTimeZone(TimeZone.getTimeZone("IST")); 
		     String todayDate = sd.format(date);
		     
			
		     Date dDate = sd.parse(todayDate);
		     
		     System.out.println(originalBooking.getJourneyDate());
	
		     Date journeyDate = sd.parse(originalBooking.getJourneyDate());
		     
		     String curentTime= new SimpleDateFormat("HH:mm").format(date);
     
		     long time1 = dDate.getTime();
		     long time2 = journeyDate.getTime();
		     
		     
		     if(dDate.before((journeyDate))){
		    	 
		    	 deduction = 0;
		    	 
		     }/*else if(dDate.after(journeyDate)){
		    	 deduction = 1;
		     }else{
		    	 deduction = 0.2;
		     }*//*else if(time1 == time2){
		    	 
		    	 
		    	 String startTime = originalBooking.getStartTime();
		    	 String [] startT = startTime.split(":");
		    	 int hrs1 = Integer.parseInt(startT[0]);
		    	 
		    	 String [] currT = curentTime.split(":");
		    	 int hrs2 = Integer.parseInt(currT[0]);
		    	 
		    	 int diff = Math.abs(hrs1- hrs2);
		    	 
		    	 if(diff >= 4){
		    		 deduction = 0.5;
		    	 }else {
		    		 
		    		 deduction = 1;
		    	 }
		     }*/
			
		
			
			double totalEligible = eachPrice * temp.length;
			
			totalEligible = totalEligible - (deduction * totalEligible);

			
			refundAmount = totalEligible;
			
		}catch(Exception ex){
			System.out.println("ex : [calculateRefund] "+ex.toString());
		}
		
		return refundAmount;
	}
	

	
	public void deleteFromBusBooking(String pnrNumber,String[] temp){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		try{
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
					
			for(int i=0;i<temp.length;i++){
				pstm = conn.prepareStatement("delete from busbooking where  pnrnumber = ? limit 1");
				pstm.setString(1, pnrNumber);
				pstm.executeUpdate();
			}
	
		}catch(Exception ex){
		
			System.out.println("ex : [deleteFromBusBooking] "+ex.toString());
		}
	}
	
	
	public User getUserByAuth(String userName, String pwd){
		User u = new User();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs= null;
		
		try{	
				conn = DBUtil.getConnection();
				pstm = conn.prepareStatement("select * from users where username = ? and password  = ? and status = ?");
				pstm.setString(1, userName);
				pstm.setString(2, pwd);
				pstm.setString(3, "active");
				
				rs = pstm.executeQuery();
				
				while(rs.next()){
					
					u.setUserid(rs.getInt("userid"));
					u.setUserName(userName);
					u.setEmail(rs.getString("email"));
					u.setMobile(rs.getLong("mobile"));
					u.setRoleid(rs.getInt("role"));
					u.setPercentage(rs.getDouble("percentage"));
				}
			
		}catch(Exception ex){
			System.out.println("ex : "+ex.toString());
		}
		
		return u;
	}
	
	
	public User getUserById(int userId){
		User u = new User();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs= null;
		
		try{
		
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
				pstm = conn.prepareStatement("select * from users where userid  = ? and status = ?");
				pstm.setInt(1, userId);
				pstm.setString(2, "active");
				
			
				
				rs = pstm.executeQuery();
				
				while(rs.next()){
					
					u.setUserid(rs.getInt("userid"));
					u.setUserName(rs.getString("username"));
					u.setEmail(rs.getString("email"));
					u.setMobile(rs.getLong("mobile"));
					u.setRoleid(rs.getInt("role"));
					u.setPercentage(rs.getDouble("percentage"));
				}
			
		}catch(Exception ex){
			System.out.println("ex : "+ex.toString());
		}
		
		return u;
	}
	
	
	public User getAgentUserById(int userId){
		User u = new User();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs= null;
		
		try{
		
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
				pstm = conn.prepareStatement("select * from users where userid  = ?");
				pstm.setInt(1, userId);
			
				rs = pstm.executeQuery();
				
				while(rs.next()){
					
					u.setUserid(rs.getInt("userid"));
					u.setUserName(rs.getString("username"));
					u.setEmail(rs.getString("email"));
					u.setMobile(rs.getLong("mobile"));
					u.setRoleid(rs.getInt("role"));
					u.setPercentage(rs.getDouble("percentage"));
				}
			
		}catch(Exception ex){
			System.out.println("ex : "+ex.toString());
		}
		
		return u;
	}
	
	
	public boolean checkIfNotStarted(String pnrNumber){
		
		boolean isStarted = false;
		Connection conn = null;
		PreparedStatement pstm = null;
		
		
		try{
			 Booking booking = getBookingByPNR(pnrNumber);
			 Bus bus = getBusByBusId(booking.getBusId());
			
			//get current date and time
			 SimpleDateFormat sd = new SimpleDateFormat(
		              "MMM d, EEE");
		     Date date = new Date();    
		     sd.setTimeZone(TimeZone.getTimeZone("IST")); 
		     String todayDate = sd.format(date);
			
		     Date dDate = sd.parse(todayDate);
		     
		     Date journeyDate = sd.parse(booking.getJourneyDate());
		     
		     String curentTime= new SimpleDateFormat("HH:mm").format(date);
		     
		     
		     
		     if(dDate.after(journeyDate)){
		    	 
		    	 isStarted = true;
		    	 
		     }
		   
		     
			
		}catch(Exception ex){
			
			System.out.println("ex : [checkIfNotStarted] "+ex.toString());
		}
		
		return isStarted;
		
	}
	
	
	public String getSequenceCancelNumber(){
		
		String cancelId = "";
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		try{
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from cancel order by cancelid desc limit 1");
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				String oldPNR = rs.getString("cancelid");
				
				String[] tempPNR = oldPNR.split("-");
				
				int iPNR = Integer.parseInt(tempPNR[1]) + 1;
				
				cancelId = "CNC-"+iPNR;
			}
			
			
		}catch(Exception ex){
			System.out.println("ex : [getSequencePNRNumber] "+ex.toString());
		}
		
		if(cancelId.equalsIgnoreCase("")){
			cancelId = "CNC-1000";
		}
		
		return cancelId;
	}
	
	
	public ArrayList getMyTrips(int userId){
		
		return getTripHistory(userId);
	
	}
	
	
	
	public ArrayList getTripHistory(int userId){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		ArrayList al = new ArrayList();
		
		try{
			
			conn =DBUtil.getConnection();
			pstm = conn.prepareStatement("select * from bookingDetails where userid = ? ORDER BY uuid desc limit 10");
			pstm.setInt(1, userId);
			
			ResultSet rs = pstm.executeQuery();
			
			while(rs.next()){
				
				String paymentStatus = rs.getString("paymentstatus");
				
				if(paymentStatus.equalsIgnoreCase("SUCCESS") || paymentStatus.equalsIgnoreCase("In Cash")){
					Booking booking = new Booking();
					booking.setPnrNumber("PNR-"+rs.getInt("uuid"));
					booking.setToCity(rs.getString("tocity"));
					booking.setFromCity(rs.getString("fromcity"));
					booking.setJourneyDate(rs.getString("journeydate"));
					booking.setNoOfSeat(rs.getInt("noofseat"));
					//booking.setAgentFare(rs.getString("agentfare"));
					booking.setTotdalFare(rs.getDouble("totalfare"));
					al.add(booking);
				}
				
			}
			
			
		}catch(Exception e){
			System.out.println("e : [getTripHistory] "+e.toString());
		}
		
		return al;
		
	}
	
	

	public ArrayList getAgentTripHistory(User user){
		
		ArrayList alTrips = new ArrayList();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		
		
		try{
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from agentbooking where agentid = ?");
			pstm.setInt(1, user.getUserid());
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				String pnrNumber = rs.getString("pnrnumber");
				
				alTrips.add(getBookingByPNR(pnrNumber));
			}
			
			
			
		}catch(Exception ex){
			
			System.out.println("ex : [getUserTripHistory] "+ex.toString());
		}
		
		return alTrips;
		
	}
	
	
	
	public ArrayList getUserTripHistory(User user){
		
		ArrayList alTrips = new ArrayList();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		
		
		try{
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from userbooking where user = ?");
			pstm.setInt(1, user.getUserid());
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				
				
				String pnrNumber = rs.getString("pnrnumber");
				
				alTrips.add(getBookingByPNR(pnrNumber));
			}
			
			
			
		}catch(Exception ex){
			
			System.out.println("ex : [getUserTripHistory] "+ex.toString());
		}
		
		return alTrips;
		
	}
	
	
	public String getPNRByBookingId(int bookingId){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs =  null;
		
		String pnrNumber = "";
		
		try{
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from busbooking where bookingid = ?");
			pstm.setInt(1, bookingId);
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				pnrNumber = rs.getString("pnrnumber");
		
			}
		
			
		}catch(Exception ex){
			System.out.println("ex : [getPNRByBookingId] "+ex.toString());
		}
		
		return pnrNumber;
	}
	
	
	public boolean checkUserAvailability(String username){
		
		boolean isExist = false;
		Connection conn = null;
		PreparedStatement pstm  = null;
		ResultSet rs = null;
		try{
			
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("select * from users where username = ?");
			pstm.setString(1, username);
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				isExist = true;
				
			}
			
		}catch(Exception ex){
			System.out.println("ex : [checkUserAvailability] "+ex.toString());
		}
		return isExist;
	}
	
	
	public User registerUser(String name,String email,long mobile,String username,String password){
		
		User user = new User();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		try{
			
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement("insert into users (username,password,email,mobile,role,name,status) values(?,?,?,?,?,?,?)", PreparedStatement.RETURN_GENERATED_KEYS);
			pstm.setString(1, username);
			pstm.setString(2, password);
			pstm.setString(3, email);
			pstm.setLong(4, mobile);
			pstm.setInt(5, 3);
			pstm.setString(6, name);
			pstm.setString(7, "active");
			
			pstm.executeUpdate();
			
			rs = pstm.getGeneratedKeys();
			
			while(rs.next()){
				user.setUserid(rs.getInt(1));
			}
		
			user.setUserName(username);
			user.setMobile(mobile);
			user.setEmail(email);
			user.setRoleid(3);

		}catch(Exception ex){
			System.out.println("ex : [registerUser] "+ex.toString());
		}
		
		return user;
		
	}
	 
	
	public Booking makePaymentBookingPayu(String pnr, String hash, String tansStatus) {
		
		
		int uuid = 0;
		
		try{
			uuid = Integer.parseInt(pnr.substring(4));
			
		}catch(Exception e){
			
			uuid = Integer.parseInt(pnr);
		}
		
		
		
		Booking booking=getBookingByPNR(pnr);
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		String status = "Payment Due";
		
		if(tansStatus.trim().equalsIgnoreCase("SUCCESS")){
			status = "SUCCESS";
			
			
			try{
				  
				conn = DBUtil.getOPenConnection();
				if(conn == null){
					conn = DBUtil.getConnection();
				}
				pstm = conn.prepareStatement("update bookingDetails set transid = ?,paymentstatus = ?  where uuid = ?");
				pstm.setString(1, pnr);
				pstm.setString(2, status);
				pstm.setInt(3, uuid);
				
				pstm.executeUpdate();
				
				booking.setPaymentStatus(status);
				booking.setTransId(pnr);
				
				if(	status.equalsIgnoreCase("SUCCESS")){
					
					SendMail sm = new SendMail();
					sm.sentBookingConfirmation(booking);
					
					SMSUtil sms = new SMSUtil();
					sms.sendSMS(booking.getMobile()+"", formatSMSUser(booking));
					sms.sendPromotionalSMS(booking.getMobile()+"");
					
				}
				
				
				
			}catch(Exception ex){
				System.out.println("ex : "+ex.toString());
				
			}	
			
		}else{
			status = "FAILED : "+tansStatus;
			Booking b = new Booking();
			b.setPnrNumber("PNR-"+uuid);
			
			///rollback
			rollBackBooking(b);
			
		}
		   
		
		

		return booking;
	}
	

	
	
	
	public Booking makePaymentBookingJuspaySafe(String pnr) {
		
		
		int uuid = 0;
		
		try{
			uuid = Integer.parseInt(pnr.substring(4));
			
		}catch(Exception e){
			
			uuid = Integer.parseInt(pnr);
		}
		
		
		
		
		Booking booking=getBookingByPNR(pnr);
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		String status = "Payment Due";
		String tansStatus = "";
		
		
		HttpClient client = HttpClientBuilder.create().build();
        HttpPost post = new HttpPost("https://info.payu.in/merchant/postservice.php?form=2");
        post.setHeader("Content-Type", "application/x-www-form-urlencoded");

        // Create some NameValuePair for HttpPost parameters
        List<NameValuePair> arguments = new ArrayList<NameValuePair>();
        arguments.add(new BasicNameValuePair("key", "qj6yHO"));
        arguments.add(new BasicNameValuePair("command", "verify_payment"));
        arguments.add(new BasicNameValuePair("var1", pnr));
        
        String hashNumber = MessageDigestUtil.hashCal("SHA-512", "qj6yHO|verify_payment|"+pnr+"|YpJzBjSV");
        
        arguments.add(new BasicNameValuePair("hash", hashNumber));

        try {
            post.setEntity(new UrlEncodedFormEntity(arguments));
            HttpResponse response = client.execute(post);

            // Print out the response message
            //System.out.println(EntityUtils.toString(response.getEntity()));
            String res = EntityUtils.toString(response.getEntity());
         
           JSONObject jsonObject =  new JSONObject(res);
           JSONObject  details = jsonObject.getJSONObject("transaction_details");
           JSONObject  tdetails = details.getJSONObject(pnr);
           
           tansStatus = tdetails.getString("status");
           
          
                        		
        } catch (IOException e) {
        
        	SendMail sm3 = new SendMail();
			sm3.sendEmail("utpal@techvariable.com", "User Booking", "error PNR"+ pnr+" and "+ e.toString());
        	
        }
        
        
		
	
		if(tansStatus.trim().equalsIgnoreCase("SUCCESS")){
			status = "SUCCESS";
			
			
			try{
				  
				
				conn = DBUtil.getConnection();
			
				pstm = conn.prepareStatement("update bookingDetails set transid = ?,paymentstatus = ?  where uuid = ?");
				pstm.setString(1, pnr);
				pstm.setString(2, status);
				pstm.setInt(3, uuid);
				
				pstm.executeUpdate();
				
				booking.setPaymentStatus(status);
				booking.setTransId(pnr);
				
				if(	status.equalsIgnoreCase("SUCCESS")){
					
					SendMail sm = new SendMail();
					sm.sentBookingConfirmation(booking);
					
					SMSUtil sms = new SMSUtil();
					String smsFormat = formatSMSUser(booking);
					smsFormat = smsFormat + "\r\n Call support @ 8403077666 for any query";
					sms.sendSMS(booking.getMobile()+"", smsFormat);
					sms.sendPromotionalSMS(booking.getMobile()+"");
					
				}
				
				
				
			}catch(Exception ex){
				SendMail sm2 = new SendMail();
				sm2.sendEmail("utpal@techvariable.com", "User Booking", "error in database"+ pnr+" and "+ ex.toString());
				
				
			}	
			
		}else{
			status = "FAILED : "+tansStatus;
			
			try{
			conn = DBUtil.getOPenConnection();
			if(conn == null){
				conn = DBUtil.getConnection();
			}
			pstm = conn.prepareStatement("update bookingDetails set transid = ?,paymentstatus = ?  where uuid = ?");
			pstm.setString(1, pnr);
			pstm.setString(2, status);
			pstm.setInt(3, uuid);
			
			pstm.executeUpdate();
			
			}catch(Exception e){
				
			}
		
			
			Booking b = new Booking();
			b.setPnrNumber("PNR-"+uuid);
			
			///rollback
			rollBackBooking(b);
			
			booking = new Booking();
			
		}
		 
		return booking;
	}
	
	public Booking makePaymentBooking(String pnr, String transId, String tansStatus) {
		
		
		int uuid = 0;
		
		try{
			uuid = Integer.parseInt(pnr.substring(4));
			
		}catch(Exception e){
			
			uuid = Integer.parseInt(pnr);
		}
		
		
		
		Booking booking=getBookingByPNR(pnr);
		
		Connection conn = null;
		PreparedStatement pstm = null;
		
		String status = "Payment Due";
		
		if(tansStatus.trim().equalsIgnoreCase("SUCCESS")){
			status = "SUCCESS";
			
			
			try{
				  
				conn = DBUtil.getOPenConnection();
				if(conn == null){
					conn = DBUtil.getConnection();
				}
				pstm = conn.prepareStatement("update bookingDetails set transid = ?,paymentstatus = ?  where uuid = ?");
				pstm.setString(1, transId);
				pstm.setString(2, status);
				pstm.setInt(3, uuid);
				
				pstm.executeUpdate();
				
				booking.setPaymentStatus(status);
				booking.setTransId(transId);
				
				if(	status.equalsIgnoreCase("SUCCESS")){
					
					/*SendMail sm = new SendMail();
					sm.sentBookingConfirmation(booking);*/
					
					SMSUtil sms = new SMSUtil();
					String smsFormat = formatSMSUser(booking);
					smsFormat = smsFormat + "\r\n Call support @ 8403077666 for any query";
					sms.sendSMS(booking.getMobile()+"", smsFormat);
					sms.sendPromotionalSMS(booking.getMobile()+"");
				}
				
				
				
			}catch(Exception ex){
				System.out.println("ex : "+ex.toString());
				
			}	
			
		}else{
			status = "FAILED : "+tansStatus;
			Booking b = new Booking();
			b.setPnrNumber("PNR-"+uuid);
			
			///rollback
			rollBackBooking(b);
			
		}
		   
		
		

		return booking;
	}
	
	public String formatSMSUser(Booking booking){
		
		
		String message = "";
		
		try{
			String fromCity = booking.getFromCity();
			String toCity = booking.getToCity();
			String pnr = booking.getPnrNumber();
			String passengers = "";
			String seats = "";
			ArrayList al = booking.getPassengerList();
			for(int i=0;i<al.size();i++){
				Passenger p = (Passenger)al.get(i);
				
				if(passengers.equals("")){
					passengers = p.getPassengerName();
				}else{
					passengers = passengers +", "+p.getPassengerName();
				}
				
				if(seats.equals("")){
					seats = p.getSeatNumber()+"";
				}else{
					seats = seats +", "+p.getSeatNumber();
				}
			
				
			message = "Network m-Ticket\r\n"+fromCity+" to "+toCity+"\r\nDate: "+booking.getJourneyDate()+"\r\nPNR: "+pnr+"\r\nTravelers : "+passengers+"\r\nSeats : "+seats+"\r\nDept Time : "+booking.getStartTime()+"\r\nBoarding Pt : "+booking.getBoardingPoint()+"\r\nTotal Fare: "+booking.getTotdalFare()+"\r\nGST 5% is applicable on all AC buses";	
				
			}
			
			
			
			
		}catch(Exception e){
			System.out.println("e : [formatSMS] "+e.toString());
		}
		return message;
	}
	
	public String formatSMS(Booking booking){
		
		
		String message = "";
		
		try{
			String fromCity = booking.getFromCity();
			String toCity = booking.getToCity();
			String pnr = booking.getPnrNumber();
			String passengers = "";
			String seats = "";
			ArrayList al = booking.getPassengerList();
			for(int i=0;i<al.size();i++){
				Passenger p = (Passenger)al.get(i);
				
				if(passengers.equals("")){
					passengers = p.getPassengerName();
				}else{
					passengers = passengers +", "+p.getPassengerName();
				}
				
				if(seats.equals("")){
					String updatedSeat = "";
					if(p.getSeatNumber() > 40){
						updatedSeat = "S"+(p.getSeatNumber() - 40);
					}else{
						updatedSeat = p.getSeatNumber()+"";
					}
					
					seats = updatedSeat;
				}else{
					String updatedSeat = "";
					if(p.getSeatNumber() > 40){
						updatedSeat = "S"+(p.getSeatNumber() - 40);
					}else{
						updatedSeat = p.getSeatNumber()+"";
					}
					
					seats = seats +", "+updatedSeat;
				}
			
				
			message = "Network m-Ticket\r\n"+fromCity+" to "+toCity+"\r\nDate: "+booking.getJourneyDate()+"\r\nPNR: "+pnr+"\r\nTravelers : "+passengers+"\r\nSeats : "+seats+"\r\nDept Time : "+booking.getStartTime()+"\r\nBoarding Pt : "+booking.getBoardingPoint()+"\r\nTotal Fare: "+booking.getTotdalFare()+"\r\nGST 5% is applicable on all AC buses";	
				
			}
			
			
			
			
		}catch(Exception e){
			System.out.println("e : [formatSMS] "+e.toString());
		}
		return message;
	}
	
	public double getAgentPercentage(int agentId){
		
		User u = getUserById(agentId);
		
		return u.getPercentage();
		
	}
	
}
