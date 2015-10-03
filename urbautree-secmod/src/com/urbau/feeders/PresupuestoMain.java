package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.PresupuestoBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class PresupuestoMain extends AbstractMain {
	
	private String allColumnNames = " ID,ANIO,MES,PROYECTADO,EJECUTADO,FECHA ";
	public static int getProgramId(){
		return -2;
	}
	public ArrayList<PresupuestoBean> get( String q, int from ){
		return get( q, from, -1 );
	}
	
	public ArrayList<PresupuestoBean> get( String q, int from, int limit ){
		
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		ArrayList<PresupuestoBean> list = new ArrayList<PresupuestoBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT "+allColumnNames+" FROM	PRESUPUESTO LIMIT " + from + "," + items );
				total_regs = Util.getTotalRegs( "PRESUPUESTO", "" );
			} else {
				String rem_where = Util.getPresupuestoWhere( q );
				rs = stmt.executeQuery( "SELECT "+allColumnNames+" FROM PRESUPUESTO " + rem_where + " LIMIT " + from + "," + items );
				total_regs = Util.getTotalRegs( "ROLES", rem_where );
			}
			while( rs.next() ){
				PresupuestoBean bean = new PresupuestoBean();
				bean.setId( 						   rs.getInt   ( 1  ));
				bean.setAnio(rs.getInt(2));
				bean.setMes(rs.getInt(3));
				bean.setProyectado(rs.getDouble(4));
				bean.setEjecutado(rs.getDouble(5));
				bean.setFecha(rs.getDate(6));
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
		
	public PresupuestoBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		PresupuestoBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT "+allColumnNames+" FROM PRESUPUESTO WHERE ID=" + id );
			while( rs.next() ){
			    bean = new PresupuestoBean();
			    bean.setId( 						   rs.getInt   ( 1  ));
				bean.setAnio(rs.getInt(2));
				bean.setMes(rs.getInt(3));
				bean.setProyectado(rs.getDouble(4));
				bean.setEjecutado(rs.getDouble(5));
				bean.setFecha(rs.getDate(6));								
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	public PresupuestoBean getBlankBean(){
		PresupuestoBean bean = new PresupuestoBean();
		bean.setId(-1);
		bean.setAnio(-1);
		bean.setMes(-1);
		bean.setProyectado(00.00);
		bean.setEjecutado(00.00);
		bean.setFecha(null);		
		return bean;
	}
	public boolean add( PresupuestoBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO PRESUPUESTO " +
					"(ANIO,MES,PROYECTADO,EJECUTADO,FECHA) " +
						"VALUES " +
					"("+ bean.getAnio()+","+bean.getMes()+","+bean.getProyectado()+","+bean.getEjecutado()+","+bean.getFecha()+")";
			int total = stmt.executeUpdate( sql );					
			return total>0;
			 
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean mod( PresupuestoBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE PRESUPUESTO SET " + 
					"ANIO = " + bean.getAnio() + " " +
					"MES = " + bean.getMes() + " " +
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
	
	public boolean del( PresupuestoBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM PRESUPUESTO WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );					
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean duplicate( PresupuestoBean bean ){
		
		if (bean.getAnio()<= 0 || bean.getMes()< 0){
			return false;
		}
				
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();			
			String sql = "SELECT * from PRESUPUESTO where ANIO = "+bean.getAnio()+" AND MES = " + bean.getMes();
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
