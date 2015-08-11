package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.PreciosPuntoDeVentaBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class PreciosPuntosDeVentasMain extends AbstractMain {
	
	private final String TABLE_NAME = "PRECIOS_PUNTOSDEVENTAS"; 
	
	public ArrayList<PreciosPuntoDeVentaBean> get( String q, int from){
		return get( q, from, -1);
	}
	
	public ArrayList<PreciosPuntoDeVentaBean> get( String q, int from, int limit){
		
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		ArrayList<PreciosPuntoDeVentaBean> list = new ArrayList<PreciosPuntoDeVentaBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
											
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				String sql="SELECT ID,ID_PUNTOSDEVENTAS,ID_PRECIO FROM "+TABLE_NAME+" LIMIT " + from + "," + items;
				System.out.println("1sql:"+sql);
				rs = stmt.executeQuery( sql );
				total_regs = Util.getTotalRegs( TABLE_NAME, "" );
				
			} else {
				String rem_where = Util.getMonedasWhere( q );
				String sql="SELECT ID,ID_PUNTOSDEVENTAS,ID_PRECIO FROM "+TABLE_NAME+" " + rem_where + " LIMIT " + from + "," + items;
				System.out.println("2sql:"+sql);
				rs = stmt.executeQuery( sql);
				total_regs = Util.getTotalRegs( TABLE_NAME, rem_where );
			}
			while( rs.next() ){
				PreciosPuntoDeVentaBean bean = new PreciosPuntoDeVentaBean();
				bean.setId( rs.getInt   ( 1  ));
				bean.setIdPuntoDeVenta(rs.getInt( 2  ));				
				bean.setIdPrecio(rs.getInt( 3  ));
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
	
	
	
	public PreciosPuntoDeVentaBean get( int id ){
		if(  id < 0){
			return getBlankBean();
		}
		PreciosPuntoDeVentaBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			String sql = "SELECT ID,ID_PUNTOSDEVENTAS,ID_PRECIO FROM "+TABLE_NAME+" WHERE ID_PUNTOSDEVENTAS='"+id+"'";
			System.out.println("sql:"+sql);
			rs = stmt.executeQuery( sql);
			while( rs.next() ){
				bean = new PreciosPuntoDeVentaBean();
				bean.setId( rs.getInt   ( 1  ));
				bean.setIdPuntoDeVenta(rs.getInt( 2  ));				
				bean.setIdPrecio(rs.getInt( 3  ));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
		
	public PreciosPuntoDeVentaBean getBlankBean(){
		PreciosPuntoDeVentaBean bean = new PreciosPuntoDeVentaBean();
		bean.setId(-1);
		bean.setIdPuntoDeVenta(-1);
		bean.setIdPrecio(-1);			
		return bean;
	}
	
	public boolean add( PreciosPuntoDeVentaBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO "+TABLE_NAME+
					" (ID_PUNTOSDEVENTAS,ID_PRECIO) " +
						"VALUES " +
					"("+ bean.getIdPuntoDeVenta()+","+bean.getIdPrecio()+")";
			
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
	public boolean mod( PreciosPuntoDeVentaBean bean ){
		if ( bean.getIdPuntoDeVenta() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE "+TABLE_NAME+" SET " +
					"ID_PUNTOSDEVENTAS = " + bean.getIdPuntoDeVenta() + " , " +
					"ID_PRECIO = " + bean.getIdPrecio() + " " +					
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
	
	public boolean del( PreciosPuntoDeVentaBean bean ){
		if ( bean.getIdPuntoDeVenta() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM "+TABLE_NAME+" WHERE ID_PUNTOSDEVENTAS = " + bean.getIdPuntoDeVenta() + " AND ID_PRECIO = " + bean.getIdPrecio();
			System.out.println("sql:"+sql);
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
		
	
	public boolean duplicate( PreciosPuntoDeVentaBean bean ){
		
		if ( bean.getIdPuntoDeVenta()  <= 0||  bean.getIdPrecio() <= 0 ){
			return false;
		}
				
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();			
			String sql = "SELECT * from "+TABLE_NAME+" where ID_PUNTOSDEVENTAS = "+bean.getIdPuntoDeVenta()+" AND ID_PRECIO = '"+bean.getIdPrecio()+"'";
			System.out.println("sql>" + sql);
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
