package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau.beans.ClasificacionRubroBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class ClasificacionRubrosMain {
	
	public ArrayList<ClasificacionRubroBean> get( String q, int from ){
		return get( q, from, -1 );
	}
	
	public ArrayList<ClasificacionRubroBean> get( String q, int from, int limit ){
				
		ArrayList<ClasificacionRubroBean> list = new ArrayList<ClasificacionRubroBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM CLASIFICACION_RUBROS LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
				total_regs = Util.getTotalRegs( "CLASIFICACION_RUBROS", "" );
			} else {
				String rem_where = Util.getRolesWhere( q );
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM CLASIFICACION_RUBROS " + Util.getDescriptionWhere( q ) + " LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
				total_regs = Util.getTotalRegs( "CLASIFICACION_RUBROS", rem_where );
			}
			while( rs.next() ){
				ClasificacionRubroBean bean = new ClasificacionRubroBean();
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
		
	public ClasificacionRubroBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		ClasificacionRubroBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM CLASIFICACION_RUBROS WHERE ID=" + id );
			while( rs.next() ){
				bean = new ClasificacionRubroBean();
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
	
	public ClasificacionRubroBean getBlankBean(){
		ClasificacionRubroBean bean = new ClasificacionRubroBean();
		bean.setDescription( "" );
		return bean;
	}
	public boolean add( ClasificacionRubroBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO CLASIFICACION_RUBROS " +
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
	public boolean mod( ClasificacionRubroBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE CLASIFICACION_RUBROS SET " +
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
	
	public boolean del( ClasificacionRubroBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM CLASIFICACION_RUBROS WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean duplicate( ClasificacionRubroBean bean ){
		
		if ( null == bean.getDescription()){
			return false;
		}
				
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();			
			String sql = "SELECT * from CLASIFICACION_RUBROS where DESCRIPCION = '"+bean.getDescription()+"'";
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
