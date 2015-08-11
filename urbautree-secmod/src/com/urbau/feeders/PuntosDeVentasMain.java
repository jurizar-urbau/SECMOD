package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import com.urbau.beans.PuntoDeVentaBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class PuntosDeVentasMain {
	
	public ArrayList<PuntoDeVentaBean> get( String q, int from ){
		return get( q, from, -1 );
	}
	
	public ArrayList<PuntoDeVentaBean> get( String q, int from, int limit ){
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		
		ArrayList<PuntoDeVentaBean> list = new ArrayList<PuntoDeVentaBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				String sql = "SELECT ID,NOMBRE,DIRECCION,TELEFONO FROM PUNTOSDEVENTAS LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				System.out.println( "sql:" + sql );
				rs = stmt.executeQuery( sql );
				
			} else {
				String sql = "SELECT ID,NOMBRE,DIRECCION,TELEFONO FROM PUNTOSDEVENTAS " + Util.getBodegasWhere( q ) + " LIMIT " + from + "," + Constants.ITEMS_PER_PAGE ;
				System.out.println( "sql:" + sql );
				rs = stmt.executeQuery( sql);				
			}
			while( rs.next() ){
				PuntoDeVentaBean bean = new PuntoDeVentaBean();
				bean.setId(  rs.getInt   ( 1  ));				
				bean.setNombre(  Util.trimString( rs.getString( 2 )));				
				bean.setDireccion( Util.trimString( rs.getString( 3 )) );
				bean.setTelefono( Util.trimString( rs.getString( 4 )) );									
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	public PuntoDeVentaBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		PuntoDeVentaBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,NOMBRE,DIRECCION,TELEFONO FROM PUNTOSDEVENTAS WHERE ID=" + id );
			while( rs.next() ){
				bean = new PuntoDeVentaBean();
				bean.setId(  rs.getInt   ( 1  ));		
				bean.setNombre(  Util.trimString( rs.getString( 2 )));				
				bean.setDireccion( Util.trimString( rs.getString( 3 )) );
				bean.setTelefono( Util.trimString( rs.getString( 4 )) );				
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public PuntoDeVentaBean getBlankBean(){
		PuntoDeVentaBean bean = new PuntoDeVentaBean();		
		bean.setNombre(  "" );		
		bean.setDireccion( "" );		
		bean.setTelefono( "" );				
		return bean;
	}
	
	public boolean add( PuntoDeVentaBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO PUNTOSDEVENTAS ( NOMBRE, DIRECCION, TELEFONO ) VALUES " +
						 "('" + bean.getNombre() + "','"+bean.getDireccion()+"','"+bean.getTelefono()+"')";
			System.out.println("sql: " +sql );
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean mod( PuntoDeVentaBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE PUNTOSDEVENTAS SET " +
					"NOMBRE=" + Util.vs( bean.getNombre() )  + ", DIRECCION=" + Util.vs( bean.getDireccion() ) + "," + 
					"TELEFONO=" + Util.vs( bean.getTelefono() ) + " WHERE ID=" + bean.getId();
			System.out.println("sql: " + sql);
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean del( PuntoDeVentaBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM PUNTOSDEVENTAS WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}

	public static int getProgramId() {
		return 2;
	}
	
	public String getDateString( Date date ){
		Calendar cal = Calendar.getInstance();
		String str = cal.get(Calendar.YEAR ) + "-" + ( cal.get( Calendar.MONTH ) + 1 ) + "-" + cal.get( Calendar.DAY_OF_MONTH );
		return str;
	}
	
}
