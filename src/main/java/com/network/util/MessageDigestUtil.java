package com.network.util;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.SecureRandom;



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
}
