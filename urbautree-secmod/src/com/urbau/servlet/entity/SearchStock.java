package com.urbau.servlet.entity;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.BodegaBean;
import com.urbau.beans.BodegaUsuarioBean;
import com.urbau.db.ConnectionManager;
import com.urbau.feeders.BodegasMain;
import com.urbau.feeders.BodegasUsuariosMain;

import org.json.simple.JSONObject;
import org.json.simple.JSONArray;

import static com.urbau.misc.Constants.Q_PARAMETER;

@WebServlet("/bin/searchstock")
public class SearchStock extends Entity {
	private static final long serialVersionUID = 1L;
       
    @SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
    	response.setContentType("application/json");
    	
		String q = request.getParameter( Q_PARAMETER );
		JSONArray jsonArray = new JSONArray();
		BodegasUsuariosMain bodegasUsuariosMain = new BodegasUsuariosMain();
		HttpSession session = request.getSession();
		ArrayList<BodegaUsuarioBean> bodegas = bodegasUsuariosMain.getFromUser( getLoggedUser(session).getId() );
		if(null != q){
			
			Connection con  = null;
			Statement  stmt = null;
			ResultSet  rs   = null;
			String sql = "";
			BodegasMain bodegasMain = new BodegasMain();
			
			try{
				for(BodegaUsuarioBean b: bodegas ){
					sql = 
							"SELECT MATCHES.CODIGO, MATCHES.DESCRIPCION,INV.AMOUNT FROM INV"+b.getIdBodega()+" INV, " +
							"(SELECT PROD.ID,PROD.CODIGO,PROD.DESCRIPCION " + 
							"FROM " + 
							"PRODUCTOS PROD RIGHT JOIN ALIAS ALI ON ALI.DESCRIPCION LIKE '%" + q + "%' " + 
							"WHERE " + 
							"PROD.ID = ALI.ID_PRODUCTO " +  
							"UNION " + 
							"SELECT PROD.ID,PROD.CODIGO,PROD.DESCRIPCION " + 
							"FROM " + 
							"PRODUCTOS PROD " + 
							"WHERE " + 
							"PROD.CODIGO LIKE '%" + q + "%'   OR  PROD.DESCRIPCION LIKE '%" + q + "%' " + 
							") MATCHES " + 
							"WHERE INV.ID_PRODUCT = MATCHES.ID AND INV.ESTATUS='a'";
					System.out.println("logging first: " + sql );
						con  = ConnectionManager.getConnection();
						stmt = con.createStatement();
						rs = stmt.executeQuery( sql );
						
						while( rs.next() ){
							BodegaBean bodega = bodegasMain.getBodega( b.getIdBodega() );
							JSONObject jsonObject = new JSONObject();				
							jsonObject.put("codigo",        rs.getString( 1 ));
							jsonObject.put("descripcion",       rs.getString( 2 ));
							jsonObject.put("existencia",   rs.getString( 3 ));
							jsonObject.put("nombrebodega", bodega.getNombre() );
							jsonArray.add(jsonObject);
							
						}
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