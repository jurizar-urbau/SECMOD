package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.RolBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class RolesMain extends AbstractMain {
	
	public static int getProgramId(){
		return -2;
	}
	public ArrayList<RolBean> getRoles( String q, int from ){
		return getRoles( q, from, -1 );
	}
	
	public ArrayList<RolBean> getRoles( String q, int from, int limit ){
		
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		ArrayList<RolBean> list = new ArrayList<RolBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM ROLES LIMIT " + from + "," + items );
				total_regs = Util.getTotalRegs( "ROLES", "" );
			} else {
				String rem_where = Util.getRolesWhere( q );
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM ROLES " + rem_where + " LIMIT " + from + "," + items );
				total_regs = Util.getTotalRegs( "ROLES", rem_where );
			}
			while( rs.next() ){
				RolBean bean = new RolBean();
				bean.setId( 						   rs.getInt   ( 1  ));
				bean.setDescription(  Util.trimString( rs.getString( 2  )));
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
	
	public ArrayList<String[]> getAllRoles( ){
		
		
		ArrayList<String[]> list = new ArrayList<String[]>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM ROLES" );
			
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
	
	
	public RolBean getRol( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		RolBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT DESCRIPCION FROM ROLES WHERE ID=" + id );
			while( rs.next() ){
			    bean = new RolBean();
			    bean.setId( id );
				bean.setDescription( Util.trimString( rs.getString( 1  )));
				
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	public RolBean getBlankBean(){
		RolBean bean = new RolBean();
		bean.setDescription("");
		return bean;
	}
	public boolean addRol( RolBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO ROLES " +
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
	public boolean modRol( RolBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE ROLES SET " + 
					"DESCRIPCION = " + Util.vs( bean.getDescription()  ) + " " +
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
	
	public boolean delRol( RolBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM ROLES WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	
}
