package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.OrdenBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class OrdenesMain extends AbstractMain {
	
	private String allColumnNames = " ID,FECHA,ID_CLIENTE,ID_BODEGA,MONTO,ID_USUARIO,MONTO,ID_USUARIO ";
	
	public static int getProgramId(){
		return -2;
	}
	public ArrayList<OrdenBean> get( String q, int from ){
		return get( q, from, -1 );
	}
	
	public ArrayList<OrdenBean> get( String q, int from, int limit ){
		
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		ArrayList<OrdenBean> list = new ArrayList<OrdenBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT "+allColumnNames+" FROM	ORDENES LIMIT " + from + "," + items );
				total_regs = Util.getTotalRegs( "ORDENES", "" );
			} else {
				String rem_where = Util.getPresupuestoWhere( q );
				rs = stmt.executeQuery( "SELECT "+allColumnNames+" FROM ORDENES " + rem_where + " LIMIT " + from + "," + items );
				total_regs = Util.getTotalRegs( "ORDENES", rem_where );
			}
			while( rs.next() ){
				OrdenBean bean = new OrdenBean();
				bean.setId        ( rs.getInt   ( 1  ));
				bean.setFecha     ( rs.getDate( 2 ));
				bean.setId_cliente( rs.getInt(3));
				bean.setId_bodega ( rs.getInt(4));
				bean.setMonto     ( rs.getDouble(5));
				bean.setId_usuario( rs.getInt(6) );
				bean.setEstado( rs.getString( 7 ));
				bean.setUid( rs.getString( 8 ));
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
		
	public OrdenBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		OrdenBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT "+allColumnNames+" FROM ORDENES WHERE ID=" + id );
			if( rs.next() ){
			    bean = new OrdenBean();
			    bean.setId        ( rs.getInt   ( 1  ));
				bean.setFecha     ( rs.getDate( 2 ));
				bean.setId_cliente( rs.getInt(3));
				bean.setId_bodega ( rs.getInt(4));
				bean.setMonto     ( rs.getDouble(5));
				bean.setId_usuario( rs.getInt(6) );
				bean.setEstado( rs.getString( 7 ));
				bean.setUid( rs.getString( 8 ));
				bean.setTotal_regs( 1 );
												
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	public OrdenBean get( String uid ){
		if( uid == null ){
			System.out.println( "uid == null , returning null bean.");
			return null;
		}
		OrdenBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT "+allColumnNames+" FROM ORDENES WHERE UID='" + uid + "'");
			if( rs.next() ){
			    bean = new OrdenBean();
			    bean.setId        ( rs.getInt   ( 1  ));
				bean.setFecha     ( rs.getDate( 2 ));
				bean.setId_cliente( rs.getInt(3));
				bean.setId_bodega ( rs.getInt(4));
				bean.setMonto     ( rs.getDouble(5));
				bean.setId_usuario( rs.getInt(6) );
				bean.setEstado( rs.getString( 7 ));
				bean.setUid( rs.getString( 8 ));
				bean.setTotal_regs( 1 );
												
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	public OrdenBean getBlankBean(){
		OrdenBean bean = new OrdenBean();
		bean.setId(-1);
		bean.setId_cliente( -1 );
		bean.setId_bodega ( -1 );
		bean.setMonto     (  0 );
		bean.setId_usuario( -1 );
		bean.setTotal_regs(  0 );
		bean.setFecha(null);		
		bean.setEstado( null );
		bean.setUid(  null );
		return bean;
	}
	public boolean add( OrdenBean bean ){
		Connection con = null;
		Statement  stmt= null;

		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO ORDENES " +
					"(FECHA,ID_CLIENTE,ID_BODEGA,MONTO,ID_USUARIO,ESTADO,UID,ID_PUNTO_VENTA) " +
						"VALUES " +
					"( NOW(),"+bean.getId_cliente()+","+bean.getId_bodega()+","+bean.getMonto()+","+bean.getId_usuario()+",'"+bean.getEstado()+"','" + bean.getUid() + "'," + bean.getId_punto_venta() + ")";
			int total = stmt.executeUpdate( sql );					
			return total>0;
			 
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean mod( OrdenBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE ORDENES SET " +
					" ULTIMA_MODIFICACION=NOW()," +
					" ID_CLIENTE="+bean.getId_cliente()+"," +
					" ID_BODEGA="+bean.getId_bodega()+"," +
					" MONTO="+bean.getMonto()+"," +
					" ID_USUARIO="+bean.getId_usuario()+", " +
					" ESTADO='"+bean.getId_usuario()+"', " +
					" ID_PUNTO_VENTA='"+bean.getId_punto_venta()+"', " +
					" UID='"+bean.getId_usuario()+"' " +
					" WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean del( OrdenBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM ORDENES WHERE ID = " + bean.getId();
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
