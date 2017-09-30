package com.network.dbfactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

	private static Connection connection = null;

	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	
	//static final String DB_URL = "jdbc:mysql://localhost:3306/network";
	static final String DB_URL = "jdbc:mysql://127.7.153.2:3306/nwt?autoReconnect=true";
	//static final String DB_URL = "jdbc:mysql://localhost:3306/network?autoReconnect=true";
	
	   //  Database credentials
	static final String USER ="adminH4hSQks";
	static final String PASS ="AMMTvSFudLzx";
	
	public static Connection getConnection() {
	/*	
		
		if (connection != null){
			try{
				if(!connection.isClosed()){
					connection.close();
				}
		
			}catch(Exception e){
				System.out.println("not null "+connection.toString());
				//return connection;
			}
		
		}*/
			
	//	else {
			try{
				   System.out.println("before conncting");
			      //STEP 2: Register JDBC driver
			      Class.forName("com.mysql.jdbc.Driver");

			      //STEP 3: Open a connection
			      System.out.println("Connecting to database...");
			      connection = DriverManager.getConnection(DB_URL,USER,PASS);
			      
			   }catch(SQLException se){
				   
				      se.printStackTrace();
				   }catch(Exception e){
				      //Handle errors for Class.forName
				   } 
			return connection;
		}
	//}
	
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
