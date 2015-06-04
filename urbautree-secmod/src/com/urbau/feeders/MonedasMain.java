package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.MonedaBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class MonedasMain extends AbstractMain {
	
	private final String TABLE_NAME = "MONEDAS"; 
	
	public ArrayList<MonedaBean> get( String q, int from ){
		return get( q, from, -1 );
	}
	
	public ArrayList<MonedaBean> get( String q, int from, int limit ){
		
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		ArrayList<MonedaBean> list = new ArrayList<MonedaBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT ID,NOMBRE,SIMBOLO FROM "+TABLE_NAME+" LIMIT " + from + "," + items );
				total_regs = Util.getTotalRegs( TABLE_NAME, "" );
			} else {
				String rem_where = Util.getMonedasWhere( q );
				rs = stmt.executeQuery( "SELECT ID,NOMBRE,SIMBOLO FROM "+TABLE_NAME+" " + rem_where + " LIMIT " + from + "," + items );
				total_regs = Util.getTotalRegs( TABLE_NAME, rem_where );
			}
			while( rs.next() ){
				MonedaBean bean = new MonedaBean();
				bean.setId( 						   rs.getInt   ( 1  ));
				bean.setNombre(  Util.trimString( rs.getString( 2  )));
				bean.setSimbolo(  Util.trimString( rs.getString( 3 )));
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
	
	
	
	public MonedaBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		MonedaBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,NOMBRE,SIMBOLO FROM "+TABLE_NAME+" WHERE ID=" + id );
			while( rs.next() ){
				bean = new MonedaBean();
			    bean.setId(  rs.getInt   ( 1  ));
			    bean.setNombre(  Util.trimString( rs.getString( 2 )));												
			    bean.setSimbolo(  Util.trimString( rs.getString( 3 )));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
		
	public MonedaBean getBlankBean(){
		MonedaBean bean = new MonedaBean();
		bean.setNombre( "" );
		bean.setSimbolo( "" );
		return bean;
	}
	
	public boolean add( MonedaBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO "+TABLE_NAME+
					" (NOMBRE,SIMBOLO) " +
						"VALUES " +
					"('"+ bean.getNombre()+"','"+bean.getSimbolo()+"')";
			
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
	public boolean mod( MonedaBean bean ){
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
					"SIMBOLO = " + Util.vs( bean.getSimbolo() ) + " " +
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
	
	public boolean del( MonedaBean bean ){
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
	
	public boolean duplicate( MonedaBean bean ){
		
		if ( null == bean.getNombre() || null == bean.getSimbolo() ){
			return false;
		}
				
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();			
			String sql = "SELECT * from "+TABLE_NAME+" where NOMBRE = '"+bean.getNombre()+"' AND SIMBOLO = '"+bean.getSimbolo()+"'";
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
