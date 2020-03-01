package com.network.dbfactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

	private static Connection connection = null;

	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	
	//static final String DB_URL = "jdbc:mysql://localhost:3306/network";
	static final String DB_URL = "jdbc:mysql://172.30.4.109:3306/nwt?autoReconnect=true";
	//static final String DB_URL = "jdbc:mysql://localhost:3306/nwt?autoReconnect=true";
	//Use this in future .. from f:://DB_NWT
	//static final String DB_URL = "jdbc:mysql://localhost:3306/network?autoReconnect=true";
	
	   //  Database credentials
	static final String USER ="userL8L";
	static final String PASS ="Ntwa0dFM4orFYsId";

	
	//static final String USER ="root";
    //static final String PASS ="";
	public static Connection getConnection() {

			try{
				  
			      //STEP 2: Register JDBC driver
			      Class.forName("com.mysql.jdbc.Driver");

			      //STEP 3: Open a connection
			    
			      connection = DriverManager.getConnection(DB_URL,USER,PASS);
			    
			      
			   }catch(SQLException se){
				   
				      se.printStackTrace();
				   }catch(Exception e){
					  e.printStackTrace();
				      //Handle errors for Class.forName
				   } 
		
			return connection;
		}

	public static Connection getOPenConnection(){
		
		try{
			if(connection.isClosed()){
				return getConnection();
			}
		}catch(Exception e){
			System.out.println(e);
		}
		
		return connection;
	}
	
	
	public static void closeConnection(){
		try{
			if(!connection.isClosed()){
				
					connection.close();
					connection = null;
					
				
			}
		}catch(Exception e){
			System.out.println(e.toString());
		}
		
	}
}
