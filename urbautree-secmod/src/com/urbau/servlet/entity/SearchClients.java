package com.urbau.servlet.entity;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urbau._abstract.entity.Entity;
import com.urbau.db.ConnectionManager;

import org.json.simple.JSONObject;
import org.json.simple.JSONArray;

@WebServlet("/bin/searchc")
public class SearchClients extends Entity {
	private static final long serialVersionUID = 1L;
       
    @SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
    	response.setContentType("application/json");
    	
		String q = request.getParameter("q");
		JSONArray jsonArray = new JSONArray();
		System.out.println(  "q: " + q );
		if(null != q){
			
			Connection con  = null;
			Statement  stmt = null;
			ResultSet  rs   = null;
			
			String sql = 
					"SELECT " +
							"ID,NIT,NOMBRES,APELLIDOS " +
					"FROM " +
							"CLIENTES " +
					"WHERE " +
							"NIT LIKE '%" + q + "%' OR " +
							"NOMBRES LIKE '%" + q + "%' OR " +
							"APELLIDOS LIKE  '%" + q + "%' " +
					"ORDER BY " +
						"NOMBRES,APELLIDOS,NIT";
			try{
				con  = ConnectionManager.getConnection();
				stmt = con.createStatement();
				rs = stmt.executeQuery( sql );
				
				while( rs.next() ){
					
					JSONObject jsonObject = new JSONObject();				
					jsonObject.put("id",        rs.getString( 1 ));
					jsonObject.put("nit",       rs.getString( 2 ));
					jsonObject.put("nombres",   rs.getString( 3 ));				
					jsonObject.put("apellidos", rs.getString( 4 ));
					jsonArray.add(jsonObject);
					
				}
			} catch( Exception e ){ 
				System.out.println( "sql: " + sql );
				e.printStackTrace();
			} finally {
				ConnectionManager.close( con, stmt, rs );
			}
		}	
		PrintWriter out = response.getWriter();
		out.print(jsonArray);			
			
	}
	
}