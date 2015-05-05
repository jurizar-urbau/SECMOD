package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import java.sql.ResultSetMetaData;
import com.urbau.beans.GenericBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class GenericMain {
	
	public ArrayList<GenericBean> getGenericBeanList( String q, int from, String tableName, String whereTemplate ){
		ArrayList<GenericBean> list = new ArrayList<GenericBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT * FROM " + tableName + " LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
			} else {
				rs = stmt.executeQuery( "SELECT * FROM " + tableName +" " + Util.getGenericWhere( whereTemplate, q ) + " LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
			}
			if( rs != null ){
				ResultSetMetaData rsmd = rs.getMetaData();
				int columnCount =rsmd.getColumnCount();
				ArrayList<String> general = new ArrayList<String>();
				while( rs.next() ){
					for( int column =1; column <= columnCount; column++ ){
						general.add( rs.getString( column ) );
					}
					GenericBean bean = new GenericBean();
					bean.setList( general );
					list.add( bean );
				}
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	public GenericBean getGenericBeanList( String id, String tableName){
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			
			rs = stmt.executeQuery( "SELECT * FROM " + tableName +" WHERE ID=" + id );
			
			if( rs != null ){
				ResultSetMetaData rsmd = rs.getMetaData();
				int columnCount =rsmd.getColumnCount();
				ArrayList<String> general = new ArrayList<String>();
				while( rs.next() ){
					for( int column =0; column < columnCount; column++ ){
						general.add( rs.getString( 1 ) );
					}
					
					GenericBean bean = new GenericBean();
					bean.setList( general );
					return  bean;
				}
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return null;
	}
	
	public GenericBean getBlankBean(){
		return new GenericBean();
	}
	public boolean add( GenericBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			StringBuffer bufferFields = new StringBuffer();
			for( String field: bean.getFieldsList() ){
				bufferFields.append( ", " ).append( field );
			}
			StringBuffer bufferValues = new StringBuffer();
			for( String str: bean.getList() ){
				bufferValues.append( ", " ).append( str );
			}
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			
			
			
			String sql = "INSERT INTO " + bean.getTableName() + " " + 
							"(id, " + bufferFields.toString() +") " +
						 "VALUES " +
						 	"(1," + bufferValues.toString() + ")"; 
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean mod( GenericBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		
		Connection con = null;
		Statement  stmt= null;
		try {
			
			StringBuffer bufferFields = new StringBuffer();
			int count = 0;
			for( String field: bean.getFieldsList() ){
				bufferFields.append( field ).append( "='" );
				bufferFields.append( bean.getList().get( count ) ).append( "'," );
				count++;
			}
			String sql = bufferFields.toString();
			if( bufferFields.length() > 0 ){
				sql = sql.substring( 0, sql.length() - 1 );
			}
			
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			System.out.println( sql );
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean del( String tableName, int id ){
		if ( id <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM " + tableName + " WHERE ID = " + id;
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
		return -100;
	}

	
	public static void main(String[] args) {
		GenericMain gm = new GenericMain();
		ArrayList<GenericBean> gbl = gm.getGenericBeanList(null, 0, "ODT", null);
		for( GenericBean b : gbl ){
			ArrayList<String> list = b.getList();
			for( String l: list){
				System.out.print( l + "," );
			}
			System.out.println();
		}
	}
}
