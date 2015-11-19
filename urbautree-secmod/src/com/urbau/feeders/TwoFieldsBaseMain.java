package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.KeyValueBean;
import com.urbau.beans.TwoFieldsBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class TwoFieldsBaseMain extends AbstractMain {
	
	
	private  String tablename;
	
	public TwoFieldsBaseMain( String tablename ){
		this.tablename = tablename;
	}
	
	public ArrayList<TwoFieldsBean> get( String q, int from ){
		ArrayList<TwoFieldsBean> list  = new ArrayList<TwoFieldsBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		String sql = "";
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			int total_regs = 0;
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				sql = "SELECT ID,DESCRIPCION FROM "+tablename +" ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				rs = stmt.executeQuery( sql);
				total_regs = Util.getTotalRegs(tablename, "" );
				 
			} else {
				sql = "SELECT ID,DESCRIPCION FROM "+tablename +" " + Util.getDescriptionWhere( q ) + "  ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				rs = stmt.executeQuery( sql);
				
				total_regs = Util.getTotalRegs( tablename, Util.getDescriptionWhere( q ) );
			}
			System.out.println( "sql: " + sql );
			while( rs.next() ){
				
				TwoFieldsBean bean = new TwoFieldsBean();
				bean.setTotal_regs( total_regs );
				bean.setId(  rs.getInt   ( 1  ));
				bean.setDescripcion(  Util.trimString( rs.getString( 2 )));							
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
			System.out.println( "sql: [" + sql + "]");
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	public TwoFieldsBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		TwoFieldsBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM "+tablename+" WHERE ID=" + id );
			while( rs.next() ){
				bean = new TwoFieldsBean();
			    bean.setId(  rs.getInt   ( 1  ));
			    bean.setDescripcion( Util.trimString( rs.getString( 2 )));												
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public TwoFieldsBean get( String codigo  ){
		if( codigo == null){
			return getBlankBean();
		}
		TwoFieldsBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM "+tablename+" WHERE ID='" + codigo + "'" );
			while( rs.next() ){
				bean = new TwoFieldsBean();
			    bean.setId(  rs.getInt   ( 1  ));
			    bean.setDescripcion( Util.trimString( rs.getString( 2 )));												
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
		
	public TwoFieldsBean getBlankBean(){
		TwoFieldsBean bean = new TwoFieldsBean();
		bean.setId( -1 );
		bean.setDescripcion( "" );				
		return bean;
	}
	
	public boolean add( TwoFieldsBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO "+tablename+
					" (DESCRIPCION) " +
						"VALUES " +
					"('"+ bean.getDescripcion()+"')";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean mod( TwoFieldsBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE "+tablename+" SET " +
					"DESCRIPCION = " + Util.vs( bean.getDescripcion() ) + " " +
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
	
	public boolean del( TwoFieldsBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM "+tablename+" WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public ArrayList<KeyValueBean> getForCombo(){
		ArrayList<KeyValueBean> list  = new ArrayList<KeyValueBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		String sql = "";
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			sql = "SELECT ID,DESCRIPCION FROM "+tablename +" ORDER BY ID DESC";
			rs = stmt.executeQuery( sql);
			while( rs.next() ){
				KeyValueBean bean = new KeyValueBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setDescripcion(  Util.trimString( rs.getString( 2 )));							
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
			System.out.println( "sql: [" + sql + "]");
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
}
