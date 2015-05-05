package com.urbau.db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;


public class ConnectionManager {

	private static String driver   = "com.mysql.jdbc.Driver";
	private static String url      = "jdbc:mysql://localhost/urbausec";
	private static String user     = "application";
	private static String password = "application";
	
	public ConnectionManager(){
		
	}
	public ConnectionManager(String driver, String url, String user, String password ){
		ConnectionManager.driver   = driver;
		ConnectionManager.url      = url;
		ConnectionManager.user     = user;
		ConnectionManager.password = password;
	}	
	public static void set(String driver, String url, String user, String password ){
		System.out.println( "setting db parameters from external. [" + driver + "," + url + "," + user + "]" );
		ConnectionManager.driver   = driver;
		ConnectionManager.url      = url;
		ConnectionManager.user     = user;
		ConnectionManager.password = password;
	}	
	
	public static Connection getConnection(){
		try{
		      Class.forName( driver );
		      Connection connection = DriverManager.getConnection( url, user, password );
		      return connection;
		} catch( Exception e ){
			e.printStackTrace();
		}
		return null;
	}
	
	public static void close( Connection con, Statement stmt, ResultSet rs ){
		if( rs != null ){
			try {
				rs.close();
			} catch (Exception e2) {
			}
		}
		if( stmt != null ){
			try {
				stmt.close();
			} catch (Exception e2) {
			}
		}
		if( con != null ){
			try {
				con.close();
			} catch (Exception e2) {
			}
		}
	}
	
	
}
