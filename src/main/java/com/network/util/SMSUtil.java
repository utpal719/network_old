package com.network.util;

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

  
public class SMSUtil {


	public void sendSMS(String number,String msg){
		
	//	System.out.println(" number : "+number);
	//	System.out.println("sendSMS : "+msg);
		msg= "'"+msg+"'";
		try{
			
		//String url = "http://trans.instaclicksms.in/sendsms.jsp?user=network&password=12travel&senderid=NTWORK&mobiles="+ URLEncoder.encode(number, "UTF-8")+"&sms="+ URLEncoder.encode(msg, "UTF-8");
		String url = "http://t.instaclicksms.in/sendsms.jsp?user=network&password=f0a7916dddXX&&senderid=NTWORK&mobiles="+ URLEncoder.encode(number, "UTF-8")+"&sms="+ URLEncoder.encode(msg, "UTF-8");
		//String encodedURL=java.net.URLEncoder.encode(url,"UTF-8");
		//System.out.println(url);	
		
			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();

			// optional default is GET
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			
		//	System.out.println("responds Code : "+responseCode);
			
		}catch(Exception e){
			System.out.println("e : [sendSMS] "+e.toString());
		}
	
	}
	
	public void sendPromotionalSMS(String number ){

		String msg= "'Follow us on https://www.facebook.com/travelwithnetwork and https://www.instagram.com/network.travels for exciting offers'";
		try{
			
		//String url = "http://trans.instaclicksms.in/sendsms.jsp?user=network&password=12travel&senderid=NTWORK&mobiles="+ URLEncoder.encode(number, "UTF-8")+"&sms="+ URLEncoder.encode(msg, "UTF-8");
		String url = "http://t.instaclicksms.in/sendsms.jsp?user=network&password=f0a7916dddXX&&senderid=NTWORK&mobiles="+ URLEncoder.encode(number, "UTF-8")+"&sms="+ URLEncoder.encode(msg, "UTF-8");
		//String encodedURL=java.net.URLEncoder.encode(url,"UTF-8");
		//System.out.println(url);	
		
			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();

			// optional default is GET
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			
			//System.out.println("responds Code : "+responseCode);
			
		}catch(Exception e){
			System.out.println("e : [sendSMS] "+e.toString());
		}
	
	}
	
	

	
}
