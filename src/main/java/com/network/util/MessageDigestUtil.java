package com.network.util;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.ArrayList;

import com.network.model.Booking;
import com.network.model.Passenger;



public class MessageDigestUtil {
	

		public static String doMessageDigest(String str) {
			String md5 = new String();
			try {
				MessageDigest messageDigest = MessageDigest.getInstance("MD5");
				messageDigest.update(str.getBytes(), 0, str.length());
				md5 = new BigInteger(1, messageDigest.digest()).toString(16);

			} catch (Exception e) {
				System.out.println("e "+e.toString());
			}
			return md5;
		}

		public static String randomGenerator(){
			String randomNumber = "ABcFssf555";
			try {
				int maxpassLength = 12;
				SecureRandom wheel = SecureRandom.getInstance("SHA1PRNG");
				StringBuffer sbf = new StringBuffer();

				char[] alphaNumberic = new char[] { 'A', 'B', 'C', 'D', 'E', 'F',
						'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
						'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd',
						'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
						'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '1', '2',
						'3', '4', '5', '6', '7', '8', '9', '0' };

				for (int i = 0; i < maxpassLength; i++) {
					int random = wheel.nextInt(alphaNumberic.length);
					sbf.append(alphaNumberic[random]);
				}
				randomNumber = sbf.toString();
			} catch (Exception e) {
				System.out.println("e : "+e.toString());
			}
			return randomNumber;
		}
		
		
		public static String generateHash(Booking booking){
			
			String hash = "";
			String random = randomGenerator();
			try{
				ArrayList passengers = booking.getPassengerList();
				Passenger name = (Passenger)passengers.get(0);
				
				
				String hashString = "qj6yHO"+"|"+booking.getPnrNumber()+"|"+booking.getTotdalFare()+"|"+booking.getBusId()+"_"+booking.getJourneyDate()+"|"+name.getPassengerName()+"|"+booking.getEmail()+"|||||||||||YpJzBjSV";
				
				
				hash = hashCal("SHA-512", hashString);
				
				
				
			}catch(Exception e){
				
			}
			
			return hash;
			
		}
		
		public static String generateWebServiceHash(Booking booking){
			
			String hash = "";
			String random = randomGenerator();
			try{
				String hashString = "qj6yHO|verify_payment|default|MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCgYZkAlJKnAIG0OqE0wgdQyIW6104b6uHneMBBpKctKGal+xUb6SFXi3pJCAahkQKKnVQyFGqUSYzEco8GdgSYc4nLdfzxtTnUx+Ll0RcQfs3sRR35gFdHkeUw3n/SBiZhU+EUu6ehfgWSNxot9sIMlwbxAxOKGiwotZ4LcRNccPskHE6Rc1hmbfOx1h7hfmfce6sxtDxdrDNfJzOb68GmEutS4iFnaCkO515OWIM+mK5czYWsknYU9DSK4Vq3cp8FbQUPeq+kC2mzXd3s/CKui8olVawgiIfe7NGL769/G7t/w+0xVro86El9YBwdmKwGs+YhBmVuRuyBDzXNMJJrAgMBAAECggEAE4dOxg9RPByHrpZlArONiHyiK/oDfMrA7xp47oVKBemhdhx4mYltkedd4H6lsA6kLJSzp9VslNnP1ivM1pCQRq/q22dmgVf7zrj4G9u130BReq9/0t2ZwxE0wxqUndI54igAhDHFW5iovQEQowAk6LuLENW7D1nYfqx+rg36uYqm6j96sSsgUfAEq04hbzEvKzHnTp8FCuURDZ0fPQyAAmvUTHGQPEqGnBNgZiT2ANlF4FpINqf0NU/RjppCP2MDbLivAPGlzI2zz7K2AP7+wVnbyP7ghuaXoRejgJjqHtYn7bqG13sgy/2PNc0iQr1ltpByrXRav+68kprb+pDBYQKBgQDRjFl+H6q+wZ63fwy3LcP58qRRpE7c8RCjC3uaxW8R9rZ6sw5/uYFu9eW6pDUi0/QuJBRGv1zP9NEfMfHpokayGjOKLBXKh4jXWFL6CwFTWXVlJkMq/1HC4VjetzQWEEDZsQZUhqGNaEMKCrBfpEoySGucd6/Cx/2IoAJqaGTtDQKBgQDD7xIWGhUIGAfei8BmHqnttXOxTpKNbhRxknpLZAiFoWEZvgz4G6fBtqYhoHhy1jLZew91j6iIUINcOyu5qNQQWAl/Mu6fnoPX3E8aK/0grTljv/s6wL61WHPZanhFpcR3LTv5WzbFLPuiJa7WA4TeefJF4Q+KALSFlZ2V93FPVwKBgQDPXhvF82KOKZ9+qW0U7WZOOG+iF36vqKO1Jgzo6c7zsPl+TSng/dv3ycHQxOWMlMHE05F5PbCEXxp/y3ZBpYRehg1RBDWAWkXyDYb3yOJD8Hh7Y7T+nPH1b/n5VMVnvCfhBg1komLHRFFrY46M51FBl2dezRaTJERi6y3YzXxrFQKBgDcx++haBJ65Fk5tFBAwhzI9sY+7ULGi1wN/fhAK6BOs+Iul7EVglQuPBpHmgMfo6340mpBFnfZ4p+itio3Mr6DDDDnXAT3aC84dc/MtfStdYRNmm8FbVt4DQu92fNcx8XyZM5H1TiKRn3l4IB6N8zoxJDznP9dih3gyQ6hhgnwVAoGBAKMI7zh+xghTY1h1YzC9fVXjXcmwwe/pc2y+NZdnyECzToKTHw/SNme1FN2ztmnbbYY6oIqQ2vURV4Rf2kQTkEzXN43tUKkTDdPatMrl4SDV+AYTR9Ihc+nBJRUXQxe8JrtlVUfPX9lcoOVLp6qfTDinMmEt0tt6NajWN3HL0WCk";
				
				
				hash = hashCal("SHA-512", hashString);
				
			}catch(Exception e){
				
			}
			
			return hash;
		}
		
		public static String VasForMobileSdkHash(Booking booking){
			
			String hash = "";
			String random = randomGenerator();
			try{
				String hashString = "qj6yHO|vas_for_mobile_sdk|default|YpJzBjSV";
				
				hash = hashCal("SHA-512", hashString);
				
			}catch(Exception e){
				
			}
			
			return hash;
		}
		
	   public static String PaymentRelatedDetailsForMobileSdkHash(Booking booking){
			
			String hash = "";
			String random = randomGenerator();
			try{
				String hashString = "qj6yHO|payment_related_details_for_mobile_sdk|default|YpJzBjSV";
				
				hash = hashCal("SHA-512", hashString);
				
			}catch(Exception e){
				
			}
			
			return hash;
		}
		
		
		
		public static String hashCal(String type, String hashString) {
			
			
			StringBuilder hash = new StringBuilder();
			MessageDigest messageDigest = null;
			try {
				messageDigest = MessageDigest.getInstance(type);
				messageDigest.update(hashString.getBytes());
				byte[] mdbytes = messageDigest.digest();
				for (byte hashByte : mdbytes) {
					 hash.append(Integer.toString((hashByte & 0xff) + 0x100, 16).substring(1));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
			return hash.toString();
		}
}
