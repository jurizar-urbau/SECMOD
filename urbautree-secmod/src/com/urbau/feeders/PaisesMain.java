package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.PaisBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class PaisesMain extends AbstractMain {
	
	private final String TABLE_NAME = "PAISES"; 
	
	public ArrayList<PaisBean> get( String q, int from ){
		return get( q, from, -1 );
	}
	
	public ArrayList<PaisBean> get( String q, int from, int limit ){
		
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		ArrayList<PaisBean> list = new ArrayList<PaisBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				
				String query = "select p.id, p.nombre, p.moneda, m.id, m.nombre, m.simbolo from PAISES p, MONEDAS m where p.moneda = m.id ORDER BY p.id, m.id  LIMIT "+ from + "," + items;				
				rs = stmt.executeQuery( query);							
				total_regs = Util.getTotalRegs( TABLE_NAME, "" );
			} else {
				String rem_where = Util.getPaisesWhere(q);
				String query = "select p.id, p.nombre, p.moneda, m.id, m.nombre, m.simbolo from PAISES p, MONEDAS m where p.moneda = m.id AND (" +Util.getFieldLikes( "p.nombre", q) +" OR "+ Util.getFieldLikes( "m.nombre", q)+") ORDER BY p.id, m.id  LIMIT "+ from + "," + items;        
				
				rs = stmt.executeQuery( query );
								
				total_regs = Util.getTotalRegs( TABLE_NAME, rem_where );
								
			}			
			while( rs.next() ){
				PaisBean bean = new PaisBean();				
				bean.setId( 						   rs.getInt   ( 1  ));
				bean.setNombre(  Util.trimString( rs.getString( 2  )));
				bean.setMoneda(  Util.trimString( rs.getString( 3  )));
				bean.setMonedaId(  Util.trimString( rs.getString( 4 )));
				bean.setMonedaNombre(  Util.trimString( rs.getString( 5 )));
				bean.setMonedaSimbolo(  Util.trimString( rs.getString( 6 )));
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
	
	
	
	public PaisBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		PaisBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,NOMBRE,MONEDA FROM "+TABLE_NAME+" WHERE ID=" + id );
			while( rs.next() ){
				bean = new PaisBean();
			    bean.setId(  rs.getInt   ( 1  ));
			    bean.setNombre(  Util.trimString( rs.getString( 2 )));												
			    bean.setMoneda(  Util.trimString( rs.getString( 3 )));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
		
	public PaisBean getBlankBean(){
		PaisBean bean = new PaisBean();
		bean.setNombre( "" );
		bean.setMoneda( "" );
		return bean;
	}
	
	public boolean add( PaisBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO "+TABLE_NAME+
					" (NOMBRE,MONEDA) " +
						"VALUES " +
					"('"+ bean.getNombre()+"','"+bean.getMoneda()+"')";
			
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
	public boolean mod( PaisBean bean ){
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
					"MONEDA = " + Util.vs( bean.getMoneda() ) + " " +
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
	
	public boolean del( PaisBean bean ){
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
	
	public boolean duplicate( PaisBean bean ){
		
		if ( null == bean.getNombre() || null == bean.getMoneda() ){
			return false;
		}
				
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();			
			String sql = "SELECT * from "+TABLE_NAME+" where NOMBRE = '"+bean.getNombre()+"' AND MONEDA = '"+bean.getMoneda()+"'";
			rs = stmt.executeQuery(sql);			
			rs.beforeFirst();
			rs.last();
			int total = rs.getRow();			
			return total >= 1;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public static int getProgramId() {
		return 1;
	}
	
	
}
