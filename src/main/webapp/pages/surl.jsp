<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SURL</title>
</head>
<body>
 <%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %> 
 <%@ page  import=" java.util.Enumeration"%>
 
 <%        // Scriptlet Tag
 
    // Fetch All required parameters 
    
String key=request.getParameter("key");  
String status=request.getParameter("status"); 
String txnid=request.getParameter("txnid");
String amount=request.getParameter("amount");    // Retrieve amount value from merchant's database 
String email=request.getParameter("email");
String productinfo=request.getParameter("productinfo");
String firstname=request.getParameter("firstname");
String udf1=request.getParameter("udf1");
String udf2=request.getParameter("udf2");
String udf3=request.getParameter("udf3");
String udf4=request.getParameter("udf4");
String udf5=request.getParameter("udf5");
String received_Reverse_Hash=request.getParameter("hash");
 

 CALCULATED_REVERSE_HASH=  getReverseHash(key,txnid,amount,productinfo,firstname,email,"","","","","",status);
 
 System.out.println("key is "+key+" txn id is "+txnid+" amount is "+amount+" productinfo is "+productinfo+" firstName is "+firstname+ " email is "+email+ " udf1 "+udf1+" udf2 "+udf2+" udf3 "+udf3+ " udf4 "+udf4+ " udf5 "+udf5);
	
 System.out.println("calcu ret hash"+CALCULATED_REVERSE_HASH);
 System.out.println("Received reverse hash : "+received_Reverse_Hash);
 
 if(CALCULATED_REVERSE_HASH.equals(received_Reverse_Hash)){
	 
	 System.out.println("Hash Successfully Matched ");
	 response.getWriter().print("Please Wait");
	 
	 
	/*   Enumeration<String> parameterList = request.getParameterNames();
	  while( parameterList.hasMoreElements() )
	  {
	    String sName = parameterList.nextElement().toString();
	    
	      out_Params.put(sName.toString(), request.getParameter( sName ).toString());
	      
	      
	    }
	  
	  response.getWriter().print(out_Params.toJSONString());
	  
	  System.out.println(out_Params.toJSONString());
	  
	  android_Data=out_Params;
	  System.out.println(android_Data.toString());
	  
	  setResponseData(android_Data); // Setting data as */
	  
	  
	  Enumeration<String> kayParams = request.getParameterNames();
		String result = "";
		
		while (kayParams.hasMoreElements()) {
			key = (String) kayParams.nextElement();
			result += key + "=" + request.getParameter(key) + (kayParams.hasMoreElements() ? "," : "");
		}
		
		setResponseData(result);  // setting result as String 
 }
 else{
	 
	 response.getWriter().print("Invalid Transaction");
	 
	setResponseData("Invalid Transaction");
	 
 }
 
 
 %>
 
 
 <%!    // Decleration Tag
 
 
 private final String salt="YpJzBjSV";  // USE THE SALT REQUIRED 
 private  String CALCULATED_REVERSE_HASH="reverse_hash";
 public String android_Data="";

 
 
 public String getReverseHash(String key,String txnid, String amount, String productinfo,String firstname,String email,String udf1,String udf2,String udf3,String udf4,String udf5, String status){
	 
	 System.out.println("udf1 "+udf1);
	 System.out.println("udf1 "+udf2);
	 System.out.println("udf1 "+udf3);
	 System.out.println("udf1 "+udf4);
	 System.out.println("udf1 "+checkNull(udf5));
	 
	 String r_h= checkNull(salt)+"|"+checkNull(status)+"||||||"+checkNull(udf5)+"|"+checkNull(udf4)+"|"+checkNull(udf3)+"|"+checkNull(udf2)+"|"+checkNull(udf1)+"|"+checkNull(email)+"|"+checkNull(firstname)+"|"+checkNull(productinfo)+"|"+checkNull(amount)+"|"+checkNull(txnid)+"|"+checkNull(key);
	 
	 System.out.println("r_h   "+r_h);
	 
	 String calculated_reverse_hash=getSHA(r_h);
	 
	 System.out.println("calculated return hash   "+calculated_reverse_hash);
	 
	 
	 
	 return calculated_reverse_hash; // return generated reverse hash
 }
 
 private String checkNull(String value) {
		if (value == null) {
			return "";
		} else {
			return value;
		}
	}
 
 
 
 private String getSHA(String str) {
	 MessageDigest md;
	String out = "";
	try {
		md = MessageDigest.getInstance("SHA-512");
		md.update(str.getBytes());
		byte[] mb = md.digest();
		for (int i = 0; i < mb.length; i++) {
			byte temp = mb[i];
			String s = Integer.toHexString(new Byte(temp));
			while (s.length() < 2) {
				s = "0" + s;
			}
			s = s.substring(s.length() - 2);
			out += s;
		}
	} catch (NoSuchAlgorithmException e) {
		e.printStackTrace();
	}
	return out; 
}
 
 public void setResponseData(String data){
	 android_Data=data;
	 System.out.println("android data "+android_Data);
 }
 
 
 
 %>
<script type="text/javascript">
	
	//for Android Success
	function AndroidSuccess(input) {
		//alert(input);
		PayU.onSuccess(input);
	}
	
	AndroidSuccess("<%= android_Data %>");
	
</script>



</body>
</html>