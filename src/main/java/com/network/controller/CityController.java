package com.network.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.network.dbfactory.DBUtil;
import com.network.model.City;
import com.network.util.UserUtil;

@RestController
@RequestMapping("city")
public class CityController {
 
	@RequestMapping(value="/getAllCityName", method=RequestMethod.GET)
	public ArrayList getAllCityNames(){
		UserUtil userUtil = new UserUtil();
		return userUtil.getAllCityName();
	}
	

	
}
