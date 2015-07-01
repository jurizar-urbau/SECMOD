package com.urbau.feeders;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.InvetarioBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;
import com.urbau.misc.InventarioHelper;

public class InventariosMain extends AbstractMain {
	
	private final String TABLE_NAME = "INV"; 
	
	public ArrayList<InvetarioBean> get( String q, int from, int idBodega ){
		return get( q, from, -1, idBodega );
	}
	
	public ArrayList<InvetarioBean> get( String q, int from, int limit, int idBodega ){
		
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		ArrayList<InvetarioBean> list = new ArrayList<InvetarioBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			
			InventarioHelper invHelper = new InventarioHelper();
			invHelper.addBodega( idBodega );
			
			
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT ID_PRODUCT,ESTATUS,AMOUNT FROM "+TABLE_NAME+idBodega+" LIMIT " + from + "," + items );
				total_regs = Util.getTotalRegs( TABLE_NAME+idBodega, "" );
			} else {
				String rem_where = Util.getMonedasWhere( q );
				rs = stmt.executeQuery( "SELECT ID_PRODUCT,ESTATUS,AMOUNT FROM "+TABLE_NAME+idBodega+" " + rem_where + " LIMIT " + from + "," + items );
				total_regs = Util.getTotalRegs( TABLE_NAME+idBodega, rem_where );
			}
			while( rs.next() ){
				InvetarioBean bean = new InvetarioBean();
				bean.setId_product( rs.getInt   ( 1  ));
				bean.setEstatus( Util.trimString( rs.getString( 2  )));
				bean.setAmount( rs.getInt( 3 ));
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
	
	
	
	public InvetarioBean get( int id, String estatus, int idBodega ){
		if( id < 0  || null == estatus){
			return getBlankBean();
		}
		InvetarioBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			String query = "SELECT ID_PRODUCT,ESTATUS,AMOUNT FROM "+TABLE_NAME+idBodega+" WHERE ID_PRODUCT=" + id +" AND ESTATUS='"+estatus+"'";
			System.out.println("query:"+query);
			rs = stmt.executeQuery( query);
			while( rs.next() ){
				bean = new InvetarioBean();
			    bean.setId_product(  rs.getInt   ( 1  ));
			    bean.setEstatus(  Util.trimString( rs.getString( 2 )));												
			    bean.setAmount(  rs.getInt( 3 ));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
		
	public InvetarioBean getBlankBean(){
		InvetarioBean bean = new InvetarioBean();
		bean.setId_product(-1);
		bean.setEstatus("");
		bean.setAmount(0);		
		return bean;
	}
	
	public boolean add( InvetarioBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO "+TABLE_NAME+bean.getIdBodega()+
					" (ID_PRODUCT,ESTATUS,AMOUNT) " +
						"VALUES " +
					"("+ bean.getId_product()+",'"+bean.getEstatus()+"',"+bean.getAmount()+")";
			
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
	public boolean mod( InvetarioBean bean ){
		if ( bean.getIdBodega() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE "+TABLE_NAME+bean.getIdBodega()+" SET " +
					"ID_PRODUCT = " + bean.getId_product() + " , " +
					"ESTATUS = " + Util.vs( bean.getEstatus() ) + ", " +
					"AMOUNT = " + bean.getAmount() + " " +
					"WHERE ID_PRODUCT = " + bean.getId_product() + " " + 
					"AND ESTATUS = " + Util.vs( bean.getEstatus() );
					
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
	
	public boolean del( InvetarioBean bean ){
		if ( bean.getIdBodega() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM "+TABLE_NAME+bean.getIdBodega()+" WHERE ID_PRODUCT = " + bean.getId_product() + " AND ESTATUS = '"+bean.getEstatus()+"'";
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
	
	/*
	 * Se necesita agregar el idBodega para la tabla de inventario
	public long count( ){
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		long count = 0;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT count(ID_PRODUCT,ESTATUS) FROM " + TABLE_NAME );
			if( rs.next() ){
				count = rs.getLong( 1 );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return count;
	}
	*/
	
	public boolean duplicate( InvetarioBean bean ){
		
		if ( bean.getId_product() <= 0 || null == bean.getEstatus() ||  bean.getIdBodega() <= 0 ){
			return false;
		}
				
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();			
			String sql = "SELECT * from "+TABLE_NAME+bean.getIdBodega()+" where ID_PRODUCT = "+bean.getId_product()+" AND ESTATUS = '"+bean.getEstatus()+"'";
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
