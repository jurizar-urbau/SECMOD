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

@WebServlet("/bin/searchp")
public class SearchProducts extends Entity {
	private static final long serialVersionUID = 1L;
       
    @SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
    	response.setContentType("application/json");
    	
		String q = request.getParameter("q");
		JSONArray jsonArray = new JSONArray();
		
		if(null != q){
			
			Connection con  = null;
			Statement  stmt = null;
			ResultSet  rs   = null;
			try{
				con  = ConnectionManager.getConnection();
				stmt = con.createStatement();
				rs = stmt.executeQuery( "select " +
						"DESCRIPCION,CODIGO,COEFICIENTE_UNIDAD," +
						"PRECIO,PRECIO_1,PRECIO_2,PRECIO_3,PRECIO_4,IMAGE_PATH,ID " +
						"from " +
						"productos " +
						"where " +
						"descripcion like '%" + q + "%'" +
						" or codigo like'%" + q + "%'" +
						" or ID in " +
						"(select id_producto from Alias where descripcion like '%" + q + "%')" );
				while( rs.next() ){
					JSONObject jsonObject = new JSONObject();				
					jsonObject.put("descripcion", rs.getString( 1 ));
					jsonObject.put("codigo",      rs.getString( 2 ));
					jsonObject.put("packing",     rs.getString( 3 ));				
					jsonObject.put("precio",    rs.getString( 4 ));
					jsonObject.put("precio_1",    rs.getString( 5 ));
					jsonObject.put("precio_2",    rs.getString( 6 ));
					jsonObject.put("precio_3",    rs.getString( 7 ));
					jsonObject.put("precio_4",    rs.getString( 8 ));
					jsonObject.put("imagepath",    rs.getString( 9 ));
					jsonObject.put("id",    rs.getString( 10 ));
					
					jsonArray.add(jsonObject);
					
				}
			} catch( Exception e ){
				e.printStackTrace();
			} finally {
				ConnectionManager.close( con, stmt, rs );
			}
		}	
		PrintWriter out = response.getWriter();
		out.print(jsonArray);			
			
	}
	
}