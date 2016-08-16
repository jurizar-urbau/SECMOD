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
import com.urbau.misc.Util;

import org.json.simple.JSONObject;
import org.json.simple.JSONArray;

@WebServlet("/bin/sepis")
public class SearchExistentProductsInStore extends Entity {
	private static final long serialVersionUID = 2L;
       
    @Override
	@SuppressWarnings("unchecked") 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
    	response.setContentType("application/json");
    	
		String q = request.getParameter("q");
		String bodegaorigen = request.getParameter( "bo" );

		JSONArray jsonArray = new JSONArray();
		if( null != q ){
			
			Connection con  = null;
			Statement  stmt = null;
			ResultSet  rs   = null;
			String sql = "SELECT PRO.DESCRIPCION,PRO.CODIGO,PRO.IMAGE_PATH,PRO.ID,INVENTARIO.AMOUNT FROM PRODUCTOS PRO,INV"+bodegaorigen+" INVENTARIO WHERE " +
					"PRO.ID = INVENTARIO.ID_PRODUCT AND INVENTARIO.ESTATUS = 'a' AND INVENTARIO.AMOUNT > 0 AND " +
					"( descripcion like '%" + q + "%' or codigo like'%" + q + "%' or ID in  (select id_producto from Alias where descripcion like '%" + q + "%'))";
			
			
			if( q != null && !q.trim().equals( "" ) ){
				try{
					con  = ConnectionManager.getConnection();
					stmt = con.createStatement();
					rs = stmt.executeQuery( sql );
					
					while( rs.next() ){
						
						JSONObject jsonObject = new JSONObject();				
						jsonObject.put("descripcion", rs.getString( 1 ));
						jsonObject.put("codigo",      rs.getString( 2 ));
						jsonObject.put("imagepath",   rs.getString( 3 ));
						jsonObject.put("id",          rs.getString( 4 ));
						jsonObject.put("stock",       rs.getString( 5 ) );
						jsonObject.put("packings", Util.getPackings( rs.getString( 4 )) );
						jsonObject.put("packingsarray", Util.getPackingsAsArray( rs.getString( 4 )) );
						jsonArray.add(jsonObject);
						
					}
				} catch( Exception e ){ 
					System.out.println( "sql: " + sql );
					e.printStackTrace();
				} finally {
					ConnectionManager.close( con, stmt, rs ); 
				} 
			}
		}	
		PrintWriter out = response.getWriter();
		out.print(jsonArray);			
			
	}
	
}