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
import com.urbau.beans.ProductoBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Util;

import org.json.simple.JSONObject;
import org.json.simple.JSONArray;

@WebServlet("/bin/searchexistentp")
public class SearchExistentProducts extends Entity {
	private static final long serialVersionUID = 2L;
       
    @Override
	@SuppressWarnings("unchecked") 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
    	response.setContentType("application/json");
    	
		String q = request.getParameter("q");
		JSONArray jsonArray = new JSONArray();
		if(null != q){
			
			Connection con  = null;
			Statement  stmt = null;
			ResultSet  rs   = null;
			String sql = "SELECT " + 
							"PRO.DESCRIPCION,PRO.CODIGO,PRO.COEFICIENTE_UNIDAD,PRO.PRECIO,PRO.PRECIO_1,PRO.PRECIO_2,PRO.PRECIO_3,PRO.PRECIO_4,PRO.IMAGE_PATH,PRO.ID " + 
						 "FROM " + 
							"PRODUCTOS PRO " + 
							"WHERE ( descripcion like '%"+q+"%' or codigo like'%"+q+"%' or ID in  (select id_producto from Alias where descripcion like '%"+q+"%'))";
			
			
			if( q != null && !q.trim().equals( "" ) ){
				try{
					con  = ConnectionManager.getConnection();
					stmt = con.createStatement();
					rs = stmt.executeQuery( sql );
					
					while( rs.next() ){
						
						ProductoBean bean = new ProductoBean();
						
						
						
						bean.setDescripcion( Util.trimString( rs.getString( 1 )) );
						bean.setCodigo( Util.trimString( rs.getString( 2 )) );
						bean.setCoeficiente_unidad( rs.getInt( 3 ));
						bean.setPrecio( rs.getDouble( 4 ));
						bean.setPrecio_1( rs.getDouble( 5 ));
						bean.setPrecio_2( rs.getDouble( 6 ));
						bean.setPrecio_3( rs.getDouble( 7 ));
						bean.setPrecio_4( rs.getDouble( 8 ));
						bean.setImage_path( Util.trimString( rs.getString( 9 )) );
						bean.setId(  rs.getInt   ( 10  ));
						//bean.setStock_minimo( rs.getInt( 11 ));
						
						JSONObject jsonObject = new JSONObject();				
						jsonObject.put("descripcion", rs.getString( 1 ));
						jsonObject.put("codigo",      rs.getString( 2 ));
						jsonObject.put("packing",     rs.getString( 3 ));				
						jsonObject.put("precio",    rs.getString( 4 ));
						jsonObject.put("precio_1",    Util.formatCurrency(bean.compiled_1())  );
						jsonObject.put("precio_2",    Util.formatCurrency(bean.compiled_2())  );
						jsonObject.put("precio_3",    Util.formatCurrency(bean.compiled_3()) );
						jsonObject.put("precio_4",    Util.formatCurrency(bean.compiled_4()) );
						jsonObject.put("imagepath",    rs.getString( 9 ));
						jsonObject.put("id",    rs.getString( 10 ));
						jsonObject.put("stock", bean.getStock_minimo() );
						jsonObject.put("packings", Util.getPackings( rs.getString( 10 )) );
						jsonObject.put("packingsarray", Util.getPackingsAsArray( rs.getString( 10 )) );
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