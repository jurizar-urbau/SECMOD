package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.sql.Date;

import com.urbau.beans.MovimientosBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class MovimientosMain extends Main {
	
	private String getTableName() {
		return "MOVIMIENTOS";
	}
	String[] getFields(){
		return new String[]{"CAJA_ID","TIPO_MOVIMIENTO","VALOR","DESCRIPCION","FECHA","ID_CUENTA"};
	}
	
	Object[] getFieldTypes(){
		return new Object[]{ new String(), new String(), new Double(0.00),new Date( System.currentTimeMillis()) , new String()};
	}

	public ArrayList<MovimientosBean> get(String q, int from, String caja_id ) {
		ArrayList<MovimientosBean> list = new ArrayList<MovimientosBean>();
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if (q == null || "null".equalsIgnoreCase(q) || "".equals(q.trim())) {
				rs = stmt.executeQuery("SELECT ID,"+getFieldNames()+" FROM " + getTableName()
						+ " where CAJA_ID=" + caja_id + " LIMIT " + from + "," + Constants.ITEMS_PER_PAGE);
			} else {
				rs = stmt.executeQuery("SELECT ID,"+getFieldNames()+" FROM " + getTableName()
						+ " " + Util.getDescriptionWhere(q) + " and CAJA_ID=" + caja_id + " LIMIT " + from
						+ "," + Constants.ITEMS_PER_PAGE);
			}
			while (rs.next()) {
				MovimientosBean bean = new MovimientosBean();
				bean.setId(rs.getInt(1));
				bean.setCaja_id( rs.getInt( 2 ));
				bean.setTipo_movimiento( rs.getString( 3 ));
				bean.setValor( rs.getDouble( 4 ));
				bean.setDescripcion( Util.trimString( rs.getString( 5 ) ));
				bean.setFecha( rs.getDate( 6 ));
				bean.setId_cuenta( rs.getInt( 7 ));
				
				list.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(con, stmt, rs);
		}
		return list;
	}

	public MovimientosBean get(int id, String caja_id ) {
		if (id < 0) {
			return getBlankBean();
		}
		MovimientosBean bean = null;
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT ID,"+getFieldNames()+" FROM " + getTableName()
					+ " WHERE CAJA_ID=" + caja_id + " and ID=" + id);
			while (rs.next()) {
				bean = new MovimientosBean();
				bean.setId(rs.getInt(1));
				bean.setCaja_id( rs.getInt( 2 ));
				bean.setTipo_movimiento( rs.getString( 3 ));
				bean.setValor( rs.getDouble( 4 ));
				bean.setDescripcion( Util.trimString( rs.getString( 5 ) ));
				bean.setFecha( rs.getDate( 6 ));
				bean.setId_cuenta( rs.getInt( 7 ));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(con, stmt, rs);
		}
		return bean;
	}

	public MovimientosBean getBlankBean() {
		MovimientosBean bean = new MovimientosBean();
		bean.setId(-1);
		bean.setCaja_id(-1);
		bean.setTipo_movimiento( "");
		bean.setValor( 0);
		bean.setDescripcion( "");
		bean.setFecha( new Date(System.currentTimeMillis()) );
		bean.setId_cuenta( -1);
		return bean;
	}

	public boolean add(MovimientosBean bean) {
		Connection con = null;
		Statement stmt = null;
		String sql="";
		try {
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			sql = "INSERT INTO "+getTableName()+" " + "(ID, "+getFieldNames()+" ) " + "VALUES "
					+ "("+
			bean.getId() + "," + 
			bean.getCaja_id() + "," +
			"'" + bean.getTipo_movimiento( ) + "'," +
			bean.getValor() + "," +
			"'" + bean.getDescripcion( ) + "','" +
			Util.getDateString( bean.getFecha( ) )+ "', "+bean.getId_cuenta()+ ")";
			int total = stmt.executeUpdate(sql);
			if ( total > 0 ){
				CajaMain cm = new CajaMain();
				cm.updateCaja( bean.getCaja_id() );
			}
			return total > 0;

		} catch (Exception e) {
			System.out.println( "sql:" + sql );
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close(con, stmt, null);
		}
	}

	public boolean mod(MovimientosBean bean) {
		if (bean.getId() <= 0) {
			return false;
		}
		Connection con = null;
		Statement stmt = null;
		try {
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			String sql = "UPDATE " + getTableName() + " SET " + "CAJA_ID=" + bean.getCaja_id() + ",TIPO_MOVIMIENTO='"+bean.getTipo_movimiento()+"',VALOR="+bean.getValor()+",DESCRIPCION='"+bean.getDescripcion()+"',FECHA='"+Util.getDateString(bean.getFecha())+"', ID_CUENTA="+bean.getId_cuenta()+" " 
					+ "WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate(sql);
			if ( total > 0 ){
				CajaMain cm = new CajaMain();
				cm.updateCaja( bean.getCaja_id() );
			}
			return total > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close(con, stmt, null);
		}
	}

	public boolean del(MovimientosBean bean) {
		if (bean.getId() <= 0) {
			return false;
		}
		Connection con = null;
		Statement stmt = null;
		try {
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			String sql = "DELETE FROM " + getTableName() + " WHERE ID = "
					+ bean.getId();
			int total = stmt.executeUpdate(sql);
			if ( total > 0 ){
				CajaMain cm = new CajaMain();
				cm.updateCaja( bean.getCaja_id() );
			}
			return total > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close(con, stmt, null);
		}
	}

	public static int getProgramId() {
		return 1;
	}
}
