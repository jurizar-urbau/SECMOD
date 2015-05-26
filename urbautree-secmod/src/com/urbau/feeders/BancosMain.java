package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.BancoBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class BancosMain extends AbstractMain {
	
	private final String TABLE_NAME = "BANCOS"; 
	
	public ArrayList<BancoBean> get( String q, int from ){
		ArrayList<BancoBean> list  = new ArrayList<BancoBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		String sql = "";
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			int total_regs = 0;
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				sql = "SELECT ID,NOMBRE FROM "+TABLE_NAME +" ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				rs = stmt.executeQuery( sql);
				total_regs = Util.getTotalRegs(TABLE_NAME, "" );
				 
			} else {
				sql = "SELECT ID,NOMBRE FROM "+TABLE_NAME +" " + Util.getBancosWhere( q ) + "  ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				rs = stmt.executeQuery( sql);
				
				total_regs = Util.getTotalRegs( TABLE_NAME, Util.getBancosWhere( q ) );
			}
			System.out.println( "sql: " + sql );
			while( rs.next() ){
				
				BancoBean bean = new BancoBean();
				bean.setTotal_regs( total_regs );
				bean.setId(  rs.getInt   ( 1  ));
				bean.setNombre(  Util.trimString( rs.getString( 2 )));							
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
			System.out.println( "sql: [" + sql + "]");
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	public BancoBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		BancoBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,NOMBRE FROM "+TABLE_NAME+" WHERE ID=" + id );
			while( rs.next() ){
				bean = new BancoBean();
			    bean.setId(  rs.getInt   ( 1  ));
			    bean.setNombre(  Util.trimString( rs.getString( 2 )));												
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
		
	public BancoBean getBlankBean(){
		BancoBean bean = new BancoBean();
		bean.setNombre( "" );				
		return bean;
	}
	
	public boolean add( BancoBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO "+TABLE_NAME+
					" (NOMBRE) " +
						"VALUES " +
					"('"+ bean.getNombre()+"')";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean mod( BancoBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE "+TABLE_NAME+" SET " +
					"NOMBRE = " + Util.vs( bean.getNombre() ) + " " +
					"WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean del( BancoBean bean ){
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
