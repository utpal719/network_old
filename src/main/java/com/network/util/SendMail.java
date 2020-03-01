package com.network.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.network.dbfactory.DBUtil;
import com.network.model.Booking;
import com.network.model.Passenger;



public class SendMail {

	private String email ="";
	private String password="";
	private String host="";
	private String username="";
	
	
	public void getMailSetttings(){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs= null;
		
		try{
			
			conn = DBUtil.getConnection();
			
			pstm = conn.prepareStatement("select * from mailsettings");
			
			rs = pstm.executeQuery();
			
			while(rs.next()){
				
				
				System.out.println("Here ");
				
				email = rs.getString("email");
				password = rs.getString("password");
				host = rs.getString("host");
				username = rs.getString("username");
				
				
				
			}
	
		}catch(Exception e){
			
			System.out.println("[getMailSetttings] "+e.toString());
		}
		
		
	} 
	
	
	
	public void sendEmail(String mailTo, String subject, String msg){

		try{
			
			getMailSetttings();
			 Properties props = new Properties();
		      props.put("mail.smtp.auth", "true");
		      props.put("mail.smtp.starttls.enable", "true");
		      props.put("mail.smtp.host", host);
		      props.put("mail.smtp.port", "587");
		      
		      Session session = Session.getInstance(props,
		    	      new javax.mail.Authenticator() {
		    	         protected PasswordAuthentication getPasswordAuthentication() {
		    	            return new PasswordAuthentication(username, password);
		    	         }
		    	      });
		      
		      
		      	 Message message = new MimeMessage(session);
			      
		         // Set From: header field of the header.
		         message.setFrom(new InternetAddress(email));
		         
		         message.setRecipients(Message.RecipientType.TO,
				         InternetAddress.parse(mailTo));

				         // Set Subject: header field
				         message.setSubject(subject);

			
				         
				         message.setContent(msg ,"text/html");
				         
				         Transport.send(message);
					
		}catch(Exception e){
			System.out.println("e : "+e.toString());
			
		}
		
		
	}
	
	
	
	public void sentBookingConfirmation(Booking booking){
		
		
		try{
			
			ArrayList alPassengers = booking.getPassengerList();
			
			Passenger firstPassenger = (Passenger)alPassengers.get(0);
			long mobile = booking.getMobile();
			int noOfSeat = booking.getNoOfSeat();
			
			String msgHeader = "<div><table><tr><td><table style='overflow: visible; text-align:left; font-variant: normal; font-weight: normal;font-size: 14px;background-color: fff;line-height: 20px;font-family: Asap, sans-serif;color: #333;padding: 0;font-style: normal; width:800px;'><tbody><tr><td colspan='6'></td></tr><tr><td style='margin: 0 20px 0 0; padding: 0 15px 0 0; width:1%;'><div style='display:inline-block; border-right: 1px solid #ccc; margin:0 0 8px 0;'><img style='padding: 10px;' src='http://techvariable.com/database/logo.png' alt='networklogo'></div></td><td style='font-size: 30px; margin: 0; padding: 3px; width:1%; '>eTICKET</td><td colspan='3'></td><td style='/*border-bottom:1px solid #ccc;*/ width: 35%; padding: 0; margin: 0; text-align: right;'><p style='font-weight: bold; margin: 0 0 5px; padding: 0;'>"+firstPassenger.getPassengerName()+"</p><p style='margin: 0; padding: 0; '><span id='#'>+91 "+mobile+"</span></p><p style='margin: 0; padding: 0; '>No. of seat "+noOfSeat+"</p></td></tr><tr><td colspan='6'><hr style='border-top: 0px solid #ccc;margin-top:-5px;'></td></tr><tr style='height: 60px;overflow: hidden;margin-top: 20px;padding: 0 0 5px;'><td colspan='4' style='border-bottom:1px solid #FFCC00; width:50%;'><div style='font-size: 22px;'><span style='display:-moz-inline-stack;display:inline-block;zoom:1;*display:inline; margin: 0 0 7px 0; font-weight: bold; padding: 0;'><span id='#'>"+booking.getFromCity()+"</span></span> <span style='display:-moz-inline-stack;display:inline-block;zoom:1;*display:inline; margin-right:10px;margin-left:10px;margin-top:100px;'><img src='http://techvariable.com/database/arrow.png'></span><span style='display:-moz-inline-stack;display:inline-block;zoom:1;*display:inline; margin: 0 0 7px 0; font-weight: bold; padding: 0; margin-right: 19px;'><span id='#'>"+booking.getToCity()+"</span></span><span><span id='#'>"+booking.getJourneyDate()+"</span></span></div></td><td colspan='2' style='border-bottom:1px solid #FFCC00; width:15%; text-align: right;'><p style='font-size: 12px; font-weight: bold; margin: 0; padding: 0;'>PNR NO: <span id='#'>"+booking.getPnrNumber()+"</span> </p><p style='font-size: 12px; margin: 0; padding: 0;'></p></td></tr></tbody></table>";
			
			String travelDetails = "<table style='overflow: visible; text-align:left; font-variant: normal; font-weight: normal;font-size: 14px;background-color: fff;line-height: 20px;font-family: Asap, sans-serif;color: #333;padding: 0;font-style: normal; width:800px;'><tbody><tr style='margin: 0; padding: 0;'><td style='width:25%; font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;'><p style='font-weight: bold; margin: 0 0 5px; padding: 0;text-transform:capitalize;'><span id='#'>Network Travels</span></p> <span style='font-size: 12px; color: #999; margin: 0; padding: 0;'><span id='#'></span></span></td><td style='width:25%; font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;'><p style='font-weight: 700; margin: 0 0 5px; padding: 0;'> <span id='#'>"+booking.getReportingTime()+"</span></p><span style='font-size: 12px; color: #999; margin: 0; padding: 0;'>Reporting time</span>  </td><td style='width: 25%;font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;'><p style='font-weight: 700; margin: 0 0 5px; padding: 0;'><span id='#'>"+booking.getStartTime()+"</span></p><span style='font-size: 12px; color: #999; margin: 0; padding: 0;'>Departure time</span>  </td><td style=' width:25%;font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;'><p style='font-weight: 700; margin: 0 0 5px; padding: 0;'><span id='#'>"+booking.getNoOfSeat()+"</span></p><span style='font-size: 12px; color: #999; margin: 0; padding: 0;'>Number of seat</span> </td></tr><tr style='margin: 0; padding: 0;'><td style='font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;'><p style='font-weight: 700; margin: 0 0 5px; padding: 0;'>Boarding point details</p> </td><td style='font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;'><p style='font-weight: 700; margin: 0 0 5px; padding: 0;'><span id='#'>"+booking.getBoardingPoint()+"</span></p><span style='font-size: 12px; color: #999; margin: 0; padding: 0;'>Location</span>  </td><td style='font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;'><p style='font-weight: 700; margin: 0 0 5px; padding: 0;'><span id='#'>"+booking.getBoardingPoint()+"</span></p><span style='font-size: 12px; color: #999; margin: 0; padding: 0;'>Landmark</span>  </td><td style='font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;'><p style='font-weight: 700; margin: 0 0 5px; padding: 0;'><span id='#'></span></p></td></tr><tr><td colspan='4'></td></tr></tbody></table>";
			
			String passengerHeader = "<table style='overflow: visible; text-align:left; font-variant: normal; font-weight: normal;font-size: 14px;background-color: fff;line-height: 20px;font-family: Asap, sans-serif;color: #333;padding: 0;font-style: normal; width:800px;'><tbody><tr style='margin: 0 0 20px 0; padding: 0; overflow: hidden;'><td colspan='6' style='border-bottom:1px solid #e0e0e0'><ul style='list-style:none;margin:0; padding:0;'></ul></td></tr><span style='display:-moz-inline-stack;display:inline-block;zoom:1;*display:inline; margin: 0 0 7px 0; font-weight: bold; padding: 0;'><span id='#'>Passenger Details:</span></span>";
			
			String passengers = "";
			
			for(int i =0; i <alPassengers.size();i++){
				
				Passenger p = (Passenger)alPassengers.get(i);
				String updatedSeatNumber = p.getSeatNumber()+"";
				if(p.getSeatNumber() > 40){
					updatedSeatNumber = "S"+ (p.getSeatNumber() - 40) ;
				}
				
				if(passengers.equalsIgnoreCase("")){
					passengers = "<tr style='margin: 0; padding: 0;'><td style='font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;width:50%;'><p style='font-weight: 700; margin: 0 0 5px; padding: 0;'>"+p.getPassengerName()+"</p> <span style='font-size: 12px; color: #999; margin: 0; padding: 0;'>"+p.getGender()+"</span>  </td><td style='font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;'><p style='font-weight: 700; margin: 0 0 5px; padding: 0;'><span id='#'>"+p.getAge()+"</span></p><span style='font-size: 12px; color: #999; margin: 0; padding: 0;'>Age</span> </td><td style='font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;'><p style='font-weight: 700; margin: 0 0 5px; padding: 0;'><span id='#'>"+updatedSeatNumber+"</span></p><span style='font-size: 12px; color: #999; margin: 0; padding: 0;'>Seat Number</span>  </td></tr>";
					
				}else{
					passengers = passengers+"<tr style='margin: 0; padding: 0;'><td style='font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;width:50%;'><p style='font-weight: 700; margin: 0 0 5px; padding: 0;'>"+p.getPassengerName()+"</p> <span style='font-size: 12px; color: #999; margin: 0; padding: 0;'>"+p.getGender()+"</span>  </td><td style='font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;'><p style='font-weight: 700; margin: 0 0 5px; padding: 0;'><span id='#'>"+p.getAge()+"</span></p><span style='font-size: 12px; color: #999; margin: 0; padding: 0;'>Age</span> </td><td style='font-size: 14px; margin: 0; padding: 10px; border-bottom:1px solid #e0e0e0; vertical-align: middle;'><p style='font-weight: 700; margin: 0 0 5px; padding: 0;'><span id='#'>"+updatedSeatNumber+"</span></p><span style='font-size: 12px; color: #999; margin: 0; padding: 0;'>Seat Number</span>  </td></tr>";
					
				}
				
			}
			
			String fareDetails = "<tr style=' margin: 0 0 20px; padding: 0;'><td><span id='#'>NOTE : This operator accepts mTicket, you need not carry a print out</span></td></tr><tr style=' margin: 0 0 20px; padding: 0;'><td></td><td colspan='6' style='margin: 0; padding: 5px; text-align: right;'><p style='font-size: 18px; font-weight: 700; margin: 0; padding: 0;'><span style='font-size: 12px; margin: 0 10px 0 0; padding: 0;'>Total Fare :</span><span id='#'>Rs. "+booking.getTotdalFare()+"</span></p><p style='font-size: 12px; color: #999; margin: 0; padding: 0;'><span id='#'>(Inclusive of  all Taxes)</span></p><p style='font-size: 13px; font-weight: 700; margin: 0; margin-top: 5px;'></p></td></tr></tbody></table>";
			
			String footer = "<table style='width:100%'><tr id='#'><td><a href='#' target='_blank'><img src='http://techvariable.com/database/banner.png' width='800'></a></td></tr></table><table cellspacing='3' style='overflow: visible; text-align:left; font-variant: normal; font-weight: normal;font-size: 14px;background-color: fff;line-height: 20px;font-family: Asap, sans-serif;color: #333;padding: 0;font-style: normal; width:800px;'><tbody><tr id='#'><td style='width:40%;'><hr style='  /*border-top: 3px solid #333;*/ height:3px; background-color: #333;width:103%;'>		<div style=' background: #fff; width: 176px; text-align: center; '>Cancellation Policy</div></td><td style='width:41%;'><hr style=' height:3px; background-color: #333; width:103%;'></td></tr></tbody></table><table style='overflow: visible; text-align:left; font-variant: normal; font-weight: normal;font-size: 14px;background-color: fff;font-family: Asap, sans-serif;color: #333;padding: 0;font-style: normal; width:800px;'><tbody><tr><td colspan='3'><span style='font-size: 18px; color: #333; margin: 0; padding: 0;'>Whom should i call?</span></td></tr><tr style='margin: 0 0 10px; padding: 0;'><td style='border-bottom:1px solid #e0e0e0;  padding-bottom: 10px;'><p style='font-size: 12px; font-weight: 700; margin: 0; color: #333; padding: 0;'>For boarding point related</p></td><td style='border-bottom:1px solid #e0e0e0;  padding-bottom: 10px;'><p style='font-size: 12px; font-weight: 700; margin: 0; color: #333; padding: 0;'>For time related</p><span style='margin: 0; padding: 0; text-align: right;'><span id='#'>8811079999/ 7086093241</span></span></td>  <td style='border-bottom:1px solid #e0e0e0;  padding-bottom: 10px;'> <p style='font-size: 12px; font-weight: 700; margin: 0; color: #333; padding: 0;'>For cancellation and refunds related</p><span style='font-size: 12px; color: #333; margin: 0; padding: 0;'>Click on this  <a href='#'>link</a> for hassle free online cancellation</span></td><td style='border-bottom:1px solid #e0e0e0;  padding-bottom: 10px;'><p style='font-size: 12px; font-weight: 700; margin: 0; color: #333; padding: 0;'>For all queries</p>	<span style='font-size: 12px; color: #333; margin: 0; padding: 0;'><a href='#'>write</a> to us</span></td></tr></tbody></table></td></tr></table></div>";
			
			String msg = msgHeader+travelDetails+passengerHeader+passengers+fareDetails+footer;
			
			sendEmail(booking.getEmail(), "Network Travels : Booking confirmation for PNR :"+booking.getPnrNumber(), msg);
			
		}catch(Exception ex){
			
			System.out.println("ex [sentBookingConfirmation] "+ex.toString());
		}
		
	}
	
	
	public void sentCancelOTP(String otp, String email,String pnr){
		
		try{
			sendEmail(email, "Network Travels :OTP for Canceliing ticket :"+pnr, otp);
			
		}catch(Exception ex){
			System.out.println("ex : [sentCancelOTP] "+ex.toString());
		}
	}
		
	public void sendTechvMail(String subject,String msg,String email){
		
		sendEmail(email, subject, msg);
		
		
	}
	
}
