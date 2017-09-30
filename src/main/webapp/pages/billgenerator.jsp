<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.text.Format" %>  
<%@page import="javax.crypto.Mac" %>   
<%@page import="javax.crypto.spec.SecretKeySpec" %>   
<%@page import="java.util.Random" %>     

<%  
response.setContentType("application/json");      
String accessKey = "XWW6V0U68SILDOY021CZ";     
String secretKey = "59b3e2860b097d5db5696e8988c31bd12ea59707";     
String returnUrl = "https://nwt-techv.rhcloud.com/pages/returnurl.jsp";     
String txnID = String.valueOf(System.currentTimeMillis());     
String amount = request.getParameter("amount");     
String dataString = "merchantAccessKey=" + accessKey + "&transactionId=" + txnID + "&amount=" + amount;    
SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey.getBytes(), "HmacSHA1");    
Mac mac = Mac.getInstance("HmacSHA1");         
mac.init(secretKeySpec);       
byte []hmacArr = mac.doFinal(dataString.getBytes());    
StringBuilder build = new StringBuilder();     
 for (byte b : hmacArr) {         
	 build.append(String.format("%02x", b));     
  }   
String hmac = build.toString();     
StringBuilder amountBuilder = new StringBuilder();     
amountBuilder.append("\"value\":\"").append(amount).append("\"").append(",\"currency\":\"INR\"");    
StringBuilder resBuilder = new StringBuilder("{");    
resBuilder.append("\"merchantTxnId\"").append(":").append("\"").append(txnID).append("\"")        
	  .append(",")        
	  .append("\"requestSignature\"").append(":").append("\"").append(hmac).append("\"")        
	  .append(",")        
	  .append("\"merchantAccessKey\"").append(":").append("\"").append(accessKey).append("\"")        
	  .append(",")        
	  .append("\"returnUrl\"").append(":").append("\"").append(returnUrl).append("\"")        
	  .append(",")        
	  .append("\"amount\"").append(":").append("{").append(amountBuilder).append("}")        
	  .append("}");   
	  out.print(resBuilder);   %>  
