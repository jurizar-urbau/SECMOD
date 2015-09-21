package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau.beans.TipoMovimientoBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class TiposDeMovimientosMain {
	
	public ArrayList<TipoMovimientoBean> get( String q, int from ){
		return get( q, from, -1 );
	}
	
	public ArrayList<TipoMovimientoBean> get( String q, int from, int limit ){
				
		ArrayList<TipoMovimientoBean> list = new ArrayList<TipoMovimientoBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM TIPO_MOVIMIENTO LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
				total_regs = Util.getTotalRegs( "TIPO_MOVIMIENTO", "" );
			} else {
				String rem_where = Util.getRolesWhere( q );
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM TIPO_MOVIMIENTO " + Util.getDescriptionWhere( q ) + " LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
				total_regs = Util.getTotalRegs( "TIPO_MOVIMIENTO", rem_where );
			}
			while( rs.next() ){
				TipoMovimientoBean bean = new TipoMovimientoBean();
				bean.setId( 						   rs.getInt   ( 1  ));
				bean.setDescription(  Util.trimString( rs.getString( 2  )));				
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
		
	public TipoMovimientoBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		TipoMovimientoBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM TIPO_MOVIMIENTO WHERE ID=" + id );
			while( rs.next() ){
				bean = new TipoMovimientoBean();
			    bean.setId(  rs.getInt   ( 1  ));
				bean.setDescription( Util.trimString( rs.getString( 2 )));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public TipoMovimientoBean getBlankBean(){
		TipoMovimientoBean bean = new TipoMovimientoBean();
		bean.setDescription( "" );
		return bean;
	}
	public boolean add( TipoMovimientoBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO TIPO_MOVIMIENTO " +
					"(DESCRIPCION) " +
						"VALUES " +
					"('"+ bean.getDescription()+"')";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean mod( TipoMovimientoBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE TIPO_MOVIMIENTO SET " +
					"DESCRIPCION = " + Util.vs( bean.getDescription() ) + " " +
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
	
	public boolean del( TipoMovimientoBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM TIPO_MOVIMIENTO WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean duplicate( TipoMovimientoBean bean ){
		
		if ( null == bean.getDescription()){
			return false;
		}
				
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();			
			String sql = "SELECT * from TIPO_MOVIMIENTO where DESCRIPCION = '"+bean.getDescription()+"'";
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
