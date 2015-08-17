package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.BodegaClienteBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class BodegasClientesMain extends AbstractMain {
	
	private final String TABLE_NAME = "BODEGAS_CLIENTES"; 
	
	public ArrayList<BodegaClienteBean> get( String q, int from){
		return get( q, from, -1);
	}
	
	public ArrayList<BodegaClienteBean> get( String q, int from, int limit){
		
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		ArrayList<BodegaClienteBean> list = new ArrayList<BodegaClienteBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
											
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				String sql="SELECT ID,ID_BODEGA,ID_CLIENTE FROM "+TABLE_NAME+" LIMIT " + from + "," + items;
				System.out.println("1sql:"+sql);
				rs = stmt.executeQuery( sql );
				total_regs = Util.getTotalRegs( TABLE_NAME, "" );
				
			} else {
				String rem_where = Util.getBodegaPorClienteWhere( q );
				String sql="SELECT ID,ID_BODEGA,ID_CLIENTE FROM "+TABLE_NAME+" " + rem_where + " LIMIT " + from + "," + items;
				System.out.println("2sql:"+sql);
				rs = stmt.executeQuery( sql);
				total_regs = Util.getTotalRegs( TABLE_NAME, rem_where );
			}
			while( rs.next() ){
				BodegaClienteBean bean = new BodegaClienteBean();
				bean.setId( rs.getInt   ( 1  ));
				bean.setIdBodega(rs.getInt( 2  ));				
				bean.setIdCliente(rs.getInt( 3  ));
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
	
	
	
	public BodegaClienteBean get( int idBodegaCliente ){
		if(  idBodegaCliente < 0){
			return getBlankBean();
		}
		BodegaClienteBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			String sql = "SELECT ID,ID_BODEGA,ID_CLIENTE FROM "+TABLE_NAME+" WHERE ID_CLIENTE='"+idBodegaCliente+"'";
			System.out.println("sql:"+sql);
			rs = stmt.executeQuery( sql);
			while( rs.next() ){
				bean = new BodegaClienteBean();
				bean.setId( rs.getInt   ( 1  ));
				bean.setIdBodega(rs.getInt( 2  ));				
				bean.setIdCliente(rs.getInt( 3  ));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
		
	public BodegaClienteBean getBlankBean(){
		BodegaClienteBean bean = new BodegaClienteBean();
		bean.setId(-1);
		bean.setIdCliente(-1);
		bean.setIdBodega(-1);			
		return bean;
	}
	
	public boolean add( BodegaClienteBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO "+TABLE_NAME+
					" (ID_CLIENTE,ID_BODEGA) " +
						"VALUES " +
					"("+ bean.getIdCliente()+","+bean.getIdBodega()+")";
			
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
	public boolean mod( BodegaClienteBean bean ){
		if ( bean.getIdCliente() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE "+TABLE_NAME+" SET " +
					"ID_CLIENTE = " + bean.getIdCliente() + " , " +
					"ID_BODEGA = " + bean.getIdBodega() + " " +					
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
	
	public boolean del( BodegaClienteBean bean ){
		if ( bean.getIdCliente() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM "+TABLE_NAME+" WHERE ID_CLIENTE = " + bean.getIdCliente() + " AND ID_BODEGAS = " + bean.getIdBodega();
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
		
	
	public boolean duplicate( BodegaClienteBean bean ){
		
		if ( bean.getIdCliente()  <= 0||  bean.getIdBodega() <= 0 ){
			return false;
		}
				
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();			
			String sql = "SELECT * from "+TABLE_NAME+" where ID_CLIENTE = "+bean.getIdCliente()+" AND ID_BODEGA = '"+bean.getIdBodega()+"'";
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
