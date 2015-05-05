package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau.beans.CuentaBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class CuentasMain {
	
	public ArrayList<CuentaBean> getCuentas( String q, int from ){
		ArrayList<CuentaBean> list = new ArrayList<CuentaBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION,TIPO FROM Cuentas LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
			} else {
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION,TIPO FROM Cuentas " + Util.getDescriptionWhere( q ) + " LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
			}
			while( rs.next() ){
				CuentaBean bean = new CuentaBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setDescription(  Util.trimString( rs.getString( 2 )));
				bean.setType(   Util.trimString( rs.getString( 3 )));
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	public CuentaBean getCuenta( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		CuentaBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,DESCRIPCION,TIPO FROM Cuentas WHERE ID=" + id );
			while( rs.next() ){
				bean = new CuentaBean();
			    bean.setId(  rs.getInt   ( 1  ));
				bean.setDescription( Util.trimString( rs.getString( 2 )));
				bean.setType( Util.trimString( rs.getString( 3 )));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public CuentaBean getBlankBean(){
		CuentaBean bean = new CuentaBean();
		bean.setDescription( "" );
		bean.setType( "" );
		return bean;
	}
	public boolean addCuenta( CuentaBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO Cuentas " +
					"(DESCRIPCION,TIPO) " +
						"VALUES " +
					"('"+ bean.getDescription()+"','" + bean.getType() + "')";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean modCuenta( CuentaBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE Cuentas SET " +
					"DESCRIPCION = " + Util.vs( bean.getDescription() ) + ",TIPO=" + Util.vs( bean.getType() ) + " " +
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
	
	public boolean delCuenta( CuentaBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM Cuentas WHERE ID = " + bean.getId();
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
