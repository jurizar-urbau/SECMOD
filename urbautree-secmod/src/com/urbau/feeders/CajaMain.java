package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau.beans.CajaBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class CajaMain {
	
	public ArrayList<CajaBean> getCajas( String q, int from ){
		ArrayList<CajaBean> list = new ArrayList<CajaBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT ID,MONTO,DESCRIPCION,SALDO FROM CAJA LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
			} else {
				rs = stmt.executeQuery( "SELECT ID,MONTO,DESCRIPCION,SALDO FROM CAJA " + Util.getDescriptionWhere( q ) + " LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
			}
			while( rs.next() ){
				CajaBean bean = new CajaBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setMonto( rs.getDouble( 2 ));
				bean.setDescripcion(  Util.trimString( rs.getString( 3 )));
				bean.setSaldo( rs.getDouble( 4 ));
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	public CajaBean getCaja( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		CajaBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,MONTO,DESCRIPCION,SALDO FROM CAJA WHERE ID=" + id );
			while( rs.next() ){
				bean = new CajaBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setMonto( rs.getDouble( 2 ));
				bean.setDescripcion(  Util.trimString( rs.getString( 3 )));
				bean.setSaldo( rs.getDouble( 4 ));
				
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public CajaBean getBlankBean(){
		CajaBean bean = new CajaBean();
		
		bean.setMonto(0);
		bean.setDescripcion( "" );
		bean.setSaldo( 0);
		
		return bean;
	}
	public boolean addCaja( CajaBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO CAJA " +
					"(MONTO,DESCRIPCION,SALDO) " +
						"VALUES " +
					"("+bean.getMonto()+",'"+ bean.getDescripcion()+"'," + bean.getSaldo() + ")";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean modCaja( CajaBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE CAJA SET " +
					"MONTO=" + bean.getMonto() + ",DESCRIPCION = " + Util.vs( bean.getDescripcion() ) + ",SALDO=" + bean.getSaldo() + " " +
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
	
	public boolean delCaja( CajaBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM CAJA WHERE ID = " + bean.getId();
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
	
	public String getDescripcionCaja( String id ){
		String description = "";
		Connection con = null;
		Statement  stmt= null;
		ResultSet   rs = null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "select descripcion from caja where id= " + id;
			rs = stmt.executeQuery( sql );
			if( rs.next() ){
				description = rs.getString( 1 );
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return description;
	}
	public double getSaldoCaja( String id ){
		double balance = 0.00;
		Connection con = null;
		Statement  stmt= null;
		ResultSet   rs = null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "select saldo from caja where id= " + id;
			rs = stmt.executeQuery( sql );
			if( rs.next() ){
				balance = rs.getDouble( 1 );
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return balance;
	}
	
	public void updateCaja( int id ){
		double balance = 0;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT SUM(VALOR) FROM MOVIMIENTOS WHERE TIPO_MOVIMIENTO='H' AND CAJA_ID=" + id );
			if( rs.next() ){
				balance = rs.getDouble( 1 );
			}
			rs = stmt.executeQuery( "SELECT SUM(VALOR) FROM MOVIMIENTOS WHERE TIPO_MOVIMIENTO='D' AND CAJA_ID=" + id );
			if( rs.next() ){
				balance -= rs.getDouble( 1 );
			}
			stmt.executeUpdate( "UPDATE CAJA SET SALDO=" + balance + " WHERE ID=" + id );
			
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		
	}
	
}
