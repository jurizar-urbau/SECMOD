package com.urbau.servlet.entity;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urbau._abstract.entity.Entity;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Util;

import org.json.simple.JSONObject;
import org.json.simple.JSONArray;

@WebServlet("/bin/TableAsJSON")
public class TableAsJSON extends Entity {
	private static final long serialVersionUID = 2L;
       
    @Override
	@SuppressWarnings("unchecked") 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
    	response.setContentType("application/json");
    	
    	String tableName = request.getParameter( "table" );
    	String fields    = request.getParameter( "fields" );
    	String where[]     = request.getParameterValues( "where" );
    	String orderBy   = request.getParameter( "order" );
    	
    	StringBuffer query = new StringBuffer();
    	
    	 query.append( "SELECT " );
    	 if( Util.isEmpty( fields )){
    		 query.append( "*" );
    	 } else {
    		 query.append( fields );
    	 }
    	 query.append( " FROM ").append( tableName );
    	 if( !Util.isEmpty( where )){
    		 query.append( " WHERE ");
    		 for( int n = 0; n < where.length; n ++ ){
    			 if( n != 0 ){
    				 query.append( " AND " );
    			 }
    			 query.append( where[ n ] );
    			 
    		 }
    	 }
    	 if( !Util.isEmpty( orderBy ) ){
    		 query.append( " " ).append( orderBy );
    	 }
    	
    	JSONArray jsonArray = new JSONArray();
			
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
			
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( query.toString() );
			ResultSetMetaData rsmd = rs.getMetaData();
			
			while( rs.next() ){
				JSONObject jsonObject = new JSONObject();
				
				for( int n = 1; n <= rsmd.getColumnCount(); n++ )
					jsonObject.put( rsmd.getColumnName( n ), rs.getString( n ));{
					
				}
				jsonArray.add(jsonObject);
				
			}
		} catch( Exception e ){ 
			System.out.println( "q: " + query );
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs ); 
		} 
		PrintWriter out = response.getWriter();
		out.print(jsonArray);			
			
	}
	
}