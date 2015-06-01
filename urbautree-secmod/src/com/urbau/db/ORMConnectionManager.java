package com.urbau.db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import com.j256.ormlite.jdbc.JdbcConnectionSource;
import com.j256.ormlite.support.ConnectionSource;


public class ORMConnectionManager {

	private static String driver   = "com.mysql.jdbc.Driver";
	private static String url      = "jdbc:mysql://localhost/urbausec";
	private static String user     = "application";
	private static String password = "application";
	
	public ORMConnectionManager(){
		
	}
	public ORMConnectionManager(String driver, String url, String user, String password ){
		ORMConnectionManager.driver   = driver;
		ORMConnectionManager.url      = url;
		ORMConnectionManager.user     = user;
		ORMConnectionManager.password = password;
	}	
	public static void set(String driver, String url, String user, String password ){
		System.out.println( "setting db parameters from external. [" + driver + "," + url + "," + user + "]" );
		ORMConnectionManager.driver   = driver;
		ORMConnectionManager.url      = url;
		ORMConnectionManager.user     = user;
		ORMConnectionManager.password = password;
	}	
	
	public static ConnectionSource getConnection(){
		try{
		      Class.forName( driver );
//		      Connection connection = DriverManager.getConnection( url, user, password );
		      ConnectionSource connection = new JdbcConnectionSource( url, user, password );
		      return connection;
		} catch( Exception e ){
			e.printStackTrace();
		}
		return null;
	}
	
	public static void close( ConnectionSource con ){
		if( con != null ){
			try {
				con.close();
			} catch (Exception e2) {
			}
		}
	}
	
	
}
