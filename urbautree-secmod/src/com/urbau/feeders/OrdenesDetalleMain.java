package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.OrdenDetailBean;
import com.urbau.db.ConnectionManager;

public class OrdenesDetalleMain extends AbstractMain {
	
	private String allColumnNames = " ID,ID_ORDEN,ID_PRODUCTO,PRECIO_UNITARIO,CANTIDAD,TOTAL ";
	
	public static int getProgramId(){
		return -2;
	}
	
	public ArrayList<OrdenDetailBean> getDetails( int id_orden ){
		
		ArrayList<OrdenDetailBean> list = new ArrayList<OrdenDetailBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT "+allColumnNames+" FROM	ORDENESDETALLE WHERE ID_ORDEN=" + id_orden );
			
			while( rs.next() ){
				OrdenDetailBean bean = new OrdenDetailBean();
				bean.setId        ( rs.getInt   ( 1  ));
				bean.setId_orden( rs.getInt( 2 ));
				bean.setId_producto( rs.getInt(3));
				bean.setPrecio_unitario( rs.getDouble(4));
				bean.setCantidad(  rs.getInt(5));
				bean.setTotal( rs.getDouble(6) );
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
		
	
	public boolean addDetail( ArrayList<OrdenDetailBean> beans ){
		boolean returnValue = false;
		for( OrdenDetailBean bean : beans ){
			boolean inserted = add( bean );
			if  ( inserted ){
				returnValue = true;
			}
		}
		return returnValue;
	}
	
	public boolean add( OrdenDetailBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO ORDENESDETALLE " +
					"(ID_ORDEN,ID_PRODUCTO,PRECIO_UNITARIO,CANTIDAD,TOTAL) " +
						"VALUES " +
					"( "+bean.getId_orden()+","+bean.getId_producto()+","+bean.getPrecio_unitario()+","+bean.getCantidad()+","+bean.getTotal()+")";
			int total = stmt.executeUpdate( sql );					
			return total>0;
			 
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	
	public boolean del( OrdenDetailBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM ORDENESDETALLE WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );					
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
}
