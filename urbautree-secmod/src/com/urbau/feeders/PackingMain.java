package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau.beans.PackingBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;


public class PackingMain {
	
	public ArrayList<PackingBean> get( String q, int from, int idproducto ){
		return get( q, from, -1, idproducto );
	}
	
	
	public ArrayList<PackingBean> getAll( int idproducto ){
		ArrayList<PackingBean> list = new ArrayList<PackingBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,NOMBRE,MULTIPLICADOR,ID_PRODUCTO FROM PACKINGS WHERE ID_PRODUCTO=" + idproducto );
			while( rs.next() ){
				PackingBean bean = new PackingBean();
				bean.setId( 						   rs.getInt   ( 1  ));
				bean.setNombre( rs.getString( 2 ));
				bean.setMultiplicador( rs.getInt( 3 ));
				bean.setId_producto( rs.getInt( 4 ));
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	public ArrayList<PackingBean> get( String q, int from, int limit, int idproducto ){
		
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		ArrayList<PackingBean> list = new ArrayList<PackingBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT ID,NOMBRE,MULTIPLICADOR,ID_PRODUCTO FROM PACKINGS WHERE ID_PRODUCTO=" + idproducto + " LIMIT " + from + "," + items );
				total_regs = Util.getTotalRegs( "ALIAS", "" );
			} else {
				String rem_where = Util.getRolesWhere( q );
				rs = stmt.executeQuery( "SELECT ID,NOMBRE,MULTIPLICADOR,ID_PRODUCTO FROM PACKINGS WHERE ID_PRODUCTO=" + idproducto + " LIMIT " + from + "," + items );
				total_regs = Util.getTotalRegs( "ALIAS", rem_where );
			} 
			while( rs.next() ){
				PackingBean bean = new PackingBean();
				bean.setId( 						   rs.getInt   ( 1  ));
				bean.setNombre( rs.getString( 2 ));
				bean.setMultiplicador( rs.getInt( 3 ));
				bean.setId_producto( rs.getInt( 4 ));
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
		
	public PackingBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		PackingBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,NOMBRE,MULTIPLICADOR,ID_PRODUCTO FROM PACKINGS WHERE ID=" + id );
			while( rs.next() ){
				bean = new PackingBean();
			    bean.setId(  rs.getInt   ( 1  ));
				bean.setNombre( rs.getString( 2 ));
				bean.setMultiplicador( rs.getInt( 3 ));
				bean.setId_producto( rs.getInt( 4 )	);
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		} 
		return bean;
	}
	
	public PackingBean getBlankBean(){
		PackingBean bean = new PackingBean();
		bean.setNombre( "") ;
		bean.setMultiplicador( 0 );
		bean.setId_producto( 0 );
		return bean;
	}
	public boolean add( PackingBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO PACKINGS (NOMBRE,MULTIPLICADOR,ID_PRODUCTO) VALUES ('"+bean.getNombre()+"',"+bean.getMultiplicador()+","+bean.getId_producto()+")";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean mod( PackingBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE PACKINGS SET NOMBRE='"+bean.getNombre()+"', MULTIPLICADOR="+bean.getMultiplicador()+" WHERE ID=" + bean.getId() ;
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean del( PackingBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM PACKINGS WHERE ID = " + bean.getId();
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
		return 1;
	}
	
	
}
