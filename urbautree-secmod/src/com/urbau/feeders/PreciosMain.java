package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.PrecioBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class PreciosMain extends AbstractMain {
	
	private final String TABLE_NAME = "PRECIOS"; 
	
	public ArrayList<PrecioBean> get( String q, int from ){
		return get( q, from, -1 );
	}
	
	public ArrayList<PrecioBean> get( String q, int from, int limit ){
		
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		ArrayList<PrecioBean> list = new ArrayList<PrecioBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){

				String query = "SELECT ID,NOMBRE,COEFICIENTE FROM "+ TABLE_NAME+ " ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
								
				System.out.println("query1: " +query);
				rs = stmt.executeQuery( query);							
				total_regs = Util.getTotalRegs( TABLE_NAME, "" );
			} else {
				String rem_where = Util.getColumNameGenericWhere("NOMBRE",q);
				String query = "SELECT ID,NOMBRE,COEFICIENTE FROM PRECIOS " + Util.getColumNameGenericWhere("NOMBRE", q ) + "  ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				System.out.println("query2: " +query);        				
				rs = stmt.executeQuery( query );
							
				total_regs = Util.getTotalRegs( TABLE_NAME, rem_where );
								
			}			
			while( rs.next() ){
				PrecioBean bean = new PrecioBean();				
				bean.setId( 						   rs.getInt   ( 1  ));
				bean.setNombre(  Util.trimString( rs.getString( 2  )));
				bean.setCoeficiente(   rs.getDouble( 3  ));				
				bean.setTotal_regs( total_regs );
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	public PrecioBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		PrecioBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,NOMBRE,COEFICIENTE FROM "+TABLE_NAME+" WHERE ID=" + id );
			while( rs.next() ){
				bean = new PrecioBean();
			    bean.setId(  rs.getInt   ( 1  ));
			    bean.setNombre(  Util.trimString( rs.getString( 2 )));												
			    bean.setCoeficiente(  rs.getDouble( 3 ));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
		
	public PrecioBean getBlankBean(){
		PrecioBean bean = new PrecioBean();
		bean.setId(-1);
		bean.setNombre( "" );
		bean.setCoeficiente(0.0);
		return bean;
	}
	
	
	
	public boolean add( PrecioBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO "+TABLE_NAME+
					" (ID,NOMBRE,COEFICIENTE) " +
						"VALUES " +
					"("+bean.getId() +",'"+ bean.getNombre()+"',"+bean.getCoeficiente()+")";
			
			System.out.println(sql);
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean mod( PrecioBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE "+TABLE_NAME+" SET " +
					"NOMBRE = " + Util.vs( bean.getNombre() ) + " , " +
					"COEFICIENTE = " +  bean.getCoeficiente()  + " " +
					"WHERE ID = " + bean.getId();
			System.out.println(sql);
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean del( PrecioBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM "+TABLE_NAME+" WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public long count( ){
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		long count = 0;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT count(ID) FROM " + TABLE_NAME );
			if( rs.next() ){
				count = rs.getLong( 1 );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return count;
	}
		
	public static int getProgramId() {
		return 1;
	}
	
	
}
