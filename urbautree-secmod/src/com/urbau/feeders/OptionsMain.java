package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau.beans.OptionBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class OptionsMain {
	
	public ArrayList<OptionBean> getOption( String q, int from ){
		ArrayList<OptionBean> list = new ArrayList<OptionBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM OPCIONES LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
			} else {
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM OPCIONES " + Util.getDescriptionWhere( q ) + " LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
			}
			while( rs.next() ){
				OptionBean bean = new OptionBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setDescription(  Util.trimString( rs.getString( 2 )));
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	public ArrayList<String[]> getAllOptions( ){
		
		
		ArrayList<String[]> list = new ArrayList<String[]>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM OPCIONES" );
			
			while( rs.next() ){
				String[] bean = new String[2];
				bean[0] = Util.trimString( rs.getString( 1  ));
				bean[1] = Util.trimString( rs.getString( 2  ));
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	public OptionBean getOption( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		OptionBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM OPCIONES WHERE ID=" + id );
			while( rs.next() ){
				bean = new OptionBean();
			    bean.setId(  rs.getInt   ( 1  ));
				bean.setDescription( Util.trimString( rs.getString( 2 )));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public OptionBean getBlankBean(){
		OptionBean bean = new OptionBean();
		bean.setDescription( "" );
		return bean;
	}
	public boolean addOption( OptionBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO OPCIONES " +
					"(DESCRIPCION) " +
						"VALUES " +
					"('"+ bean.getDescription()+"')";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean modOption( OptionBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE OPCIONES SET " +
					"DESCRIPCION = " + Util.vs( bean.getDescription() ) + " " +
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
	
	public boolean delOption( OptionBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM OPCIONES WHERE ID = " + bean.getId();
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
