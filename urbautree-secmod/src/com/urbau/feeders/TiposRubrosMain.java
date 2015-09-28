package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.TipoRubroBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class TiposRubrosMain extends AbstractMain {
	
	public static int getProgramId(){
		return -2;
	}
	public ArrayList<TipoRubroBean> get( String q, int from ){
		return get( q, from, -1 );
	}
	
	public ArrayList<TipoRubroBean> get( String q, int from, int limit ){
		
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		ArrayList<TipoRubroBean> list = new ArrayList<TipoRubroBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM TIPOS_RUBRO LIMIT " + from + "," + items );
				total_regs = Util.getTotalRegs( "ROLES", "" );
			} else {
				String rem_where = Util.getRolesWhere( q );
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM TIPOS_RUBRO " + rem_where + " LIMIT " + from + "," + items );
				total_regs = Util.getTotalRegs( "TIPOS_RUBRO", rem_where );
			}
			while( rs.next() ){
				TipoRubroBean bean = new TipoRubroBean();
				bean.setId( 						   rs.getInt   ( 1  ));
				bean.setDescripcion(  Util.trimString( rs.getString( 2  )));
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
		
	public TipoRubroBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		TipoRubroBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT DESCRIPCION FROM TIPOS_RUBRO WHERE ID=" + id );
			while( rs.next() ){
			    bean = new TipoRubroBean();
			    bean.setId( id );
				bean.setDescripcion( Util.trimString( rs.getString( 1  )));
				
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	public TipoRubroBean getBlankBean(){
		TipoRubroBean bean = new TipoRubroBean();
		bean.setDescripcion("");
		return bean;
	}
	public boolean add( TipoRubroBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO TIPOS_RUBRO " +
					"(DESCRIPCION) " +
						"VALUES " +
					"('"+ bean.getDescripcion()+"')";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean mod( TipoRubroBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE TIPOS_RUBRO SET " + 
					"DESCRIPCION = " + Util.vs( bean.getDescripcion()  ) + " " +
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
	
	public boolean del( TipoRubroBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM TIPOS_RUBRO WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean duplicate( TipoRubroBean bean ){
		
		if ( null == bean.getDescripcion()){
			return false;
		}
				
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();			
			String sql = "SELECT * from TIPOS_RUBRO where DESCRIPCION = '"+bean.getDescripcion()+"'";
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
	
}
