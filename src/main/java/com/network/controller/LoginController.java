package com.network.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.network.dbfactory.DBUtil;
import com.network.model.User;
import com.network.util.MessageDigestUtil;
import com.network.util.SMSUtil;
import com.network.util.SendMail;
import com.network.util.UserUtil;

@RestController
@RequestMapping("pages/LoginService")
public class LoginController {

	UserUtil userutil = new UserUtil();

@RequestMapping(value="/authenticate", method = RequestMethod.POST )
public User autheticateUser(String username,String password){
	
	if(username.trim() == "" || password.trim() == ""){
		
		return new User();
	}else{
		//Digest the password
		String encryptPass = MessageDigestUtil.doMessageDigest(password);	
		
		User u = userutil.getUserByAuth(username, encryptPass);
		DBUtil.closeConnection();
		return u;
	}
	
	
}

@RequestMapping(value="/checkUserAvailable",method = RequestMethod.POST)
public boolean checkUserAvailability(String username){
	
	
	return userutil.checkUserAvailability(username);
	
}

@RequestMapping(value = "/registeruser", method = RequestMethod.POST)
public User registerUser(String name,String email,long mobile,String username,String password){
	
	//SendMail smail = new SendMail();
	//smail.sendEmail("utpal@techvariable.com", "new Reg", "name : "+name+" emal : "+email+" mobile : "+mobile+" pass : "+password+" username : "+username);
	
	String encryptPass = MessageDigestUtil.doMessageDigest(password);	
	
	return userutil.registerUser(name,email,mobile,username,encryptPass);
	
}

}
