package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.BancoMovimientoBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class BancosMovimientosMain extends AbstractMain {
	
	private final String TABLE_NAME = "BANCOS_MOVIMIENTOS"; 
	
	public ArrayList<BancoMovimientoBean> get( String q, int from){
		return get( q, from, -1);
	}
	
	public ArrayList<BancoMovimientoBean> get( String q, int from, int limit){
		
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		ArrayList<BancoMovimientoBean> list = new ArrayList<BancoMovimientoBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
											
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				String sql="SELECT BM.ID,BM.ID_BANCO,BM.FECHA,BM.TIPO_MOVIMIENTO,BM.DESCRIPCION,BM.MONTO,TM.DESCRIPCION FROM "+TABLE_NAME+" AS BM INNER JOIN TIPO_MOVIMIENTO AS TM ON BM.TIPO_MOVIMIENTO=TM.ID LIMIT " + from + "," + items;
				System.out.println("1sql:"+sql);
				rs = stmt.executeQuery( sql );
				total_regs = Util.getTotalRegs( TABLE_NAME, "" );
				
			} else {
				String rem_where = Util.getBancosMovimientosWithPrefixWhere( q );
				String sql="SELECT BM.ID,BM.ID_BANCO,BM.FECHA,BM.TIPO_MOVIMIENTO,BM.DESCRIPCION,BM.MONTO,TM.DESCRIPCION FROM "+TABLE_NAME+" AS BM INNER JOIN TIPO_MOVIMIENTO AS TM ON BM.TIPO_MOVIMIENTO=TM.ID  " + rem_where + " LIMIT " + from + "," + items;
				System.out.println("2sql:"+sql);
				rs = stmt.executeQuery( sql);
				total_regs = Util.getTotalRegs( TABLE_NAME, rem_where );
			}
			while( rs.next() ){
				BancoMovimientoBean bean = new BancoMovimientoBean();
				bean.setId( rs.getInt   ( 1  ));
				bean.setIdBanco(rs.getInt(2));
				bean.setFecha(rs.getDate(3));
				bean.setIdTipoMovimiento(rs.getInt(4));
				bean.setDescripcion(Util.trimString( rs.getString( 5 )));
				bean.setMonto(rs.getDouble(6));				
				bean.setDescripcionTipoMovimiento(Util.trimString( rs.getString( 7 )));
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
	
	
	
	public BancoMovimientoBean get( int id ){
		if(  id < 0){
			return getBlankBean();
		}
		BancoMovimientoBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			String sql = "SELECT BM.ID,BM.ID_BANCO,BM.FECHA,BM.TIPO_MOVIMIENTO,BM.DESCRIPCION,BM.MONTO,TM.DESCRIPCION FROM "+TABLE_NAME+" AS BM INNER JOIN TIPO_MOVIMIENTO AS TM ON BM.TIPO_MOVIMIENTO=TM.ID WHERE BM.ID_BANCO='"+id+"'";
			System.out.println("sql:"+sql);
			rs = stmt.executeQuery( sql);
			while( rs.next() ){
				bean = new BancoMovimientoBean();
				bean.setId( rs.getInt   ( 1  ));
				bean.setIdBanco(rs.getInt(2));
				bean.setFecha(rs.getDate(3));
				bean.setIdTipoMovimiento(rs.getInt(4));
				bean.setDescripcion(Util.trimString( rs.getString( 5 )));
				bean.setMonto(rs.getDouble(6));
				bean.setDescripcionTipoMovimiento(Util.trimString( rs.getString( 7 )));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
		
	public BancoMovimientoBean getBlankBean(){
		BancoMovimientoBean bean = new BancoMovimientoBean();							
		bean.setId( -1);
		bean.setIdBanco(-1);
		bean.setFecha(null);
		bean.setIdTipoMovimiento(-1);
		bean.setDescripcion("");
		bean.setMonto(0.00);							
		return bean;
	}
	
	public boolean add( BancoMovimientoBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO "+TABLE_NAME+
					" (ID_BANCO,FECHA,TIPO_MOVIMIENTO,DESCRIPCION,MONTO) " +
						"VALUES " +
					"("+ bean.getIdBanco()+","+bean.getFecha()+","+bean.getIdTipoMovimiento()+",'"+bean.getDescripcion()+"',"+bean.getMonto()+")";
			
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
	
	public boolean mod( BancoMovimientoBean bean ){
		if ( bean.getIdBanco() <= 0  && bean.getIdTipoMovimiento() <= 0){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {			
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE "+TABLE_NAME+" SET " +
					"ID_BANCO = " + bean.getIdBanco() + " , " +
					"FECHA = " + bean.getFecha() + " , " +
					"TIPO_MOVIMIENTO= " + bean.getIdTipoMovimiento() + " , " +
					"DESCRIPCION= " + bean.getDescripcion() + " , " +
					"MONTO = " + bean.getMonto() + " " +					
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
	
	public boolean del( BancoMovimientoBean bean ){
		if ( bean.getIdBanco() <= 0 && bean.getIdTipoMovimiento() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM "+TABLE_NAME+" WHERE ID_BANCO = " + bean.getIdBanco() + " AND TIPO_MOVIMIENTO = " + bean.getIdTipoMovimiento();
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
		
	
	public boolean duplicate( BancoMovimientoBean bean ){
		
		if ( bean.getIdBanco()  <= 0||  bean.getIdTipoMovimiento() <= 0 ){
			return false;
		}
				
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();			
			String sql = "SELECT * from "+TABLE_NAME+" where ID_BANCO = "+bean.getIdBanco()+" AND TIPO_MOVIMIENTO = '"+bean.getIdTipoMovimiento()+"'";
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
