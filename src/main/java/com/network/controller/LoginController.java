package com.network.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.network.model.User;
import com.network.util.MessageDigestUtil;
import com.network.util.UserUtil;

@RestController
@RequestMapping("pages/LoginService")
public class LoginController {

	UserUtil userutil = new UserUtil();

@RequestMapping(value="/authenticate", method = RequestMethod.POST )
public User autheticateUser(String username,String password){
	
	System.out.println("username : "+username+" pwd : "+password);
	
	//Digest the password
	String encryptPass = MessageDigestUtil.doMessageDigest(password);	
	
	System.out.println("encrypt : "+encryptPass);
	
	return userutil.getUserByAuth(username, encryptPass);
}

@RequestMapping(value="/checkUserAvailable",method = RequestMethod.POST)
public boolean checkUserAvailability(String username){
	
	System.out.println("User name "+username);
	
	return userutil.checkUserAvailability(username);
	
}

/*@RequestMapping(value = "/registeruser", method = RequestMethod.POST)
public User registerUser(String name,String email,long mobile,String username,String password){
	
	String encryptPass = MessageDigestUtil.doMessageDigest(password);	
	
	return userutil.registerUser(name,email,mobile,username,encryptPass);
	
}
*/
}
